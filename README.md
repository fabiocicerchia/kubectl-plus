# kubectl-plus

[![CI](https://github.com/fabiocicerchia/kubectl-plus/actions/workflows/ci.yml/badge.svg)](https://github.com/fabiocicerchia/kubectl-plus/actions/workflows/ci.yml)
[![Security](https://github.com/fabiocicerchia/kubectl-plus/actions/workflows/security.yml/badge.svg)](https://github.com/fabiocicerchia/kubectl-plus/actions/workflows/security.yml)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/fabiocicerchia/kubectl-plus/badge)](https://securityscorecards.dev/viewer/?uri=github.com/fabiocicerchia/kubectl-plus)
[![CI carbon](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/fabiocicerchia/kubectl-plus/gh-pages/badge.json)](.github/workflows/carbon-badge.yml)
[![Release](https://img.shields.io/github/v/release/fabiocicerchia/kubectl-plus)](https://github.com/fabiocicerchia/kubectl-plus/releases)

`kubectl` + `jq` + `yq` + `curl` + `envsubst` (+ bash) in one small,
version-pinned, multi-arch image — the actual toolset every in-cluster
automation Job, hook, and CI step ends up needing.

Stop building the same ad-hoc "kubectl but with jq" image in every project.

## What's inside

| Tool       | Source                          | Why                              |
|------------|---------------------------------|----------------------------------|
| `kubectl`  | dl.k8s.io, checksum-verified    | talk to the cluster              |
| `jq`       | Alpine package                  | slice JSON output                |
| `yq`       | mikefarah/yq pinned release     | patch manifests                  |
| `curl`     | Alpine package                  | webhooks, health endpoints       |
| `envsubst` | gettext                         | template manifests from env vars |
| `bash`     | Alpine package                  | glue                             |

Runs as non-root (UID 10001). Tags mirror the bundled kubectl version.

## Install

```sh
docker pull ghcr.io/fabiocicerchia/kubectl-plus:latest
```

Or pin a specific version (mirrors the bundled kubectl version):

```sh
docker pull ghcr.io/fabiocicerchia/kubectl-plus:1.33.2
```

## Usage

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: annotate-release
spec:
  template:
    spec:
      serviceAccountName: deployer
      restartPolicy: Never
      containers:
        - name: run
          image: fabiocicerchia/kubectl-plus:1.33.2
          args:
            - |
              IMAGE_TAG=$(kubectl get deploy my-app -o json | jq -r '.spec.template.spec.containers[0].image')
              envsubst < /config/notify.tpl.json | curl -sf -d @- "$SLACK_WEBHOOK"
```

The entrypoint is `bash -c`, so a Job's `args` can be a plain script string.

## Development

Override the kubectl version with `make build VERSION=1.32.6`, and pass a
command to `make run` with `ARGS='kubectl get pods -A'`.

### Make targets

`make help` lists them. Every repository in this estate exposes the same eight
verbs, so you do not have to read a Makefile to find out how to build or test it
(FC-GEN-057).

| Verb      | What it does here                                          |
| --------- | ---------------------------------------------------------- |
| `setup`   | Install the pre-commit hook                                |
| `install` | `docker pull` the published image                          |
| `build`   | Build the image locally                                    |
| `test`    | Build, then run `test.sh` against the image                |
| `lint`    | `pre-commit run --all-files` — the whole gate              |
| `run`     | Run the image; `ARGS` is the command                       |
| `format`  | Rewrite what the gate can fix: whitespace, endings, EOF    |
| `analyze` | `trivy fs` — the same scan CI runs                         |

`make push` and `make release` publish the image; the release workflow is what
normally runs them.

## Documentation

Full docs live in [`docs/`](docs/). Runnable examples live in [`examples/`](examples/).

## Support

Need help implementing this? [Get in touch](https://fabiocicerchia.it/contact).

## License

Apache 2.0 — see [LICENSE](LICENSE).
