resource "azurerm_virtual_network" "fw-vnet" {
    name                = "fw-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = var.fw_rg
}

resource "azurerm_subnet" "fw-subnet" {
    name                 = "AzureFirewallSubnet"
    resource_group_name  = var.fw_rg
    virtual_network_name = azurerm_virtual_network.fw-vnet.name
    address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "public-ip" {
    name                = "public-pip"
    location            = var.location
    resource_group_name = var.fw_rg
    allocation_method   = "Static"
    sku                 = "Standard"
}

resource "azurerm_firewall" "secret-fw" {
    name                = "secret-firewall"
    location            = var.location
    resource_group_name = var.fw_rg

    ip_configuration {
        name                 = "configuration"
        subnet_id            = azurerm_subnet.fw-subnet.id
        public_ip_address_id = azurerm_public_ip.public-ip.id
    }
}

###This block will ensure only connection from specific ip range is allowed. 
resource "azurerm_firewall_network_rule_collection" "example" {
    name                = "only-secret-allow-firewall-rule"
    resource_group_name = var.fw_rg
    firewall_name       = azurerm_firewall.secret-fw.name
    priority            = 100
    action              = "Allow"

    rule {
        name                  = "allow-ip-range"
        source_addresses      = ["*"]
        destination_addresses = {Allowed_IP_Range}
        destination_ports     = ["*"]
        protocols             = ["Any"]
    }
}

resource "azurerm_firewall_network_rule_collection" "block_other_ips" {
    name                = "block-other-ips"
    resource_group_name = var.fw_rg
    firewall_name       = azurerm_firewall.secret-fw.name
    priority            = 200
    action              = "Deny"

    rule {
        name                  = "deny-other-ip-range"
        source_addresses      = ["*"]
        destination_addresses = ["*"]
        destination_ports     = ["*"]
        protocols             = ["Any"]
    }
}