using System;
using System.Collections.ObjectModel;
using System.Linq;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using ElementsShell.Desktop.Models;

namespace ElementsShell.Desktop.ViewModels;

public partial class MainWindowViewModel : ViewModelBase
{
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
    private string _statusMessage = "Ready for onboarding";

    [ObservableProperty]
    private string _selectedBundleSummary = "Common, Baseline, User, Risk, Workspace";

    [ObservableProperty]
    private string _selectedCustomer = "Mock MSP";

    [ObservableProperty]
    private string _selectedTenant = "mockmsp.onmicrosoft.com";

    [ObservableProperty]
    private string _searchText = string.Empty;

    public MainWindowViewModel()
    {
        NavigationItems = new ObservableCollection<NavigationItem>
        {
            new() { Title = "Overview", Subtitle = "Dashboard and health", Glyph = "01" },
            new() { Title = "Customers", Subtitle = "Onboarding and services", Glyph = "02" },
            new() { Title = "Operations", Subtitle = "Backup, baseline, risk", Glyph = "03" },
            new() { Title = "Reports", Subtitle = "Workspace and security", Glyph = "04" }
        };

        MetricCards = new ObservableCollection<MetricCard>
        {
            new() { Title = "Managed Customers", Value = "128", Delta = "+12 this quarter", AccentHex = "#0F7BFF" },
            new() { Title = "Protected Workloads", Value = "5,482", Delta = "+384 this month", AccentHex = "#D7263D" },
            new() { Title = "Baseline Drift Items", Value = "74", Delta = "-9 since yesterday", AccentHex = "#12B886" },
            new() { Title = "Open Risk Hits", Value = "31", Delta = "7 require triage", AccentHex = "#FFB020" }
        };

        WorkflowItems = new ObservableCollection<WorkflowItem>
        {
            new() { Title = "Connect to Elements", Detail = "Authenticate once and initialize all required scope bundles.", ScopeBundle = "Common, Baseline, User, Risk, Workspace" },
            new() { Title = "Review customer posture", Detail = "Load customer, tenant, backup, and service summaries without copying IDs.", ScopeBundle = "Common" },
            new() { Title = "Investigate baseline drift", Detail = "Jump from baseline reports to tenant monitor actions in one flow.", ScopeBundle = "Baseline" },
            new() { Title = "Audit user and workspace exposure", Detail = "Review user insights, workspace compliance, and data security posture.", ScopeBundle = "User, Workspace" }
        };

        ActivityItems = new ObservableCollection<ActivityItem>
        {
            new() { Title = "Shell package published", Detail = "Standalone desktop packaging pipeline is ready for the next release.", Status = "Release", Timestamp = DateTimeOffset.UtcNow.AddMinutes(-18) },
            new() { Title = "Bundle-aware auth ready", Detail = "Common, Baseline, User, Risk, and Workspace bundles initialized successfully.", Status = "Connection", Timestamp = DateTimeOffset.UtcNow.AddMinutes(-42) },
            new() { Title = "Backup overview synced", Detail = "Operational summary refreshed for Mock MSP.", Status = "Operations", Timestamp = DateTimeOffset.UtcNow.AddHours(-2) }
        };
    }

    public ObservableCollection<NavigationItem> NavigationItems { get; }

    public ObservableCollection<MetricCard> MetricCards { get; }

    public ObservableCollection<WorkflowItem> WorkflowItems { get; }

    public ObservableCollection<ActivityItem> ActivityItems { get; }

    public bool IsOverviewSelected => SelectedSection == "Overview";

    public bool IsCustomersSelected => SelectedSection == "Customers";

    public bool IsOperationsSelected => SelectedSection == "Operations";

    public bool IsReportsSelected => SelectedSection == "Reports";

    public string ConnectionBadge => ConnectionState == "Connected" ? "SESSION READY" : "NOT CONNECTED";

    public string WindowTitle => $"Elements Shell Desktop  {ConnectionBadge}";

    public string OverviewHeadline => "Operationalize AvePoint Elements without living in raw API documentation.";

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
    }

    [RelayCommand]
    private void SelectSection(string? section)
    {
        if (!string.IsNullOrWhiteSpace(section))
        {
            SelectedSection = section;
        }
    }

    [RelayCommand]
    private void Connect()
    {
        ConnectionState = "Connected";
        StatusMessage = $"Connected to {Environment} for {TenantLabel}";
        SelectedBundleSummary = "Common, Baseline, User, Risk, Workspace";
        ActivityItems.Insert(0, new ActivityItem
        {
            Title = "Connected to AvePoint Elements",
            Detail = $"Desktop session initialized for {Environment}.",
            Status = "Connected",
            Timestamp = DateTimeOffset.UtcNow
        });
    }

    [RelayCommand]
    private void Disconnect()
    {
        ConnectionState = "Disconnected";
        StatusMessage = "Session disconnected. Reconnect to continue.";
        ActivityItems.Insert(0, new ActivityItem
        {
            Title = "Disconnected from AvePoint Elements",
            Detail = "Desktop session closed cleanly.",
            Status = "Disconnected",
            Timestamp = DateTimeOffset.UtcNow
        });
    }

    [RelayCommand]
    private void OpenWorkflow(string? workflowTitle)
    {
        if (string.IsNullOrWhiteSpace(workflowTitle))
        {
            return;
        }

        SelectedSection = workflowTitle.Contains("customer", StringComparison.OrdinalIgnoreCase) ? "Customers" : "Operations";
        StatusMessage = $"Prepared workflow: {workflowTitle}";
    }

    [RelayCommand]
    private void ApplySearch()
    {
        var target = string.IsNullOrWhiteSpace(SearchText) ? "all records" : SearchText.Trim();
        StatusMessage = $"Search prepared for {target}.";
    }

    [RelayCommand]
    private void LoadMockCustomer()
    {
        SelectedCustomer = "AvePoint";
        SelectedTenant = "M365x72730749.onmicrosoft.com";
        StatusMessage = "Loaded customer context from the desktop shell.";
        SelectedSection = "Customers";
    }

    [RelayCommand]
    private void GenerateReport(string? reportName)
    {
        var title = string.IsNullOrWhiteSpace(reportName) ? "Operations summary" : reportName;
        SelectedSection = "Reports";
        StatusMessage = $"Queued desktop report view: {title}.";
    }

    public string[] TopCustomerHighlights =>
    [
        "AvePoint  •  2 tenants  •  Finished with exception",
        "Mock MSP  •  1 tenant   •  Baseline management active",
        "MSP Services Inc.  •  1 tenant  •  Backup protected"
    ];

    public string[] OperationsHighlights =>
    [
        "Backup visibility with protected object and storage summaries",
        "Baseline drift review with tenant monitor actions",
        "Risk hit triage across customer and tenant scope",
        "Workspace compliance and data protection posture reporting"
    ];

    public string FilteredNavigationSummary =>
        string.Join("  •  ", NavigationItems.Select(item => item.Title));
}
