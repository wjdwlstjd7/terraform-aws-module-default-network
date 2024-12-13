terraform {
  required_version = ">= 1.0.7"
  required_providers {
    aws = {
      version = ">= 3.55.0"
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  # Default Region
  region = var.aws_default_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}