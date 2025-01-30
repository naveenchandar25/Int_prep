resource "azurerm_virtual_network" "secret-sharing_vnet" {
    name                = "secret-vnet"
    address_space       = ["10.72.72.0/16"]
    location            = { location }
    resource_group_name = {resource_group_name}
}

resource "azurerm_subnet" "secret-sharing_subnet{
    name                 = "secret-subnet"
    resource_group_name  = {resource_group_name}
    virtual_network_name = {vnet_name}
    address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "secret-sharing_NSG" {
    name                = {nsg_name}
    location            = {location}
    resource_group_name = {resource_group_name}

    security_rule {
        name                       = "allow-https"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

resource "azurerm_subnet_network_security_group_association" "secret-sharing_NSG_association" {
    subnet_id                 = azurerm_subnet.secret-sharing_subnet.id
    network_security_group_id = azurerm_network_security_group.secret-sharing_NSG.id
}
