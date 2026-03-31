function Get-AvptScanProfileDetail {
    <#
    .SYNOPSIS
    Retrieves the details of a specific scan profile.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $CustomerId,

        [Parameter(Mandatory)]
        [string] $ScanProfileId,

        [switch] $Raw
    )

    $path = "/partner/external/v3/general/customers/$CustomerId/scan-profiles/$ScanProfileId"
    $item = Invoke-AvptWebRequest -Method Get -Path $path -ScopeBundle 'Common'

    if ($Raw) {
        return $item
    }

    $maps = Get-AvptEnumMap
    ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.ScanProfileDetail' -EnumMap @{
        ScanMode = $maps.ScanMode
    }
}

