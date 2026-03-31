function Get-AvptScanProfileChange {
    <#
    .SYNOPSIS
    Retrieves daily change details for a specific scan profile.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,

        [string] $ScanProfileId,

        [switch] $Raw
    )

    $context = Resolve-AvptScanProfileSelection -CustomerId $CustomerId -ScanProfileId $ScanProfileId
    $path = "/partner/external/v3/general/customers/$($context.CustomerId)/scan-profiles/$($context.ScanProfileId)/changes"
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
