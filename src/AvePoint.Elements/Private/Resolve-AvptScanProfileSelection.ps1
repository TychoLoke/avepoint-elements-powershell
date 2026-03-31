function Resolve-AvptScanProfileSelection {
    [CmdletBinding()]
    param(
        [string] $CustomerId,
        [string] $ScanProfileId
    )

    $customerContext = Resolve-AvptCustomerSelection -CustomerId $CustomerId
    if ($ScanProfileId) {
        return [pscustomobject]@{
            CustomerId    = $customerContext.CustomerId
            ScanProfileId = $ScanProfileId
            ScanProfile   = $null
        }
    }

    $profiles = @(Get-AvptScanProfile -CustomerId $customerContext.CustomerId -All)
    $selected = Read-AvptObjectSelection -Title 'Choose a scan profile:' -Items $profiles -LabelScript {
        param($item)
        '{0} [{1}]' -f $item.profileName, $item.profileId
    } -DescriptionScript {
        param($item)
        '{0} mode' -f $item.ScanModeName
    } -Prompt 'Scan profile number'

    [pscustomobject]@{
        CustomerId    = $customerContext.CustomerId
        ScanProfileId = $selected.profileId
        ScanProfile   = $selected
    }
}

