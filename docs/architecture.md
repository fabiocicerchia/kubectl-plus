# Architecture

kubectl-plus is a minimal Docker image that bundles a curated, version-pinned
set of CLI tools commonly needed for Kubernetes automation Jobs, hooks, and CI
steps.

## Overview

```text
Alpine base ─▶ kubectl (pinned, checksum-verified)
             ─▶ jq    (Alpine package)
             ─▶ yq    (mikefarah/yq, pinned release)
             ─▶ curl  (Alpine package)
             ─▶ envsubst (gettext, Alpine package)
             ─▶ bash  (Alpine package)
             ─▶ non-root user (UID 10001)
```

## Components

- **kubectl** — downloaded directly from `dl.k8s.io` with SHA-256 checksum
  verification. The `KUBECTL_VERSION` build-arg pins the exact version baked
  into each image tag.
- **jq** — used to slice and filter JSON output from kubectl.
- **yq** — used to patch and template YAML manifests in-place.
- **curl** — used for webhooks, health-check probes, and REST calls.
- **envsubst** — substitutes environment variables into manifest templates
  before applying them with kubectl.
- **bash** — glue scripting; the image entrypoint is `bash -c`.

## Image tagging

Tags mirror the bundled kubectl version (e.g. `1.33.2`). The `latest` tag
always points to the most recently released version. Multi-arch builds target
`linux/amd64` and `linux/arm64`.

## Security posture

- Runs as non-root (UID 10001).
- kubectl binary is checksum-verified at build time.
- All other tools installed from pinned Alpine packages or pinned upstream
  releases — no floating versions.
