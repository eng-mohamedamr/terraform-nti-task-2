# Create a ConfigMap containing the Instance public IP
resource "kubernetes_config_map" "instance_ip" {
  metadata {
    name = "bastion-ip-config"
  }

  data = {
    BASTION_PUBLIC_IP = var.instance_public_ip
  }
}

# Create an NGINX Pod that reads the IP from the ConfigMap
resource "kubernetes_pod" "nginx" {
  metadata {
    name = "nginx-bastion-ip"
    labels = {
      app = "nginx"
    }
  }

  spec {
    container {
      name  = "nginx"
      image = "nginx:latest"

      env {
        name = "BASTION_PUBLIC_IP"

        value_from {
          config_map_key_ref {
            name = kubernetes_config_map.instance_ip.metadata[0].name
            key  = "BASTION_PUBLIC_IP"
          }
        }
      }
    }
  }
}

# Deploy Traefik using Helm
resource "helm_release" "traefik" {
  name       = "traefik"
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  namespace  = "default"

  create_namespace = false
}