# Values Terraform prints back after apply finishes. ca_policy_state is
# the one that mattered most in this lab: after the drift-restore apply,
# it printed "enabled", confirmed straight from Terraform's live read of
# the real policy object over Microsoft Graph, not a portal screenshot
# that could be stale or cached.

output "authenticated_tenant_id" {
  value = data.azuread_client_config.current.tenant_id
}

output "authenticated_client_id" {
  value = data.azuread_client_config.current.client_id
}

output "authenticated_object_id" {
  value = data.azuread_client_config.current.object_id
}

output "ca_pilot_group_object_id" {
  value = azuread_group.ca_pilot_device_compliance.object_id
}

output "ca_policy_state" {
  value = azuread_conditional_access_policy.require_compliant_device.state
}
