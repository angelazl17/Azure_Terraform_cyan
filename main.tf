

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