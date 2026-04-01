[CmdletBinding()]
param(
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',

    [string]$Runtime = 'win-x64',

    [string]$OutputRoot = '',

    [switch]$SelfContained = $true,

    [switch]$SingleFile = $true
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$projectPath = Join-Path $repoRoot 'app/ElementsShell.Desktop/ElementsShell.Desktop.csproj'
$moduleManifestPath = Join-Path $repoRoot 'src/AvePoint.Elements/AvePoint.Elements.psd1'

if (-not (Test-Path $projectPath)) {
    throw "Desktop project not found at $projectPath"
}

if (-not (Test-Path $moduleManifestPath)) {
    throw "Module manifest not found at $moduleManifestPath"
}

$moduleManifest = Import-PowerShellDataFile -Path $moduleManifestPath
$version = $moduleManifest.ModuleVersion.ToString()

if (-not $OutputRoot) {
    $OutputRoot = Join-Path $repoRoot "dist/desktop/$version"
}

New-Item -ItemType Directory -Path $OutputRoot -Force | Out-Null

$publishArguments = @(
    'publish'
    $projectPath
    '--configuration', $Configuration
    '--runtime', $Runtime
    '--output', $OutputRoot
    ('-p:SelfContained=' + $SelfContained.ToString().ToLowerInvariant())
    ('-p:PublishSingleFile=' + $SingleFile.ToString().ToLowerInvariant())
    '-p:IncludeNativeLibrariesForSelfExtract=true'
    '-p:EnableCompressionInSingleFile=true'
)

Write-Host "Publishing Elements Shell Desktop $version to $OutputRoot" -ForegroundColor Cyan
dotnet @publishArguments

if ($LASTEXITCODE -ne 0) {
    throw "dotnet publish failed with exit code $LASTEXITCODE"
}

$quickstartPath = Join-Path $OutputRoot "ElementsShell.Desktop-quickstart-$version.txt"
$quickstart = @"
Elements Shell Desktop $version

Install and run:
1. Extract the ZIP to a normal folder.
2. Launch ElementsShell.exe.
3. Use the Desktop Readiness panel to confirm the bundled runtime and embedded module are ready.
4. Enter your AvePoint Elements environment, client ID, and client secret.
5. Connect and load customers.

This desktop package is published self-contained for $Runtime.
It includes the Avalonia app, hosted PowerShell engine, and embedded AvePoint.Elements module.
No separate pwsh installation is required for the desktop app.
"@
$quickstart | Set-Content -Path $quickstartPath -Encoding UTF8

$zipPath = Join-Path (Split-Path $OutputRoot -Parent) "ElementsShell.Desktop-$Runtime-$version.zip"
if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
}
Compress-Archive -Path (Join-Path $OutputRoot '*') -DestinationPath $zipPath -CompressionLevel Optimal

$hashFilePath = Join-Path (Split-Path $OutputRoot -Parent) "ElementsShell.Desktop-$version-sha256.txt"
$hashLines = @()

foreach ($targetPath in @($zipPath, $quickstartPath)) {
    $hash = Get-FileHash -Path $targetPath -Algorithm SHA256
    $hashLines += '{0}  {1}' -f $hash.Hash.ToLowerInvariant(), (Split-Path $targetPath -Leaf)
}

$exePath = Join-Path $OutputRoot 'ElementsShell.exe'
if (Test-Path $exePath) {
    $hash = Get-FileHash -Path $exePath -Algorithm SHA256
    $hashLines += '{0}  {1}' -f $hash.Hash.ToLowerInvariant(), (Split-Path $exePath -Leaf)
}

$hashLines | Set-Content -Path $hashFilePath -Encoding UTF8

Write-Host 'Desktop publish completed.' -ForegroundColor Green
Write-Host " Folder   : $OutputRoot" -ForegroundColor DarkGray
Write-Host " Zip      : $zipPath" -ForegroundColor DarkGray
Write-Host " Quickstart: $quickstartPath" -ForegroundColor DarkGray
Write-Host " Checksums: $hashFilePath" -ForegroundColor DarkGray
