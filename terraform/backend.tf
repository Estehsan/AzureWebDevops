terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = ">= 3.30"
    }
  }
}

provider "azurerm" {
  features {}  
}

#Terraform code to create a resource group

terraform {
  backend "azurerm" {
    storage_account_name = "azurewebapptaskdv"
    container_name       = "acr15may"
    key                  = "test.state"
    subscription_id      = "fb121715-e9af-41d9-b113-aae88bed3c6d"
    tenant_id            = "ffa63cad-6366-428d-97c3-019bd2ba9d93"
    resource_group_name  = "aznodejsapp-rg"
  }
}
