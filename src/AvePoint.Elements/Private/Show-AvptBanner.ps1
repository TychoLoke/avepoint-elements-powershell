function Show-AvptBanner {
    [CmdletBinding()]
    param()

    $lines = @(
        '=============================================================================================='
        '  EEEEE   L      EEEEE  M   M  EEEEE  N   N  TTTTT  SSSSS'
        '  E       L      E      MM MM  E      NN  N    T    S    '
        '  EEEE    L      EEEE   M M M  EEEE   N N N    T     SSS '
        '  E       L      E      M   M  E      N  NN    T        S'
        '  EEEEE   LLLLL  EEEEE  M   M  EEEEE  N   N    T    SSSSS'
        '=============================================================================================='
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
