resource "azurerm_cosmosdb_postgresql_cluster" "db" {
  name                                 = "stripedb"
  resource_group_name                  = azurerm_resource_group.rg.name
  location                             = azurerm_resource_group.rg.location
  administrator_login_password         = var.admin_password
  coordinator_server_edition           = "BurstableMemoryOptimized"
  node_server_edition                  = "MemoryOptimized"
  coordinator_storage_quota_in_mb      = 32768
  coordinator_vcore_count              = 1
  node_vcores                          = 4
  node_count                           = 0
  sql_version                          = 14
  coordinator_public_ip_access_enabled = true
  node_storage_quota_in_mb             = 524288
  citus_version                        = 12.1
}

resource "azurerm_cosmosdb_postgresql_firewall_rule" "cpfr" {
  name             = "webapprule"
  cluster_id       = azurerm_cosmosdb_postgresql_cluster.db.id
  start_ip_address = azurerm_public_ip.pip.ip_address
  end_ip_address   = azurerm_public_ip.pip.ip_address
}
