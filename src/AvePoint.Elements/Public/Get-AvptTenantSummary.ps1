function Get-AvptTenantSummary {
    <#
    .SYNOPSIS
    Retrieves an operator-friendly tenant summary across user, workspace, and protection views.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $TenantId,
        [switch] $Raw
    )

    $tenantContext = Resolve-AvptTenantSelection -CustomerId $CustomerId -TenantId $TenantId
    $securityUsers = @(Get-AvptSecurityUserOverview -CustomerId $tenantContext.CustomerId -TenantId $tenantContext.TenantId -All)
    $workspace = Get-AvptWorkspaceOverview -CustomerId $tenantContext.CustomerId -TenantId $tenantContext.TenantId
    $compliance = Get-AvptWorkspaceCompliance -CustomerId $tenantContext.CustomerId -TenantId $tenantContext.TenantId
    $posture = Get-AvptWorkspaceDataSecurityPosture -CustomerId $tenantContext.CustomerId -TenantId $tenantContext.TenantId
    $protection = Get-AvptWorkspaceDataProtectionStatistic -CustomerId $tenantContext.CustomerId -TenantId $tenantContext.TenantId

    if ($Raw) {
        return [pscustomobject]@{
            SecurityUserOverview          = $securityUsers
            WorkspaceOverview             = $workspace
            WorkspaceCompliance           = $compliance
            WorkspaceDataSecurityPosture  = $posture
            WorkspaceDataProtection       = $protection
        }
    }

    $statusTotals = @{}
    foreach ($user in $securityUsers) {
        foreach ($status in @($user.StatusCodes)) {
            $statusKey = [string] $status
            if (-not $statusTotals.ContainsKey($statusKey)) {
                $statusTotals[$statusKey] = 0
            }
            $statusTotals[$statusKey]++
        }
    }

    $summary = [pscustomobject]@{
        CustomerId                   = $tenantContext.CustomerId
        TenantId                     = $tenantContext.TenantId
        UserCount                    = @($securityUsers).Count
        HighRiskUserCount            = if ($statusTotals.ContainsKey('3')) { $statusTotals['3'] } else { 0 }
        InactiveUserCount            = if ($statusTotals.ContainsKey('6')) { $statusTotals['6'] } else { 0 }
        TestUserCount                = if ($statusTotals.ContainsKey('8')) { $statusTotals['8'] } else { 0 }
        Workspaces                   = $workspace.workspaces
        ActiveWorkspaces             = $workspace.activeWorkspaces
        OrphanedWorkspaces           = $workspace.orphanedWorkspaces
        GuestWorkspaceRate           = $workspace.GuestWorkspaceRate
        ComplianceRate               = $compliance.ComplianceRate
        SensitiveExposureSignals     = $posture.TotalSensitiveExposureSignals
        ProtectionAlerts             = $protection.TotalProtectionAlerts
    }
    $summary.PSObject.TypeNames.Insert(0, 'AvePoint.Elements.TenantSummary')
    $summary
}
