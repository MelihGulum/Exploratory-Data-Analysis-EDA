# ==========================================================
# Type Conversion Functions
# ==========================================================
# Functions covered:
# 1. tostring(value)
# 2. tonumber(value)
# 3. tobool(value)
# 4. tolist(value)
# 5. toset(value)
# 6. tomap(value)


# 1. ToString
# Converts a value to its string representation.
output "to_string_example" {
  value = tostring(12345)
}
# Output: "12345"


# 2. ToNumber
# Converts a value to a number, if possible.
output "to_number_example" {
  value = tonumber("42.5")
}
# Output: 42.5


# 3. ToBool
# Converts a value to a boolean. Strings like "true"/"false" and numbers like 1/0 are accepted.
output "to_bool_example" {
  value = tobool("true")
}
# Output: true


# 4. ToList
# Converts a set or tuple into a list.
locals {
  sample_set = toset(["apple", "banana", "cherry"])
}

output "to_list_example" {
  value = tolist(local.sample_set)
}
# Output: ["apple", "banana", "cherry"]


# 5. ToSet
# Converts a list or tuple into a set (removing duplicates).
locals {
  sample_list = ["apple", "apple", "banana", "cherry"]
}

output "to_set_example" {
  value = toset(local.sample_list)
}
# Output: ["apple", "banana", "cherry"]


# 6. ToMap
# Converts an object or list of key-value tuples into a map.
locals {
  key_value_pairs = {
    key1 = "value1"
    key2 = "value2"
  }
}

output "to_map_example" {
  value = tomap(local.key_value_pairs)
}
# Output:
# {
#   "key1" = "value1"
#   "key2" = "value2"
# }


# ==========================================================
# Conclusion
# ==========================================================
# This file demonstrates Terraform's type conversion functions.
# Use `terraform apply` to see these outputs.
# Experiment by changing the input data types to understand how conversions work!
