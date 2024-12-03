# ==========================================================
# Core Collection Functions
# ==========================================================
# Functions covered:
# 1. length(list or map)
# 2. element(list, index)
# 3. lookup(map, key, default)
# 4. merge(map1, map2, ...)
# 5. flatten(list of lists)


# 1. Length Function
# Returns the number of elements in a list or keys in a map.
output "length_list_example" {
  value = length(var.list_example)
}
# Output: 3

output "length_map_example" {
  value = length(var.map_example)
}
# Output: 2


# 2. Element Function
# Returns an element from a list by its index.
output "element_example" {
  value = element(var.list_example, 1)
}
# Output: "banana"


# 3. Lookup Function
# Retrieves the value for a key in a map. If the key is not found, it returns a default value.
output "lookup_example" {
  value = lookup(var.map_example, "email", "not_found@example.com")
}
# Output: "john.doe@example.com"

output "lookup_default_example" {
  value = lookup(var.map_example, "age", "N/A")
}
# Output: "N/A"


# 4. Merge Function
# Combines multiple maps into one. If keys overlap, later values overwrite earlier ones.
output "merge_example" {
  value = merge(var.map_example, var.map_example2)
}
# Output: {
#   email = "john.doe@example.com"
#   name  = "John Doe"
#   role  = "Admin"
#   team  = "IT"
# }


# 5. Flatten Function
# Converts a nested list into a single list.
output "flatten_example" {
  value = flatten(var.nested_list_example)
}
# Output: ["red", "green", "blue", "yellow"]


# ==========================================================
# Extended Collection Functions
# ==========================================================
# Functions covered:
# 6. keys(map)
# 7. values(map)
# 8. zipmap(keys, values)


# 6. Keys Function
# Returns a list of all keys in a map.
output "keys_example" {
  value = keys(var.map_example)
}
# Output: ["name", "email"]


# 7. Values Function
# Returns a list of all values in a map.
output "values_example" {
  value = values(var.map_example)
}
# Output: ["John Doe", "john.doe@example.com"]


# 8. Zipmap Function
# Creates a map from a list of keys and a list of values.
output "zipmap_example" {
  value = zipmap(["key1", "key2"], ["value1", "value2"])
}
# Output: {
#   key1 = "value1"
#   key2 = "value2"
# }


# ==========================================================
# Conclusion
# ==========================================================
# This file demonstrates Terraform's collection manipulation functions.
# Use `terraform apply` to see these outputs.
# Try experimenting with your own data structures to explore further!
