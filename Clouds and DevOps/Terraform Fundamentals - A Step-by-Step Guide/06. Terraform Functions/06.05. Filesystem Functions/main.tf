# ==========================================================
# Filesystem Functions
# ==========================================================
# Functions covered:
# 1. file(filename)
# 2. filebase64(filename)
# 3. dirname(path)
# 4. basename(path)
# 5. abs_path(path)
# 6. join(delimiter, list)


# 1. File Function
# Reads the contents of a file.
output "file_contents" {
  value = file("example.txt")
}
# Output: The content of example.txt


# 2. Filebase64 Function
# Reads a file and encodes it in base64.
output "file_base64" {
  value = filebase64("example.txt")
}
# Output: Base64-encoded content of example.txt


# 3. Dirname Function
# Returns the directory part of a file path.
output "dir_name_example" {
  value = dirname("/path/to/example.txt")
}
# Output: /path/to


# 4. Basename Function
# Returns the file name from a given path.
output "base_name_example" {
  value = basename("/path/to/example.txt")
}
# Output: example.txt


# 5. Abs_path Function
# Returns the absolute path of a relative file path.
output "abs_path_example" {
  value = abspath("example.txt")
}
# Output: /absolute/path/to/example.txt (depends on your current working directory)


# 6. Join Function
# Joins a list of strings into a single string using a delimiter.
locals {
  path_parts = ["path", "to", "example.txt"]
}
output "joined_path" {
  value = join("/", local.path_parts)
}
# Output: path/to/example.txt


# ==========================================================
# Conclusion
# ==========================================================
# This file demonstrates common filesystem functions in Terraform.
# Use `terraform apply` to see these outputs.
# Try experimenting with different file paths and filenames!
