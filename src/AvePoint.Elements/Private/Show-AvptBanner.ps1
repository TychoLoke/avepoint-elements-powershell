function Show-AvptBanner {
    [CmdletBinding()]
    param()

    $lines = @(
        '==============================================================================================='
        '  _______   __       ________  __       __  ________  __    __  _________   ________         '
        ' / ____/ | / /      / ____/ / / /      /  |/  / __ \\/ /   / / / /_  __/  / ____/ /         '
        '/ __/ /  |/ /______/ __/ / / / /______/ /|_/ / /_/ / /   / /_/ / / /    / /   / /          '
        '/ /___/ /|  /_____/ /___/ /_/ /_____/ /  / / ____/ /___/ __  / / /    / /___/ /___         '
        '/_____/_/ |_/     /_____/\\____/     /_/  /_/_/   /_____/_/ /_/ /_/     \\____/_____/        '
        '==============================================================================================='
    )

    Write-Host ''
    for ($index = 0; $index -lt $lines.Count; $index++) {
        $color = if ($index -in 0, ($lines.Count - 1)) { 'DarkRed' } else { 'Blue' }
        Write-Host $lines[$index] -ForegroundColor $color
    }

    Write-Host ' ELEMENTS SHELL' -ForegroundColor Red
    Write-Host ' AvePoint Elements PowerShell Toolkit for MSP Operations' -ForegroundColor Cyan
    Write-Host ' Secure multi-scope session onboarding for the AvePoint Elements API' -ForegroundColor DarkBlue
    Write-Host ''
}
