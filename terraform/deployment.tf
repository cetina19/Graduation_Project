resource "kubernetes_pod" "chatbot" {
  metadata {
    name = "chatbot"
  }

  spec {
    container {
      image = "alpercetin/chatbot_web:latest"
      name  = "chatbot"
      stdin = true
      tty   = true

      port {
        container_port = 5000
        host_port = 5000
      }

      resources {
        limits = {
          cpu    = "2"
          memory = "9Gi"
        }
        requests = {
          cpu    = "1"
          memory = "3Gi"
        }
      }
    }
  }
}

resource "kubernetes_pod" "chatbot2" {
  metadata {
    name = "chatbot2"
  }

  spec {
    container {
      image = "alpercetin/chatbot_loadbalancer:v1"
      name  = "chatbot2"
      stdin = true
      tty   = true

      port {
        container_port = 5001
        host_port = 5001
      }

      resources {
        limits = {
          cpu    = "4"
          memory = "9Gi"
        }
        requests = {
          cpu    = "2"
          memory = "3Gi"
        }
      }
    }
  }
}

resource "kubernetes_pod" "loadbalancer1" {
  metadata {
    name = "loadbalancer1"
  }

  spec {
    container {
      image = "alpercetin/chatbot_loadbalancer:v2"
      name  = "loadbalancer1"
      stdin = true
      tty   = true

      port {
        container_port = 8000
        host_port = 8000
      }

      resources {
        limits = {
          cpu    = "2"
          memory = "2Gi"
        }
        requests = {
          cpu    = "1"
          memory = "2Gi"
        }
      }
    }
  }
}

resource "kubernetes_pod" "loadbalancer2" {
  metadata {
    name = "loadbalancer2"
  }

  spec {
    container {
      image = "alpercetin/chatbot_loadbalancer:v3"
      name  = "loadbalancer2"
      stdin = true
      tty   = true

      port {
        container_port = 8001
        host_port = 8001
      }

      resources {
        limits = {
          cpu    = "2"
          memory = "2Gi"
        }
        requests = {
          cpu    = "1"
          memory = "2Gi"
        }
      }
    }
  }
}