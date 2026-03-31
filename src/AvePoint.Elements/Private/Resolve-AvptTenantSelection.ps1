function Resolve-AvptTenantSelection {
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $TenantId
    )

    $customerContext = Resolve-AvptCustomerSelection -CustomerId $CustomerId
    if ($TenantId) {
        return [pscustomobject]@{
            CustomerId = $customerContext.CustomerId
            TenantId   = $TenantId
            Tenant     = $null
        }
    }

    $customer = if ($customerContext.Customer) { $customerContext.Customer } else { @(Get-AvptCustomer -CustomerId $customerContext.CustomerId)[0] }
    $tenants = @($customer.tenants)
    $selected = Read-AvptObjectSelection -Title 'Choose a tenant:' -Items $tenants -LabelScript {
        param($item)
        '{0} [{1}]' -f $item.name, $item.id
    } -DescriptionScript { param($item) 'Customer tenant' } -Prompt 'Tenant number'

    [pscustomobject]@{
        CustomerId = $customerContext.CustomerId
        TenantId   = $selected.id
        Tenant     = $selected
    }
}

