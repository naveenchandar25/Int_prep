resource "azurerm_resource_group" "rg_primary" {
    name     = "example-resources-${var.primary_region}"
    location = var.primary_region
}

resource "azurerm_resource_group" "rg_secondary" {
    name     = "example-resources-${var.secondary_region}"
    location = var.secondary_region
}

