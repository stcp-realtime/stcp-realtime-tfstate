# ---------------------------------------------------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }

  backend "local" {
    path = "state/terraform.tfstate"
  }
}

provider "aws" {
  region = local.aws_region

  default_tags {
    tags = {
      environment = local.environment
      project     = local.project_name
    }
  }
}

locals {
  project_name = "stcp-realtime-tfstate"
  environment = "prod"
  aws_region = "eu-south-2"
}

module "s3_dynamo_tfstate" {
  source = "../../modules/s3_dynamodb_tfstate"

  project_name = local.project_name
  environment = local.environment
}
