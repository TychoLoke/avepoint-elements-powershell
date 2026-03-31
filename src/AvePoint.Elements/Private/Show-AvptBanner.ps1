function Show-AvptBanner {
    [CmdletBinding()]
    param()

    $lines = @(
        '  ________    _______   ________  ___      ___  _______   ________   _________   ________      '
        ' |\   ____\  |\  ___ \ |\   ____\|\  \    /  /||\  ___ \ |\   ___  \|\___   ___\|\   ____\     '
        ' \ \  \___|  \ \   __/|\ \  \___|\ \  \  /  / /\ \   __/|\ \  \\ \  \|___ \  \_|\ \  \___|_    '
        '  \ \  \  ___ \ \  \_|/_\ \  \    \ \  \/  / /  \ \  \_|/_\ \  \\ \  \   \ \  \  \ \_____  \   '
        '   \ \  \|\  \\ \  \_|\ \ \  \____ \ \    / /    \ \  \_|\ \ \  \\ \  \   \ \  \  \|____|\  \  '
        '    \ \_______\\ \_______\\ \_______\\ \__/ /      \ \_______\\ \__\\ \__\   \ \__\   ____\_\  \ '
        '     \|_______| \|_______| \|_______| \|__|/        \|_______| \|__| \|__|    \|__|  |\_________\'
        '                                                                                         \|_________|'
    )

    Write-Host ''
    foreach ($line in $lines) {
        Write-Host $line -ForegroundColor Cyan
    }

    Write-Host ' Elements Shell' -ForegroundColor Yellow
    Write-Host ' MSP operations toolkit for the AvePoint Elements API' -ForegroundColor DarkCyan
    Write-Host ''
}
