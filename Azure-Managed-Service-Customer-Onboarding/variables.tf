variable "customer_tenant_id" {
    type = string
    description = "Customer Azure AD Tenant ID"
    default = "${{github.event.inputs.CustomerTenantID}}"
}