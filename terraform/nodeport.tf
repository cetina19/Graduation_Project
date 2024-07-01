resource "kubernetes_service" "chatbot" {
  metadata {
    name = "chatbot-ip"
  }

  spec {
    selector = {
      app = "chatbot"
    }

    port {
      port        = 5000
      target_port = 5000
    }

    type = "NodePort"
  }
}

resource "kubernetes_service" "chatbot2" {
  metadata {
    name = "chatbot-ip2"
  }

  spec {
    selector = {
      app = "chatbot2"
    }

    port {
      port        = 5001
      target_port = 5001
    }

    type = "NodePort"
  }
}

resource "kubernetes_service" "loadbalancer1" {
  metadata {
    name = "loadbalancer-ip1"
  }

  spec {
    selector = {
      app = "loadbalancer1"
    }

    port {
      port        = 8000
      target_port = 8000
    }

    type = "NodePort"
  }
}

resource "kubernetes_service" "loadbalancer2" {
  metadata {
    name = "loadbalancer-ip2"
  }

  spec {
    selector = {
      app = "loadbalancer2"
    }

    port {
      port        = 8001
      target_port = 8001
    }

    type = "NodePort"
  }
}