# ==========================================================
# Core String Functions
# ==========================================================
# Functions covered:
# 1. join(separator, list)
# 2. split(separator, string)
# 3. replace(string, search, replace)
# 4. trimspace(string)


# 1. Join Function
# Combines a list of strings into one string, using a specified separator.
output "join_example" {
  value = join(", ", var.words)
}
# Output: "hello, world"


# 2. Split Function
# Splits a string into a list of strings based on a specified separator.
output "split_example" {
  value = split(" ", var.phrase)
}
# Output: ["hello", "world", "terraform"]


# 3. Replace Function
# Replaces all occurrences of a substring with another substring.
output "replace_example" {
  value = replace(var.phrase, "terraform", "Terraform")
}
# Output: "hello world Terraform"


# 4. Trimspace Function
# Removes leading and trailing whitespace from a string.
output "trimspace_example" {
  value = trimspace(var.text)
}
# Output: "Terraform is awesome!"


# ==========================================================
# Extended String Functions
# ==========================================================
# Functions covered:
# 5. substr(string, offset, length)
# 6. tolower(string)
# 7. toupper(string)
# 8. startswith(string, prefix)
# 9. endswith(string, suffix)
# 10. coalesce(string1, string2, ...)


# 5. Substr Function
# Extracts a portion of a string, starting at a given position and spanning a specified length.
output "substr_example" {
  value = substr(trimspace(var.text), 0, 9)
}
# Output: "Terraform"


# 6. ToLower Function
# Converts all characters in a string to lowercase.
output "lower_example" {
  value = lower(var.phrase)
}
# Output: "hello world terraform"


# 7. ToUpper Function
# Converts all characters in a string to uppercase.
output "upper_example" {
  value = upper(var.phrase)
}
# Output: "HELLO WORLD TERRAFORM"


# 8. Startswith and Endswith Functions
# Checks whether a string starts or ends with a specified substring.
output "startswith_example" {
  value = startswith(var.phrase, "hello")
}
# Output: true

output "endswith_example" {
  value = endswith(var.phrase, "terraform")
}
# Output: true


# 9. Coalesce Function
# Returns the first non-empty string from the list of inputs.
variable "empty_value" {
  default = ""
}

output "coalesce_example" {
  value = coalesce(var.empty_value, "default_value", "fallback_value")
}
# Output: "default_value"


# ==========================================================
# Conclusion
# ==========================================================
# This file demonstrates Terraform's string manipulation functions.
# Try applying and running this file using `terraform apply` to see the outputs.
# Add more examples to practice and explore other Terraform capabilities!
