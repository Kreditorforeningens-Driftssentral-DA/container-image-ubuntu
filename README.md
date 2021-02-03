# UBUNTU BASE CONTAINER IMAGE

Ubuntu base image, with packages installed for use with building images using packer/ansible
This is meant to be used as a building-block for other containers

> * GitHub: https://github.com/Kreditorforeningens-Driftssentral-DA/container-image-ubuntu
> * Docker Hub: https://hub.docker.com/r/kdsda/ubuntu-base

NOTE: This image contains an example entrypoint, for demonstrating use of gosu & tini

## EXAMPLE USE
```bash
# Build image from /src/packer; see Makefile
make build

docker images

REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
local/ubuntu  2004      941e06656514   4 minutes ago    174MB

docker run --rm -it local/ubuntu:2004 show this text
docker run --rm -it local/ubuntu:2004 cmd whoami
docker run -e GOSU=true --rm -it local/ubuntu:2004 cmd whoami
docker run -e GOSU=true -e GOSU_USER=demo --rm -it local/ubuntu:2004 cmd whoami
docker run -e GOSU=true -e GOSU_USER=rune --rm -it local/ubuntu:2004 cmd bash
```