variable "number1" {
  default = 15
}

variable "number2" {
  default = 10
}

locals {
  greater_than     = var.number1 > var.number2
  less_than        = var.number1 < var.number2
  greater_or_equal = var.number1 >= var.number2
  less_or_equal    = var.number1 <= var.number2
}

output "comparison_operations" {
  value = {
    greater_than     = local.greater_than
    less_than        = local.less_than
    greater_or_equal = local.greater_or_equal
    less_or_equal    = local.less_or_equal
  }
}
