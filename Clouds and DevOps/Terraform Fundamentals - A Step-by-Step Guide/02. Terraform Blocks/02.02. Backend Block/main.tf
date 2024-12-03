terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.19.0"
    }
  }

  backend "s3" { # Specifies the backend type: local, S3, azurerm, gcs
    bucket = "your_bucketname" # The name of the S3 bucket to store the state file.
    key    = "your_key" # The path within the bucket where the state file is stored.
    region = "us-east-1"
  }
}

