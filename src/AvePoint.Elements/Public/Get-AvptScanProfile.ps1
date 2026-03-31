function Get-AvptScanProfile {
    <#
    .SYNOPSIS
    Retrieves scan profiles for a customer.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $CustomerId,

        [string[]] $ScanProfileId,

        [ValidateRange(1, 100)]
        [int] $PageSize = 50,

        [switch] $All,
        [switch] $Raw
    )

    $path = "/partner/external/v3/general/customers/$CustomerId/scan-profiles/batch"
    $items = Invoke-AvptPagedOperation -Method Post -Path $path -Body @{
        scanProfileIds = $ScanProfileId
    } -PageSize $PageSize -All:$All -ScopeBundle 'Common'

    if ($Raw) {
        return $items
    }

    $maps = Get-AvptEnumMap
    foreach ($item in $items) {
        ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.ScanProfile' -EnumMap @{
            ScanMode = $maps.ScanMode
        }
    }
}

