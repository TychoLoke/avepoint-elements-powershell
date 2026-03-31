function Resolve-AvptCustomerSelection {
    [CmdletBinding()]
    param(
        [string] $CustomerId
    )

    if ($CustomerId) {
        return [pscustomobject]@{
            CustomerId = $CustomerId
            Customer   = $null
        }
    }

    $customers = @(Get-AvptCustomer -All)
    $selected = Read-AvptObjectSelection -Title 'Choose a customer:' -Items $customers -LabelScript {
        param($item)
        '{0} [{1}]' -f $item.organization, $item.id
    } -DescriptionScript {
        param($item)
        if ($item.TenantNames) { $item.TenantNames } else { $item.ownerEmail }
    } -Prompt 'Customer number'

    [pscustomobject]@{
        CustomerId = $selected.id
        Customer   = $selected
    }
}

