# Declares the inputs this configuration needs without hardcoding any real
# values into version-controlled code. The actual values live in
# terraform.tfvars, which is gitignored and never committed - this file is
# only the contract, not the secret itself.

variable "tenant_id" {
  description = "Entra ID tenant ID for starkenterpriselab.com"
  type        = string
}

variable "client_id" {
  description = "Application (client) ID of the tf-entra-automation app registration"
  type        = string
}

variable "client_secret" {
  description = "Client secret for the tf-entra-automation app registration"
  type        = string
  # Tells Terraform to mask this value in plan/apply output on screen, so
  # it isn't echoed in plain text even in a local terminal.
  sensitive = true
}

variable "tony_stark_upn" {
  description = "UPN of the Tony Stark lab user, used to look up their object ID for pilot group membership"
  type        = string
  # Falls back to this value if never overridden - the only variable here
  # with a default, since the other three are tenant-specific secrets that
  # should never have a hardcoded fallback.
  default = "tony.stark@starkenterpriselab.com"
}
