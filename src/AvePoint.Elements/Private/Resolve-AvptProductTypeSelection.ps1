function Resolve-AvptProductTypeSelection {
    [CmdletBinding()]
    param(
        [int] $ProductType
    )

    if ($PSBoundParameters.ContainsKey('ProductType')) {
        return $ProductType
    }

    $products = Get-AvptProductTypeCatalog
    $selected = Read-AvptObjectSelection -Title 'Choose an AvePoint product type:' -Items $products -LabelScript {
        param($item)
        '{0} [{1}]' -f $item.Name, $item.ProductType
    } -Prompt 'Product number'

    $selected.ProductType
}

