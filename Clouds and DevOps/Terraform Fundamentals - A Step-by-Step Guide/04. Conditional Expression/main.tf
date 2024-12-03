terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.19.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = (
    var.environment == "prod" ? "cond-exp-prod-bucket" :
    # var.environment == "test" ? "cond-exp-test-bucket" :
    "cond-exp-dev-bucket"
  )

  tags = {
    Name        = "Example S3 Bucket"
    Environment = var.environment
  }
}
