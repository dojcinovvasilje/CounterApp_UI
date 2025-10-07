############################ ZA MASTER NAMESPACE ############################

resource "kubernetes_deployment" "frontend_deployment_master" {
  metadata {
    name = "counter-frontend-deployment"
    namespace = "master"
  }

  spec {
    replicas = 1
    
    selector {
      match_labels = {
        app = "counter-frontend"
      }
    }
    
    template {
      metadata {
        labels = {
          app = "counter-frontend"
        }
      }
      
      spec {
        container {
          name  = "react-container"
          image = "vasilijed/counter-frontend:latest"
          image_pull_policy = "Always"
          
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend_service_master" {
  metadata {
    name = "frontend-service"
    namespace = "master"
  }
  
  spec {
    selector = {
      app = "counter-frontend"
    }
    
    port {
      port        = 80
      target_port = 80
    }
    
    type = "NodePort"
  }
}