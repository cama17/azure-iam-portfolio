# Setup: Entra ID as Code (Terraform), Conditional Access + Drift Detection

## Prerequisites
- Microsoft Entra ID P2 (required for Conditional Access)
- Terraform installed locally
- A test account to scope the pilot policy to, separate from any admin
  account, so a "require compliant device" policy cannot self-lock the
  person running it

## 1. Register the automation identity
App registrations, New registration, `tf-entra-automation`.

![App registration overview](./screenshots/12-app-registration-overview.png)

Generated a client secret under Certificates & secrets.

![Client secret created](./screenshots/13-client-secret-created.png)

## 2. Grant least-privilege Graph permissions
Six Microsoft Graph permissions were granted in total, but not all at
once. Three were added reactively as real 403 errors surfaced during the
first `terraform apply` (full trace in
[scenarios.md](./scenarios.md)). The final set:

| Permission | Type |
|---|---|
| `User.Read` | Delegated |
| `User.Read.All` | Application |
| `Group.Read.All` | Application |
| `Group.ReadWrite.All` | Application |
| `Policy.Read.All` | Application |
| `Policy.ReadWrite.ConditionalAccess` | Application |

![Final six permissions granted, admin consent confirmed](./screenshots/01-final-api-permissions-granted.png)

## 3. Initialize Terraform
```
terraform init
```

![Terraform initialized successfully](./screenshots/14-terraform-init-success.png)

## 4. Fix a real credential mixup before the real build
The first `terraform plan` failed on `AADSTS7000215`. The app
registration's client secret Secret ID had been pasted into
`terraform.tfvars` instead of the secret's Value. Re-copying the Value
column fixed it. Full detail in [scenarios.md](./scenarios.md).

![terraform plan succeeded after the secret fix](./screenshots/15-terraform-plan-success-after-secret-fix.png)

## 5. Deploy in report-only mode first
`main.tf` defines a security group, `CA-Pilot-Device-Compliance`, scoped
to one member (Tony Stark), and a Conditional Access policy requiring a
compliant device, scoped only to that group. It was first deployed with
`state = "enabledForReportingButNotEnforced"`, never enforced blind.

```
terraform apply
```

![terraform apply, report-only creation plan](./screenshots/02-terraform-apply-plan-reportonly.png)
![terraform apply, report-only creation succeeded](./screenshots/03-terraform-apply-create-success.png)
![CA-Pilot-Device-Compliance group membership](./screenshots/04-ca-pilot-group-membership.png)
![Policy details confirming report-only state](./screenshots/05-policy-report-only-state.png)

## 6. Validate against a real sign-in
Signed in as Tony Stark from an unmanaged macOS device. The sign-in log's
report-only tab confirmed the policy correctly evaluated his device as
non-compliant, without blocking him. This is proof the policy behaves
correctly before it can affect anyone.

![Report-only tab, correct evaluation without blocking](./screenshots/06-signin-log-report-only-failure.png)

## 7. Flip to enforced
Changed one field in `main.tf`, `state = "enabled"`, and reapplied. This is
where the real break happened, full detail including two distinct real
errors is in [scenarios.md](./scenarios.md).

## 8. Simulate drift and let Terraform catch it
Manually disabled the Conditional Access policy in the portal, simulating
an unauthorized out-of-band change.

```
terraform plan
```

![terraform plan detecting manual drift](./screenshots/09-terraform-plan-drift-detected.png)

```
terraform apply
```

![terraform apply restoring the policy](./screenshots/10-terraform-apply-restore-confirmed.png)

Restore confirmed directly from Terraform's own live read against the
Graph API (`ca_policy_state = "enabled"` in the apply output), not a
portal screenshot.

Full investigation and the actual break are in
[scenarios.md](./scenarios.md). The runnable code is in
[`terraform/`](./terraform/) and the detection query is in
[`scripts/Detection.kql`](./scripts/Detection.kql).
