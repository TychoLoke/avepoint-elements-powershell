using System;

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
