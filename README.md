# AvePoint Elements PowerShell

`AvePoint.Elements` is a public PowerShell 7+ toolkit for MSP operations on the AvePoint Elements API.

It is designed to be more than a thin REST wrapper. The module focuses on practical service-provider workflows such as customer onboarding, service visibility, tenant and seat reporting, backup visibility, scan profile inspection, baseline operations, risk review, user discovery, and workspace posture reporting.

## Project Status

This repository is in active public development.

- Current version: `0.2.1`
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

```powershell
git clone git@github.com:TychoLoke/avepoint-elements-powershell.git
Set-Location avepoint-elements-powershell
Import-Module ./src/AvePoint.Elements/AvePoint.Elements.psd1 -Force
```

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

To list the built-in permission catalog:

```powershell
Get-AvptPermissionScope
Get-AvptPermissionScope -AccessLevel Read
```

## Examples

Examples will be expanded as the cmdlet surface grows.

```powershell
Test-AvptElementsConnection
Disconnect-AvptElements
```

Current implemented authentication commands:

- `Connect-AvptElements`
- `Disconnect-AvptElements`
- `Get-AvptPermissionScope`
- `Test-AvptElementsConnection`

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
- `1.0.0` first stable public release

Each release is tracked in `CHANGELOG.md` and published with a git tag.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development standards, public-safety rules, and contribution workflow.

## Roadmap

See [docs/ROADMAP.md](docs/ROADMAP.md).
