# Phase 10 - Conditional Access Strategy Document

## Objective
Document the Conditional Access strategy for Stark Enterprise
in a format suitable for presenting to a security lead.
Validate CA policy enforcement using sign-in log evidence.

## SC-300 Alignment
- Lab 13: Implement and Test a Conditional Access Policy (extension)
- Lab 14: Enable Sign-in and User Risk Policies (extension)

## Accelerator Alignment
- Week 8: Conditional Access Strategy Document

---

# Stark Enterprise - Conditional Access Strategy
## Identity Security Baseline - April 2026

**Prepared by:** Craig McGuinness - IAM Engineer
**Classification:** Internal

---

## Executive Summary

This document defines the Conditional Access strategy for Stark
Enterprise. It covers policies in place, the rationale behind
each decision, and the security outcomes they achieve. This
strategy aligns to Microsoft Zero Trust principles and the
SC-300 Identity and Access Administrator framework.

---

## What is Conditional Access

Conditional Access is the policy engine that controls how users
access Stark Enterprise resources. Every sign-in is evaluated
against conditions before access is granted, denied, or challenged.

Traditional security grants access based on a correct password.
Conditional Access evaluates context - who is signing in, from
where, on what device, what they are accessing, and what risk
level is associated with that sign-in.

---

## Current Policy Baseline

### CA001 - Require MFA for All Users

**What it does:**
Every sign-in to any Stark Enterprise cloud application
requires the user to complete multi-factor authentication.

**Why it exists:**
Passwords alone are insufficient. MFA blocks over 99% of
account compromise attempts even when credentials are stolen.

**Who it applies to:** All users - hybrid and cloud-only.

---

### CA002 - Block Legacy Authentication

**What it does:**
Blocks sign-in attempts using legacy protocols including
Exchange ActiveSync, POP3, IMAP, and SMTP AUTH.

**Why it exists:**
Legacy protocols have no mechanism to support MFA. An attacker
with stolen credentials can use these protocols to bypass MFA
enforcement entirely. Over 99% of password spray attacks use
legacy authentication.

**Business impact:**
Any applications still using legacy protocols will stop working.
A Report-only period should precede enforcement in production to
identify affected applications.

---

### CA003 - Sign-in Risk Policy

**What it does:**
When Identity Protection detects a medium or high risk sign-in,
MFA is required before access is granted.

**Why it exists:**
Risk-based policies respond automatically to threats without
admin intervention. Triggers include impossible travel, leaked
credential detection, and anonymous IP sign-ins.

---

## Policy Enforcement Evidence

Sign-in logs confirmed CA policies are actively enforcing
access controls across both hybrid and cloud-only users.

Confirmed successful authenticated sign-ins with CA Success:
- Tony Stark (hybrid user) - MyApps
- Phil Coulson (hybrid user) - MyApps
- Steve Rogers (cloud-only user) - MyApps

---

## CA Policy Insights - Note

CA Insights and Reporting requires a Log Analytics workspace
connected to Entra ID via Azure Monitor. This will be available
after Phase 17 when Sentinel is configured. Sign-in logs were
used as the primary evidence source for this phase.

---

## Policy Gap - Admin Device Requirement

A policy requiring compliant device for privileged role
activation was identified as a future enhancement. This requires
Microsoft Intune device management to be configured first.

---

## Recommended Next Steps

1. Monitor CA002 in Report-only for 2 weeks in production
   before enforcing to identify legacy auth dependencies
2. Configure Intune and add compliant device requirement
   for admin role activation
3. Review CA policies quarterly based on sign-in log analysis
4. Consider named locations to exclude trusted office IPs
   from MFA requirements

## Screenshots
- 01-ca-enforcement-proof.png
- 02-ca-signin-logs-ca-success.png
- 02-ca-policies-overview.png