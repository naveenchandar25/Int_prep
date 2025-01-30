output "cosmosdb_account_name" {
    value = azurerm_cosmosdb_account.secret-cosmosdb-account.name
}

output "cosmosdb_sql_database_name" {
    value = azurerm_cosmosdb_sql_database.sectret-db.name
}

output "cosmosdb_sql_container_name" {
    value = azurerm_cosmosdb_sql_container.secret-db-container.name
}