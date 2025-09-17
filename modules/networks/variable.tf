variable "subnet_config" {
  description = "subnet config"
  type = list(object({
    name           = string
    address_prefix = string
    security_group = optional(string, "default")
  }))
  default = []
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be deployed"
}

variable "resource_group_name" {
  type        = string
  description = "The Azure region where resources will be deployed"
}