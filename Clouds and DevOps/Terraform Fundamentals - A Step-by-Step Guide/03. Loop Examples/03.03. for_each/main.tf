provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "buckets" {
  for_each = var.bucket_tags
  bucket   = each.key

  tags = {
    Name        = each.key
    Environment = each.value
  }
}