function Get-AvptScanProfileDetail {
    <#
    .SYNOPSIS
    Retrieves the details of a specific scan profile.
    #>
    [CmdletBinding()]
    param(
        [string] $CustomerId,

        [string] $ScanProfileId,

        [switch] $Raw
    )

    $context = Resolve-AvptScanProfileSelection -CustomerId $CustomerId -ScanProfileId $ScanProfileId
    $path = "/partner/external/v3/general/customers/$($context.CustomerId)/scan-profiles/$($context.ScanProfileId)"
    $item = Invoke-AvptWebRequest -Method Get -Path $path -ScopeBundle 'Common'

    if ($Raw) {
        return $item
    }

    $maps = Get-AvptEnumMap
    ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.ScanProfileDetail' -EnumMap @{
        ScanMode = $maps.ScanMode
    }
}
