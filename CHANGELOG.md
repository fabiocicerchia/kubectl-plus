# Changelog

All notable changes to this project are documented here. The format is based
on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and tags follow
the bundled kubectl version.

## [0.1.1](https://github.com/fabiocicerchia/kubectl-plus/compare/v0.1.0...v0.1.1) (2026-08-06)


### Bug Fixes

* **pre-commit:** stop check-yaml failing on Helm templates and multi-doc manifests ([02d39a7](https://github.com/fabiocicerchia/kubectl-plus/commit/02d39a7249c0d99dfa15605f83b60b847d515db5))
* **security:** skip the SARIF upload on private repos ([bffd5f9](https://github.com/fabiocicerchia/kubectl-plus/commit/bffd5f986bad34190e67d13e4eff876bf55f5179))
* use exec form for the healthcheck command (DL3025) ([a6436ab](https://github.com/fabiocicerchia/kubectl-plus/commit/a6436ab7944498386530b8bf19f132200af9ac98))

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
