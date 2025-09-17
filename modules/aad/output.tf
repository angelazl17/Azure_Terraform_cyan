output "uami_client_id" {
  description = "托管身份的客户端 ID"
  value       = azurerm_user_assigned_identity.uami_demo.client_id
}

output "uami_principal_id" {
  description = "托管身份的主体 ID（对象 ID）"
  value       = azurerm_user_assigned_identity.uami_demo.principal_id
}

output "uami_resource_id" {
  description = "托管资源的完整资源 ID"
  value       = azurerm_user_assigned_identity.uami_demo.id
}