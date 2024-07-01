resource "kubernetes_horizontal_pod_autoscaler_v2" "hpa" {
  metadata {
    name = "hpa"
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "chatbot"
    }

    min_replicas = 1
    max_replicas = 5

    target_cpu_utilization_percentage = 90

    metric {
      type = "Resource"
      resource {
        name   = "cpu"
        target {
          type  = "Utilization"
          value = 1
          average_utilization = 1
          //average_value = "2"
          //average_utilization = "2"
        }
      }
    }
  }
}