IMAGE     ?= fabiocicerchia/kubectl-plus
VERSION   ?= 1.33.2
PLATFORMS ?= linux/amd64,linux/arm64

.PHONY: setup build lint test push release

setup:
	git config core.hooksPath .githooks
	@command -v pre-commit >/dev/null 2>&1 && pre-commit install || true

build:
	# ponytail: --network host — BuildKit's DNS drops dl.k8s.io's IPv6 records and
	# musl stalls; host DNS resolves fine. Drop the flag if the daemon DNS is fixed.
	docker build --network host --build-arg KUBECTL_VERSION=$(VERSION) -t $(IMAGE):$(VERSION) .

lint:
	docker run --rm -i hadolint/hadolint < Dockerfile
	shellcheck test.sh

test: build
	./test.sh $(IMAGE):$(VERSION)

push: build
	docker push $(IMAGE):$(VERSION)

release:
	docker buildx build --platform $(PLATFORMS) \
		--build-arg KUBECTL_VERSION=$(VERSION) \
		-t $(IMAGE):$(VERSION) -t $(IMAGE):latest --push .
