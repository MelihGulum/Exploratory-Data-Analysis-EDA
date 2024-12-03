variable "enabled" {
  default = true
}

variable "is_active" {
  default = false
}

locals {
  and_operation = var.enabled && var.is_active
  or_operation  = var.enabled || var.is_active
  not_operation = !var.is_active
}

output "logical_operations" {
  value = {
    and_operation = local.and_operation
    or_operation  = local.or_operation
    not_operation = local.not_operation
  }
}
