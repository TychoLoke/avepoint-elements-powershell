using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading.Tasks;
using Avalonia.Threading;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using ElementsShell.Desktop.Models;
using ElementsShell.Desktop.Services;

namespace ElementsShell.Desktop.ViewModels;

public partial class MainWindowViewModel : ViewModelBase
{
    private readonly AvptDesktopPowerShellClient _desktopClient = new();
    private readonly DesktopPreferencesStore _preferencesStore = new();
    private readonly DispatcherTimer _splashTimer;
    private bool _isApplyingPreferences;

    [ObservableProperty]
    private string _selectedSection = "Overview";

    [ObservableProperty]
    private string _environment = "Commercial";

    [ObservableProperty]
    private string _tenantLabel = "Mock MSP";

    [ObservableProperty]
    private string _operatorName = "MSP Operator";

    [ObservableProperty]
    private string _connectionState = "Disconnected";

    [ObservableProperty]
    private string _statusMessage = "Ready for desktop onboarding";

    [ObservableProperty]
    private string _selectedBundleSummary = "Common, Baseline, User, Risk, Workspace";

    [ObservableProperty]
    private string _selectedCustomer = "No customer selected";

    [ObservableProperty]
    private string _selectedTenant = "No tenant context loaded";

    [ObservableProperty]
    private string _searchText = string.Empty;

    [ObservableProperty]
    private string _clientId = string.Empty;

    [ObservableProperty]
    private string _clientSecret = string.Empty;

    [ObservableProperty]
    private bool _isBusy;

    [ObservableProperty]
    private bool _isOnboardingVisible = true;

    [ObservableProperty]
    private bool _isSplashVisible = true;

    [ObservableProperty]
    private string _busyTitle = "Working";

    [ObservableProperty]
    private string _busyDetail = "Preparing your Elements workspace.";

    [ObservableProperty]
    private CustomerRecord? _selectedCustomerRecord;

    [ObservableProperty]
    private CustomerSummaryResult? _currentCustomerSummary;

    public MainWindowViewModel()
    {
        _splashTimer = new DispatcherTimer
        {
            Interval = TimeSpan.FromMilliseconds(1800)
        };
        _splashTimer.Tick += OnSplashTimerTick;

        NavigationItems = new ObservableCollection<NavigationItem>
        {
            new() { Title = "Overview", Subtitle = "Dashboard and health", Glyph = "01" },
            new() { Title = "Customers", Subtitle = "Onboarding and services", Glyph = "02" },
            new() { Title = "Operations", Subtitle = "Backup, baseline, risk", Glyph = "03" },
            new() { Title = "Reports", Subtitle = "Workspace and security", Glyph = "04" }
        };

        MetricCards = new ObservableCollection<MetricCard>
        {
            new() { Title = "Managed Customers", Value = "Live", Delta = "Load from the customer workspace", AccentHex = "#0F7BFF" },
            new() { Title = "Protected Workloads", Value = "Bundle-aware", Delta = "Desktop app runs real module commands", AccentHex = "#D7263D" },
            new() { Title = "Baseline Drift Items", Value = "Ops-ready", Delta = "Desktop shell can branch into real workflows", AccentHex = "#12B886" },
            new() { Title = "Open Risk Hits", Value = "App layer", Delta = "Operator surface over the module", AccentHex = "#FFB020" }
        };

        WorkflowItems = new ObservableCollection<WorkflowItem>
        {
            new() { Title = "Connect to Elements", Detail = "Authenticate with client ID, secret, environment, and bundle-aware scope setup.", ScopeBundle = "Common, Baseline, User, Risk, Workspace" },
            new() { Title = "Load customers", Detail = "Pull live partner customer data directly into the desktop experience.", ScopeBundle = "Common" },
            new() { Title = "Inspect customer summary", Detail = "Open a shaped customer summary with services and backup metrics.", ScopeBundle = "Common" },
            new() { Title = "Expand into operations", Detail = "Use the desktop shell as the operator layer over the PowerShell module.", ScopeBundle = "Baseline, Risk, User, Workspace" }
        };

        ActivityItems = new ObservableCollection<ActivityItem>
        {
            new() { Title = "Desktop shell initialized", Detail = "The application is ready to import the bundled module and start a live session.", Status = "Ready", Timestamp = DateTimeOffset.UtcNow }
        };

        Customers = new ObservableCollection<CustomerRecord>();
        DependencyChecks = new ObservableCollection<DependencyCheckItem>(_desktopClient.GetDependencyChecks());
        OnboardingSteps = new ObservableCollection<OnboardingStep>
        {
            new() { Number = "01", Title = "Set context", Detail = "Choose your environment and partner label so the app knows where to operate." },
            new() { Number = "02", Title = "Connect once", Detail = "Enter your client ID and secret, then initialize the bundle-aware session." },
            new() { Number = "03", Title = "Work from live data", Detail = "Load customers, pick a tenant context, and open shaped summaries instead of raw API output." }
        };

        ApplyPreferences(_preferencesStore.Load());
        _splashTimer.Start();
    }

