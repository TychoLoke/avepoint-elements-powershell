function Get-AvptProductOverview {
    <#
    .SYNOPSIS
    Retrieves the purchased user seats for an AvePoint product.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,

        [int] $ProductType,

        [switch] $Raw
    )

    $CustomerId = (Resolve-AvptCustomerSelection -CustomerId $CustomerId).CustomerId
    $ProductType = Resolve-AvptProductTypeSelection -ProductType $ProductType

    $path = "/partner/external/v3/general/customers/$CustomerId/avpt-products/type/$ProductType/overview"
    $item = Invoke-AvptWebRequest -Method Get -Path $path -ScopeBundle 'Common'

    if ($Raw) {
        return $item
    }

    ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.ProductOverview'
}
