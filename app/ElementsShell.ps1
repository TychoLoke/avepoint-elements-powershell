try {
    if ($MyInvocation.MyCommand.CommandType -eq 'ExternalScript') {
        $launcherRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
    }
    else {
        $launcherRoot = Split-Path -Parent -Path ([Environment]::GetCommandLineArgs()[0])
        if (-not $launcherRoot) {
            $launcherRoot = '.'
        }
    }

    $launcherRoot = [System.IO.Path]::GetFullPath($launcherRoot)
    Set-Location -Path $launcherRoot

    $logPath = Join-Path -Path $launcherRoot -ChildPath 'ElementsShell-startup.log'
    $embeddedModulePath = Join-Path -Path $launcherRoot -ChildPath 'embedded/src/AvePoint.Elements/AvePoint.Elements.psd1'
    $repoModulePath = Join-Path -Path $launcherRoot -ChildPath '../src/AvePoint.Elements/AvePoint.Elements.psd1'

    $modulePath = if (Test-Path -Path $embeddedModulePath) {
        $embeddedModulePath
    }
    elseif (Test-Path -Path $repoModulePath) {
        $repoModulePath
    }
    else {
        throw ("Unable to locate the AvePoint.Elements module. Checked: {0} and {1}" -f $embeddedModulePath, $repoModulePath)
    }

    @(
        ('Launcher root: {0}' -f $launcherRoot)
        ('Module path: {0}' -f $modulePath)
        ('Timestamp: {0}' -f (Get-Date).ToString('u'))
    ) | Set-Content -Path $logPath -Encoding UTF8

    Import-Module $modulePath -Force
    Start-AvptElementsShell
}
catch {
    $message = $_ | Out-String
    $safeLogPath = if ($logPath) { $logPath } else { Join-Path -Path (Get-Location) -ChildPath 'ElementsShell-startup.log' }

    @(
        ('Timestamp: {0}' -f (Get-Date).ToString('u'))
        'Elements Shell failed to start.'
        ''
        $message.Trim()
    ) | Set-Content -Path $safeLogPath -Encoding UTF8

    Write-Host ''
    Write-Host 'Elements Shell failed to start.' -ForegroundColor Red
    Write-Host ("Startup log: {0}" -f $safeLogPath) -ForegroundColor Yellow
    Write-Host ''
    Write-Host $message -ForegroundColor DarkYellow
    Write-Host ''
    [void] (Read-Host 'Press Enter to close')
    exit 1
}
