function Get-AvptWorkspaceCompliance {
    <#
    .SYNOPSIS
    Retrieves workspace compliance statistics for a tenant.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $TenantId,
        [switch] $Raw
    )

    $tenantContext = Resolve-AvptTenantSelection -CustomerId $CustomerId -TenantId $TenantId
    $path = "/partner/external/v3/wm/customers/$($tenantContext.CustomerId)/tenants/$($tenantContext.TenantId)/overview/data-protection/compliance-rate"
    $item = Invoke-AvptWebRequest -Method Get -Path $path -ScopeBundle 'Workspace'

    if ($Raw) { return $item }

    $compliance = ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.WorkspaceCompliance'
    $total = [int] $item.workspacesInCompliance + [int] $item.workspacesOutOfCompliance
    $complianceRate = if ($total -gt 0) { [math]::Round(($item.workspacesInCompliance / $total) * 100, 2) } else { 0 }
    $compliance | Add-Member -NotePropertyName TotalWorkspacesEvaluated -NotePropertyValue $total
    $compliance | Add-Member -NotePropertyName ComplianceRate -NotePropertyValue $complianceRate
    $compliance
}
