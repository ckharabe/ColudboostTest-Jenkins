variable "boolean_map" {
  type = map(string)

  default = {
    "true"  = "true"
    "false" = "false"
  }
}

variable "sku_name_map" {
  type = map(string)

  default = {
    "standard" = "standard"
    "premium"  = "premium"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
 client_id = "6d41da4e-773b-4a87-a599-69b30e68317d"
 client_secret = "p~We1._-8Nv520.oRL0MiPurP4PTVqw6MM"
 subscription_id = "cfde4035-44d8-4bee-a995-eb9199a8a2c1"
 tenent_id = "c7183232-e1e7-424d-9b37-ab787c4a6c0c"
features {}
}

resource "azurerm_resource_group" "quickstart" {
  name     = "${var.resource_group_name}"
  location = "${var.resource_group_location}"

  # tags {
  #   "Source" : "Azure Quickstarts for Terraform"
  # }
}

resource "azurerm_key_vault" "quickstart" {
  name                = "${var.keyvault_name}"
  location            = "${azurerm_resource_group.quickstart.location}"
  resource_group_name = "${azurerm_resource_group.quickstart.name}"

  sku_name = "${lookup(var.sku_name_map, var.sku_name)}"

  tenant_id = "${var.keyvault_tenant_id}"


  enabled_for_deployment          = "${lookup(var.boolean_map, var.enable_vault_for_deployment)}"
  enabled_for_disk_encryption     = "${lookup(var.boolean_map, var.enable_vault_for_disk_encryption)}"
  enabled_for_template_deployment = "${lookup(var.boolean_map, var.enabled_for_template_deployment)}"
}

output "vault_uri" {
  value = ["${azurerm_key_vault.quickstart.vault_uri}"]
}
