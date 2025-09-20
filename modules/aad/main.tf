resource "azurerm_user_assigned_identity" "uami_demo" {
  name                = "uami-demo"
  resource_group_name = var.resource_group_name
  location            = var.location
}

