# Resources and References

## Microsoft Learn documentation used
- [azuread_conditional_access_policy (Terraform Registry)](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/conditional_access_policy): confirms `enabledForReportingButNotEnforced` as the real report-only state value, and the `compliantDevice` built-in grant control
- [azuread_group (Terraform Registry)](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group): schema for the pilot security group resource
- [Conditional Access: Require compliant device](https://learn.microsoft.com/entra/identity/conditional-access/concept-conditional-access-grant): what the compliant-device grant control actually checks, an MDM-reported flag, not join or registration state

## Scripting disclaimer
The Terraform in [`terraform/`](./terraform/) reflects resources that were
actually deployed against the real tenant during this lab, with
`terraform init`, `plan`, and `apply` all run for real, not just planned.
Written with AI assistance, reviewed and understood line by line before
running, consistent with standard engineering practice of validating any
code before it touches a real environment. The detailed line-by-line
comments in each `.tf` file exist for transparency into how this was
built. They are denser than production code would typically carry.

## Still open
- The 530001 browser/WAM error's relationship to device compliance is not
  fully resolved from a tenant-admin perspective. Whether that error can
  ever be made to reference compliance directly is untested.
- No break-glass or emergency-access exclusion was defined for this
  specific policy.
- Remote state, CI/CD-triggered plan and apply, and secrets stored in a
  vault instead of a local `.tfvars` file are named as a known limitation,
  not built or tested here.
