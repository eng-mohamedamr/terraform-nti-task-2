terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
      http = {
      source  = "hashicorp/aws"
    }
    }
    
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

