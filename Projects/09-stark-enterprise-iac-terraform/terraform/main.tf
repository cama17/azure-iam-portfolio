# Project 09 - Entra ID as Code (Terraform), Conditional Access + Drift Detection
#
# DISCLAIMER: every resource below was actually deployed against the real
# starkenterpriselab.com tenant with `terraform apply`, not just planned.
# Written with AI assistance, reviewed and understood line by line before
# running, consistent with standard engineering practice of validating any
# code before it touches a real environment.

# Reads back Terraform's own identity (the tf-entra-automation service
# principal): its tenant, client, and object ID. This is a read, not a
# write - it doesn't create anything, it confirms who Terraform is
# authenticating as. Feeds the authenticated_* outputs in outputs.tf.
data "azuread_client_config" "current" {}

# Looks up Tony Stark's real user object by UPN. This is the exact call that
# needed the User.Read.All application permission - without it, this data
# block 403's before anything else runs, since Terraform has no way to
# resolve his object ID for the group membership below.
data "azuread_user" "tony_stark" {
  user_principal_name = var.tony_stark_upn
}

# The pilot security group. Deliberately scoped to one member, Tony Stark,
# not my own Global Admin account - a "require compliant device" policy
# that lands on your own admin account before it's proven safe is a real
# self-lockout risk. Creating this group is what needed
# Group.ReadWrite.All - the weaker Group.Read.All permission can read
# groups but can't create one.
resource "azuread_group" "ca_pilot_device_compliance" {
  display_name     = "CA-Pilot-Device-Compliance"
  security_enabled = true
  description      = "Terraform-managed pilot group for the Require Compliant Device Conditional Access policy"

  members = [
    # References the data lookup above directly - Tony's real object ID is
    # never typed by hand, Terraform resolves it at apply time.
    data.azuread_user.tony_stark.object_id,
  ]
}

# The actual Conditional Access policy. Creating/updating this needed both
# Policy.Read.All and Policy.ReadWrite.ConditionalAccess together -
# Microsoft's own docs flag this as a known issue, since the permission
# name alone doesn't suggest a second read permission is required for
# app-only auth.
resource "azuread_conditional_access_policy" "require_compliant_device" {
  display_name = "Require Compliant Device - CA Pilot Group"

  # This is the one field that was hand-flipped mid-lab. First deployed as
  # "enabledForReportingButNotEnforced" (report-only) and validated against
  # a real sign-in before being changed to "enabled" here, which is what
  # actually caused the real block in THE BREAK. Never enforced blind.
  state = "enabled"

  conditions {
    client_app_types = ["all"]

    applications {
      included_applications = ["All"]
    }

    users {
      # References the group resource above - Terraform infers it has to
      # create the group first, then the policy, without being told the
      # order explicitly.
      included_groups = [azuread_group.ca_pilot_device_compliance.object_id]
    }
  }

  grant_controls {
    # Only one control in the list right now, so operator doesn't change
    # behavior yet - it's the field that would matter if a second grant
    # control (like MFA) were ever added alongside this one.
    operator          = "OR"
    built_in_controls = ["compliantDevice"]
  }
}