    public ObservableCollection<NavigationItem> NavigationItems { get; }

    public ObservableCollection<MetricCard> MetricCards { get; }

    public ObservableCollection<WorkflowItem> WorkflowItems { get; }

    public ObservableCollection<ActivityItem> ActivityItems { get; }

    public ObservableCollection<CustomerRecord> Customers { get; }

    public ObservableCollection<DependencyCheckItem> DependencyChecks { get; }

    public ObservableCollection<OnboardingStep> OnboardingSteps { get; }

    public bool IsOverviewSelected => SelectedSection == "Overview";

    public bool IsCustomersSelected => SelectedSection == "Customers";

    public bool IsOperationsSelected => SelectedSection == "Operations";

    public bool IsReportsSelected => SelectedSection == "Reports";

    public bool HasCustomers => Customers.Count > 0;

    public bool HasNoCustomers => Customers.Count == 0;

    public bool HasCustomerSummary => CurrentCustomerSummary is not null;

    public bool HasDependencyChecks => DependencyChecks.Count > 0;

    public string ConnectionBadge => ConnectionState == "Connected" ? "SESSION READY" : "NOT CONNECTED";

    public string WindowTitle => $"Elements Shell Desktop  {ConnectionBadge}";

    public string OverviewHeadline => "A desktop operator layer for AvePoint Elements that runs the public PowerShell module underneath.";

    public string SummaryHeadline => CurrentCustomerSummary is null
        ? "No customer summary loaded yet."
        : $"{CurrentCustomerSummary.Organization}  •  {CurrentCustomerSummary.TenantCount} tenants  •  {CurrentCustomerSummary.ProductCount} products";

    public string SummaryDetail => CurrentCustomerSummary is null
        ? "Connect and load a customer to turn the desktop shell into a live operational workspace."
        : $"Protected objects: {CurrentCustomerSummary.ProtectedObjectCount}  •  Scanned objects: {CurrentCustomerSummary.ScannedObjectCount}  •  AvePoint storage: {CurrentCustomerSummary.AvePointStorageGb} GB";

    public string DependencySummary =>
        string.Join("  •  ", DependencyChecks.Select(item => $"{item.Name}: {item.Status}"));

    public string WelcomeHeadline => "A modern desktop workspace for AvePoint Elements operations.";

    public string WelcomeDetail => "Designed to feel like an application layer, not a pile of cmdlets and copied IDs.";

    public string SplashMessage => "Loading a calmer, more modern operator workspace.";

    partial void OnSelectedSectionChanged(string value)
    {
        OnPropertyChanged(nameof(IsOverviewSelected));
        OnPropertyChanged(nameof(IsCustomersSelected));
        OnPropertyChanged(nameof(IsOperationsSelected));
        OnPropertyChanged(nameof(IsReportsSelected));
    }

    partial void OnConnectionStateChanged(string value)
    {
        OnPropertyChanged(nameof(ConnectionBadge));
        OnPropertyChanged(nameof(WindowTitle));

        if (value == "Connected") {
            IsOnboardingVisible = false;
        }
    }

    partial void OnEnvironmentChanged(string value)
    {
        SavePreferences();
    }

    partial void OnTenantLabelChanged(string value)
    {
        SavePreferences();
    }

    partial void OnOperatorNameChanged(string value)
    {
        SavePreferences();
    }

    partial void OnIsOnboardingVisibleChanged(bool value)
    {
        SavePreferences();
    }

    partial void OnCurrentCustomerSummaryChanged(CustomerSummaryResult? value)
    {
        OnPropertyChanged(nameof(HasCustomerSummary));
        OnPropertyChanged(nameof(SummaryHeadline));
        OnPropertyChanged(nameof(SummaryDetail));
    }

