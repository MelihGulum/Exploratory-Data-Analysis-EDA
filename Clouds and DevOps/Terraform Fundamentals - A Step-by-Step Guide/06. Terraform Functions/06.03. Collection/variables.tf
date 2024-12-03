# Variables Section
# -----------------
# Define reusable variables for collection function examples.
variable "list_example" {
  default = ["apple", "banana", "cherry"]
}

variable "nested_list_example" {
  default = [["red", "green"], ["blue", "yellow"]]
}

variable "map_example" {
  default = {
    name  = "John Doe"
    email = "john.doe@example.com"
  }
}

variable "map_example2" {
  default = {
    role  = "Admin"
    team  = "IT"
  }
}