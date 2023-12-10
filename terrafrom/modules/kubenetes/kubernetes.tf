resource "kubernetes_deployment" "dolly-deployment" {
  metadata {
    name = "dolly-v2-3b-deployment"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "dolly-v2-3b"
      }
    }

    template {
      metadata {
        labels = {
          app = "dolly-v2-3b"
        }
      }

      spec {
        container {
          image = "comprcompr/arash:latest"
          name  = "dolly-v2-3b"
          # just incase 
          command = ["bash", "-c"]

          port {
            container_port = 8000
          }

          volume_mount {
            mount_path = "/model"
            name       = "model-storage"
          }

          # Define other container properties 
        }

        volume {
          name = "model-storage"

          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.model-pvc.metadata[0]
          }
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "model-pvc" {
  metadata {
    name = "model-storage-pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "10Gi"
      }
    }
  }
}

# Include the Kubernetes service definition if needed
