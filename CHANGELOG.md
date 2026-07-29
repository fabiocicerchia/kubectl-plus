# Changelog

All notable changes to this project are documented here. The format is based
on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and tags follow
the bundled kubectl version.

## 1.0.0 (2026-07-29)


### Features

* add install.sh one-liner installer ([95e6fda](https://github.com/fabiocicerchia/kubectl-plus/commit/95e6fdab6f672abc640dc2fd055273ef8595ac51))


### Bug Fixes

* **deps:** bump apk package versions to match alpine:3.24 ([0379244](https://github.com/fabiocicerchia/kubectl-plus/commit/0379244c5fa45eb3168842533880c6134d1b18f6))
* fix broken trivy-action pin ([#12](https://github.com/fabiocicerchia/kubectl-plus/issues/12)) ([7e329aa](https://github.com/fabiocicerchia/kubectl-plus/commit/7e329aa673a647f3bb40f70aef1b7e9c1caf9f47))

## [Unreleased]

### Added

- Community health files: `CODE_OF_CONDUCT.md`, issue/PR templates, `CLAUDE.md`.
- CI workflows: `code-quality`, `security`, `scorecard`, `dependency-review`.
- `.editorconfig`, `.gitattributes`, pre-commit hooks, and a `make setup` target.
- `HEALTHCHECK` in the image.

### Changed

- Pinned apk package versions and GitHub Actions to commit SHAs for
  reproducible, supply-chain-hardened builds.
- Scoped `release` workflow token permissions to the job level.
- Bumped pinned `curl`, `bash`, and `gettext` apk versions to match the
  `alpine:3.24` repo (the alpine bump left them stale, breaking `make build`).
