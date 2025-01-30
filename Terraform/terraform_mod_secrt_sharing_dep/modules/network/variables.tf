variable "vnet_name" {
    description = "The name of the virtual network"
    type        = string
    default     = "secret-vnet"
 }
variable "subnet_name" {
    description = "The name of the subnet"
    type        = string
    default     = "secret-subnet"
}

variable "nsg_name" {
    description = "The name of the network security group"
    type        = string
    default     = "example-nsg"
}