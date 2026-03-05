# 1A — Okta SSO with Zendesk (SAML 2.0)

> **Status:** ✅ Completed & Tested  
> **Environment:** Trial Okta Org + Zendesk Sandbox

---

## Objective

Configure SAML 2.0 Single Sign-On between **Okta** (acting as the Identity Provider) and **Zendesk** (acting as the Service Provider) for internal agent/staff authentication.

This demonstrates the ability to integrate a cloud Identity Provider with a SaaS application using industry-standard federated authentication.

---

## Concepts Demonstrated

| Concept | Detail |
|---|---|
| **Protocol** | SAML 2.0 |
| **Identity Provider (IdP)** | Okta |
| **Service Provider (SP)** | Zendesk |
| **Auth Flow** | SP-Initiated & IdP-Initiated SSO |
| **User Scope** | Internal agents/staff only |
| **Credential Management** | Centralised in Okta - no local Zendesk passwords |

---

## Why This Matters for IAM Roles

- SSO eliminates credential sprawl — one identity controls access to many applications
- SAML 2.0 is the enterprise standard for federated identity across SaaS platforms
- Okta is one of the most widely deployed IdPs in enterprise environments
- Zendesk is a realistic enterprise SaaS target used by support and ops teams globally

---

## Key Screenshots

| Step | Screenshot |
|---|---|
| Okta — Zendesk app overview | `screenshots/01-okta-app-catalog.png` |
| SAML 2.0 selected as sign-on method | `screenshots/02-saml-signin-method.png` |
| SAML metadata retrieved from Okta | `screenshots/03-okta-metadata.png` |
| Zendesk SSO navigation | `screenshots/04-zendesk-sso-nav.png` |
| Zendesk SAML configuration | `screenshots/05-zendesk-sso-config.png` |
| SSO enabled in Zendesk | `screenshots/06-sso-enabled.png` |
| Users assigned in Okta | `screenshots/07-user-assigned.png` |
| SP-initiated login — Okta redirect | `screenshots/08-sp-initiated-login.png` |
| SP-initiated login — Zendesk dashboard | `screenshots/09-idp-initiated-login.png` |
| Okta end user dashboard — Zendesk tile | `screenshots/10-okta-dashboard-tile.png` |
| IdP-initiated login — Zendesk dashboard | `screenshots/11-idp-initiated-success.png` |

---

## Files in This Section

| File | Description |
|---|---|
| `README.md` | This file - overview and key concepts |
| `WALKTHROUGH.md` | Full step-by-step configuration with screenshots |

---

## Environment

- **Okta Org:** `trial-1192088.okta.com`
- **Zendesk Subdomain:** `z3nlotrtest.zendesk.com`
- **Date Configured:** February 2026