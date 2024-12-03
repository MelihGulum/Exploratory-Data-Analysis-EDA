variable "bucket_tags" {
  description = "Map of bucket names to environment tags"
  default = {
    "demo-for-each-bucket-dev"  = "Development"
    "demo-for-each-bucket-prod" = "Production"
    "demo-for-each-bucket-test" = "Testing"
  }
}
