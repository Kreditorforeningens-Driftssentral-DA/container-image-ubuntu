build {
  sources = ["source.docker.UBUNTU_2004"]

  # ADD EXAMPLE ENTRYPOINT FILE
  provisioner "file" {
    source      = "files/docker-entrypoint.sh"
    destination = "/docker-entrypoint.sh"
  }

  # PROVISION IMAGE
  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline = [
      "set -e",
      "echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections",
      "apt-get -qqy update",
      "apt-get -qqy install --no-install-recommends dialog apt-utils",
      "apt-get -qqy upgrade",
      "apt-get -qqy install --no-install-recommends tini gosu python3-minimal python3-apt unzip curl jq gnupg2",
      "apt-get -qqy clean",
      "chmod +x /docker-entrypoint.sh",
    ]
  }

  # TAG & PUSH IMAGE(S)
  post-processors {
    post-processor "docker-tag" {
      only       = ["docker.UBUNTU_2004"]
      tags       = [var.build_date,"20.04", "focal", "latest"]
      repository = var.docker_image_name
    }

    post-processor "docker-push" {
      name           = "push"
      login          = true
      login_username = var.docker_login_username
      login_server   = var.docker_login_server
      login_password = var.docker_login_password
    }
  }
}
