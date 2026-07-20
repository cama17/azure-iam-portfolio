# 🛡️ Identity & Access Management Portfolio

Hands-on Azure security and identity engineering projects built to 
demonstrate real-world IAM skills for a cybersecurity career in 
cloud identity and access management.

---

## 👤 About
Cybersecurity graduate with hands-on experience in identity and access 
management at Zendesk. Building practical expertise in Microsoft Entra ID, 
Okta, Active Directory, and cloud security engineering through 
enterprise-focused lab projects.

**Targeting:** IAM Security Analyst | Cloud Identity Engineer | IAM Engineer

---

## 🔬 Projects

### 1. Enterprise SSO — Zendesk + Microsoft Entra ID
- **Status:** ✅ Complete
- **Tools:** Microsoft Entra ID · Conditional Access · SAML 2.0 · Microsoft 365 Admin Center · Zendesk
- **Scenario:** Integrated Zendesk with Entra ID as the Identity Provider using SAML 2.0 and enforced MFA via Conditional Access for all agent sign-ins
- [View Project](./Projects/01-enterprise-sso/)

### 2. Okta SSO with Zendesk (SAML 2.0)
- **Status:** ✅ Complete
- **Tools:** Okta · SAML 2.0 · Zendesk
- **Scenario:** Configured SAML 2.0 SSO between Okta as Identity Provider and Zendesk as Service Provider. Covers SP-initiated and IdP-initiated flows, user assignment, and end-to-end verification
- [View Project](./Projects/02-okta-sso/)

### 3. Zendesk SCIM Provisioning with Microsoft Entra ID
- **Status:** ✅ Complete
- **Tools:** Microsoft Entra ID · SCIM 2.0 · Zendesk
- **Scenario:** Automated provisioning and deprovisioning of Zendesk users and groups via Microsoft Entra ID SCIM connector
- [View Project](./Projects/03-zendesk-provisioning/)

### 4. Okta SCIM Provisioning with Zendesk
- **Status:** ✅ Complete
- **Tools:** Okta · SCIM 2.0 · Zendesk · API Token Authentication
- **Scenario:** Automated full identity lifecycle management between Okta and Zendesk including investigation into email identity anchoring and SCIM read-only restrictions
- [View Project](./Projects/04-okta-provisioning/)

### 5. Stark Enterprise Active Directory Lab
- **Status:** ✅ Complete
- **Tools:** Windows Server 2022 · Active Directory Domain Services · DNS · PowerShell
- **Scenario:** Designed and implemented a production-ready on-premises Active Directory environment for a fictional enterprise with 15 users across 6 departments, structured for hybrid Entra ID synchronization
- [View Project](./Projects/05-stark-enterprise-ad/)

### 6. Stark Enterprise Hybrid Identity Lab
- **Status:** In progress 🔄
- **Tools:** Microsoft Entra ID Premium P2 · Entra Connect · PowerShell · Microsoft Graph API
- **Scenario:** Extends the on-premises AD lab into a full hybrid identity environment covering identity management, access control, security policies, and governance workflows
- [View Project](./Projects/06-stark-enterprise-entra/)

### 7. Stark Enterprise Wise Integration
- **Status:** ✅ Complete
- **Tools:** Microsoft Entra ID · Azure Key Vault · Azure Functions (Python, Flex Consumption) · Managed Identity · Azure RBAC · Elastic Cloud · Kibana
- **Scenario:** Built an internal payment gateway wrapping the Wise sandbox API behind an Entra ID App Registration, Key Vault, and a system assigned Managed Identity with zero hardcoded credentials, then diagnosed four deliberately introduced failure scenarios using HTTP response signatures and Kibana platform logs
- [View Project](./Projects/07-stark-enterprise-wise-integration/)

### 8. Stark Enterprise Identity Protection
- **Status:** ✅ Complete
- **Tools:** Microsoft Entra ID P2 (Identity Protection) · Conditional Access · Microsoft Graph PowerShell SDK · Azure Log Analytics (KQL)
- **Scenario:** Built a risk-based Conditional Access policy scoped to a pilot group, triggered a real anonymized-IP risk detection, and investigated and remediated the flagged account through Microsoft Graph PowerShell, tracing why a dismissed risk still produced a second real AADSTS53004 block before finding the fix that actually worked
- [View Project](./Projects/08-stark-enterprise-identity-protection/)

### 9. Entra ID as Code (Terraform), Conditional Access + Drift Detection
- **Status:** ✅ Complete
- **Tools:** Terraform (`hashicorp/azuread` provider) · Microsoft Entra ID P2 · Conditional Access · Microsoft Graph API · Azure Log Analytics (KQL)
- **Scenario:** Managed a real Conditional Access policy and security group as Terraform code instead of portal clicks, validated it in report-only mode against real sign-in log evidence, then proved an out-of-band manual change to the policy gets caught by `terraform plan` and reversed by `terraform apply` instead of silently drifting
- [View Project](./Projects/09-stark-enterprise-iac-terraform/)

---

## 🛠️ Technical Skills

**Identity & Access Management**
- Microsoft Entra ID Configuration & Administration
- Active Directory Architecture & Administration
- Conditional Access Policy Design & Implementation
- Single Sign-On (SSO) — SAML 2.0, Okta, Entra ID
- SCIM 2.0 User Provisioning & Deprovisioning
- Identity Lifecycle Management
- Hybrid Identity (Entra ID Connect)
- Privileged Identity Management (PIM)
- Identity Governance & Access Reviews

**Automation & Scripting**
- PowerShell for Active Directory Administration
- Microsoft Graph API Integration
- Infrastructure as Code (Terraform, `hashicorp/azuread` provider)

**Security Operations**
- Microsoft Sentinel (SIEM) — in progress
- KQL (Kusto Query Language) — in progress
- Conditional Access & Zero Trust Architecture

---

## 📜 Certifications

| Certification | Issuer | Year |
|---|---|---|
| SC-300: Identity and Access Management Associate | Microsoft | In Progress |
| SC-900: Security, Compliance & Identity Fundamentals | Microsoft | 2025 |
| Certified Access Management Specialist (CAMS) | Identity Institute | 2025 |
| AWS Certified Cloud Practitioner | Amazon Web Services | 2025 |

---

## 📫 Contact
- LinkedIn: [Craig McGuinness](https://www.linkedin.com/in/mcguinnesscraig/)
- GitHub: [cama17](https://github.com/cama17)
