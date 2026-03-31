function Show-AvptShellPanel {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Title,

        [string[]] $Lines,

        [ConsoleColor] $AccentColor = 'Cyan'
    )

    $content = @($Lines | Where-Object { $null -ne $_ })
    $width = 108
    $titleText = " $Title "
    $titleWidth = [Math]::Min($titleText.Length, $width - 2)
    $rule = ('=' * [Math]::Max(0, $width - $titleWidth - 2))

    Write-Host ("+{0}{1}+" -f $titleText.Substring(0, $titleWidth), $rule) -ForegroundColor $AccentColor
    if (-not $content -or $content.Count -eq 0) {
        Write-Host ("| {0}|" -f ''.PadRight($width - 2)) -ForegroundColor DarkGray
    }
    else {
        foreach ($line in $content) {
            $safeLine = [string] $line
            if ($safeLine.Length -gt ($width - 4)) {
                $safeLine = $safeLine.Substring(0, $width - 7) + '...'
            }
            Write-Host ("| {0} |" -f $safeLine.PadRight($width - 4)) -ForegroundColor DarkGray
        }
    }
    Write-Host ("+{0}+" -f ('-' * ($width - 2))) -ForegroundColor $AccentColor
}
