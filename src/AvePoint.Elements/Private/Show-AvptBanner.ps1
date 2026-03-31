function Show-AvptBanner {
    [CmdletBinding()]
    param()

    $lines = @(
        '      _    __   ________ ____  ____  ____  _______   ________   ________   _______   __  ________'
        '     / \  / /  / ____/ // __ \/ __ \/  _/ / ___/ /  / ____/ /  / ____/ /  / ____/ | / / /_  __/ __ \\'
        '    /  |/ /  / __/ / // /_/ / / / // /   \__ \/ /  / __/ / /  / __/ / /  / __/ /  |/ /   / / / / / /'
        '   / /|  /  / /___/ // ____/ /_/ // /   ___/ / /__/ /___/ /__/ /___/ /__/ /___/ /|  /   / / / /_/ / '
        '  /_/ |_/  /_____/_//_/    \____/___/  /____/____/_____/____/_____/____/_____/_/ |_/   /_/  \____/  '
    )

    Write-Host ''
    foreach ($line in $lines) {
        Write-Host $line -ForegroundColor Cyan
    }

    Write-Host ' AvePoint Elements PowerShell Toolkit' -ForegroundColor Yellow
    Write-Host ' MSP operations toolkit for the AvePoint Elements API' -ForegroundColor DarkCyan
    Write-Host ''
}
