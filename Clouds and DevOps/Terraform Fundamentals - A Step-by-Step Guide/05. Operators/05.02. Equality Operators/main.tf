variable "env" {
  default = "dev"
}

locals {
  is_dev  = var.env == "dev"
  is_prod = var.env != "prod"
}

output "equality_operations" {
  value = {
    is_dev  = local.is_dev
    is_prod = local.is_prod
  }
}
