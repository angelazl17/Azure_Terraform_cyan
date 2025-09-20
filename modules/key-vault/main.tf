data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "main" {
  name                        = "kv-aks-demo-${substr(md5(var.resource_group_name), 0, 8)}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  # 初始策略：允许当前用户访问
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"
    ]
  }
}

# 3. 在 Key Vault 中存储一个示例密码
resource "azurerm_key_vault_secret" "example" {
  name         = "ExampleDatabaseConnectionString"
  value        = "Server=myServer;Database=myDB;User Id=myUser;Password=myPass;"
  key_vault_id = azurerm_key_vault.main.id
}


resource "azurerm_key_vault_access_policy" "workload" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.uami_principal_id

  secret_permissions = [
    "Get", "List"
  ]
}