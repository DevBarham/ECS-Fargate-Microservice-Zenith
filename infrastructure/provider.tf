# ------- Version -------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
  backend "s3" {
    key    = "ecs/terraform.tfstate"
    region = "us-east-1"
  }
}

# ------- Providers -------
provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}
