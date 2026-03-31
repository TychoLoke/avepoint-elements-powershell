function Resolve-AvptDataCenterSelection {
    [CmdletBinding()]
    param(
        [string] $DataCenterId,
        [string] $Environment
    )

    if ($DataCenterId) {
        return $DataCenterId
    }

    $items = Get-AvptDataCenterCatalog -Environment $Environment
    $selected = Read-AvptObjectSelection -Title 'Choose an AvePoint Elements data center:' -Items $items -LabelScript {
        param($item)
        '{0} [{1}]' -f $item.Name, $item.Region
    } -DescriptionScript {
        param($item)
        $item.DataCenterId
    } -Prompt 'Data center number'

    $selected.DataCenterId
}
