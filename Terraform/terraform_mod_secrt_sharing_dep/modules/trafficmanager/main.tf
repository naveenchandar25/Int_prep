resource "azurerm_traffic_manager_profile" "secret" {
    name                = "secret-tm-profile"
    resource_group_name = "tm-rg"
    location            = "global"
    traffic_routing_method = "Performance"
    dns_config {
        relative_name = "secret-tm"
        ttl           = 30
    }
    monitor_config {
        protocol = "HTTP"
        port     = 80
        path     = "/"
    }
}
###Below block will help us to route the traffic to the Desired Regions. 
resource "azurerm_traffic_manager_endpoint" "primary" {
    name                = "primary-endpoint"
    profile_name        = azurerm_traffic_manager_profile.secret.name
    resource_group_name = "secret-resources"
    type                = "externalEndpoints"
    target              = {primary_target}
    endpoint_status     = "Enabled"
    priority            = 1
}

resource "azurerm_traffic_manager_endpoint" "secondary" {
    name                = "secondary-endpoint"
    profile_name        = azurerm_traffic_manager_profile.secret.name
    resource_group_name = "secret-resources"
    type                = "externalEndpoints"
    target              = "secondary.secret.com"
    endpoint_status     = "Enabled"
    priority            = 2
}
