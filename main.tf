

locals {
  resource_group_name_cyan = "${var.environment}-${var.company_name}-rg" #rg=resource group

}



resource "azurerm_resource_group" "daily_rg" {
  name     = local.resource_group_name_cyan # 引用本地计算出的名称
  location = var.location
}

module "network" {
  source              = "./modules/networks"
  location = var.location
  resource_group_name = azurerm_resource_group.daily_rg.name
}

module "aad" {
  source              = "./modules/aad"
  location = var.location
  resource_group_name = azurerm_resource_group.daily_rg.name
  cluster_name = var.cluster_name
}

module "key-vault" {
  source              = "./modules/key-vault"
  location = var.location
  resource_group_name = azurerm_resource_group.daily_rg.name
  uami_principal_id = module.aad.uami_principal_id
}

module "aks" {
  source              = "./modules/aks"
  location = var.location
  environment = var.environment
  resource_group_name = azurerm_resource_group.daily_rg.name
  subnet_id = module.network.web_subnet_id
}