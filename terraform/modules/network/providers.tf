terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
      # http = {
      # source  = "hashicorp/aws"
      # }
    }
  }
  backend "s3" {
    bucket       = "mohamedamr-terraform-test"
    key          = "state_file/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
  }


}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

