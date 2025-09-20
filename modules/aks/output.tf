output "public_kubeconfig" {
  value     = azurerm_kubernetes_cluster.azurecilium.kube_config_raw
  sensitive = true # 标记为敏感，防止在输出中明文显示
}