# Changelog

All notable changes to this project are documented here. The format is based
on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and tags follow
the bundled kubectl version.

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
