function Read-AvptPermissionSelection {
    [CmdletBinding()]
    param(
        [switch] $ReadOnlyOnly
    )

    $catalog = Get-AvptPermissionCatalog
    if ($ReadOnlyOnly) {
        $catalog = $catalog | Where-Object AccessLevel -eq 'Read'
    }

    $indexedCatalog = for ($index = 0; $index -lt $catalog.Count; $index++) {
        [pscustomobject]@{
            Number      = $index + 1
            Category    = $catalog[$index].Category
            Scope       = $catalog[$index].Scope
            AccessLevel = $catalog[$index].AccessLevel
            Description = $catalog[$index].Description
        }
    }

    Write-Host ''
    Write-Host 'Available AvePoint Elements permissions:' -ForegroundColor Cyan

    $currentCategory = $null
    foreach ($item in $indexedCatalog) {
        if ($item.Category -ne $currentCategory) {
            $currentCategory = $item.Category
            Write-Host ''
            Write-Host "[$currentCategory]" -ForegroundColor Yellow
        }

        Write-Host (' {0,2}. {1} ({2})' -f $item.Number, $item.Scope, $item.AccessLevel)
    }

    Write-Host ''
    $selection = Read-Host 'Enter one or more numbers separated by commas'

    if ([string]::IsNullOrWhiteSpace($selection)) {
        throw 'No permission scopes were selected.'
    }

    $selectedNumbers = $selection -split '[,\s]+' |
        Where-Object { $_ } |
        ForEach-Object { [int] $_ } |
        Select-Object -Unique

    $selectedScopes = foreach ($number in $selectedNumbers) {
        $match = $indexedCatalog | Where-Object Number -eq $number
        if (-not $match) {
            throw "Invalid permission selection number: $number"
        }

        $match.Scope
    }

    @($selectedScopes | Select-Object -Unique)
}

