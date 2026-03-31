function Get-AvptRiskHitItem {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $CustomerId,
        [Parameter(Mandatory)]
        [string] $TenantId,
        [Parameter(Mandatory)]
        [string] $RuleId,
        [ValidateRange(1, 100)]
        [int] $PageSize = 50,
        [switch] $All,
        [switch] $Raw
    )

    $path = "/partner/external/v3/rm/customers/$CustomerId/tenants/$TenantId/detection/rules/$RuleId/hit-items"
    $items = Invoke-AvptPagedOperation -Method Get -Path $path -PageSize $PageSize -All:$All -ScopeBundle 'Risk' -MetadataProperty 'metaData'

    if ($Raw) { return $items }

    $maps = Get-AvptEnumMap
    foreach ($item in $items) {
        $hit = ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.RiskHitItem' -EnumMap @{
            DataSource = $maps.RiskDataSource
        }
        if ($item.detail) {
            $hit.detail = ConvertTo-AvptNestedObject -InputObject $item.detail -TypeName 'AvePoint.Elements.RiskHitItemDetail'
        }
        $hit
    }
}

