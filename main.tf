# frontend/main.tf
terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "frontend_deployment" {
  metadata {
    name = "counter-frontend-deployment"
    namespace = "default"
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
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend_service" {
  metadata {
    name = "frontend-service"
    namespace = "default"
  }
  
  spec {
    selector = {
      app = "counter-frontend"
    }
    
    port {
      port        = 3000
      target_port = 3000
    }
    
    type = "ClusterIP"
  }
}

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
            container_port = 3000
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
      port        = 3000
      target_port = 3000
    }
    
    type = "ClusterIP"
  }
}