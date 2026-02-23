---
name: infrastructure-security
description: "Use this skill when you need cloud security architecture (AWS/Azure/GCP), on-premises security hardening, IAM strategy (RBAC, ABAC, PAM), network security design, data center security, encryption implementation, database security, SSL/TLS certificate management, or infrastructure security posture assessment. Trigger for infrastructure deployments, cloud migrations, network redesigns, or identity governance programs."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [cloud-security, iam, network-security, encryption, database-security, infrastructure, on-premises, zero-trust]
  sub-skills:
    - iam-specialist
    - network-data-security
---

# Infrastructure Security — VP Infrastructure Security

## Role

VP Infrastructure Security owns the end-to-end security of all technology infrastructure: cloud environments, on-premises data centers, network architecture, identity and access management, data protection, and encryption. This skill applies Zero Trust principles across every layer of the infrastructure stack.

---

## Phase 1 — Infrastructure Security Architecture

### Zero Trust Architecture (ZTA) Principles

```
Never Trust. Always Verify. Assume Breach.

1. Verify explicitly        — authenticate and authorize every request
2. Least privilege access   — just-in-time, just-enough access
3. Assume breach            — minimize blast radius, encrypt all, log all
```

**ZTA implementation pillars:**

| Pillar | Controls |
|---|---|
| Identity | MFA, conditional access, identity governance |
| Device | EDR, device compliance, managed endpoints |
| Network | Micro-segmentation, ZTNA, SD-WAN |
| Application | WAF, API gateway, SAST/DAST |
| Data | Classification, DLP, encryption, RMS |
| Infrastructure | Hardened configs, IaC security scanning |
| Visibility | SIEM, UEBA, full packet capture |

---

## Phase 2 — Cloud Security (AWS / Azure / GCP)

**Delegate detailed implementation to `network-data-security` and `iam-specialist`.**

### Cloud Security Posture Management (CSPM):
- Enable CSPM tool (AWS Security Hub, Microsoft Defender for Cloud, Google SCC)
- CIS Benchmark compliance: enforce CIS Level 1 minimum, Level 2 for production
- Continuous compliance scanning: no critical findings unresolved >48h

### Cloud Account / Landing Zone Security:

| Control | AWS | Azure | GCP |
|---|---|---|---|
| Root/Global Admin | Locked, MFA, no daily use | Emergency access only | Org admin MFA enforced |
| IAM | Roles only, no long-term keys | Managed Identities | Service Accounts, Workload Identity |
| Network | VPC with private subnets | VNet, Private Endpoints | VPC, Private Service Connect |
| Logging | CloudTrail all regions | Azure Monitor, Activity Log | Cloud Audit Logs |
| Encryption | KMS-managed CMKs | Azure Key Vault | Cloud KMS |
| Secrets | AWS Secrets Manager | Azure Key Vault | Secret Manager |
| Container | ECS/EKS with IRSA | AKS with managed identity | GKE with Workload Identity |

### Infrastructure-as-Code (IaC) Security:
- All IaC scanned with checkov/tfsec/Snyk IaC before merge
- No public S3/Blob/GCS buckets except CDN assets (explicit approval)
- No hardcoded credentials in IaC — enforce via pre-commit hooks + SAST

### Cloud Security Architecture Non-Negotiables:
- Separate AWS accounts / Azure subscriptions / GCP projects per environment (dev/stage/prod)
- Centralized logging account/project with immutable log archive
- GuardDuty / Defender / Chronicle threat detection enabled in all regions
- No internet-facing management ports (SSH/RDP) — use SSM Session Manager / Bastion with JIT

---

## Phase 3 — On-Premises Security

### Data Center Physical Security:
- Multi-factor physical access (badge + PIN + biometric for sensitive areas)
- CCTV coverage: 100% of entry/exit, server rooms, wiring closets
- Visitor management: escorted access, logged, badge issued
- Environmental controls: temperature, humidity, fire suppression, UPS
- Asset tagging: all hardware tracked in CMDB
- Secure disposal: NIST 800-88 media sanitization before disposal

### Server Hardening Standards:
```
OS Hardening:
- CIS Benchmark Level 1 applied to all servers
- Remove all unnecessary services and packages
- Disable root login; use sudo with MFA
- Password policy: min 14 chars, complexity, no reuse (last 12)
- Automatic security patches: critical <24h, high <72h, medium <30 days
- Host-based firewall: deny all inbound, whitelist required ports
- File integrity monitoring: AIDE/Tripwire on critical paths
```

### Privileged Access Management (PAM):
- All privileged access through PAM vault (CyberArk/HashiCorp Vault/BeyondTrust)
- No standing privileged access — just-in-time (JIT) provisioning
- Session recording for all privileged sessions
- Credential rotation: automated, minimum 90 days for non-vaulted, 30 days for vaulted
- Break-glass accounts: dual-approval, alerting, time-limited

---

## Phase 4 — IAM Strategy (delegate to `iam-specialist`)

### Access Control Models:

| Model | Use Case | Implementation |
|---|---|---|
| RBAC (Role-Based) | Standard user access | Job function roles, group-based assignment |
| ABAC (Attribute-Based) | Dynamic, context-aware access | Policy engine (OPA, Cedar), attribute tags |
| RBA (Risk-Based Access) | Adaptive authentication | Risk scoring engine, step-up auth triggers |
| PBAC (Policy-Based) | Fine-grained API/data access | OPA, XACML, Cedar policies |

