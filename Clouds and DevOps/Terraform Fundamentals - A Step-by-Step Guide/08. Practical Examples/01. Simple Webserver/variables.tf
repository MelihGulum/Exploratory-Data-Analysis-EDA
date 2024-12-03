variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default     = 8080
}

variable "instance_ami" {
  description = "The AMI ID to use for the instance"
  default     = "ami-012967cc5a8c9f891"
}

variable "instance_type" {
  description = "The instance type to use"
  default     = "t2.micro"
}
