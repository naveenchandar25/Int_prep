
output "vnet_id" {
    value = azurerm_virtual_network.secret-sharing_vnet.id
}

output "subnet_id" {
    value = azurerm_subnet.secret-sharing_subnet.id
}