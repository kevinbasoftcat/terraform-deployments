output "application_id" {
    description = "The applicaiton (client) ID of the appr egistration that was created"
    value       = azuread_application.deployment_app.application_id
}

output "application_url" {
    description = "The URL that can be provided to customers to accept the app registration into their tenant"
    value = "https://login.microsoftonline.com/organizations/v2.0/adminconsent?client_id=${azuread_application.deployment_app.application_id}&scope=https://graph.microsoft.com/.default"
}

output "application_key_id" {
    description = "The appication key ID"
    value = azuread_application_password.deployment_app_key.key_id
}

output "application_key_secret" {
    description = "The application key secret"
    value = azuread_application_password.deployment_app_key.value
    sensitive = true
}

output "keyvault_name" {
    description = "Name of the keyvault created for the customer"
    value = azurerm_key_vault.customer_tenant_key_vault.name
}