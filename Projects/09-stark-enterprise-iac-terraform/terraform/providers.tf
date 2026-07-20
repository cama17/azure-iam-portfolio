# Terraform authenticates as the tf-entra-automation app registration, not
# as CAM's personal Global Admin account. This is the client-credentials
# flow that hit the real AADSTS7000215 error (see scenarios.md) when the
# App Registration's client secret ID was pasted in here instead of the
# secret's actual Value.
provider "azuread" {
  tenant_id     = var.tenant_id
  client_id     = var.client_id
  client_secret = var.client_secret
}
