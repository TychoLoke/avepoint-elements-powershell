function Get-AvptProductOverview {
    <#
    .SYNOPSIS
    Retrieves the purchased user seats for an AvePoint product.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $CustomerId,

        [Parameter(Mandatory)]
        [int] $ProductType,

        [switch] $Raw
    )

    $path = "/partner/external/v3/general/customers/$CustomerId/avpt-products/type/$ProductType/overview"
    $item = Invoke-AvptWebRequest -Method Get -Path $path -ScopeBundle 'Common'

    if ($Raw) {
        return $item
    }

    ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.ProductOverview'
}

