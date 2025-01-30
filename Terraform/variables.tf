variable "subscription_name" {
    description = "The name of the subscription"
    type        = string
}

variable "resource_group_name" {
    description = "The name of the resource group"
    type        = string
}

variable "primary_location" {
    description = "The primary location"
    type        = string
}

variable "secondary_location" {
    description = "The secondary location"
    type        = string
}

variable "Allowed_IP_Range" {
    description = "The allowed IP range for the firewall"
    type        = string
}

variable "primary" {
    description = "The primary network location"
    type        = string
}

variable "secondary" {
    description = "The secondary network location"
    type        = string
}