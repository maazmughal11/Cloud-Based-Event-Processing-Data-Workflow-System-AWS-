terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# STATE STORAGE (local for demo)
terraform {
  backend "local" {}
}

# Resources
module "s3" {
  source = "./s3.tf"
}

module "iam" {
  source = "./iam.tf"
}

module "glue" {
  source = "./glue.tf"
}

module "lambda" {
  source = "./lambda.tf"
}

module "redshift" {
  source = "./redshift.tf"
}
