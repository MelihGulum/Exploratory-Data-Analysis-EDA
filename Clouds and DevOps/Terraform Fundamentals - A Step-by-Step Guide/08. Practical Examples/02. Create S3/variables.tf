variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "bucket_acl" {
  description = "The ACL for the S3 bucket."
  type        = string
  default     = "private"
}

variable "bucket_ownership" {
  description = "The ownership for the S3 bucket."
  type        = string
  default     = "BucketOwnerPreferred"
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket."
  type        = string
  default     = "Enabled"
}

/*
variable "logging_bucket" {
  description = "The name of the bucket to store logs."
  type        = string
}
*/

variable "environment" {
  description = "Environment tag for the bucket."
  type        = string
  default     = "dev"
}