function Read-AvptChoice {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Title,

        [Parameter(Mandatory)]
        [object[]] $Options,

        [string] $Prompt = 'Select a number'
    )

    Write-Host $Title -ForegroundColor Cyan
    for ($index = 0; $index -lt $Options.Count; $index++) {
        $item = $Options[$index]
        Write-Host (' {0,2}. {1}' -f ($index + 1), $item.Label) -ForegroundColor Yellow
        if ($item.Description) {
            Write-Host ('     {0}' -f $item.Description) -ForegroundColor DarkGray
        }
    }

    Write-Host ''
    $selection = Read-Host $Prompt
    if ([string]::IsNullOrWhiteSpace($selection)) {
        throw 'No selection was provided.'
    }

    $number = [int] $selection
    if ($number -lt 1 -or $number -gt $Options.Count) {
        throw "Invalid selection number: $number"
    }

    $Options[$number - 1].Value
}

