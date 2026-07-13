# kubectl-plus

[![CI](https://github.com/fabiocicerchia/kubectl-plus/actions/workflows/ci.yml/badge.svg)](https://github.com/fabiocicerchia/kubectl-plus/actions/workflows/ci.yml)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)

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

`make build` / `make lint` / `make test` / `make release` (multi-arch push).
Override the kubectl version with `make build VERSION=1.32.6`.

## License

Apache 2.0 — see [LICENSE](LICENSE).
