# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog and the project follows Semantic Versioning.

## [0.4.1] - 2026-03-31

### Added

- Interactive selectors for customers, tenants, scan profiles, baselines, risk rules, and product types

### Changed

- Many cmdlets now let you choose required IDs from live data when parameters are omitted
- Documentation and examples now show the friendlier picker-based workflow

## [0.4.0] - 2026-03-31

### Added

- Baseline retrieval via `Get-AvptBaseline`, `Get-AvptBaselineReport`, and `Get-AvptBaselineTenant`
- Risk visibility via `Get-AvptRiskRule` and `Get-AvptRiskHitItem`
- Safe write actions with `ShouldProcess` via `New-AvptBaseline` and `Invoke-AvptTenantMonitorAction`

### Changed

- Improved customer output with tenant counts and tenant name summaries
- Improved customer service output with product counts and service name summaries
- Pagination helper now supports alternate metadata property names used by risk hit item responses

## [0.3.0] - 2026-03-31

### Added

- Read-only customer retrieval via `Get-AvptCustomer`
- Customer service retrieval via `Get-AvptCustomerService`
- Tenant seat visibility via `Get-AvptTenantSeat`
- AvePoint product overview retrieval via `Get-AvptProductOverview`
- Backup overview and backup job retrieval via `Get-AvptBackupOverview` and `Get-AvptBackupJob`
- Scan profile retrieval, detail, and daily change cmdlets
- Shared metadata-based pagination helper for Elements endpoints that use `pageIndex` and `pageSize`

## [0.2.4] - 2026-03-31

### Added

- Named scope bundles for `Common`, `Baseline`, `User`, `Risk`, and `Workspace`
- `Get-AvptScopeBundle` for bundle discovery
- Multi-token cache initialization during `Connect-AvptElements` so one connection can cover all endpoint families without one oversized scope request

### Changed

- Guided onboarding now supports bundle-based connection setup
- `Test-AvptElementsConnection` accepts `-ScopeBundle`

## [0.2.3] - 2026-03-31

### Added

- `Test-AvptScopeSet` for validating token issuance against specific scope combinations
- Requested scope count and scope-string length diagnostics in connection output

### Changed

- `Connect-AvptElements` now shows requested scopes separately from granted scopes
- `Connect-AvptElements` warns when the requested scope string exceeds 300 characters based on live Commercial endpoint testing from 2026-03-31

## [0.2.2] - 2026-03-31

### Added

- Guided onboarding flow for `Connect-AvptElements`
- Interactive environment selection for Commercial, Government, AOS2, and FedRAMP
- Interactive authentication method selection
- Console banner and cleaner connection summary output

### Changed

- `Connect-AvptElements` now starts a full guided onboarding flow when called without connection parameters

## [0.2.1] - 2026-03-31

### Added

- Built-in AvePoint Elements permission catalog aligned to the current public portal scope list
- `Get-AvptPermissionScope` for scope discovery and filtering
- Interactive numbered permission selection for `Connect-AvptElements` via `-UseScopeMenu` and `-ReadOnlyScopeMenu`

### Changed

- Updated examples and help to use real Elements scope names

## [0.2.0] - 2026-03-31

### Added

- Centralized module state for connection and token caching
- Client secret authentication support
- Certificate-based authentication support for PFX files and certificate store thumbprints
- Shared request helper with retry, backoff, error handling, and JSON parsing
- Shared pagination helper for upcoming read-only cmdlets
- Connection cmdlets: `Connect-AvptElements`, `Disconnect-AvptElements`, and `Test-AvptElementsConnection`
- Pester coverage for connection, retry, pagination, and exported functions

## [0.1.0] - 2026-03-31

### Added

- Public repository scaffold
- MIT license
- Initial README, changelog, contribution guide, roadmap, and examples
- Module manifest and loader
- Initial test and CI structure
