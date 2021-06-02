# Variables passed to PACKER (PKR_VAR_)
export PKR_VAR_build_date        ?= 2021.22
export PKR_VAR_docker_image_name ?= kdsda/ubuntu-base

# Build image, but don't try to push
build:
	@packer build -except=push .
.PHONY: build

# Build image & push to registry.
# Requires related variables to be set
push:
	@packer build -except=push .
.PHONY: push

test:
	@docker run --rm -it ${PKR_VAR_docker_image_name}:2004 cmd whoami
.PHONY: test