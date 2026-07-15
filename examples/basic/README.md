# Basic Example

Run kubectl-plus as a one-shot Docker container against a live cluster.

## Prerequisites

- Docker installed locally
- `KUBECONFIG` pointing at a live cluster (or use `~/.kube/config`)

## Pull

```sh
docker pull ghcr.io/fabiocicerchia/kubectl-plus:latest
```

## Examples

### List all pods across all namespaces as JSON, filtered with jq

```sh
docker run --rm \
  -v "$HOME/.kube/config:/root/.kube/config:ro" \
  ghcr.io/fabiocicerchia/kubectl-plus:latest \
  bash -c "kubectl get pods -A -o json | jq '[.items[] | {name: .metadata.name, ns: .metadata.namespace, status: .status.phase}]'"
```

### Patch a deployment image using yq

```sh
docker run --rm \
  -v "$HOME/.kube/config:/root/.kube/config:ro" \
  -v "$(pwd)/my-deploy.yaml:/work/deploy.yaml" \
  ghcr.io/fabiocicerchia/kubectl-plus:latest \
  bash -c "yq e '.spec.template.spec.containers[0].image = \"myapp:v2.0.0\"' /work/deploy.yaml | kubectl apply -f -"
```

### Use envsubst to template a manifest and apply it

```sh
export APP_VERSION=v2.0.0
docker run --rm \
  -v "$HOME/.kube/config:/root/.kube/config:ro" \
  -v "$(pwd)/deploy.tpl.yaml:/work/deploy.tpl.yaml" \
  -e APP_VERSION \
  ghcr.io/fabiocicerchia/kubectl-plus:latest \
  bash -c "envsubst < /work/deploy.tpl.yaml | kubectl apply -f -"
```
