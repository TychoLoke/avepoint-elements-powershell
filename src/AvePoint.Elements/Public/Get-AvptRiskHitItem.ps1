function Get-AvptRiskHitItem {
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $TenantId,
        [string] $RuleId,
        [ValidateRange(1, 100)]
        [int] $PageSize = 50,
        [switch] $All,
        [switch] $Raw
    )

    $context = Resolve-AvptRiskRuleSelection -CustomerId $CustomerId -TenantId $TenantId -RuleId $RuleId
    $path = "/partner/external/v3/rm/customers/$($context.CustomerId)/tenants/$($context.TenantId)/detection/rules/$($context.RuleId)/hit-items"
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
