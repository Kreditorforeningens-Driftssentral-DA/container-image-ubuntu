source docker "UBUNTU_2104" {
  image   = "registry.hub.docker.com/library/ubuntu:hirsute"
  commit  = true
  changes = var.dockerfile_changes
}

source docker "UBUNTU_2004" {
  image   = "registry.hub.docker.com/library/ubuntu:focal"
  commit  = true
  changes = var.dockerfile_changes
}
