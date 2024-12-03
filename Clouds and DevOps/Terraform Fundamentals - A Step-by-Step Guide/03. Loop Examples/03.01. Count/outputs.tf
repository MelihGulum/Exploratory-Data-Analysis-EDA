# Output the created bucket names
output "bucket_names" {
  value = aws_s3_bucket.buckets[*].bucket
}

