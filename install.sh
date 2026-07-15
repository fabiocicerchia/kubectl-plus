#!/usr/bin/env bash
set -euo pipefail
# One-line installer for kubectl-plus
# Usage: curl -fsSL https://raw.githubusercontent.com/fabiocicerchia/kubectl-plus/main/install.sh | bash

IMAGE="ghcr.io/fabiocicerchia/kubectl-plus:latest"

echo "Pulling kubectl-plus from GHCR..."
docker pull "$IMAGE"
echo ""
echo "kubectl-plus ready. Example usage:"
echo "  docker run --rm -v ~/.kube:/home/nonroot/.kube:ro $IMAGE get pods -A"
