function Get-AvptCustomer {
    <#
    .SYNOPSIS
    Retrieves customers managed by the current partner.
    #>
    [CmdletBinding()]
    param(
        [string[]] $CustomerId,
        [ValidateRange(1, 100)]
        [int] $PageSize = 50,
        [switch] $All,
        [switch] $Raw
    )

    $items = Invoke-AvptPagedOperation -Method Post -Path '/partner/external/v3/general/customers/batch' -Body @{
        customerIds = $CustomerId
    } -PageSize $PageSize -All:$All -ScopeBundle 'Common'

    if ($Raw) {
        return $items
    }

    $maps = Get-AvptEnumMap
    foreach ($item in $items) {
        $customer = ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.Customer' -EnumMap @{
            JobStatus      = $maps.JobStatus
            ManagementMode = $maps.ManagementMode
        }
        $customer | Add-Member -NotePropertyName TenantCount -NotePropertyValue @($item.tenants).Count
        $customer | Add-Member -NotePropertyName TenantNames -NotePropertyValue (@($item.tenants | ForEach-Object { $_.name }) -join ', ')
        $customer.tenants = @($item.tenants | ForEach-Object { ConvertTo-AvptNestedObject -InputObject $_ -TypeName 'AvePoint.Elements.CustomerTenant' })
        $customer
    }
}
