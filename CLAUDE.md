# CLAUDE.md

Guidance for Claude Code (and other AI agents) working in this repo.

## Project

kubectl-plus is a small, multi-arch container image bundling `kubectl`, `jq`,
`yq`, `curl`, `envsubst` (gettext) and `bash` on Alpine — the toolset
in-cluster automation Jobs, hooks, and CI steps usually reassemble by hand.
There is no application code: the deliverable is the `Dockerfile`.

## Commands

```sh
make build   # build the image locally
make lint    # hadolint (Dockerfile) + shellcheck (test.sh)
make test    # build + smoke test (./test.sh)
make release # buildx multi-arch build & push
make setup   # install git hooks + pre-commit
```

## Conventions

- Match existing style; don't reformat unrelated code.
- Keep the image minimal — every added package must earn its place.
- Pin versions (kubectl, yq, apk packages, GitHub Actions by SHA) for
  reproducible builds.
- Update `CHANGELOG.md` (`## [Unreleased]`) for user-visible changes.
- Never commit secrets; CI runs gitleaks. Keep `.env` out of git.

## Guardrails

- Don't add dependencies without a clear reason; prefer what Alpine ships.
- Releases are cut by pushing a `vX.Y.Z` tag (see `.github/workflows/release.yml`).
- Ask before large refactors or destructive operations.
