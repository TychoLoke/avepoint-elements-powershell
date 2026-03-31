function Get-AvptScanProfileChange {
    <#
    .SYNOPSIS
    Retrieves daily change details for a specific scan profile.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $CustomerId,

        [Parameter(Mandatory)]
        [string] $ScanProfileId,

        [switch] $Raw
    )

    $path = "/partner/external/v3/general/customers/$CustomerId/scan-profiles/$ScanProfileId/changes"
    $item = Invoke-AvptWebRequest -Method Get -Path $path -ScopeBundle 'Common'

    if ($Raw) {
        return $item
    }

    $maps = Get-AvptEnumMap
    ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.ScanProfileChange' -EnumMap @{
        ScanMode       = $maps.ScanMode
        LastScanStatus = $maps.LastScanStatus
    }
}
