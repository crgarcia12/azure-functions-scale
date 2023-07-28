resource "azurerm_service_plan" "plan" {
 name                = "${var.prefix}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "Y1"
}


resource "azurerm_function_app" "client-function" {
  name                       = "${var.prefix}-func-client"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_service_plan.plan.id
  storage_account_name       = var.storage_name
  storage_account_access_key = var.storage_key
  version                    = "~4"
  os_type                    = "linux"
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"              = "1",
    "FUNCTIONS_WORKER_RUNTIME"              = "python",
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = var.appinsights_key
    "FUNCTIONS_EXTENSION_VERSION"           = "~4"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.appinsights_connectionstring
  }

  site_config {
    linux_fx_version = "Python|3.8"
    ftps_state       = "Disabled"
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_function_app" "chunker-function" {
  name                       = "${var.prefix}-func-chunker"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_service_plan.plan.id
  storage_account_name       = var.storage_name
  storage_account_access_key = var.storage_key
  version                    = "~4"
  os_type                    = "linux"
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"              = "1",
    "FUNCTIONS_WORKER_RUNTIME"              = "python",
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = var.appinsights_key
    "FUNCTIONS_EXTENSION_VERSION"           = "~4"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.appinsights_connectionstring
  }

  site_config {
    linux_fx_version = "Python|3.8"
    ftps_state       = "Disabled"
  }
  identity {
    type = "SystemAssigned"
  }
}
