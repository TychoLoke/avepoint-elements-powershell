# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog and the project follows Semantic Versioning.

## [0.8.0] - 2026-03-31

### Added

- Quickstart text file for Windows shell downloads
- ZIP package now includes `ElementsShell.exe` plus quickstart instructions

### Changed

- Replaced the third-party GitHub release action with GitHub CLI publishing in the packaging workflow
- Clarified the recommended download path: use the ZIP package, extract it, and run `ElementsShell.exe` from the extracted folder

## [0.7.9] - 2026-03-31

### Changed

- Upgraded `actions/checkout` to `v6` and `actions/upload-artifact` to `v6`
- Reduced GitHub Actions deprecation noise by moving official workflow dependencies onto newer Node 24-capable major versions

## [0.7.8] - 2026-03-31

### Changed

- Opted GitHub workflows into Node 24 to stay ahead of the GitHub Actions Node 20 deprecation
- Reduced future CI and packaging maintenance risk without changing the module or shell behavior

## [0.7.7] - 2026-03-31

### Changed

- Updated the release packaging workflow to generate or update GitHub release notes automatically on tagged builds
- Reduced the manual release-publishing burden so tags behave more like self-publishing packaged releases

## [0.7.6] - 2026-03-31

### Changed

- Embedded the `AvePoint.Elements` module files into `ElementsShell.exe`
- Updated the launcher so the standalone executable prefers the embedded module and no longer depends on the repository layout next to the binary

## [0.7.5] - 2026-03-31

### Added

- Generated application icon for `ElementsShell.exe`
- Automatic zip packaging and SHA-256 checksum generation for Windows shell releases
- Signing placeholder step in the Windows packaging workflow for future Authenticode integration

### Changed

- The packaging script now embeds richer version metadata into `ElementsShell.exe`
- Tagged releases now distribute the `.exe`, `.zip`, and checksum assets together

## [0.7.4] - 2026-03-31

### Changed

- Removed the broken PowerShell setup action from GitHub workflows and now rely on the built-in `pwsh` available on GitHub runners
- Unblocked the Windows packaging workflow so `ElementsShell.exe` can be built and attached on tagged releases

## [0.7.3] - 2026-03-31

### Changed

- Updated the Windows packaging workflow so tagged releases attach `ElementsShell.exe` as a GitHub release asset
- Kept artifact upload in place for troubleshooting while adding direct release distribution for the binary

## [0.7.2] - 2026-03-31

### Added

- Customer Center and Tenant Center drill-down menus inside `Start-AvptElementsShell`
- Built-in CSV and JSON export actions from shell result screens

### Changed

- Shifted the shell from flat top-level actions toward workflow-driven navigation
- Result views can now stay open for export without dropping back to the dashboard immediately

## [0.7.1] - 2026-03-31

### Changed

- Upgraded `Start-AvptElementsShell` from a plain menu loop to a dashboard-style console experience
- Added session panels, workflow hints, result headers, and return-to-dashboard pauses so the shell feels more like an application
- Improved the visual structure of shell output without changing the underlying cmdlet model

## [0.7.0] - 2026-03-31

### Added

- `Start-AvptElementsShell` for a menu-driven interactive console wrapper
- `app/ElementsShell.ps1` as the dedicated launcher entry point
- `tools/Build-ElementsShellExe.ps1` and a Windows packaging workflow for building `ElementsShell.exe`

### Changed

- Extended the project from a cmdlet-only toolkit into an app-style shell experience
- Added a packaging path for a Windows `.exe` without giving up cross-platform module usage

## [0.6.0] - 2026-03-31

### Added

- Customer onboarding with `New-AvptCustomer` including interactive data center selection
- Service assignment with `Add-AvptCustomerService` using `ShouldProcess`
- Guided summary commands with `Get-AvptCustomerSummary` and `Get-AvptTenantSummary`

### Changed

- Added default display sets for onboarding and summary result types
- Continued shifting the module toward operator workflows instead of raw endpoint-by-endpoint usage

## [0.5.0] - 2026-03-31

### Added

- User management coverage with `Get-AvptSecurityUserOverview`, `Get-AvptUser`, and `Get-AvptUsers`
- Workspace reporting coverage with `Get-AvptWorkspaceOverview`, `Get-AvptWorkspaceCompliance`, `Get-AvptWorkspaceDataSecurityPosture`, and `Get-AvptWorkspaceDataProtectionStatistic`
- Interactive user selection for `Get-AvptUser` so operators can browse live tenant users instead of copying IDs

### Changed

- Added default display property sets for key output types so common cmdlets render cleaner summary views by default
- User and workspace cmdlets now add summary properties such as status labels, compliance rate, exposure totals, and protection alert totals

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
