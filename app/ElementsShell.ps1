if ($MyInvocation.MyCommand.CommandType -eq 'ExternalScript') {
    $launcherRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
}
else {
    $launcherRoot = Split-Path -Parent -Path ([Environment]::GetCommandLineArgs()[0])
    if (-not $launcherRoot) {
        $launcherRoot = '.'
    }
}

$embeddedModulePath = Join-Path -Path $launcherRoot -ChildPath 'embedded/src/AvePoint.Elements/AvePoint.Elements.psd1'
$repoModulePath = Join-Path -Path $launcherRoot -ChildPath '../src/AvePoint.Elements/AvePoint.Elements.psd1'

$modulePath = if (Test-Path -Path $embeddedModulePath) {
    $embeddedModulePath
}
elseif (Test-Path -Path $repoModulePath) {
    $repoModulePath
}
else {
    throw 'Unable to locate the AvePoint.Elements module. The standalone package may be incomplete.'
}

Import-Module $modulePath -Force

Start-AvptElementsShell
