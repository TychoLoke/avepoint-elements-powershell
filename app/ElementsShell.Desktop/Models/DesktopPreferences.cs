namespace ElementsShell.Desktop.Models;

public sealed class DesktopPreferences
{
    public string Environment { get; set; } = "Commercial";

    public string TenantLabel { get; set; } = "Mock MSP";

    public string OperatorName { get; set; } = "MSP Operator";

    public bool OnboardingDismissed { get; set; }
}
