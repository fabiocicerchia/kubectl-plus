#!/usr/bin/env sh
# Smoke test: every bundled tool must exist and run.
set -eu
IMAGE="${1:?usage: test.sh <image:tag>}"
docker run --rm "$IMAGE" '
  set -e
  kubectl version --client >/dev/null
  jq --version
  yq --version
  curl --version >/dev/null
  echo "$FOO" | envsubst >/dev/null
  echo PASS
' || { echo "FAIL" >&2; exit 1; }
