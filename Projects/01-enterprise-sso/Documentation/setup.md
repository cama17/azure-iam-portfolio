# Project 01: Zendesk + Entra ID SAML SSO Setup

This document details how I integrated Zendesk with Microsoft Entra ID using **SAML SSO** and enforced **Conditional Access** requiring MFA. All steps were completed through the **user interface** (Entra portal, Zendesk Admin Center, Microsoft 365 Admin Center).

## 1. Add Zendesk in Entra ID
- Go to **Microsoft Entra admin center** → **Enterprise applications** → **New application**.
- Search for **Zendesk**, select it, and click **Create**.

![Entra app setup](../screenshots/Entra%20-%20Zendesk%20app%20setup.png)

## 2. Configure SAML in Entra
- Open the Zendesk app in Entra.
- Go to **Single sign-on** → select **SAML**.
- Enter the values for your Zendesk subdomain:
  - **Identifier (Entity ID)**
  - **Reply URL**
  - **Sign-on URL**

![Entra SSO Config](../screenshots/Entra-Zendesk%20SSO%20Config.png)

## 3. Configure SAML in Zendesk
- In **Zendesk Admin Center** → **Security** → **Single sign-on** → Add new **SAML** configuration.
- Paste in the **SAML SSO URL**, **Certificate Thumbprint**, and other values provided by Entra.

![Zendesk SSO setup page](../screenshots/Zendesk%20-%20SSO%20setup%20page.png)  
![Zendesk > Entra Configuration](../screenshots/Zendesk%20%3E%20Entra%20Configuration.png)

## 4. Assign Users in Entra
- In the Entra Zendesk app → **Users and groups** → assign test users/agents.

![Entra - Zendesk Users](../screenshots/Entra-Zendesk%20Users.png)

## 4b. Invite Zendesk Agents via Microsoft 365 Admin Center
- Go to **Microsoft 365 Admin Center** → **Users** → **Active users** → **Add a user**.
- Create accounts, assign a license, and add them to the Zendesk group.

![MS Admin Center - Zendesk Users](../screenshots/MS%20Admin%20center%20-%20Zendesk%20Users.png)

## 5. Apply Conditional Access Policy
- In Entra → **Security** → **Conditional Access** → **New Policy**.
- Target: Zendesk enterprise app + Zendesk Agents group.
- Control: Require MFA.

![Entra-Zendesk CA](../screenshots/Entra-Zendesk%20CA.png)  
![MFA Verification](../screenshots/MFA-verification.png)

## 6. Test the SSO
### SP-initiated:
- Navigate to your Zendesk subdomain → redirected to Entra login.
- After authentication, redirected back into Zendesk.

![Zendesk User Login](../screenshots/Zendesk%20User%20Login.png)  
![Zendesk login main dashboard](../screenshots/Zendesk%20login%20in%20main%20dashboard.png)

## 7. Validate with Entra Sign-In Logs
- Go to **Monitoring → Sign-in logs** in Entra.
- Filter for Zendesk → confirm successful sign-ins and MFA enforcement.

![Entra - Zendesk Sign-In logs](../screenshots/Entra%20-%20Zendesk%20Sign-In%20logs.png)

## Lessons Learned
- UI setup is straightforward but values must be carefully matched between Entra and Zendesk.
- **Conditional Access** enables MFA per-application, tightening security without impacting all services.
- Using **Microsoft 365 Admin Center** to onboard test users ensures lifecycle management aligns with IAM best practices.
- Both **SP-initiated** and **IdP-initiated** login flows should be tested for reliability.
