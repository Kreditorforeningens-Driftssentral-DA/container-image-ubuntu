build {
  sources = [
    "source.docker.UBUNTU_2004",
  ]

  # ADD EXAMPLE ENTRYPOINT FILE
  provisioner "file" {
    source      = "docker-entrypoint.sh"
    destination = "/docker-entrypoint.sh"
  }

  # PROVISION IMAGE
  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline = [
      "set -e",
      "chmod +x /docker-entrypoint.sh",
      "apt-get -qqy update",
      "apt-get -qqy install --no-install-recommends dialog apt-utils",
      "apt-get -qqy upgrade",
      "apt-get -qqy install --no-install-recommends tini gosu python3-minimal python3-apt unzip curl jq gnupg2",
      "apt-get -qqy clean",
    ]
  }

  # TAG & PUSH IMAGE(S)
  post-processors {
    post-processor "docker-tag" {
      only       = ["docker.UBUNTU_2004"]
      repository = var.docker_image_name
      tags       = ["2004", "focal", "latest"]
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
