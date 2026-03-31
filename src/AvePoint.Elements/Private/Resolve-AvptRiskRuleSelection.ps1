function Resolve-AvptRiskRuleSelection {
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $TenantId,
        [string] $RuleId
    )

    $tenantContext = Resolve-AvptTenantSelection -CustomerId $CustomerId -TenantId $TenantId
    if ($RuleId) {
        return [pscustomobject]@{
            CustomerId = $tenantContext.CustomerId
            TenantId   = $tenantContext.TenantId
            RuleId     = $RuleId
            Rule       = $null
        }
    }

    $rules = @(Get-AvptRiskRule -CustomerId $tenantContext.CustomerId -TenantId $tenantContext.TenantId)
    $selected = Read-AvptObjectSelection -Title 'Choose a risk rule:' -Items $rules -LabelScript {
        param($item)
        '{0} [{1}]' -f $item.ruleName, $item.ruleId
    } -DescriptionScript {
        param($item)
        '{0} hits from {1}' -f $item.hitItemCount, $item.DataSourceName
    } -Prompt 'Risk rule number'

    [pscustomobject]@{
        CustomerId = $tenantContext.CustomerId
        TenantId   = $tenantContext.TenantId
        RuleId     = $selected.ruleId
        Rule       = $selected
    }
}