    partial void OnSelectedCustomerRecordChanged(CustomerRecord? value)
    {
        if (value is null) {
            return;
        }

        SelectedCustomer = value.Organization;
        SelectedTenant = string.IsNullOrWhiteSpace(value.TenantNames) ? "No tenant names returned" : value.TenantNames;
    }

    [RelayCommand]
    private void SelectSection(string? section)
    {
        if (!string.IsNullOrWhiteSpace(section)) {
            SelectedSection = section;
        }
    }

    [RelayCommand]
    private async Task ConnectAsync()
    {
        if (IsBusy) {
            return;
        }

        if (string.IsNullOrWhiteSpace(ClientId) || string.IsNullOrWhiteSpace(ClientSecret)) {
            StatusMessage = "Client ID and client secret are required for the desktop session.";
            return;
        }

        await RunBusyAsync(async () =>
        {
            BusyTitle = "Connecting to Elements";
            BusyDetail = "Initializing secure bundle-aware session and validating the desktop runtime.";
            var result = await _desktopClient.ConnectAsync(BuildConnectionSettings());
            ConnectionState = "Connected";
            SelectedBundleSummary = string.Join(", ", result.ScopeBundle);
            StatusMessage = $"Connected to {result.Environment} with {result.ScopeBundle.Count} scope bundles.";
            AddActivity("Connected to AvePoint Elements", $"Desktop session initialized for {result.Environment}.", "Connected");
        });
    }

    [RelayCommand]
    private void Disconnect()
    {
        ConnectionState = "Disconnected";
        StatusMessage = "Desktop session cleared. Credentials remain only in memory.";
        SelectedCustomerRecord = null;
        CurrentCustomerSummary = null;
        Customers.Clear();
        SelectedCustomer = "No customer selected";
        SelectedTenant = "No tenant context loaded";
        AddActivity("Disconnected desktop session", "Cleared loaded customer context from the app.", "Disconnected");
        OnPropertyChanged(nameof(HasCustomers));
        OnPropertyChanged(nameof(HasNoCustomers));
    }

    [RelayCommand]
    private void OpenWorkflow(string? workflowTitle)
    {
        if (string.IsNullOrWhiteSpace(workflowTitle)) {
            return;
        }

        SelectedSection = workflowTitle.Contains("customer", StringComparison.OrdinalIgnoreCase) ? "Customers" : "Overview";
        StatusMessage = $"Workflow selected: {workflowTitle}";
    }

    [RelayCommand]
    private void ApplySearch()
    {
        if (string.IsNullOrWhiteSpace(SearchText)) {
            StatusMessage = "Search cleared. Load customers to refresh the full list.";
            return;
        }

        var match = Customers.FirstOrDefault(customer =>
            customer.Organization.Contains(SearchText, StringComparison.OrdinalIgnoreCase) ||
            customer.OwnerEmail.Contains(SearchText, StringComparison.OrdinalIgnoreCase) ||
            customer.TenantNames.Contains(SearchText, StringComparison.OrdinalIgnoreCase));

        if (match is null) {
            StatusMessage = $"No loaded customer matched '{SearchText}'.";
            return;
        }

        SelectedCustomerRecord = match;
        StatusMessage = $"Selected {match.Organization} from the loaded desktop customer list.";
    }

    [RelayCommand]
    private async Task LoadCustomersAsync()
    {
        if (IsBusy) {
            return;
        }

        if (!CanRunLiveCommands()) {
            return;
        }

        await RunBusyAsync(async () =>
        {
            BusyTitle = "Loading customers";
            BusyDetail = "Pulling live customer context into the desktop workspace.";
            var customers = await _desktopClient.GetCustomersAsync(BuildConnectionSettings());
            Customers.Clear();
            foreach (var customer in customers.OrderBy(item => item.Organization)) {
                Customers.Add(customer);
            }

            SelectedSection = "Customers";
            StatusMessage = $"Loaded {Customers.Count} customers into the desktop workspace.";
            AddActivity("Customer list refreshed", $"Loaded {Customers.Count} customers from the module.", "Customers");
            OnPropertyChanged(nameof(HasCustomers));
            OnPropertyChanged(nameof(HasNoCustomers));
        });
    }

