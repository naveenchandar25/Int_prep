output "resource_group_name" {
    value = azurerm_resource_group.secret.name
}

output "container_group_name" {
    value = azurerm_container_group.secret.name
}

output "application_gateway_name" {
    value = azurerm_application_gateway.secret.name
}

output "virtual_network_name" {
    value = azurerm_virtual_network.secret.name
}

output "subnet_name" {
    value = azurerm_subnet.secret.name
}