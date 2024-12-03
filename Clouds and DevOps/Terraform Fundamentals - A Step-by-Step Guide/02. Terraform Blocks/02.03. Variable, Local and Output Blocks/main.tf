terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.19.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  common_tags = {
    Environment = "Development"
    Owner       = "Melih"
  }
}

resource "aws_instance" "app_server" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  tags = merge(
    local.common_tags,
    {
      Name = "${var.instance_name}-app-server"
    }
  )
  monitoring = true
}