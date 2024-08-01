output "webapp_url" {
  value = azurerm_linux_web_app.app.default_site_hostname
}

output "postgresql_host" {
  value = azurerm_cosmosdb_postgresql_cluster.db.
}