# Variables passed to PACKER (PKR_VAR_)
export PKR_VAR_docker_image_name     ?= kdsda/ubuntu-base
export PKR_VAR_docker_image_tags     ?= ["dev"]

# Build image, but don't try to push
build:
	@packer build -except=push .
.PHONY: build

# Build image & push to registry.
# Requires related variables to be set
push:
	@packer build .
.PHONY: push

test:
	@docker run --rm -it ${PKR_VAR_docker_image_name}:dev cmd whoami
.PHONY: test