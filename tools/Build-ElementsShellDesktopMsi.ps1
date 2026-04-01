[CmdletBinding()]
param(
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',

    [string]$Runtime = 'win-x64',

    [string]$OutputRoot = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not $IsWindows) {
    throw 'MSI packaging is only supported on Windows because WiX Toolset builds MSI packages on Windows hosts.'
}

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$moduleManifestPath = Join-Path $repoRoot 'src/AvePoint.Elements/AvePoint.Elements.psd1'
$installerProjectPath = Join-Path $repoRoot 'installer/ElementsShell.Desktop.Installer/ElementsShell.Desktop.Installer.wixproj'

if (-not (Test-Path $moduleManifestPath)) {
    throw "Module manifest not found at $moduleManifestPath"
}

if (-not (Test-Path $installerProjectPath)) {
    throw "Installer project not found at $installerProjectPath"
}

$moduleManifest = Import-PowerShellDataFile -Path $moduleManifestPath
$version = $moduleManifest.ModuleVersion.ToString()

$publishRoot = Join-Path $repoRoot "dist/desktop/$version"
if (-not (Test-Path (Join-Path $publishRoot 'ElementsShell.exe'))) {
    & (Join-Path $PSScriptRoot 'Build-ElementsShellDesktop.ps1') -Configuration $Configuration -Runtime $Runtime
}

if (-not $OutputRoot) {
    $OutputRoot = Join-Path $repoRoot 'dist/installer'
}

New-Item -ItemType Directory -Path $OutputRoot -Force | Out-Null

$buildArguments = @(
    'build'
    $installerProjectPath
    '-c', $Configuration
    '-p:PublishDir=' + $publishRoot
    '-p:ProductVersion=' + $version
    '-o', $OutputRoot
)

Write-Host "Building Elements Shell Desktop MSI $version" -ForegroundColor Cyan
dotnet @buildArguments

if ($LASTEXITCODE -ne 0) {
    throw "dotnet build failed with exit code $LASTEXITCODE"
}

$msiPath = Join-Path $OutputRoot 'ElementsShell.Desktop.msi'
if (-not (Test-Path $msiPath)) {
    throw "Expected MSI not found at $msiPath"
}

$hashFilePath = Join-Path $OutputRoot "ElementsShell.Desktop-$version-msi-sha256.txt"
$hash = Get-FileHash -Path $msiPath -Algorithm SHA256
'{0}  {1}' -f $hash.Hash.ToLowerInvariant(), (Split-Path $msiPath -Leaf) | Set-Content -Path $hashFilePath -Encoding UTF8

Write-Host 'MSI build completed.' -ForegroundColor Green
Write-Host " MSI      : $msiPath" -ForegroundColor DarkGray
Write-Host " Checksums: $hashFilePath" -ForegroundColor DarkGray
