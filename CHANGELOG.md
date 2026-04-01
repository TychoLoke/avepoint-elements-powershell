# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog and the project follows Semantic Versioning.

## [0.12.5] - 2026-04-01

### Added

- Added tenant-specific action cards in the desktop customer workspace so a selected tenant can drive focused snapshot, backup, and baseline workflows.
- Added operations lane cards and a report narrative surface to make the connected shell feel more like a routed application workspace.

### Changed

- Refined the desktop operations and reports sections to be more product-like and less panel-driven.

## [0.12.4] - 2026-04-01

### Added

- Added tenant-focus workspace cards in the desktop customer experience so operators can move from customer context into named tenant context without copying identifiers.
- Added shaped report insight cards to the desktop reporting view for tenant coverage, product count, protected objects, and storage posture.

### Changed

- Refined the connected desktop workspace with a stronger tenant focus panel, richer operations context, and cleaner report composition.

## [0.12.3] - 2026-04-01

### Changed

- Expanded the selected-customer workspace with stat tiles so customer context reads more like a page than a selection state
- Strengthened the customer detail surface with clearer visual presentation of tenancy and operational context
- Continued moving the connected shell toward richer workspace components instead of generic stacked panels

## [0.12.2] - 2026-04-01

### Changed

- Added a clearer selected-customer detail surface in the customer workspace so selection feels like opening a customer page
- Added tenant chips and stronger customer actions so the app exposes context more visually instead of relying on dense text
- Continued moving the connected experience toward purpose-built workspace components

## [0.12.1] - 2026-04-01

### Changed

- Upgraded the connected home screen with clearer dashboard action cards instead of generic workflow rows
- Reworked the customer workspace into larger, more app-like customer cards with clearer status and tenancy presentation
- Continued reducing the “tool surface” feel in the connected experience by using stronger task-oriented components

## [0.12.0] - 2026-04-01

### Changed

- Split the desktop app into a real disconnected login/setup experience and a separate connected operational workspace
- Removed the old overlay-driven onboarding model so the product now behaves more like a dedicated desktop application
- Reframed the connected shell around clearer home, customer, operations, and summary surfaces instead of stacked utility panels

## [0.11.8] - 2026-04-01

### Changed

- Refined the desktop shell with a more studio-grade sidebar, versioned brand chrome, and cleaner operator/session panels
- Reworked onboarding into a more premium setup surface with clearer studio copy, runtime status, and better visual hierarchy
- Continued simplifying the app so onboarding and the main workspace feel like one coherent product rather than separate utility screens

## [0.11.7] - 2026-04-01

### Changed

- Moved real Elements portal connection entry into onboarding so operators can set environment, tenant label, client ID, and client secret before entering the workspace
- Tightened the desktop session flow so live data actions require an actual connected session instead of relying on field presence alone
- Continued polishing the shell layout so onboarding and the main workspace feel like one coherent application

## [0.11.6] - 2026-04-01

### Fixed

- Removed the duplicate WiX `WIXUI_INSTALLDIR` property that was breaking the Windows MSI packaging job
- Restored the release pipeline path so tagged desktop releases can attach ZIP and MSI assets instead of only showing source archives

## [0.11.5] - 2026-04-01

### Changed

- Refined the desktop shell with stronger hero chrome, clearer section framing, and more intentional app-style hierarchy
- Added calmer decorative background treatment and workspace pulse context so the UI reads more like a product than a dashboard prototype
- Added subtle fade transitions for splash, onboarding, and busy overlays to make state changes feel smoother

## [0.11.4] - 2026-04-01

### Changed

- Reworked desktop onboarding into a clearer step-based flow with progress, back/continue actions, and a more product-like hero layout
- Added saved recent-customer context so operators can reopen live customer workflows without copying identifiers again
- Kept the modern desktop shell direction while making the app feel less stateless between sessions

## [0.11.3] - 2026-04-01

### Changed

- Added a splash-style launch overlay for a smoother first impression
- Added local desktop preferences for environment, operator label, and onboarding state
- Made the desktop app feel less stateless between launches

## [0.11.2] - 2026-04-01

### Changed

- Added a welcome-style onboarding overlay to the desktop app
- Added a centered loading overlay with progress feedback for live actions
- Simplified the visual hierarchy so the desktop experience feels cleaner and more modern

## [0.11.1] - 2026-04-01

### Changed

- Fixed the GitHub release asset publishing step so desktop ZIP and MSI assets are uploaded reliably
- Kept the MSI packaging and desktop UI improvements from `0.11.0` while correcting the release workflow

## [0.11.0] - 2026-04-01

### Added

- WiX-based MSI installer project for Elements Shell Desktop
- `Build-ElementsShellDesktopMsi.ps1` to turn the published desktop output into an MSI package
- Release workflow support for publishing desktop MSI assets

### Changed

- Continued refining the desktop application layout and install experience
- Prepared the project for a more normal Windows installer flow alongside the ZIP package

## [0.10.1] - 2026-04-01

### Changed

- Fixed crowded desktop layout issues in the main application window
- Reworked the header actions, connection form layout, and readiness panel spacing for cleaner Windows rendering

## [0.10.0] - 2026-04-01

### Added

- In-process PowerShell hosting for the desktop app via `Microsoft.PowerShell.SDK`
- Desktop readiness checks for runtime, embedded module, and hosted PowerShell engine
- Self-contained Windows desktop packaging with ZIP, quickstart file, and SHA-256 checksums

### Changed

- Upgraded the desktop app to `.NET 9` so it can host the PowerShell engine directly
- Removed the desktop app's dependency on an external `pwsh` install
- Shifted desktop packaging toward a real distributable application instead of a source-only shell

## [0.9.1] - 2026-03-31

### Added

- Desktop PowerShell execution service that imports the embedded `AvePoint.Elements` module at runtime
- Live desktop workflows for `Connect-AvptElements`, `Get-AvptCustomer`, and `Get-AvptCustomerSummary`
- Embedded module copy-to-output behavior so the desktop app can run against the bundled module files

### Changed

- Reworked the desktop shell view model and UI around real connection fields, live customer loading, and customer summary reporting
- Bumped the desktop app and module metadata to `0.9.1`
- Documented that the current desktop app requires `pwsh` on the host machine

## [0.9.0] - 2026-03-31

### Added

- First Avalonia-based desktop application shell in `app/ElementsShell.Desktop`
- Professional desktop dashboard with navigation, connection workspace, workflow cards, reporting panels, and recent activity
- `tools/Build-ElementsShellDesktop.ps1` for publishing the desktop app from the repository

### Changed

- Moved the desktop app project onto `.NET 8` so it builds cleanly with the current SDK toolchain
- Added `.gitignore` coverage for desktop build output directories
- Expanded the README with desktop app run and publish instructions

## [0.8.2] - 2026-03-31

### Changed

- Added standalone startup diagnostics to `ElementsShell.exe`
- The EXE now keeps the console open on startup failure and writes `ElementsShell-startup.log` beside the binary
- The packaged quickstart text now tells users where to look if startup fails

## [0.8.1] - 2026-03-31

### Changed

- Fixed `GH_TOKEN` wiring for the GitHub CLI release-publishing step
- Restored fully first-party release publishing for packaged Windows shell assets

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
