# we specify here the storage account, container and key where the state will be stored..
# the subscription will be the one defined in the ARM_SUBSCRIPTION_ID (parameter of the pipeline)

terraform {
    backend "azurerm" {
        resource_group_name  = "ES-STORAGEACC"
        storage_account_name = "ES_TST_NAVEEN"
        container_name       = "tfstatefile"
        key                  = "ES_TST_NAVEEN_TFSTATE.tfstate" # you must adjust that line if using own resource group
        # This is the backend configuration for storing the Terraform state file in Azure
    }
}