# Okta SCIM Provisioning with Zendesk

> **Status:** Completed
> **Environment:** Okta Trial Org + Zendesk Sandbox
> **Date:** March 2026

---

## Objective

Configure automated user provisioning and deprovisioning between Okta and Zendesk using SCIM. With SSO already in place from Project 1A, this project adds full identity lifecycle management so users are automatically created, updated and suspended in Zendesk based on their status in Okta.

---

## Concepts Demonstrated

| Concept | Detail |
|---|---|
| **Protocol** | SCIM (System for Cross-domain Identity Management) |
| **Identity Provider** | Okta |
| **Target Application** | Zendesk |
| **Lifecycle Actions** | Provision, update, deprovision |
| **Authentication Method** | Zendesk API token |
| **Attribute Mapping** | Okta profile to Zendesk user profile |

---

## Why This Matters

Provisioning is what makes IAM practical at scale. Without it, every new hire needs a manual account created in every application they use. Every departure risks leaving active accounts behind. SCIM automates the full joiners, movers and leavers process so access is always in sync with the source of truth in Okta.

---

## Provisioning Features Configured

| Feature | Status | Notes |
|---|---|---|
| Create Users | Enabled | Account created in Zendesk on app assignment |
| Update User Attributes | Enabled | Profile changes in Okta push to Zendesk |
| Deactivate Users | Enabled | Account suspended in Zendesk on unassignment |
| Sync Password | Disabled | SSO is used for authentication, not passwords |

---

## Screenshots

| Step | Screenshot |
|---|---|
| Provisioning tab before configuration | `screenshots/01-provisioning-tab.png` |
| API integration enabled | `screenshots/02-enable-api-integration.png` |
| Zendesk API token created | `screenshots/03-zendesk-api-token.png` |
| API credentials verified in Okta | `screenshots/04-test-api-credentials.png` |
| Provisioning features enabled | `screenshots/05-provisioning-features.png` |
| Attribute mappings | `screenshots/06-attribute-mappings.png` |
| User assigned in Okta | `screenshots/07-assign-user-okta.png` |
| User auto-created in Zendesk | `screenshots/08-user-created-zendesk.png` |
| User unassigned in Okta | `screenshots/09-unassign-user-okta.png` |
| User suspended in Zendesk | `screenshots/10-user-suspended-zendesk.png` |
| Email attribute update test | `screenshots/11-email-change-okta.png` |

---

## Files in This Section

| File | Description |
|---|---|
| `README.md` | This file |
| `WALKTHROUGH.md` | Full step-by-step configuration with screenshots |

---

## References

- [Integrate Zendesk with Okta](https://help.okta.com/oie/en-us/content/topics/provisioning/zendesk/zendesk-integrate.htm)
- [Zendesk Supported Features](https://help.okta.com/oie/en-us/content/topics/provisioning/zendesk/zendesk-supported-features.htm)
- [Zendesk Considerations and Limits](https://help.okta.com/oie/en-us/content/topics/provisioning/zendesk/zendesk-considerations.htm)
