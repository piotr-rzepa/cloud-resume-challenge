terraform {
  required_version = "~> 1.4.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
  }
  # The backend for different environment (main, dev) is passed using terraform init -backend-config=<backend config file>
  backend "s3" {}
}

provider "aws" {
  region = var.aws_region
}

provider "random" {}
