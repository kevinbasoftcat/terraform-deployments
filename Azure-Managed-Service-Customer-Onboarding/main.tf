terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
    backend "azurerm" {
    }
}

data "azuread_client_config" "current" {}
data "azurerm_client_config" "current" {}

# provider "azurerm" {
#   alias = "SandboxManagement"
#   subscription_id = ""
# }

resource "azurerm_resource_group" "customer_tenant_rg" {
  name = "Managed_Azure_(${var.customer_tenant_id})"
  location = "UK South"
}

resource "azurerm_key_vault" "customer_tenant_key_vault" {
  name                        = "key_vault_${substr(var.customer_tenant_id, 0, 8 )}"
  location                    = azurerm_resource_group.customer_tenant_rg.location
  resource_group_name         = azurerm_resource_group.customer_tenant_rg.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

}

resource "azuread_application" "deployment_app" {
  display_name     = "Softcat Managed Azure - (${var.customer_tenant_id})"
  logo_image       = filebase64("Softcat_Logo.png")
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = "AzureADMultipleOrgs"

   required_resource_access {
     resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

     resource_access {
       id   = "df021288-bdef-4463-88db-98f22de89214" # User.Read.All
       type = "Role"
     }
   }

   web {
    #  homepage_url  = "https://app.example.net"
    #  logout_url    = "https://app.example.net/logout"
      redirect_uris = ["https://login.microsoftonline.com/"]

     implicit_grant {
       access_token_issuance_enabled = true
       id_token_issuance_enabled     = true
     }
    }
}

resource "azuread_application_password" "deployment_app_key" {
  application_object_id = azuread_application.deployment_app.object_id
  display_name = "tf_key"
  }

