function Resolve-AvptBaselineSelection {
    [CmdletBinding()]
    param(
        [string] $BaselineId
    )

    if ($BaselineId) {
        return [pscustomobject]@{
            BaselineId = $BaselineId
            Baseline   = $null
        }
    }

    $baselines = @(Get-AvptBaseline -All)
    $selected = Read-AvptObjectSelection -Title 'Choose a baseline:' -Items $baselines -LabelScript {
        param($item)
        '{0} [{1}]' -f $item.baselineName, $item.baselineId
    } -DescriptionScript {
        param($item)
        $item.StatusName
    } -Prompt 'Baseline number'

    [pscustomobject]@{
        BaselineId = $selected.baselineId
        Baseline   = $selected
    }
}

