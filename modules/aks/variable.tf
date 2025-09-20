variable "location" {
  type        = string
  description = "The Azure region where resources will be deployed"
}

variable "environment" {
  type        = string
  description = "The Azure evn"
}

variable "resource_group_name" {
  type        = string
  description = "The Azure region where resources will be deployed"
}

variable "subnet_id" {
  type        = string
  description = "subnet id for cluster"
}
