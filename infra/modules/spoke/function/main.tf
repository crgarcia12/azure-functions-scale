resource "azurerm_app_service_plan" "plan" {
  name                = "${var.prefix}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_function_app" "function" {
  name                       = "${var.prefix}-func-client"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_app_service_plan.plan.id
  storage_account_name       = var.storage_name
  storage_account_access_key = var.storage_key
}