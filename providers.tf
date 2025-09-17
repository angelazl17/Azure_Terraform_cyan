terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
  subscription_id = "11598e29-e9dc-4552-8212-8915837abedb"
}