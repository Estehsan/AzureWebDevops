###########################################################
# Azure App Services
###########################################################
variable "app_name" {
  default = "aznodejsapp"
}

# Set the default environment to dev
variable "app_environment" {
  default = "dev"
}

# Create a Resource Group

resource "azurerm_resource_group" "tf_rg" {
  name = "aznodejsapp-rg"
  location = "West Europe"
}

# Create an App Service Plan

resource "azurerm_app_service_plan" "tf_app_service_plan" {
  name                = "${var.app_name}-${var.app_environment}-app-service-plan-rg"
  location            = data.azurerm_resource_group.tf_rg.location
  resource_group_name = data.azurerm_resource_group.tf_rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Create an App Service

resource "azurerm_app_service" "tf_app_service" {
  name                = "${var.app_name}-${var.app_environment}-service"
  location            = data.azurerm_resource_group.tf_rg.location
  resource_group_name = data.azurerm_resource_group.tf_rg.name
  app_service_plan_id = azurerm_app_service_plan.tf_app_service_plan.id

  tags = {
    Name        = "${var.app_name}-app-service"
    Environment = var.app_environment
  }
}