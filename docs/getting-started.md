# Getting Started

## Prerequisites

- Docker (or any OCI-compatible runtime)
- Access to a Kubernetes cluster with `KUBECONFIG` set

## Install

Pull the image from GitHub Container Registry:

```sh
docker pull ghcr.io/fabiocicerchia/kubectl-plus:latest
```

Or pin to a specific kubectl version:

```sh
docker pull ghcr.io/fabiocicerchia/kubectl-plus:1.33.2
```

## Run

### Interactive shell

```sh
docker run --rm -it \
  -v "$KUBECONFIG:/root/.kube/config:ro" \
  ghcr.io/fabiocicerchia/kubectl-plus:latest \
  bash
```

### One-liner in a Kubernetes Job

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
          image: ghcr.io/fabiocicerchia/kubectl-plus:latest
          args:
            - |
              IMAGE_TAG=$(kubectl get deploy my-app -o json | jq -r '.spec.template.spec.containers[0].image')
              envsubst < /config/notify.tpl.json | curl -sf -d @- "$SLACK_WEBHOOK"
```

The entrypoint is `bash -c`, so a Job's `args` can be a plain script string.
