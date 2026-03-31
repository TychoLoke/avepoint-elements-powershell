function Get-AvptWorkspaceDataSecurityPosture {
    <#
    .SYNOPSIS
    Retrieves workspace data security posture statistics for a tenant.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $TenantId,
        [switch] $Raw
    )

    $tenantContext = Resolve-AvptTenantSelection -CustomerId $CustomerId -TenantId $TenantId
    $path = "/partner/external/v3/wm/customers/$($tenantContext.CustomerId)/tenants/$($tenantContext.TenantId)/overview/dspm/insights"
    $item = Invoke-AvptWebRequest -Method Get -Path $path -ScopeBundle 'Workspace'

    if ($Raw) { return $item }

    $posture = ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.WorkspaceDataSecurityPosture'
    $total = 0
    foreach ($property in $item.PSObject.Properties) {
        if ($property.Value -is [int] -or $property.Value -is [long]) {
            $total += [int64] $property.Value
        }
    }
    $posture | Add-Member -NotePropertyName TotalSensitiveExposureSignals -NotePropertyValue $total
    $posture
}
