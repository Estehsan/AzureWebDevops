############################################################
# Azure App Services
############################################################
variable "app_name" {
  default = "aznodejsapp"
}

variable "app_environment" {
  default = "dev"
}

data "azurerm_resource_group" "tf_rg" {
  name = "aznodejsapp-rg"
}

resource "azurerm_app_service_plan" "tf_app_service_plan" {
  name                = "${var.app_name}-${var.app_environment}-app-service-plan"
  location            = data.azurerm_resource_group.tf_rg.location
  resource_group_name = data.azurerm_resource_group.tf_rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

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
