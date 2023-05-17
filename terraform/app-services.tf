###########################################################
# Azure App Services
###########################################################

variable "app_name" {
  default = "aznodejsapp"
}

variable "resource_group_name" {
  default = "aznodejsapp-rg"
}

variable "environment" {
  default = "dev"
}

# Create a Resource Group

data "azurerm_resource_group" "tf_rg" {
  name = var.resource_group_name
}

# Create an App Service Plan

resource "azurerm_app_service_plan" "tf_app_service_plan" {
  name                = "${var.app_name}-${var.environment}-app-service-plan"
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
  name                = "${var.app_name}-${var.environment}-app-service"
  location            = data.azurerm_resource_group.tf_rg.location
  resource_group_name = data.azurerm_resource_group.tf_rg.name
  app_service_plan_id = azurerm_app_service_plan.tf_app_service_plan.id

  tags = {
    Name        = "${var.app_name}-app-service"
    Environment = var.environment
  }
}
