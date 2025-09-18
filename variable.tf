variable "environment" {
  description = "The deployment environment (e.g., dev, stg, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}


variable "company_name" {
  description = "The code of the machine learning"
  type        = string
  default     = "cyan"
}

variable "cluster_name"{
  description = "The code of the machine learning"
  type        = string
  default ="cyan"
}