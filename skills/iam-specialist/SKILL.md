---
name: iam-specialist
description: "Use this skill when you need Identity and Access Management architecture, RBAC (Role-Based Access Control) design, ABAC (Attribute-Based Access Control) policy authoring, RBA (Risk-Based Authentication) implementation, PAM (Privileged Access Management), SSO/federation setup, MFA strategy, fine-grained access control policies, service account governance, lifecycle management automation, or identity governance and administration (IGA) programs."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [iam, rbac, abac, rba, pam, sso, mfa, identity-governance, zero-trust, fine-grained-access, service-accounts, okta, entra, cyberark]
---

# IAM Specialist — Identity & Access Management Expert

## Role

The IAM Specialist designs and implements the full identity and access management ecosystem: authentication, authorization, identity lifecycle, privileged access, and fine-grained access control. This skill ensures the right people have access to the right resources at the right time — and nothing more.

---

## Phase 1 — Identity Architecture

**Identity Architecture Layers:**

```
Layer 1: Identity Providers (IdP)
  - Enterprise: Okta, Microsoft Entra ID, Ping Identity, ForgeRock
  - Social: Google, Apple (consumer apps only; never enterprise resources)
  - Federation: SAML 2.0, OIDC, WS-Federation for cross-domain trust

Layer 2: Directory Services
  - Active Directory / Azure AD: primary enterprise identity store
  - LDAP: legacy system integration
  - HR System (Workday/SAP): authoritative source for identity attributes

Layer 3: Authentication
  - MFA: TOTP, FIDO2/WebAuthn, push notification, hardware tokens
  - Passwordless: FIDO2 passkeys (preferred for modern systems)
  - SSO: single sign-on via OIDC/SAML for all enterprise applications

Layer 4: Authorization
  - RBAC: job function roles, group-based
  - ABAC: policy engine evaluating attributes
  - PAM: privileged just-in-time access
  - Fine-grained: field/row-level, API scope level

Layer 5: Governance & Lifecycle
  - IGA: identity governance and administration platform
  - Access reviews: automated campaigns, manager approval workflows
  - Certifications: quarterly for privileged; semi-annual for standard
  - Entitlement catalog: searchable, self-service request portal
```

---

## Phase 2 — RBAC Design

**Role Design Principles:**

```
1. JOB FUNCTION ALIGNMENT
   - Roles map to job titles or functions (not individuals)
   - One role per job function minimum; no monolithic "all access" roles
   - Role hierarchy: parent roles inherit from child roles (e.g., Manager inherits Analyst)

2. ROLE INVENTORY
   Format for each role:
   Role Name:        [JobFunction]-[System]-[AccessLevel]
   Description:      What this role enables
   Entitlements:     List of specific permissions granted
   Owner:            Business owner responsible for membership
   Risk level:       Low / Medium / High / Critical
   Review frequency: Annual / Semi-annual / Quarterly

3. ROLE MINING
   - Analyze existing access patterns to derive roles from reality
   - Identify outliers (unique access not fitting any role)
   - Remediate outliers: adjust role or create exception with risk acceptance

4. SEGREGATION OF DUTIES (SoD)
   - Define incompatible role pairs (e.g., Create Payment + Approve Payment)
   - SoD matrix maintained in IGA platform
   - Automated SoD conflict detection on access request
   - Conflicts: deny by default; allow only with dual approval + CISO escalation
   - Quarterly SoD violation report to CISO and audit team
```

**Standard enterprise roles framework:**

```
Tier 1 — Standard User Roles (broad, low-risk):
  - Employee-Basic: email, calendar, intranet, standard SaaS tools
  - Employee-Remote: VPN access + Employee-Basic
  - Contractor-Basic: limited to project-specific systems; time-bound

Tier 2 — Function-Specific Roles (medium-risk):
  - Developer-[Team]: code repo, dev/test environment, CI/CD pipeline
  - Analyst-[Department]: BI tools, reporting databases (read-only)
  - Finance-AP: accounts payable system (create/view invoices; no approval)
  - Finance-AP-Approver: approve invoices; no create (SoD with Finance-AP)
  - HR-Recruiter: ATS, job posting tools; no access to comp data
  - HR-Compensation: comp system; separate from HR-Recruiter (SoD)

Tier 3 — Privileged Roles (high-risk, enhanced controls):
  - DevOps-[Environment]: production deployment, infrastructure management
  - DBA-[Environment]: database admin; PAM-vaulted; session recorded
  - Security-Analyst: SIEM read, EDR triage; no production data write
  - Security-Admin: SIEM admin, firewall changes; dual approval required

Tier 4 — Super-Privileged (critical, JIT only):
  - Domain-Admin: Active Directory administration; JIT only; 4h max session
  - Cloud-Admin-[Provider]: root/global admin; break-glass; CISO + peer approval
  - DB-SA: SQL Server SA; dual-person approval; session recorded; JIT only
```

