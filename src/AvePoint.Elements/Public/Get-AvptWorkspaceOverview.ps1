function Get-AvptWorkspaceOverview {
    <#
    .SYNOPSIS
    Retrieves workspace overview statistics for a tenant.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $TenantId,
        [switch] $Raw
    )

    $tenantContext = Resolve-AvptTenantSelection -CustomerId $CustomerId -TenantId $TenantId
    $path = "/partner/external/v3/wm/customers/$($tenantContext.CustomerId)/tenants/$($tenantContext.TenantId)/overview/workspace"
    $item = Invoke-AvptWebRequest -Method Get -Path $path -ScopeBundle 'Workspace'

    if ($Raw) { return $item }

    $workspace = ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.WorkspaceOverview'
    $guestWorkspaceRate = if ($item.workspaces -gt 0) { [math]::Round(($item.workspacesWithGuestUsers / $item.workspaces) * 100, 2) } else { 0 }
    $orphanedWorkspaceRate = if ($item.workspaces -gt 0) { [math]::Round(($item.orphanedWorkspaces / $item.workspaces) * 100, 2) } else { 0 }
    $workspace | Add-Member -NotePropertyName GuestWorkspaceRate -NotePropertyValue $guestWorkspaceRate
    $workspace | Add-Member -NotePropertyName OrphanedWorkspaceRate -NotePropertyValue $orphanedWorkspaceRate
    $workspace
}
