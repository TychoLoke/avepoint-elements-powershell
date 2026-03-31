function Get-AvptBaseline {
    [CmdletBinding()]
    param(
        [string[]] $BaselineId,
        [ValidateRange(1, 100)]
        [int] $PageSize = 50,
        [switch] $All,
        [switch] $Raw
    )

    $items = Invoke-AvptPagedOperation -Method Post -Path '/partner/external/v3/bm/baselines/batch' -Body @{
        baselineIds = $BaselineId
    } -PageSize $PageSize -All:$All -ScopeBundle 'Baseline'

    if ($Raw) { return $items }

    $maps = Get-AvptEnumMap
    foreach ($item in $items) {
        ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.Baseline' -EnumMap @{
            Status = $maps.BaselineStatus
        }
    }
}

