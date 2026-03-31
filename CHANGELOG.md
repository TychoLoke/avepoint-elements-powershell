# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog and the project follows Semantic Versioning.

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
