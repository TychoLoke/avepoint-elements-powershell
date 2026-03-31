function Show-AvptBanner {
    [CmdletBinding()]
    param()

    $lines = @(
        '    ___              ____       _       __  _____      __           __      '
        '   /   |_   _____   / __ \___  (_)___  / /_/ ___/___  / /__  _____/ /_____ '
        '  / /| | | / / _ \ / /_/ / _ \/ / __ \/ __/\__ \/ _ \/ / _ \/ ___/ __/ __ \'
        ' / ___ | |/ /  __// ____/  __/ / / / / /_ ___/ /  __/ /  __/ /__/ /_/ /_/ /'
        '/_/  |_|___/\___(_)_/    \___/_/_/ /_/\__//____/\___/_/\___/\___/\__/\____/ '
    )

    Write-Host ''
    foreach ($line in $lines) {
        Write-Host $line -ForegroundColor Cyan
    }

    Write-Host ' MSP operations toolkit for the AvePoint Elements API' -ForegroundColor DarkCyan
    Write-Host ''
}

