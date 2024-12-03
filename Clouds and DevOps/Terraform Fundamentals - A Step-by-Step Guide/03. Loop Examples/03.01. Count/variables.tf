# Input Variables for Bucket Configurations
variable "bucket_names" {
  description = "List of bucket names to create"
  default = ["count-demo-bucket0", "count-demo-bucket1", "count-demo-bucket2"]
}
