# 1. Crear un Namespace para organizar las cosas
resource "kubernetes_namespace_v1" "db2_space" {
  metadata {
    name = "database-layer"
  }
}

# 2. El Deployment de Db2
resource "kubernetes_deployment_v1" "db2_deployment" {
  metadata {
    name      = "db2-server"
    namespace = kubernetes_namespace_v1.db2_space.metadata[0].name
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "db2"
      }
    }

    template {
      metadata {
        labels = {
          app = "db2"
        }
      }

      spec {
        container {
          image = "icr.io/db2_community/db2" # Imagen oficial de IBM
          name  = "db2-container"
          security_context {
            privileged = true
          }
          env {
            name  = "DB2INSTANCE"
            value = "db2inst1"
          }
          env {
            name  = "db2inst1_password"
            value = "passw0rd" # ¡Change it!
          }
          env {
            name  = "LICENSE"
            value = "accept"
          }

          port {
            container_port = 50000 
          }
        }
      }
    }
  }
}

# 3. El Servicio para conectar con la DB
resource "kubernetes_service_v1" "db2_service" {
  metadata {
    name      = "db2-service"
    namespace = kubernetes_namespace_v1.db2_space.metadata[0].name
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.db2_deployment.spec[0].template[0].metadata[0].labels.app
    }
    port {
      port        = 50000
      target_port = 50000
    }
    type = "NodePort" 
  }
}

