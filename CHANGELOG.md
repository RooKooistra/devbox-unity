# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog.

## [Unreleased]

## [0.5.0] - 2026-09-21

### Added

- Automatic host/container installation routing.
- Distrobox container existence detection.
- Automatic Ubuntu development container creation.
- Host-to-container installer execution.
- Strict Ubuntu container validation.

### Changed

- Host and container modes now enforce their execution environments.
- Ubuntu package installation can no longer run directly against the host.
- Unity development directories are created during container setup.
- Installer can now be launched from the immutable host as the primary entry point.

## [0.4.0] - 2026-09-21

### Added

- Firefox installation module.
- Mozilla official APT repository configuration.
- Mozilla repository signing-key fingerprint verification.
- Mozilla package priority configuration.
- Firefox installation verification.

### Changed

- Installer now runs the Base System and Firefox modules sequentially.
- Smoke tests now use repository-root paths and validate the Firefox module.
- Updated installer help and README status for Milestone 4.

---
## [0.3.0] - 2026-07-22

### Added

- Shared package management library.
- Idempotent package installation helper.
- Common package update and upgrade helpers.

---

## [0.2.0] - 2026-07-04

### Added

- Installer framework.
- Configuration loader.
- Dry-run mode.
- Host/container detection.
- Shared shell libraries.
- Smoke test.

---

## [0.1.0] - 2026-07-03

### Added

- Repository structure.
- Initial README.
- MIT License.
- Contribution guide.
- Code of Conduct.
- Security policy.
