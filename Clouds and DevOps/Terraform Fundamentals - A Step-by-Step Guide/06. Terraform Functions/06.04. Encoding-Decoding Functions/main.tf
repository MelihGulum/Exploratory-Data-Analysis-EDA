# ==========================================================
# Encoding-Decoding Functions
# ==========================================================
# Functions covered:
# 1. base64encode(string)
# 2. base64decode(string)
# 3. JSON Encoding
# 4. jsondecode(string)
# 5. urlencode(string)


# 1. Base64 Encoding
# Encodes a string into Base64 format.
output "base64_encoded" {
  value = base64encode("Hello, Terraform!")
}
# Output: "SGVsbG8sIFRlcnJhZm9ybSE="


# 2. Base64 Decoding
# Decodes a Base64-encoded string back to its original form.
output "base64_decoded" {
  value = base64decode(base64encode("Hello, Terraform!"))
}
# Output: "Hello, Terraform!"


# 3. JSON Encoding
# Encodes a Terraform object into a JSON string.
locals {
  object_data = {
    key1 = "value1"
    key2 = 42
  }
}

output "encoded_json" {
  value = jsonencode(local.object_data)
}
# Output: "{\"key1\":\"value1\",\"key2\":42}"


# 4. JSON Decoding
# Decodes a JSON string into a Terraform map or object.
locals {
  json_data = "{\"key1\": \"value1\", \"key2\": 42}" # JSON string
}

output "decoded_json" {
  value = jsondecode(local.json_data)
}
# Output:
# {
#   "key1" = "value1"
#   "key2" = 42
# }


# 5. URL Encoding
# Encodes special characters in a URL string to make it safe.
output "url_encoded" {
  value = urlencode("https://example.com/?key=value&other=thing")
}
# Output: "https%3A%2F%2Fexample.com%2F%3Fkey%3Dvalue%26other%3Dthing"


# ==========================================================
# Conclusion
# ==========================================================
# This file demonstrates Terraform's encoding and decoding functions.
# Use `terraform apply` to see these outputs.
# Experiment with different strings to explore further!
