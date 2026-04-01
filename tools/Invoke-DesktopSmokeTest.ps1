[CmdletBinding()]
param(
    [ValidateSet('Commercial', 'Government', 'Aos2', 'FedRAMP')]
    [string]$Environment = 'Commercial',

    [string]$TenantLabel = '',

    [switch]$SkipBuild
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$desktopProjectPath = Join-Path $repoRoot 'app/ElementsShell.Desktop/ElementsShell.Desktop.csproj'
$moduleManifestPath = Join-Path $repoRoot 'src/AvePoint.Elements/AvePoint.Elements.psd1'

if (-not $SkipBuild) {
    Write-Host 'Building desktop project for smoke test...' -ForegroundColor Cyan
    dotnet build $desktopProjectPath -c Release | Out-Host
    if ($LASTEXITCODE -ne 0) {
        throw "dotnet build failed with exit code $LASTEXITCODE"
    }
}

Import-Module $moduleManifestPath -Force

$clientId = $env:AVPT_CLIENT_ID
$clientSecret = $env:AVPT_CLIENT_SECRET

if (-not $clientId -or -not $clientSecret) {
    Write-Warning 'Skipping live AvePoint smoke test because AVPT_CLIENT_ID and AVPT_CLIENT_SECRET are not set.'
    return
}

$secret = ConvertTo-SecureString $clientSecret -AsPlainText -Force
$credential = [pscredential]::new($clientId, $secret)

Write-Host 'Connecting to AvePoint Elements for smoke test...' -ForegroundColor Cyan
$connectionSplat = @{
    Environment = $Environment
    Credential  = $credential
    ScopeBundle = @('Common', 'Baseline', 'User', 'Risk', 'Workspace')
    PassThru    = $true
}

if ($TenantLabel) {
    $connectionSplat.TenantName = $TenantLabel
}

$session = Connect-AvptElements @connectionSplat
Write-Host ("Connected to {0} with bundles: {1}" -f $session.Environment, ($session.ScopeBundle -join ', ')) -ForegroundColor Green

$customer = Get-AvptCustomer -All | Select-Object -First 1
if (-not $customer) {
    throw 'Smoke test connected successfully but returned no customers.'
}

Write-Host ("Customer retrieval succeeded: {0}" -f $customer.organization) -ForegroundColor Green

Disconnect-AvptElements
Write-Host 'Desktop smoke test completed successfully.' -ForegroundColor Green