---

## Phase 3 — ABAC Policy Design

**ABAC policy authoring (using OPA/Cedar):**

**Attribute taxonomy:**

```
Subject Attributes:
  user.department      = [Engineering, Finance, HR, Legal, Sales]
  user.jobTitle        = [Junior, Senior, Manager, Director, VP, CISO]
  user.clearanceLevel  = [Public, Internal, Confidential, Restricted, Secret]
  user.mfaVerified     = [true, false]
  user.deviceCompliant = [true, false]
  user.location        = [HQ, Remote, Office-[City], Unknown]
  user.employmentType  = [FTE, Contractor, Vendor, Intern]

Resource Attributes:
  data.classification  = [Public, Internal, Confidential, Restricted, Secret]
  data.owner           = [department name]
  data.regulation      = [PHI, PII, PCI, CUI, Unrestricted]
  system.environment   = [dev, staging, production]
  system.criticality   = [Low, Medium, High, Critical]

Action Attributes:
  action.type          = [read, write, delete, export, admin]
  action.bulk          = [true, false]
  action.time          = [ISO 8601 timestamp]
  action.ipAddress     = [IP / CIDR]

Context Attributes:
  context.riskScore    = [0–100 numeric]
  context.geoCountry   = [ISO 3166 country code]
  context.dayOfWeek    = [Mon–Sun]
  context.hour         = [0–23]
  context.networkZone  = [corporate, vpn, public]
```

**Sample ABAC policies (Cedar policy language):**

```cedar
// Policy: Engineers can read confidential code repos during business hours from corporate network
permit(
  principal in Group::"Engineering",
  action == Action::"read",
  resource in ResourceType::"CodeRepository"
)
when {
  principal.mfaVerified == true &&
  principal.deviceCompliant == true &&
  resource.classification in [Classification::"Internal", Classification::"Confidential"] &&
  context.networkZone in [Zone::"corporate", Zone::"vpn"] &&
  context.hour >= 6 && context.hour <= 22
};

// Policy: Finance can export financial reports only with manager approval attribute
permit(
  principal in Group::"Finance",
  action == Action::"export",
  resource in ResourceType::"FinancialReport"
)
when {
  principal.clearanceLevel >= ClearanceLevel::"Confidential" &&
  principal.mfaVerified == true &&
  context.riskScore < 50 &&
  principal.hasAttribute("manager_approved_export")
};

// Deny: Never allow bulk delete on production databases
forbid(
  principal,
  action == Action::"delete",
  resource in ResourceType::"ProductionDatabase"
)
when {
  action.bulk == true
};
```

---

## Phase 4 — Risk-Based Authentication (RBA)

**Risk scoring model:**

```
Risk Signal                          Weight    High-Risk Threshold
Impossible travel (>500 mph)         +40       Immediate step-up
New device (never seen before)       +20       Step-up required
New country (first access)           +20       Step-up required
TOR exit node / VPN anonymizer       +30       Block or step-up
Time anomaly (2am for user type)     +10       Monitor
Failed MFA attempts (>3)             +25       Account lock (30 min)
High-value transaction               +15       Step-up required
Admin action attempted               +15       Step-up required
Credential in breach database        +50       Force password reset + step-up
UEBA anomaly score elevated          +20       Step-up required
Recent phishing simulation failure   +10       Enhanced monitoring

Risk Score → Action:
0–25:    Allow (standard auth)
26–50:   Step-up MFA (TOTP or push notification)
51–75:   Step-up hardware token or biometric
76–100:  Block + alert SOC + require manual unlock
```

