module "Secret_Subscription" {
    source                            = "./modules/subscription"
    name                              = var.subscription_name
}

module "Secret_ResourceGroup" {
    depends_on = [
    module.Secret_Subscription
    ]
    source                             = "./modules/resource_group"
    resource_group                     = var.resource_group_name
    primary                            = var.primary_location
    secondary                          = var.secondary_location
}

module "Secret_Network" {
    depends_on = [
    module.Secret_Subscription, module.Secret_ResourceGroup
    ]
    source                            = "./modules/network"
     primary                          = var.primary
    secondary                         = var.secondary
}

module "Secret_firewall" {
    source                            = "./modules/firewall"
    Allowed_IP_Range                  = var.Allowed_IP_Range
}

module "Secret_database" {
    source                            = "./modules/database"
}

module "Secret_container" {
    source                            = "./modules/compute_or_conainer"
}

module "Secret_trafficmanager" 
    depends_on = [
    module.Secret_container
    ]
    source                            = "./modules/trafficmanager"
    primary_target                    = "primary.secret.com"
    secondary_target                  = "secondary.secret.com"
}



