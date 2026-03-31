function Get-AvptWorkspaceDataProtectionStatistic {
    <#
    .SYNOPSIS
    Retrieves workspace data protection statistics for a tenant.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $TenantId,
        [switch] $Raw
    )

    $tenantContext = Resolve-AvptTenantSelection -CustomerId $CustomerId -TenantId $TenantId
    $path = "/partner/external/v3/wm/customers/$($tenantContext.CustomerId)/tenants/$($tenantContext.TenantId)/overview/data-protection/ransomware-detection"
    $item = Invoke-AvptWebRequest -Method Get -Path $path -ScopeBundle 'Workspace'

    if ($Raw) { return $item }

    $statistic = ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.WorkspaceDataProtectionStatistic'
    $riskSignals = 0
    foreach ($property in $item.PSObject.Properties) {
        if ($property.Value -is [int] -or $property.Value -is [long]) {
            $riskSignals += [int64] $property.Value
        }
    }
    $statistic | Add-Member -NotePropertyName TotalProtectionAlerts -NotePropertyValue $riskSignals
    $statistic
}
