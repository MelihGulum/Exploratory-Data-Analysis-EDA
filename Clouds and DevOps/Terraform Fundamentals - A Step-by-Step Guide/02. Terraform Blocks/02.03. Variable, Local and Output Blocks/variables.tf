variable "aws_region" {
  description = "The AWS region for the infrastructure."
  type        = string
  default     = "us-east-1"
}

# EC2 Variables
variable "instance_ami" {
  description = "The AMI to use for the instance"
  type        = string
  default     = "ami-012967cc5a8c9f891"
}

variable "instance_type" {
  description = "The instance type of the EC2 instance."
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name to be used on EC2 instance created"
  type        = string
}
