resource "azurerm_user_assigned_identity" "function_identity" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name = "${var.prefix}-func-msi"
}

resource "azurerm_role_assignment" "function_identity_assignment" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.function_identity.principal_id
}

resource "azurerm_service_plan" "plan" {
  name                = "${var.prefix}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  //sku_name            = "Y1"
  sku_name = "S2"
}


resource "azurerm_linux_function_app" "client-function" {
  name                       = "${var.prefix}-func-client"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = azurerm_service_plan.plan.id
  storage_account_name       = var.storage_name
  storage_account_access_key = var.storage_key

  app_settings = {
    //"WEBSITE_RUN_FROM_PACKAGE"              = "1",
    //"FUNCTIONS_WORKER_RUNTIME"              = "python",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.appinsights_key
    //"FUNCTIONS_EXTENSION_VERSION"           = "~4"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.appinsights_connectionstring
    AzureWebJobsFeatureFlags = "EnableWorkerIndexing"
  }

  site_config {
    always_on                                     = true
    container_registry_use_managed_identity       = true
    container_registry_managed_identity_client_id = azurerm_user_assigned_identity.function_identity.client_id
    application_stack {
      docker {
        registry_url = var.acr_url
        image_name   = "client"
        image_tag    = "latest"
      }
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.function_identity.id]
  }
}

# resource "azurerm_function_app" "chunker-function" {
#   name                       = "${var.prefix}-func-chunker"
#   location                   = var.location
#   resource_group_name        = var.resource_group_name
#   app_service_plan_id        = azurerm_service_plan.plan.id
#   storage_account_name       = var.storage_name
#   storage_account_access_key = var.storage_key
#   version                    = "~4"
#   os_type                    = "linux"

#   app_settings = {
#     "WEBSITE_RUN_FROM_PACKAGE"              = "1",
#     "FUNCTIONS_WORKER_RUNTIME"              = "python",
#     "FUNCTIONS_EXTENSION_VERSION"           = "~4"
#     "APPINSIGHTS_INSTRUMENTATIONKEY"        = var.appinsights_key
#     "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.appinsights_connectionstring
#     "DOCKER_REGISTRY_SERVER_URL"          = var.acr_url
#     "DOCKER_REGISTRY_SERVER_USERNAME"     = var.acr_username
#     "DOCKER_REGISTRY_SERVER_PASSWORD"     = var.acr_password
#   }

#   site_config {
#     ftps_state       = "Disabled"
#     always_on = true
#     #linux_fx_version = "Python|3.8"
#     linux_fx_version = "DOCKER|${var.acr_url}/client:latest"
#   }

#   identity {
#     type = "SystemAssigned"
#   }
# }




#   name                = "test-app-${local.rg_suffix}"
#   resource_group_name = "test"
#   location            = "westus2"

#   storage_account_name       = azurerm_storage_account.test_app_sa.name
#   storage_account_access_key = azurerm_storage_account.test_app_sa.primary_access_key
#   service_plan_id            = data.azurerm_service_plan.test_service_plan.id
#   builtin_logging_enabled    = false

#   identity {
#     type         = "UserAssigned"
#     identity_ids = [azurerm_user_assigned_identity.test_app.id]
#   }
#   app_settings = {
#     WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
#     FUNCTION_APP_EDIT_MODE              = "readOnly"
#     RUST_BACKTRACE                      = 1
#   }

#   site_config {
#     always_on                                     = true
#     vnet_route_all_enabled                        = true
#     container_registry_use_managed_identity       = true
#     container_registry_managed_identity_client_id = azurerm_user_assigned_identity.test_app.client_id
#     application_stack {
#       docker {
#         registry_url = data.azurerm_container_registry.services_acr.login_server
#         image_name   = "test-repo"
#         image_tag    = "latest"
#       }
#     }
#     app_service_logs {
#       disk_quota_mb         = 35
#       retention_period_days = 90
#     }

#   }
#   depends_on = [
#     azurerm_role_assignment.test_app_docker_pull
#   ]
# }



