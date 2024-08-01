variable "location" {
  default = "westeurope"
}

variable "admin_password" {
  description = "The password for the PostgreSQL administrator login."
  type        = string
  sensitive   = true
}

variable "docker_reg_user" {
  description = "Docker registry username"
  type        = string
  sensitive   = true
}

variable "docker_reg_pass" {
  description = "Docker registry password"
  type        = string
  sensitive   = true
}
locals {
  postgre_connect_url = "postgresql://citus:${var.admin_password}@${azurerm_cosmosdb_postgresql_cluster.db.servers[0].fqdn}:5432/citus?sslmode=require"
}

