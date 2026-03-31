function Get-AvptRiskRule {
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $TenantId,
        [int[]] $DataSource,
        [ValidateSet(0,1)]
        [int] $Status,
        [switch] $Raw
    )

    $tenantContext = Resolve-AvptTenantSelection -CustomerId $CustomerId -TenantId $TenantId
    $query = @{}
    if ($PSBoundParameters.ContainsKey('DataSource')) { $query.dataSources = ($DataSource -join ',') }
    if ($PSBoundParameters.ContainsKey('Status')) { $query.status = $Status }

    $path = "/partner/external/v3/rm/customers/$($tenantContext.CustomerId)/tenants/$($tenantContext.TenantId)/detection/rules"
    $response = Invoke-AvptWebRequest -Method Get -Path $path -Query $query -ScopeBundle 'Risk'
    $items = @($response.result)

    if ($Raw) { return $items }

    $maps = Get-AvptEnumMap
    foreach ($item in $items) {
        ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.RiskRule' -EnumMap @{
            DataSource = $maps.RiskDataSource
        }
    }
}
