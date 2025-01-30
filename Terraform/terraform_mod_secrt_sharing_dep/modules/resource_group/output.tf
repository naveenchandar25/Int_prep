# Output the name of the primary resource group
output "primary_resource_group" {
    # The value is set to the name of the primary resource group
    value = azurerm_resource_group.rg_primary.name
}

# Output the name of the secondary resource group
output "secondary_resource_group" {
    # The value is set to the name of the secondary resource group
    value = azurerm_resource_group.rg_secondary.name
}