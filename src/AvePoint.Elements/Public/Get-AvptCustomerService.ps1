function Get-AvptCustomerService {
    <#
    .SYNOPSIS
    Retrieves service subscriptions for customers managed by the current partner.
    #>
    [CmdletBinding()]
    param(
        [string[]] $CustomerId,
        [ValidateRange(1, 100)]
        [int] $PageSize = 50,
        [switch] $All,
        [switch] $Raw
    )

    $items = Invoke-AvptPagedOperation -Method Post -Path '/partner/external/v3/general/customers/services/batch' -Body @{
        customerIds = $CustomerId
    } -PageSize $PageSize -All:$All -ScopeBundle 'Common'

    if ($Raw) {
        return $items
    }

    foreach ($item in $items) {
        $service = ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.CustomerService'
        $service | Add-Member -NotePropertyName ProductCount -NotePropertyValue @($item.products).Count
        $service | Add-Member -NotePropertyName ServiceNames -NotePropertyValue (@($item.products | ForEach-Object { $_.service }) -join ', ')
        $service.products = @($item.products | ForEach-Object { ConvertTo-AvptNestedObject -InputObject $_ -TypeName 'AvePoint.Elements.ServiceSubscription' })
        $service
    }
}
