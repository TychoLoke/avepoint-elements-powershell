[CmdletBinding()]
param(
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',

    [string]$Runtime = '',

    [string]$OutputRoot = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$projectPath = Join-Path $repoRoot 'app/ElementsShell.Desktop/ElementsShell.Desktop.csproj'

if (-not $OutputRoot) {
    $OutputRoot = Join-Path $repoRoot 'artifacts/desktop'
}

if (-not (Test-Path $projectPath)) {
    throw "Desktop project not found at $projectPath"
}

$publishArguments = @(
    'publish'
    $projectPath
    '--configuration', $Configuration
    '--output', $OutputRoot
)

if ($Runtime) {
    $publishArguments += @('--runtime', $Runtime, '--self-contained', 'false')
}

Write-Host "Publishing Elements Shell Desktop to $OutputRoot" -ForegroundColor Cyan
dotnet @publishArguments

if ($LASTEXITCODE -ne 0) {
    throw "dotnet publish failed with exit code $LASTEXITCODE"
}

Write-Host 'Desktop publish completed.' -ForegroundColor Green
