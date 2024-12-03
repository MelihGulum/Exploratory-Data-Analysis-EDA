terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.19.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "vpc_id" {
  description = "Will get VPC ID"
  type = string
  default = ""
}

data "aws_vpc" "selected" {
  default = true
  id = var.vpc_id
}

output "foo" {
  value = data.aws_vpc.selected.id
}

/*
resource "aws_subnet" "example" {
  vpc_id = data.aws_vpc.selected.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.1.0/24"
}*/
