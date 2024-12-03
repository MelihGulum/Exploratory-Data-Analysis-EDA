output "bucket_names_and_tags" {
  value = { for k, v in var.bucket_tags : k => aws_s3_bucket.buckets[k].tags }
}