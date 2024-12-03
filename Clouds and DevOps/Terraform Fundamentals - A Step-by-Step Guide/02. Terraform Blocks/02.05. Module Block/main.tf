terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.19.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "ec2_instance" {
  source        = "./modules/ec2_instance"
  instance_ami  = var.instance_ami
  instance_type = var.instance_type
  instance_name = var.instance_name
}

output "instance_id" {
  value = module.ec2_instance.module_instance_id
}
