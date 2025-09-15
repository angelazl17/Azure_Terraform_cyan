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

locals {
  resource_group_name_cyan = "${var.environment}-${var.company_name}-rg" #rg=resource group

}

resource "azurerm_resource_group" "daily_rg" {
  name     = local.resource_group_name_cyan # 引用本地计算出的名称
  location = "West US"
}

# 2. Create a Virtual Network
resource "azurerm_virtual_network" "main_vnet" {
  name                = "main-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.daily_rg.location
  resource_group_name = azurerm_resource_group.daily_rg.name
}

# 3. Create Subnets
resource "azurerm_subnet" "web_subnet" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.daily_rg.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "app_subnet" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.daily_rg.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "db_subnet" {
  name                 = "db-subnet"
  resource_group_name  = azurerm_resource_group.daily_rg.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name
  address_prefixes     = ["10.0.3.0/24"]

#   # Often used for subnets that house private endpoints or require no public internet
#   enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_network_security_group" "web_nsg" {
  name                = "web-nsg"
  location            = azurerm_resource_group.daily_rg.location
  resource_group_name = azurerm_resource_group.daily_rg.name

  # Allow HTTP from Internet
  security_rule {
    name                       = "AllowHTTPIn"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*" # Anywhere on the internet
    destination_address_prefix = "*" # Any IP in this subnet
  }

  # Allow HTTPS from Internet
  security_rule {
    name                       = "AllowHTTPSIn"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Allow outbound internet access for updates, etc.
  security_rule {
    name                       = "AllowInternetOut"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443" # HTTPS for secure outbound traffic
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "web_nsg_association" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}

output "vnet_id" {
  value = azurerm_virtual_network.main_vnet.id
}

output "web_subnet_id" {
  value = azurerm_subnet.web_subnet.id
}