output "vnet_id" {
  value = azurerm_virtual_network.main_vnet.id
}

output "web_subnet_id" {
  value = azurerm_subnet.web_subnet.id
}