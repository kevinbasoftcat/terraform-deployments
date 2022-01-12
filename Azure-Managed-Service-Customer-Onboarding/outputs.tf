output "application_id" {
    description = "The applicaiton (client) ID of the appr egistration that was created"
    value       = azuread_application.id
}

output "application_url" {
    description = "The URL that can be provided to customers to accept the app registration into their tenant"
    value = "https://login.microsoftonline.com/organizations/v2.0/adminconsent?client_id=${output.azuread_application.value}&scope=https://graph.microsoft.com/.default"
}
