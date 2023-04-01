terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
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