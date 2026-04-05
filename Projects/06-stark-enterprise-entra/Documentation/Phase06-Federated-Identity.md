# Phase 06 - Federated Identity Provider

## Objective
Configure Google as a federated identity provider in Microsoft
Entra ID so external guest users can sign in using their existing
Google account without needing a Microsoft account.

## SC-300 Alignment
- Lab 06: Add a Federated Identity Provider

## Accelerator Alignment
- Week 2: External collaboration settings

## What Was Configured

| Setting | Value |
|---|---|
| Identity Provider | Google |
| Google Project | Stark Enterprise Lab |
| Redirect URI | https://login.microsoftonline.com/te/starkenterpriselab.com/oauth2/authresp |
| Configuration Location | Identity - External Identities - All identity providers |

## How Federation Works

When a guest user with a Gmail address attempts to sign in
to a Stark Enterprise resource:

1. Entra ID detects the Gmail address
2. Entra ID redirects the user to Google for authentication
3. Google verifies the user's credentials
4. Google returns a trusted token to Entra ID
5. Entra ID grants access based on that token

Stark Enterprise never handles or stores the user's Google
password at any point in this flow.

## Why This Matters for Contractor Management

Without federation:
- IT must create Microsoft accounts for every contractor
- IT manages passwords and must disable accounts when contracts end
- Forgotten offboarding creates orphaned accounts and security risk

With Google federation:
- Contractors use credentials they already own
- No new accounts for IT to create or manage
- Access ends naturally when a contractor leaves their organisation
- Stark Enterprise controls resource access - not contractor credentials

## Relevant Users

Logan is the primary contractor in this environment with a
Gmail address. Google federation allows Logan to access Stark
Enterprise guest resources without a Microsoft account.

## Screenshots
- 01-google-oauth-credentials.png
- 02-google-federation-configured.png
- 03-identity-providers-list.png