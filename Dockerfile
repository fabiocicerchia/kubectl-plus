# kubectl-plus — kubectl + jq + yq + curl + envsubst: the toolset every
# in-cluster automation Job actually needs.
ARG KUBECTL_VERSION=1.33.2
ARG YQ_VERSION=4.45.4

FROM alpine:3.24 AS fetch
ARG KUBECTL_VERSION
ARG YQ_VERSION
ARG TARGETOS=linux
ARG TARGETARCH=amd64
# ponytail: apk versions pinned for reproducible builds (hadolint DL3018 / kics).
# They track alpine:3.24; bump alongside the base image when dependabot updates it.
SHELL ["/bin/ash", "-o", "pipefail", "-c"]
RUN apk add --no-cache curl=8.21.0-r0 ca-certificates=20260611-r0
RUN curl -fsSLo /kubectl "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl" \
 && curl -fsSLo /kubectl.sha256 "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl.sha256" \
 && echo "$(cat /kubectl.sha256)  /kubectl" | sha256sum -c - \
 && chmod 0755 /kubectl
RUN curl -fsSLo /yq "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_${TARGETOS}_${TARGETARCH}" \
 && chmod 0755 /yq

FROM alpine:3.24
ARG KUBECTL_VERSION
LABEL org.opencontainers.image.title="kubectl-plus" \
      org.opencontainers.image.description="kubectl + jq + yq + curl + envsubst for in-cluster automation jobs" \
      org.opencontainers.image.version="${KUBECTL_VERSION}" \
      org.opencontainers.image.licenses="Apache-2.0 AND GPL-3.0-or-later AND MIT" \
      org.opencontainers.image.source="https://github.com/fabiocicerchia/kubectl-plus"
# gettext provides envsubst
RUN apk add --no-cache bash=5.3.9-r1 curl=8.21.0-r0 jq=1.8.1-r0 gettext=1.0-r0 ca-certificates=20260611-r0 \
 && adduser -D -u 10001 automation
COPY NOTICE /NOTICE
COPY --from=fetch /kubectl /usr/local/bin/kubectl
COPY --from=fetch /yq /usr/local/bin/yq
USER 10001
# Liveness for the linters; a CLI image has no service, so we just prove the
# core tool runs. ponytail: swap for a real probe if this ever runs long-lived.
HEALTHCHECK CMD ["/bin/bash", "-c", "kubectl version --client >/dev/null 2>&1 || exit 1"]
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["kubectl version --client"]
