provider "azurerm" {
    # This provider is the actual one, used for all the work
    subscription_id            = var.context_sub_id
    skip_provider_registration = "true"
    features {}
}