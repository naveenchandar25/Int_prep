# Retrieve the billing enrollment account scope data
data "azurerm_billing_enrollment_account_scope" "company_name" {
  billing_account_name    = "75757575"         # The billing account name
  enrollment_account_name = "7575757575"       # The enrollment account name
}

# Create a new Azure subscription resource
resource "azurerm_subscription" "secret_sharing" {
  subscription_name = "ES-secret_sharing_tool" # The name of the new subscription
  billing_scope_id  = data.azurerm_billing_enrollment_account_scope.company_name.id # The billing scope ID from the data source
}