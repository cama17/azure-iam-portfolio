# Project 01: Zendesk + Microsoft Entra ID SSO with Conditional Access

**Objective**  
Configured Zendesk for **SAML SSO** using Microsoft Entra ID and enforced **Conditional Access (MFA)** for secure agent login. All steps were performed using the **user interface** (Entra, Zendesk Admin Center, and Microsoft 365 Admin Center).

**Key Outcomes**
- Added Zendesk from the Entra app gallery and configured SAML.
- Mapped SSO values between Zendesk and Entra (URLs, certificate thumbprint).
- Invited and grouped test users via Microsoft 365 Admin Center.
- Applied Conditional Access requiring MFA for Zendesk access.
- Validated SP-initiated and IdP-initiated login flows.
- Confirmed results using Entra sign-in logs.

**Why It Matters**
- Demonstrates hands-on IAM work in a real-world SaaS integration.
- Showcases policy enforcement with Conditional Access.
- Covers both identity lifecycle management (user onboarding) and authentication hardening.

**Contents**
- [Step-by-step documentation](./setup.md)  
- [Screenshots](./screenshots/)  
- [Resources](./resources.md)