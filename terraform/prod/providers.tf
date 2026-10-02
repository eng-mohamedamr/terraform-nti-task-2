terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.13"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket       = "mohamedamr-terraform-test"
    key          = "state_file/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = false
  }
}

provider "aws" {
  region = "eu-north-1"
}
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

# Helm provider v3 syntax (attribute). On v2, use a nested `kubernetes { ... }` block instead.
provider "helm" {
  kubernetes = {
    config_path    = "~/.kube/config"
    config_context = "minikube"
  }
}