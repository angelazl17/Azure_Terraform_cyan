resource "azurerm_kubernetes_cluster" "azurecilium" {
  name                = "azurecilium"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "azurecilium"
  default_node_pool {
    name           = "azurecilium"
    node_count     = 2
    vm_size        = "Standard_B2ms"
    vnet_subnet_id = var.subnet_id
  }


  identity {
    type = "SystemAssigned"
  }
  network_profile {
    pod_cidr            = "10.10.0.0/22"
    service_cidr        = "10.20.0.0/24"
    dns_service_ip      = "10.20.0.10"
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy = "cilium"
    network_data_plane     = "cilium"
  }

  tags = {
    Environment = var.environment
  }
}