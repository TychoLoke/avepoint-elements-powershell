# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog and the project follows Semantic Versioning.

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
