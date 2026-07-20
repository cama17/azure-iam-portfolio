# Pins the Terraform version and provider version this configuration was
# actually built and run against. Without this, someone re-running this
# code later could pull a different azuread provider version that changes
# behavior silently - the same reason a lockfile matters for reproducible
# builds.
terraform {
  required_version = ">= 1.15.0"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.0"
    }
  }
}
