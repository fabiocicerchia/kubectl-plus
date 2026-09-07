# Changelog

All notable changes to this project are documented here. The format is based
on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and tags follow
the bundled kubectl version.

## [0.2.1](https://github.com/fabiocicerchia/kubectl-plus/compare/v0.2.0...v0.2.1) (2026-08-29)

### Bug Fixes

- unblock quality and clear the Scorecard pinned-dependencies finding ([#35](https://github.com/fabiocicerchia/kubectl-plus/issues/35)) ([95f2878](https://github.com/fabiocicerchia/kubectl-plus/commit/95f287885f269d74e53cdf4c71797b8a2e0b30ab))

## [0.2.0](https://github.com/fabiocicerchia/kubectl-plus/compare/v0.1.3...v0.2.0) (2026-08-25)

### Features

- **docs:** build the docs site in Actions and drop Read the Docs ([#32](https://github.com/fabiocicerchia/kubectl-plus/issues/32)) ([95a417d](https://github.com/fabiocicerchia/kubectl-plus/commit/95a417d716fc1831f4899f2ff16a1bbc66e7419e))

## [0.1.3](https://github.com/fabiocicerchia/kubectl-plus/compare/v0.1.2...v0.1.3) (2026-08-13)

### Bug Fixes

- security and code-quality findings ([#28](https://github.com/fabiocicerchia/kubectl-plus/issues/28)) ([57fc486](https://github.com/fabiocicerchia/kubectl-plus/commit/57fc486dd37dddf8b71bcd4fe57352dd95808d96))

## [0.1.2](https://github.com/fabiocicerchia/kubectl-plus/compare/v0.1.1...v0.1.2) (2026-08-08)

### Bug Fixes

- publish the image from the release job so it actually runs ([5803b63](https://github.com/fabiocicerchia/kubectl-plus/commit/5803b6365bc1715cc9c378f28ca0248a5edbbd73))

## [0.1.1](https://github.com/fabiocicerchia/kubectl-plus/compare/v0.1.0...v0.1.1) (2026-08-06)

### Bug Fixes

- **pre-commit:** stop check-yaml failing on Helm templates and multi-doc manifests ([02d39a7](https://github.com/fabiocicerchia/kubectl-plus/commit/02d39a7249c0d99dfa15605f83b60b847d515db5))
- **security:** skip the SARIF upload on private repos ([bffd5f9](https://github.com/fabiocicerchia/kubectl-plus/commit/bffd5f986bad34190e67d13e4eff876bf55f5179))
- use exec form for the healthcheck command (DL3025) ([a6436ab](https://github.com/fabiocicerchia/kubectl-plus/commit/a6436ab7944498386530b8bf19f132200af9ac98))

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
