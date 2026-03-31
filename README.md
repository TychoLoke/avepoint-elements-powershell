# AvePoint Elements PowerShell

`AvePoint.Elements` is a public PowerShell 7+ toolkit for MSP operations on the AvePoint Elements API.

It is designed to be more than a thin REST wrapper. The module focuses on practical service-provider workflows such as customer onboarding, service visibility, tenant and seat reporting, backup visibility, scan profile inspection, baseline operations, risk review, user discovery, and workspace posture reporting.

## Project Status

This repository is in active public development.

- Current version: `0.8.1`
- License: MIT
- PowerShell: `7.0+`
- Support target: cross-platform where AvePoint API access is available

## Design Goals

- Approved PowerShell verb-noun naming
- Public-safe repository content only
- Centralized authentication, HTTP invocation, pagination, and retry behavior
- Friendly PowerShell output objects with optional raw and JSON access patterns
- Community-ready documentation, tests, and release hygiene
- MSP-oriented workflows instead of endpoint-by-endpoint wrappers

## Planned Phase 1 Scope

### Authentication

- `Connect-AvptElements`
- `Disconnect-AvptElements`
- `Test-AvptElementsConnection`

### Customers and Services

- `Get-AvptCustomer`
- `New-AvptCustomer`
- `Get-AvptCustomerService`
- `Add-AvptCustomerService`

### Tenant and Licensing Visibility

- `Get-AvptTenantSeat`
- `Get-AvptProductOverview`

### Backup and Operational Visibility

- `Get-AvptBackupOverview`
- `Get-AvptBackupJob`

### Scan Profiles

- `Get-AvptScanProfile`
- `Get-AvptScanProfileDetail`
- `Get-AvptScanProfileChange`

### Baseline Management

- `New-AvptBaseline`
- `Get-AvptBaseline`
- `Get-AvptBaselineReport`
- `Get-AvptBaselineTenant`
- `Invoke-AvptTenantMonitorAction`

### Risk Management

- `Get-AvptRiskRule`
- `Get-AvptRiskHitItem`

### User Management

- `Get-AvptSecurityUserOverview`
- `Get-AvptUser`
- `Get-AvptUsers`

### Workspace Management

- `Get-AvptWorkspaceOverview`
- `Get-AvptWorkspaceCompliance`
- `Get-AvptWorkspaceDataSecurityPosture`
- `Get-AvptWorkspaceDataProtectionStatistic`

## Installation

PowerShell Gallery publishing will come after the module reaches a stable public milestone.

For local development:

```bash
git clone https://github.com/TychoLoke/avepoint-elements-powershell.git
cd avepoint-elements-powershell
pwsh
```

```powershell
Import-Module ./src/AvePoint.Elements/AvePoint.Elements.psd1 -Force
```

To launch the app-style shell wrapper:

```powershell
Start-AvptElementsShell
```

The shell now presents:

- a dashboard-style home screen
- session status panels
- grouped operational actions
- titled result screens with return-to-dashboard flow
- customer and tenant drill-down centers
- CSV and JSON export directly from result screens

The repository also includes:

- `app/ElementsShell.ps1` as the launcher entry point
- `tools/Build-ElementsShellExe.ps1` to package a Windows `.exe`, `.zip`, and checksum file
- `.github/workflows/shell-package.yml` to build the wrapper in GitHub Actions on Windows and attach `ElementsShell.exe` to tagged releases

Windows release packaging now includes:

- `ElementsShell.exe`
- `ElementsShell-win-x64-<version>.zip`
- `ElementsShell-<version>-sha256.txt`
- `ElementsShell-quickstart-<version>.txt`
- embedded version metadata and a generated app icon
- embedded module files so the standalone `.exe` can run without the repository beside it

Recommended Windows download flow:

1. Download `ElementsShell-win-x64-<version>.zip` from the release.
2. Extract it to a normal folder such as `Downloads` or `Desktop`.
3. Run `ElementsShell.exe` from the extracted folder.

Notes:

- Do not run the EXE from inside the ZIP preview window.
- The standalone `.exe` should work on its own as of `0.7.6+`, but the ZIP package is the preferred download because it includes a quickstart file and avoids common browser/ZIP confusion.

## Authentication Example

Use placeholder values only:

```powershell
$clientSecret = ConvertTo-SecureString 'your-client-secret' -AsPlainText -Force
$credential = [pscredential]::new('your-client-id', $clientSecret)

Connect-AvptElements `
    -Environment Commercial `
    -Credential $credential `
    -TenantName 'contoso-demo' `
    -Scope @(
        'elements.customers.read.all'
        'elements.license.read.all'
    )
```

Or use the built-in interactive menu:

```powershell
Connect-AvptElements -Environment Commercial -Credential $credential -UseScopeMenu
```

Or run full guided onboarding:

```powershell
Connect-AvptElements
```

