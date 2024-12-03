variable "names" {
  description = "A list of names"
  type        = list(string)
  default     = ["Michael", "Dwight", "Jim"]
}

output "upper_names" {
  value = [for name in var.names : lower(name)]
}