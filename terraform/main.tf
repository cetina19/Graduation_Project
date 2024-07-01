terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
    k8s = {
      source = "mingfang/k8s"
      version = "1.0.6"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.24.0"
    }
  }
}

provider "docker" {}
provider "k8s" {}
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-kind"
  config_context_cluster   = "kind-kind"
}

resource "docker_image" "chatbot" {
  name         = "alpercetin/chatbot_web:latest"
  keep_locally = false
}

resource "docker_container" "chatbot" {
  image = docker_image.chatbot.image_id
  name  = "chatbot_web"
  stdin_open  = true
  tty   = true

  ports {
    internal = 80
    external = 5000
  }

  cpu_shares = 2
}

resource "docker_image" "chatbot2" {
  name         = "alpercetin/chatbot_loadbalancer:v1"
  keep_locally = false
}

resource "docker_container" "chatbot2" {
  image = docker_image.chatbot2.image_id
  name  = "chatbot_loadbalancer"
  stdin_open  = true
  tty   = true

  ports {
    internal = 80
    external = 5001
  }

  cpu_shares = 4
}

resource "docker_image" "loadbalancer1" {
  name         = "alpercetin/chatbot_loadbalancer:v2"
  keep_locally = false
}

resource "docker_container" "loadbalancer1" {
  image = docker_image.loadbalancer1.image_id
  name  = "chatbot_loadbalancer2"
  stdin_open  = true
  tty   = true

  ports {
    internal = 80
    external = 8000
  }

  cpu_shares = 2
}

resource "docker_image" "loadbalancer2" {
  name         = "alpercetin/chatbot_loadbalancer:v3"
  keep_locally = false
}

resource "docker_container" "loadbalancer2" {
  image = docker_image.loadbalancer2.image_id
  name  = "chatbot_loadbalancer3"
  stdin_open  = true
  tty   = true

  ports {
    internal = 80
    external = 8001
  }

  cpu_shares = 2
}