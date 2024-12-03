variable "base_number" {
  default = 10
}

locals {
  addition       = var.base_number + 5
  subtraction    = var.base_number - 3
  multiplication = var.base_number * 2
  division       = var.base_number / 2
  modulus        = var.base_number % 3
}

output "arithmetic_operations" {
  value = {
    addition       = local.addition
    subtraction    = local.subtraction
    multiplication = local.multiplication
    division       = local.division
    modulus        = local.modulus
  }
}
