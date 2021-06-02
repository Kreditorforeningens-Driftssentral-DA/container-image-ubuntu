variable build_date {
  type    = string
  default = "2021-01-01"
}

variable docker_image_name {
  type    = string
  default = "local/ubuntu"
}

variable docker_image_tags {
  type    = list(string)
  default = ["latest"]
}

variable docker_login_username {
  type    = string
  default = ""
}

variable docker_login_password {
  type    = string
  default = ""
}

variable docker_login_server {
  type    = string
  default = "registry.hub.docker.com"
}

variable dockerfile_changes {
  type    = list(string)
  default = [
    "ENTRYPOINT [\"/usr/bin/tini\", \"--\", \"/docker-entrypoint.sh\"]",
    "CMD [\"hello\"]"
  ]
}