**IAM governance requirements:**
- Access review: quarterly for privileged, semi-annual for standard users
- Automated provisioning/deprovisioning tied to HR system
- Orphan account detection: accounts not used in 90 days → auto-disabled
- Separation of duties: enforced for financial systems, production access, admin roles
- Service accounts: inventory maintained, no interactive login, rotated credentials

---

## Phase 5 — Encryption Standards

### Encryption-at-Rest:
```
Minimum standard: AES-256-GCM
Key management:   HSM-backed KMS (FIPS 140-2 Level 3 minimum)
Key rotation:     Annual minimum; automated where supported
Scope:            All databases, object storage, file systems, backups, laptops
Database:         TDE (Transparent Data Encryption) enabled by default
Laptops:          Full-disk encryption (BitLocker/FileVault) + key escrow
Backups:          Encrypted with separate key from primary data
```

### Encryption-in-Transit:
```
Minimum: TLS 1.2; TLS 1.3 preferred; SSLv3/TLS 1.0/1.1 disabled everywhere
Certificates:     Public CA for external; internal PKI for internal services
Certificate mgmt: Automated renewal (Let's Encrypt/ACME or enterprise CA)
mTLS:             Required for all service-to-service communication in microservices
SSH:              Ed25519 keys minimum; RSA 4096 acceptable; password auth disabled
PGP/S-MIME:       For email encryption of sensitive communications
Secrets in transit: Never in URLs, logs, or headers — use body or vault references
```

### TTL & Token Expiry Standards:
```
Session tokens:         8h max (re-auth required after); 30 min idle timeout
API access tokens:      1h max for user-delegated; 24h for service-to-service
OAuth access tokens:    15 min (short-lived); refresh tokens: 7 days, single-use
JWT TTL:                15 min; never >1h without explicit CISO exception
Password reset tokens:  15 min, single-use
MFA OTP codes:          30 seconds (TOTP); 5-minute window max
Temp credentials (cloud): 1h max; 15 min for high-risk operations
Certificate validity:    1 year max (TLS); 3 years max (internal CA)
```

---

## Phase 6 — Network Security Architecture

**Delegate detailed implementation to `network-data-security`.**

### Network Segmentation:
```
Zone Architecture:
├── Internet DMZ          (public-facing, heavily monitored)
├── Application Zone      (web servers, APIs, load balancers)
├── Data Zone             (databases, data warehouses, message queues)
├── Management Zone       (monitoring, logging, PAM, secrets vault)
├── Development Zone      (isolated from production; no cross-contamination)
└── OT/IoT Zone           (air-gapped or heavily segmented)
```

### Network Security Controls:
- Next-gen firewall (NGFW) with IPS at all zone boundaries
- DNS security: RPZ (Response Policy Zones), DNS-over-HTTPS for clients, DNSSEC
- Email security: SPF + DKIM + DMARC (p=reject) enforced; advanced ATP scanning
- DDoS protection: cloud-based scrubbing (Cloudflare/AWS Shield Advanced)
- Network traffic analysis: East-West traffic monitoring for lateral movement detection
- VLAN segmentation: separate VLANs per zone; inter-VLAN routing through NGFW

### SSL/TLS Certificate Management:
- Centralized certificate inventory (all certs tracked in platform)
- Expiry alerting: 60/30/7 days before expiry → automated renewal trigger
- Certificate transparency monitoring: alert on unauthorized cert issuance
- Wildcard certs: restricted to internal use; justified for external with approval
- PKI governance: root CA offline; intermediate CAs online with HSM

---

## Phase 7 — Database Security

**Enforce across all database platforms (SQL, NoSQL, NewSQL, Data Lakes):**

```
Access Controls:
- Application service accounts: read-only or scoped write; never DBA privileges
- DBA access: PAM-vaulted, session recorded, JIT only
- No shared database credentials between applications
- Row-level security (RLS) for multi-tenant data isolation

Encryption:
- TDE enabled on all databases
- Column-level encryption for PII/PHI fields (SSN, DOB, payment data)
- Encrypted backups with key separation from primary

Auditing:
- Database activity monitoring (DAM): log all DML/DDL on sensitive tables
- Failed login attempts: alert after 5 consecutive failures
- Privileged query logging: all SELECT on sensitive tables logged with user + timestamp
- Data export logging: bulk exports require approval and are logged

Patching:
- Critical CVEs: patch within 72h or implement compensating control
- High CVEs: patch within 30 days
- Version management: no EOL database versions in production
```

---

## Non-Negotiable Infrastructure Security Rules

1. **No unencrypted data at rest or in transit** — zero tolerance; any exception requires CISO sign-off
2. **No direct internet access to management interfaces** — all admin access via Zero Trust gateway or PAM
3. **No long-lived credentials** — service accounts rotated; human access via SSO; API keys rotated
4. **IaC is the source of truth** — no manual console changes in production; all changes via pipeline
5. **All cloud accounts monitored** — threat detection enabled from day one, not retrofitted
6. **No public cloud storage without explicit approval** — S3/Blob ACLs reviewed every 30 days
7. **Backup and recovery tested** — full restore drill quarterly; backup encryption verified monthly
