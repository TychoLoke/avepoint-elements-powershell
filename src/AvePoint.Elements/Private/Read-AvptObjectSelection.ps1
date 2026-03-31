function Read-AvptObjectSelection {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Title,

        [Parameter(Mandatory)]
        [object[]] $Items,

        [Parameter(Mandatory)]
        [scriptblock] $LabelScript,

        [scriptblock] $DescriptionScript,

        [string] $Prompt = 'Select a number'
    )

    if (-not $Items -or $Items.Count -eq 0) {
        throw "No selectable items were found for '$Title'."
    }

    $options = foreach ($item in $Items) {
        [pscustomobject]@{
            Label       = & $LabelScript $item
            Description = if ($DescriptionScript) { & $DescriptionScript $item } else { $null }
            Value       = $item
        }
    }

    Read-AvptChoice -Title $Title -Options $options -Prompt $Prompt
}

