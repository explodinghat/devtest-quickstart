terraform {
  required_version = ">= 1.3"
  backend "azurerm" {}
  required_providers {
    azurerm = {
      version = "~>3.2"
      source  = "hashicorp/azurerm"
    }
  }
}
provider "azurerm"{
    features{}
}
resource "azurerm_resource_group" "devtestlab" {
  name     = "devtestlab-${var.DEVTEST_ID}-rg"
  location = "UKWest"
}

resource "azurerm_dev_test_lab" "example" {
  name                = "devtestlab-${var.DEVTEST_ID}"
  location            = azurerm_resource_group.devtestlab.location
  resource_group_name = azurerm_resource_group.devtestlab.name

  tags = {
    "Automated" = "True"
  }
}