    [RelayCommand]
    private async Task LoadCustomerSummaryAsync()
    {
        if (IsBusy) {
            return;
        }

        if (!CanRunLiveCommands()) {
            return;
        }

        var target = SelectedCustomerRecord;
        if (target is null) {
            StatusMessage = "Select a customer first, or load customers into the desktop workspace.";
            return;
        }

        await RunBusyAsync(async () =>
        {
            BusyTitle = "Building customer summary";
            BusyDetail = "Collecting service and backup insight for the selected customer.";
            CurrentCustomerSummary = await _desktopClient.GetCustomerSummaryAsync(BuildConnectionSettings(), target.Id);
            SelectedSection = "Reports";
            StatusMessage = $"Loaded live customer summary for {target.Organization}.";
            AddActivity("Customer summary generated", $"Loaded summary metrics for {target.Organization}.", "Summary");
        });
    }

    [RelayCommand]
    private void SelectCustomer(CustomerRecord? customer)
    {
        if (customer is null) {
            return;
        }

        SelectedCustomerRecord = customer;
        SelectedSection = "Customers";
        StatusMessage = $"Customer context selected: {customer.Organization}";
    }

    [RelayCommand]
    private void GenerateReport(string? reportName)
    {
        var title = string.IsNullOrWhiteSpace(reportName) ? "Operations summary" : reportName;
        SelectedSection = "Reports";
        StatusMessage = $"Prepared desktop report view: {title}";
    }

    [RelayCommand]
    private void RefreshDependencies()
    {
        DependencyChecks.Clear();
        foreach (var item in _desktopClient.GetDependencyChecks())
        {
            DependencyChecks.Add(item);
        }

        StatusMessage = "Dependency checks refreshed for the desktop app.";
        OnPropertyChanged(nameof(HasDependencyChecks));
        OnPropertyChanged(nameof(DependencySummary));
    }

    [RelayCommand]
    private void DismissOnboarding()
    {
        IsOnboardingVisible = false;
        StatusMessage = "Welcome dismissed. The desktop workspace is ready.";
    }

    [RelayCommand]
    private void StartOnboarding()
    {
        IsOnboardingVisible = true;
        SelectedSection = "Overview";
        StatusMessage = "Follow the onboarding steps to start a clean desktop session.";
    }

    private DesktopConnectionSettings BuildConnectionSettings()
    {
        return new DesktopConnectionSettings
        {
            Environment = Environment,
            TenantLabel = TenantLabel,
            ClientId = ClientId.Trim(),
            ClientSecret = ClientSecret,
            ScopeBundles = new[] { "Common", "Baseline", "User", "Risk", "Workspace" }
        };
    }

    private bool CanRunLiveCommands()
    {
        if (string.IsNullOrWhiteSpace(ClientId) || string.IsNullOrWhiteSpace(ClientSecret)) {
            StatusMessage = "Provide client ID and client secret before loading live data.";
            return false;
        }

        return true;
    }

    private async Task RunBusyAsync(Func<Task> action)
    {
        IsBusy = true;
        try {
            await action();
        }
        catch (Exception ex) {
            StatusMessage = ex.Message;
            AddActivity("Desktop command failed", ex.Message, "Error");
        }
        finally {
            IsBusy = false;
        }
    }

    private void AddActivity(string title, string detail, string status)
    {
        ActivityItems.Insert(0, new ActivityItem
        {
            Title = title,
            Detail = detail,
            Status = status,
            Timestamp = DateTimeOffset.UtcNow
        });
    }

    private void ApplyPreferences(DesktopPreferences preferences)
    {
        _isApplyingPreferences = true;
        try
        {
            Environment = preferences.Environment;
            TenantLabel = preferences.TenantLabel;
            OperatorName = preferences.OperatorName;
            IsOnboardingVisible = !preferences.OnboardingDismissed;
        }
        finally
        {
            _isApplyingPreferences = false;
        }
    }

    private void SavePreferences()
    {
        if (_isApplyingPreferences)
        {
            return;
        }

        _preferencesStore.Save(new DesktopPreferences
        {
            Environment = Environment,
            TenantLabel = TenantLabel,
            OperatorName = OperatorName,
            OnboardingDismissed = !IsOnboardingVisible
        });
    }

    private void OnSplashTimerTick(object? sender, EventArgs e)
    {
        _splashTimer.Stop();
        IsSplashVisible = false;
        StatusMessage = IsOnboardingVisible
            ? "Welcome ready. Follow the onboarding flow to start."
            : "Desktop workspace restored from local preferences.";
    }
}
