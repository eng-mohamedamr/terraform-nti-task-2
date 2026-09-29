terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
      http = {
      source  = "hashicorp/http"
    }
    }
    
  }
    backend "s3" {
    bucket       = "s3-bucket-for-state-file-terraform"
    key          = "state_file/terraform.tfstate"
    region       =  "eu-north-1"
    encrypt      = true
    use_lockfile = true   # S3-native locking, Terraform >= 1.10
    profile = "default"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