---

## Phase 5 — Privileged Access Management (PAM)

**PAM implementation requirements:**

```
Vault Requirements:
- All privileged credentials (local admin, service accounts, SSH keys, API keys) in vault
- Credentials not viewable in vault UI without checkout request logged
- Auto-rotation: privileged passwords rotated after each checkout; service accounts on schedule (30 days)
- No standing access: JIT provisioning with time limit (4h max for most; 1h for production)

Session Management:
- All privileged sessions recorded (screen recording + keylogging)
- Session recordings retained 90 days minimum; critical systems 365 days
- Jump server / bastion host: single controlled access path to privileged systems
- No direct privileged access from internet; only through PAM gateway

Service Account Governance:
- Complete inventory of all service accounts (name, system, purpose, owner)
- No service accounts with interactive login capabilities (no shell access)
- Service account credentials: vault-managed, not known to humans (auto-injected by CI/CD or PAM)
- Service accounts scoped to minimum required permissions (read-only where possible)
- Quarterly review: confirm all service accounts are still needed and appropriately scoped

Emergency / Break-Glass Access:
- Break-glass accounts: dual-person approval required (two senior security staff)
- Immediate alert to CISO and security team when break-glass used
- Time-limited: 4-hour sessions maximum; must be renewed for extended access
- Full audit log: every action during break-glass session reviewed post-use
- Post-use review: PIR within 24h; credential rotated immediately after use
```

---

## Phase 6 — Identity Lifecycle Management

**Automated lifecycle events:**

```
Joiners (new employee/contractor):
Day -5: Create account in IdP; assign base role from HR job title
Day 0:  Provision all entitled systems; send welcome email with setup guide
Day 1:  Verify provisioning complete; MFA enrollment confirmed
Day 30: Manager review: confirm access is appropriate for role

Movers (role/department change):
HR triggers: role change event → automated role-swap in IdP
Old access: removed within 1 business day of effective date
New access: provisioned on effective date (no access gap)
Review: manager certifies new access within 30 days of change

Leavers (termination):
Immediate on notification: disable account (not delete); revoke SSO sessions
Within 1 hour: revoke VPN access, badge access, cloud access
Within 24 hours: revoke all remaining access; document for audit
Within 30 days: archive mailbox; transfer data ownership; delete account
Contractors: access expires automatically on contract end date; no manual process required

Dormant accounts:
Detection: accounts with no login in 90 days
Action: auto-disable + alert account owner
Reactivation: manager approval required; MFA re-enrollment required
Deletion: after 180 days of inactivity (or per data retention policy)
```

---

## Phase 7 — Fine-Grained Access Controls

**Levels of access granularity:**

```
Level 1 — Application (coarse):
  User has/does not have access to the application
  Example: HRIS system access yes/no

Level 2 — Module (medium):
  User has access to specific modules within application
  Example: HR can see org chart but not compensation module

Level 3 — Record (fine):
  User can access specific records (often row-level security)
  Example: Sales rep can only see their own accounts; manager sees team
  Implementation: RLS in database (PostgreSQL row-level security, SQL Server RLS)

Level 4 — Field (very fine):
  User can see only specific fields within a record
  Example: HR sees employee name/dept; payroll sees + salary; medical team sees + health
  Implementation: Dynamic data masking (SQL Server DDM, field-level encryption + decryption by role)

Level 5 — Action (finest):
  User can perform only specific operations on records they can access
  Example: Analyst can view orders; Supervisor can view + modify; Manager can view + modify + delete
  Implementation: ABAC policy engine; API gateway authorization
```

---

## Non-Negotiable IAM Rules

1. **No shared accounts — ever** — every human and system principal has a unique identity
2. **MFA is mandatory** — no exceptions for any production system access; hardware token for privileged
3. **Least privilege always** — access granted is the minimum required; excess access is a security finding
4. **Lifecycle automation is not optional** — manual provisioning/deprovisioning fails; automate or fail audit
5. **PAM is mandatory for privileged access** — no direct privileged access outside of PAM vault and JIT
6. **Quarterly access reviews are law** — missed review = compliance finding; no extensions without CISO
7. **SoD violations are blocked, not warned** — conflicting access denied at provisioning; no post-hoc remediation
