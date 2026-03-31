function Read-AvptScopeBundleSelection {
    [CmdletBinding()]
    param()

    $catalog = Get-AvptScopeBundleCatalog
    $indexedCatalog = for ($index = 0; $index -lt $catalog.Count; $index++) {
        [pscustomobject]@{
            Number      = $index + 1
            Name        = $catalog[$index].Name
            Description = $catalog[$index].Description
            Scope       = $catalog[$index].Scope
        }
    }

    Write-Host ''
    Write-Host 'Available AvePoint Elements scope bundles:' -ForegroundColor Cyan
    foreach ($item in $indexedCatalog) {
        Write-Host (' {0,2}. {1}' -f $item.Number, $item.Name) -ForegroundColor Yellow
        Write-Host ('     {0}' -f $item.Description) -ForegroundColor DarkGray
    }

    Write-Host ''
    $selection = Read-Host 'Enter one or more bundle numbers separated by commas'
    if ([string]::IsNullOrWhiteSpace($selection)) {
        throw 'No scope bundles were selected.'
    }

    $selectedNumbers = $selection -split '[,\s]+' |
        Where-Object { $_ } |
        ForEach-Object { [int] $_ } |
        Select-Object -Unique

    $selectedNames = foreach ($number in $selectedNumbers) {
        $match = $indexedCatalog | Where-Object Number -eq $number
        if (-not $match) {
            throw "Invalid scope bundle selection number: $number"
        }

        $match.Name
    }

    @($selectedNames | Select-Object -Unique)
}

