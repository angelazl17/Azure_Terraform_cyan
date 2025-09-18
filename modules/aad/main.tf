resource "azurerm_user_assigned_identity" "uami_demo" {
  name                = "uami-demo"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azuread_group" "aks_admins" {
  display_name = "aks-admins-${var.cluster_name}"
  security_enabled = true
}