resource "azurerm_resource_group" "secret" {
    name     = "secret-rg"
    location = "East US"
}

resource "azurerm_container_group" "secret" {
    name                = "secret-containergroup"
    location            = azurerm_resource_group.secret.location
    resource_group_name = azurerm_resource_group.secret.name
    os_type             = "Linux"

    container {
        name   = "secret-container"
        image  = "nginx:latest"
        cpu    = "0.5"
        memory = "1.5"

        ports {
            port     = 80
            protocol = "TCP"
        }
    }

    tags = {
        environment = "testing"
    }
}

resource "azurerm_application_gateway" "secret" {
    name                = "secret-appgateway"
    location            = azurerm_resource_group.secret.location
    resource_group_name = azurerm_resource_group.secret.name
    sku {
        name     = "Standard_v2"
        tier     = "Standard_v2"
        capacity = 2
    }

    gateway_ip_configuration {
        name      = "appgatewayipconfig"
        subnet_id = azurerm_subnet.secret.id
    }

    frontend_port {
        name = "frontendport"
        port = 80
    }

    frontend_ip_configuration {
        name                 = "frontendipconfig"
        public_ip_address_id = azurerm_public_ip.secret.id
    }

    backend_address_pool {
        name = "backendpool"
    }

    backend_http_settings {
        name                  = "backendhttpsettings"
        cookie_based_affinity = "Disabled"
        port                  = 80
        protocol              = "Http"
        request_timeout       = 20
    }

    http_listener {
        name                           = "httplistener"
        frontend_ip_configuration_name = "frontendipconfig"
        frontend_port_name             = "frontendport"
        protocol                       = "Http"
    }

    request_routing_rule {
        name                       = "rulename"
        rule_type                  = "Basic"
        http_listener_name         = "httplistener"
        backend_address_pool_name  = "backendpool"
        backend_http_settings_name = "backendhttpsettings"
    }

    tags = {
        environment = "testing"
    }
}

resource "azurerm_virtual_network" "secret" {
    name                = "secret-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.secret.location
    resource_group_name = azurerm_resource_group.secret.name
}

resource "azurerm_subnet" "secret" {
    name                 = "secret-subnet"
    resource_group_name  = azurerm_resource_group.secret.name
    virtual_network_name = azurerm_virtual_network.secret.name
    address_prefixes     = ["10.0.1.0/24"]
}

