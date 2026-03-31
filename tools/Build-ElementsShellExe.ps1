[CmdletBinding()]
param(
    [string] $OutputPath = (Join-Path -Path $PSScriptRoot -ChildPath '../dist/ElementsShell.exe')
)

if (-not $IsWindows) {
    throw 'ElementsShell.exe packaging is only supported on Windows hosts.'
}

$ps2exe = Get-Module -ListAvailable -Name ps2exe
if (-not $ps2exe) {
    Install-Module ps2exe -Scope CurrentUser -Force -SkipPublisherCheck
}

$scriptPath = Join-Path -Path $PSScriptRoot -ChildPath '../app/ElementsShell.ps1'
$resolvedOutput = [System.IO.Path]::GetFullPath($OutputPath)
$outputDirectory = Split-Path -Path $resolvedOutput -Parent
New-Item -Path $outputDirectory -ItemType Directory -Force | Out-Null
$manifestPath = Join-Path -Path $PSScriptRoot -ChildPath '../src/AvePoint.Elements/AvePoint.Elements.psd1'
$manifest = Import-PowerShellDataFile -Path $manifestPath
$version = [string] $manifest.ModuleVersion
$iconPath = Join-Path -Path $PSScriptRoot -ChildPath '../app/ElementsShell.ico'
$moduleRoot = Join-Path -Path $PSScriptRoot -ChildPath '../src/AvePoint.Elements'

& (Join-Path -Path $PSScriptRoot -ChildPath 'New-ElementsShellIcon.ps1') -OutputPath $iconPath

$embedFiles = @{}
foreach ($file in Get-ChildItem -Path $moduleRoot -Recurse -File) {
    $relativePath = $file.FullName.Substring($moduleRoot.Length).TrimStart('\', '/')
    $targetPath = '.\embedded\src\AvePoint.Elements\' + ($relativePath -replace '/', '\')
    $embedFiles[$targetPath] = $file.FullName
}

Invoke-PS2EXE -InputFile $scriptPath -OutputFile $resolvedOutput -Title 'Elements Shell' -Product 'AvePoint Elements PowerShell' -Description 'Interactive shell for the AvePoint Elements PowerShell toolkit' -Company 'Open Source' -Copyright 'Copyright (c) 2026 Tycho Loke' -Trademark 'AvePoint Elements PowerShell' -Version $version -iconFile $iconPath -embedFiles $embedFiles -NoConsole:$false

$zipPath = Join-Path -Path $outputDirectory -ChildPath ("ElementsShell-win-x64-{0}.zip" -f $version)
if (Test-Path $zipPath) {
    Remove-Item -Path $zipPath -Force
}
Compress-Archive -Path $resolvedOutput -DestinationPath $zipPath -CompressionLevel Optimal

$checksumPath = Join-Path -Path $outputDirectory -ChildPath ("ElementsShell-{0}-sha256.txt" -f $version)
$exeHash = Get-FileHash -Path $resolvedOutput -Algorithm SHA256
$zipHash = Get-FileHash -Path $zipPath -Algorithm SHA256
@(
    "{0}  {1}" -f $exeHash.Hash.ToLowerInvariant(), [System.IO.Path]::GetFileName($resolvedOutput)
    "{0}  {1}" -f $zipHash.Hash.ToLowerInvariant(), [System.IO.Path]::GetFileName($zipPath)
) | Set-Content -Path $checksumPath -Encoding ASCII

Write-Host ("Created executable at {0}" -f $resolvedOutput)
Write-Host ("Created zip at {0}" -f $zipPath)
Write-Host ("Created checksum file at {0}" -f $checksumPath)
