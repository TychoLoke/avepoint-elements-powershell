function Resolve-AvptUserSelection {
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $TenantId,
        [string] $UserId
    )

    $tenantContext = Resolve-AvptTenantSelection -CustomerId $CustomerId -TenantId $TenantId
    if ($UserId) {
        return [pscustomobject]@{
            CustomerId = $tenantContext.CustomerId
            TenantId   = $tenantContext.TenantId
            UserId     = $UserId
            User       = $null
        }
    }

    $users = @(Get-AvptSecurityUserOverview -CustomerId $tenantContext.CustomerId -TenantId $tenantContext.TenantId -All)
    $selected = Read-AvptObjectSelection -Title 'Choose a user:' -Items $users -LabelScript {
        param($item)
        '{0} [{1}]' -f $item.displayName, $item.id
    } -DescriptionScript {
        param($item)
        if ($item.StatusNames) {
            '{0} | {1}' -f $item.userPrincipalName, $item.StatusNames
        }
        else {
            $item.userPrincipalName
        }
    } -Prompt 'User number'

    [pscustomobject]@{
        CustomerId = $tenantContext.CustomerId
        TenantId   = $tenantContext.TenantId
        UserId     = $selected.id
        User       = $selected
    }
}
