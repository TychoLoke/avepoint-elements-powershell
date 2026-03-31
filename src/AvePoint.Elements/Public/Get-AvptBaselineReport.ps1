function Get-AvptBaselineReport {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $BaselineId,
        [ValidateRange(1, 100)]
        [int] $PageSize = 50,
        [switch] $All,
        [switch] $Raw
    )

    $path = "/partner/external/v3/bm/baselines/$BaselineId/reports"
    $items = Invoke-AvptPagedOperation -Method Get -Path $path -PageSize $PageSize -All:$All -ScopeBundle 'Baseline'

    if ($Raw) { return $items }

    foreach ($item in $items) {
        ConvertTo-AvptFriendlyObject -InputObject $item -TypeName 'AvePoint.Elements.BaselineReport'
    }
}

