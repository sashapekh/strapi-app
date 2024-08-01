output "webapp_url" {
  value = azurerm_linux_web_app.app.default_hostname
}

output "postgresql_host_url" {
  value = local.postgre_connect_url
  sensitive = true
}