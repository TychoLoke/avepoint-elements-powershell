using System;
using System.Collections.Generic;

namespace ElementsShell.Desktop.Models;

public sealed class NavigationItem
{
    public required string Title { get; init; }

    public required string Subtitle { get; init; }

    public required string Glyph { get; init; }
}

public sealed class MetricCard
{
    public required string Title { get; init; }

    public required string Value { get; init; }

    public required string Delta { get; init; }

    public required string AccentHex { get; init; }
}

public sealed class DashboardActionCard
{
    public required string Title { get; init; }

    public required string Detail { get; init; }

    public required string CommandLabel { get; init; }

    public required string CommandParameter { get; init; }

    public required string AccentHex { get; init; }
}

public sealed class WorkflowItem
{
    public required string Title { get; init; }

    public required string Detail { get; init; }

    public required string ScopeBundle { get; init; }
}

public sealed class ActivityItem
{
    public required string Title { get; init; }

    public required string Detail { get; init; }

    public required string Status { get; init; }

    public required DateTimeOffset Timestamp { get; init; }
}

public sealed class DependencyCheckItem
{
    public required string Name { get; init; }

    public required string Status { get; init; }

    public required string Detail { get; init; }
}

public sealed class OnboardingStep
{
    public required string Number { get; init; }

    public required string Title { get; init; }

    public required string Detail { get; init; }
}

public sealed class RecentCustomerItem
{
    public string CustomerId { get; init; } = string.Empty;

    public string Organization { get; init; } = string.Empty;

    public string OwnerEmail { get; init; } = string.Empty;

    public string TenantNames { get; init; } = string.Empty;

    public int TenantCount { get; init; }

    public string ManagementModeName { get; init; } = string.Empty;

    public string LastAccessedLabel { get; init; } = string.Empty;
}

public sealed class TenantChip
{
    public string Name { get; init; } = string.Empty;
}

public sealed class CustomerWorkspaceStat
{
    public required string Label { get; init; }

    public required string Value { get; init; }

    public required string Detail { get; init; }
}

public sealed class TenantWorkspaceCard
{
    public string Name { get; init; } = string.Empty;

    public string Subtitle { get; init; } = string.Empty;

    public string AccentHex { get; init; } = "#0F7BFF";

    public string ActionLabel { get; init; } = "Use Tenant";
}

public sealed class ReportInsightCard
{
    public required string Title { get; init; }

    public required string Value { get; init; }

    public required string Detail { get; init; }

    public string AccentHex { get; init; } = "#0F7BFF";
}

public sealed class TenantDetailMetric
{
    public required string Label { get; init; }

    public required string Value { get; init; }

    public required string Detail { get; init; }

    public string AccentHex { get; init; } = "#0F7BFF";
}

public sealed class VisualTrendCard
{
    public required string Title { get; init; }

    public required string Value { get; init; }

    public required string Detail { get; init; }

    public double FillWidth { get; init; }

    public string AccentHex { get; init; } = "#0F7BFF";
}

public sealed class DesktopConnectionSettings
{
    public required string Environment { get; init; }

    public string TenantLabel { get; init; } = string.Empty;

    public required string ClientId { get; init; }

    public required string ClientSecret { get; init; }

    public required IReadOnlyList<string> ScopeBundles { get; init; }
}

public sealed class BundleStatusResult
{
    public string Name { get; init; } = string.Empty;

    public int RequestedScopeCount { get; init; }

    public int RequestedScopeLength { get; init; }

    public DateTimeOffset? ExpiresAt { get; init; }
}

public sealed class ConnectionResult
{
    public string Environment { get; init; } = string.Empty;

    public string ClientId { get; init; } = string.Empty;

    public string AuthType { get; init; } = string.Empty;

    public string? TenantName { get; init; }

    public IReadOnlyList<string> ScopeBundle { get; init; } = Array.Empty<string>();

    public IReadOnlyList<BundleStatusResult> BundleStatus { get; init; } = Array.Empty<BundleStatusResult>();
}

public sealed class CustomerRecord
{
    public string Id { get; init; } = string.Empty;

    public string Organization { get; init; } = string.Empty;

    public string OwnerEmail { get; init; } = string.Empty;

    public string CountryOrRegion { get; init; } = string.Empty;

    public string JobStatusName { get; init; } = string.Empty;

    public string ManagementModeName { get; init; } = string.Empty;

    public int TenantCount { get; init; }

    public string TenantNames { get; init; } = string.Empty;
}

public sealed class CustomerSummaryResult
{
    public string CustomerId { get; init; } = string.Empty;

    public string Organization { get; init; } = string.Empty;

    public string OwnerEmail { get; init; } = string.Empty;

    public string CountryOrRegion { get; init; } = string.Empty;

    public string ManagementMode { get; init; } = string.Empty;

    public int TenantCount { get; init; }

    public string TenantNames { get; init; } = string.Empty;

    public int ProductCount { get; init; }

    public string ServiceNames { get; init; } = string.Empty;

    public int BackupModuleCount { get; init; }

    public int ProtectedObjectCount { get; init; }

    public int ScannedObjectCount { get; init; }

    public double AvePointStorageGb { get; init; }
}
