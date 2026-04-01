using System.Collections.Generic;

namespace ElementsShell.Desktop.Models;

public sealed class DesktopPreferences
{
    public string Environment { get; set; } = "Commercial";

    public string TenantLabel { get; set; } = "Mock MSP";

    public string OperatorName { get; set; } = "MSP Operator";

    public bool OnboardingDismissed { get; set; }

    public int OnboardingStepIndex { get; set; }

    public List<RecentCustomerPreference> RecentCustomers { get; set; } = [];
}

public sealed class RecentCustomerPreference
{
    public string CustomerId { get; set; } = string.Empty;

    public string Organization { get; set; } = string.Empty;

    public string OwnerEmail { get; set; } = string.Empty;

    public string TenantNames { get; set; } = string.Empty;

    public int TenantCount { get; set; }

    public string ManagementModeName { get; set; } = string.Empty;

    public string LastAccessedLabel { get; set; } = string.Empty;
}
