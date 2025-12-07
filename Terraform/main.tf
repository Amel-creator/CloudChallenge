terraform {
  required_providers {

    random = {
      source = "hashicorp/random"
      version = "~> 3.5"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

// Configuration du provider AWS
provider "aws" {
  region = var.aws_region
}

// Création du VPC
resource "aws_vpc" "app" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
     Name = var.vpc_name  # Référence à la variable vpc_name
  }
}
module "s3" {
  source       = "./modules/s3"
  bucket_name = "${var.project_name}-bucket-${var.environment}-${random_id.bucket_suffix.hex}"
  environment  = var.environment
}
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

module "parameter_store" {
  source = "./modules/parameter_store"

  parameters = {
    DB_PASSWORD = var.db_password
    API_KEY     = var.api_key
  }

  environment  = var.environment
  project_name = var.project_name
  db_password  = var.db_password
  api_key      = var.api_key
}

module "github_sa" {
  source = "./modules/service_account"

  name              = var.project_name
  repo_owner        = var.repo_owner
  repo_name         = var.repo_name
  branch            = var.branch
  github_oidc_url   = var.github_oidc_url
  github_oidc_arn   = var.github_oidc_arn
}

