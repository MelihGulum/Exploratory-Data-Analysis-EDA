provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "buckets" {
  count  = length(var.bucket_names)
  bucket = var.bucket_names[count.index]

  tags = {
    Name        = "Bucket-${var.bucket_names[count.index]}"
    Environment = "Development"
  }
}