To connect once and initialize separate cached tokens for all endpoint families:

```powershell
Connect-AvptElements `
    -Environment Commercial `
    -Credential $credential `
    -ScopeBundle Common,Baseline,User,Risk,Workspace
```

To list the built-in permission catalog:

```powershell
Get-AvptPermissionScope
Get-AvptPermissionScope -AccessLevel Read
Get-AvptScopeBundle
```

To test whether a scope combination can successfully obtain a token:

```powershell
Test-AvptScopeSet `
    -Environment Commercial `
    -Credential $credential `
    -Scope @(
        'elements.customers.read.all'
        'elements.license.read.all'
    )
```

## Examples

Examples will be expanded as the cmdlet surface grows.

```powershell
Test-AvptElementsConnection
Disconnect-AvptElements
Get-AvptCustomer -All
Get-AvptCustomerService -CustomerId '00000000-0000-0000-0000-000000000000'
Get-AvptProductOverview -CustomerId '00000000-0000-0000-0000-000000000000' -ProductType 2048
Get-AvptBaseline -All
Get-AvptRiskRule -CustomerId '00000000-0000-0000-0000-000000000000' -TenantId '11111111-1111-1111-1111-111111111111'
```

Many cmdlets can now guide you through live selection if you omit IDs:

```powershell
Get-AvptBackupOverview
Get-AvptScanProfileDetail
Get-AvptRiskHitItem
Get-AvptProductOverview
Get-AvptUser
Get-AvptCustomerSummary
Get-AvptTenantSummary
```

Current implemented commands:

- `Connect-AvptElements`
- `Disconnect-AvptElements`
- `Get-AvptPermissionScope`
- `Get-AvptScopeBundle`
- `Get-AvptCustomer`
- `Get-AvptCustomerSummary`
- `Get-AvptCustomerService`
- `Add-AvptCustomerService`
- `Get-AvptTenantSeat`
- `Get-AvptProductOverview`
- `Get-AvptBackupOverview`
- `Get-AvptBackupJob`
- `Get-AvptBaseline`
- `Get-AvptBaselineReport`
- `Get-AvptBaselineTenant`
- `New-AvptBaseline`
- `Invoke-AvptTenantMonitorAction`
- `Get-AvptRiskRule`
- `Get-AvptRiskHitItem`
- `Get-AvptScanProfile`
- `Get-AvptScanProfileDetail`
- `Get-AvptScanProfileChange`
- `Get-AvptSecurityUserOverview`
- `Get-AvptUser`
- `Get-AvptUsers`
- `Get-AvptWorkspaceOverview`
- `Get-AvptWorkspaceCompliance`
- `Get-AvptWorkspaceDataSecurityPosture`
- `Get-AvptWorkspaceDataProtectionStatistic`
- `Get-AvptTenantSummary`
- `Start-AvptElementsShell`
- `Test-AvptScopeSet`
- `Test-AvptElementsConnection`

Examples of the newer usability-first workflow:

```powershell
New-AvptCustomer -FirstName 'Alex' -LastName 'Morgan' -OrganizationName 'Contoso MSP Demo' `
    -RegistrationAccount 'admin@contoso-demo.onmicrosoft.com' -Password 'UseATemporaryPassword123!' `
    -CountryCode 'US' -WhatIf

Get-AvptCustomerSummary
Get-AvptTenantSummary
```

The module now leans into an operator workflow:

- connect once
- omit IDs when you want guided selection from live data
- get cleaner default output without building `Invoke-RestMethod` plumbing, pagination, or response shaping yourself

## Repository Layout

```text
src/AvePoint.Elements/
  Public/
  Private/
  en-US/
Tests/
docs/
examples/
```

## Versioning and Releases

This project uses semantic versioning.

- `0.1.0` initial public scaffolding
- `0.2.0` authentication and request foundation
- `0.3.0` initial read-only cmdlets
- `0.4.0` baseline and risk coverage
- `0.5.0` broader operational coverage
- `0.6.0` onboarding and summary workflow improvements
- `0.7.0` interactive shell wrapper and Windows `.exe` packaging path
- `0.7.1` dashboard-style shell polish
- `0.7.2` shell drill-down centers and export actions
- `0.7.3` release-attached `.exe` packaging
- `0.7.4` fixed GitHub Actions packaging execution
- `0.7.5` production-grade shell packaging assets
- `0.7.6` standalone executable embeds the module
- `0.7.7` automated release note generation
- `0.7.8` Node 24 workflow readiness
- `0.8.0` ZIP-first release guidance and GitHub CLI publishing
- `0.8.1` fixed GitHub CLI release authentication
- `1.0.0` first stable public release

Each release is tracked in `CHANGELOG.md` and published with a git tag.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development standards, public-safety rules, and contribution workflow.

## Roadmap

See [docs/ROADMAP.md](docs/ROADMAP.md).
