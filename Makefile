IMAGE     ?= fabiocicerchia/kubectl-plus
VERSION   ?= 1.33.2
PLATFORMS ?= linux/amd64,linux/arm64

.PHONY: setup build lint test push release help

.DEFAULT_GOAL := help

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	  awk 'BEGIN {FS = ":.*?## "}; {printf "  %-10s %s\n", $$1, $$2}'

setup: ## Install the pre-commit hook
	pre-commit install

build: ## Build the image locally
	# ponytail: --network host — BuildKit's DNS drops dl.k8s.io's IPv6 records and
	# musl stalls; host DNS resolves fine. Drop the flag if the daemon DNS is fixed.
	docker build --network host --build-arg KUBECTL_VERSION=$(VERSION) -t $(IMAGE):$(VERSION) .

lint: ## Lint the Dockerfile and shell scripts
	docker run --rm -i hadolint/hadolint < Dockerfile
	shellcheck test.sh

test: build ## Build, then run the smoke tests
	./test.sh $(IMAGE):$(VERSION)

push: build ## Push the tagged image
	docker push $(IMAGE):$(VERSION)

release: ## Multi-arch buildx build and push (version + latest)
	docker buildx build --platform $(PLATFORMS) \
		--build-arg KUBECTL_VERSION=$(VERSION) \
		-t $(IMAGE):$(VERSION) -t $(IMAGE):latest --push .
