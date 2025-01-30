resource "azurerm_cosmosdb_account" "secret-cosmosdb-account" {
    name                = "secret-cosmosdb-account"
    location            = {location}
    resource_group_name = {resource_group_name}
    offer_type          = "Standard"
    kind                = "GlobalDocumentDB"

    consistency_policy {
        consistency_level = "Session"
    }

    geo_location {
        location          = {location}
        failover_priority = 0
    }
}

resource "azurerm_cosmosdb_sql_database" "sectret-db" {
    name                = "secret-sqldatabase"
    resource_group_name = {resource_group_name}
    account_name        = azurerm_cosmosdb_account.secret-cosmosdb.name
}

resource "azurerm_cosmosdb_sql_container" "secret-db-container" {
    name                = "example-sqlcontainer"
    resource_group_name = {resource_group_name}
    account_name        = azurerm_cosmosdb_account.secret-cosmosdb-account.name
    database_name       = azurerm_cosmosdb_sql_database.sectret-db.name
    partition_key_path  = "/definition/id"
}