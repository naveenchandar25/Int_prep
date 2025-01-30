output "traffic_manager_profile_id" {
    value = azurerm_traffic_manager_profile.secret.id
}

output "primary_endpoint_id" {
    value = azurerm_traffic_manager_endpoint.primary.id
}

output "secondary_endpoint_id" {
    value = azurerm_traffic_manager_endpoint.secondary.id
}