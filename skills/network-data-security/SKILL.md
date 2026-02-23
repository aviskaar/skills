---
name: network-data-security
description: "Use this skill when you need network security architecture, firewall policy design, IDS/IPS configuration, DNS security, email security (DMARC/DKIM/SPF), SSL/TLS certificate lifecycle management, DDoS protection, data loss prevention (DLP), PII/PHI data protection controls, encryption implementation (at-rest and in-transit), database security hardening, data classification, or information security governance. Trigger for network design reviews, data security programs, or encryption strategy."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [network-security, firewall, ids-ips, ssl-tls, dns-security, email-security, dlp, pii, encryption, database-security, data-classification, information-security]
---

# Network & Data Security — Network and Data Protection Specialist

## Role

The Network & Data Security specialist owns the defense of data in motion and at rest: network architecture, perimeter and internal controls, data classification, encryption, DLP, and information security governance. Every byte of sensitive data must be protected from unauthorized access, interception, and exfiltration.

---

## Phase 1 — Network Security Architecture

### Defense-in-Depth Network Model:

```
Internet
    │
[DDoS Scrubbing / CDN]        ← Cloudflare / AWS Shield Advanced / Akamai
    │
[Edge Firewall / WAF]         ← NGFW + Web Application Firewall
    │
[Internet DMZ]
    │ Web servers, load balancers, public APIs, email gateway
    │
[Internal Firewall]           ← Zone-to-zone inspection, IPS enabled
    │
[Application Zone]            ← App servers, microservices, APIs
    │
[Data Zone]                   ← Databases, data warehouses, queues
    │
[Management Zone]             ← SIEM, monitoring, PAM, secrets vault
    │
[OT/IoT Zone]                 ← Air-gapped or strict one-way data diode
```

### Firewall Policy Standards:

```
Default policy: DENY ALL (permit only explicitly required traffic)

Rule authoring requirements:
- Source: specific IP/subnet or group (never "any" on permit rules for inbound)
- Destination: specific IP/subnet, host, or group
- Service/Port: specific port(s) (never "any" on permit rules for inbound)
- Direction: inbound vs outbound clearly documented
- Justification: business reason in rule comment field
- Owner: team owning the rule; contact for renewal
- Expiry: time-limited rules (contractor access, temp rules) with auto-expiry

Rule review cadence:
- All rules: annual review; confirm still required
- High-risk rules (internet-facing permit): semi-annual
- Unused rules (no traffic 90+ days): flagged for removal
- Orphan rules (no documented owner): removed after 30-day grace period

Prohibited rule patterns:
✗ permit any any (any source to any destination)
✗ permit any to internal subnet (any internet source inbound)
✗ Management ports (22/3389) open from internet
✗ Flat network (no zone segmentation between DMZ and internal)
```

---

## Phase 2 — IDS/IPS Configuration

**Intrusion detection strategy:**

```
Network IDS/IPS placement:
- Internet perimeter: detect/prevent external attacks
- DMZ: detect/prevent attacks on public-facing services
- East-West (internal): detect lateral movement (critical for Zero Trust)
- Cloud VPC: VLAN tap or cloud-native IDS (AWS Network Firewall, Azure IDPS)

Signature management:
- Automatic signature updates: daily minimum
- Custom signatures: develop for internal-specific threats (after threat hunting)
- Tuning: reduce false positives to <5% per rule; excessive FP rules → review
- Testing: validate new signatures in IDS-only mode for 7 days before IPS (active block)

Detection categories to enable (minimum):
- Port scanning and network reconnaissance
- Exploit attempts (CVE-based signatures)
- Brute force attacks (auth failures)
- SQL injection / XSS over network
- C2 communication patterns
- Data exfiltration indicators (large outbound, DNS tunneling)
- Malware communication signatures
- Protocol anomalies (DNS, HTTP, SMB)
```

---

## Phase 3 — DNS Security

**DNS security controls:**

```
DNS Architecture:
- Internal DNS: separate from external DNS; does not respond to internet queries
- External DNS: DNSSEC-signed zones; DNSSEC validation enabled
- DNS-over-HTTPS (DoH) for client queries (prevent DNS eavesdropping)
- RPZ (Response Policy Zones): block known malicious domains at DNS resolver
- DNS monitoring: all queries logged to SIEM; anomaly detection enabled

DNS-based Attack Prevention:
- DNS rebinding: bind DNS resolver to local network; refuse external resolution for internal ranges
- DNS tunneling: monitor query length (>100 chars) + query frequency per source
- Fast-flux domains: reputation feeds integrated into RPZ
- DGA (Domain Generation Algorithm): ML-based detection for beacon-like DNS patterns
- Typosquatting: monitor for domains similar to brand names

DNSSEC Implementation:
- Sign all authoritative zones with DNSSEC (RSA-2048 or ECDSA P-256)
- Key Signing Key (KSK): rotated annually; offline storage
- Zone Signing Key (ZSK): rotated monthly (automated)
- DS record: published in parent zone; chain of trust validated
- Monitoring: alert on DNSSEC validation failure in resolver logs
```

---

## Phase 4 — Email Security

**Email security stack (all three layers required):**

```
Layer 1 — Sending Authentication (SPF / DKIM / DMARC):

SPF Record:
v=spf1 include:_spf.google.com include:_spf.salesforce.com ip4:[authorized-IPs] -all
(hard fail -all; reject any sender not in SPF record)

DKIM:
- 2048-bit RSA key (minimum); Ed25519 preferred
- Key rotation: annual; old key retained for 30 days post-rotation for validation
- All outbound mail signed; verify inbound DKIM on receipt

DMARC:
- Policy progression: p=none (monitoring) → p=quarantine → p=reject (enforce within 90 days)
- Target: p=reject on all domains (including subdomains: sp=reject)
- RUA/RUF reports: configured and monitored daily
- DMARC record: v=DMARC1; p=reject; rua=mailto:dmarc@[domain]; ruf=mailto:dmarc-forensic@[domain]; sp=reject; adkim=s; aspf=s

Layer 2 — Anti-Spam and Anti-Phishing:
- Email security gateway: Proofpoint/Mimecast/Google/Microsoft Defender for O365
- Sandboxing: all attachments detonated in sandbox before delivery
- URL rewriting: all URLs rewritten and scanned at click-time
- Impersonation protection: executive name spoofing; lookalike domain detection
- Attachment types: block .exe, .bat, .cmd, .vbs, .js, .ps1, .msi by default

Layer 3 — User-Level Controls:
- External email banner: all external emails labeled [EXTERNAL]
- Report phishing button: one-click reporting; auto-intake to SOC queue
- Quarantine: suspicious email held for review (not delivered; not deleted)
- Mail flow monitoring: alerts on mass email send, unusual recipients, large attachments outbound
```

---

## Phase 5 — SSL/TLS Certificate Lifecycle Management

**Certificate inventory and lifecycle:**

```
Certificate Inventory Requirements:
- All certificates cataloged: hostname, CA, expiry, owner, purpose
- Automated discovery: scan for unknown/rogue certificates quarterly
- Certificate types tracked: DV, OV, EV, wildcard, internal CA, code signing
- Responsible team: certificate owner notified of all lifecycle events

Expiry Management:
- Alert at: 90 days, 60 days, 30 days, 14 days, 7 days before expiry
- Auto-renewal: ACME protocol (Let's Encrypt) or CA API for automated renewal
- Manual renewal: triggered 60 days out for internal CA and non-ACME certs
- Emergency: certificate expiry in production = P2 incident; immediate escalation

Certificate Standards:
Minimum:
  TLS: TLS 1.2 with strong ciphers (disable RC4, 3DES, MD5, SHA-1)
  Key size: RSA 2048+ or ECDSA P-256+
  SAN: Subject Alternative Names; no CN-only matching
  HSTS: Strict-Transport-Security: max-age=31536000; includeSubDomains; preload

Preferred:
  TLS: TLS 1.3 (forward secrecy built-in)
  Key: ECDSA P-256 (smaller, faster, equally secure)
  Certificate validity: 90 days (short-lived; auto-renewed)
  CT: Certificate Transparency logging (required for public trust)

Prohibited:
  ✗ Self-signed certificates in production (internal CA = acceptable)
  ✗ Wildcard certificates for high-security applications (use individual certs)
  ✗ SHA-1 signed certificates (deprecated; rejected by browsers)
  ✗ Certificates with validity >1 year for public-facing (398-day limit)
  ✗ Private key stored in version control or config file
```

---

## Phase 6 — Data Loss Prevention (DLP)

**DLP implementation across all channels:**

```
DLP Coverage Matrix:
Channel                 | Tool                    | Policy
------------------------|-------------------------|----------------------------------
Email outbound          | Email gateway DLP        | Block PII/PHI/PCI; quarantine suspicious
Web upload              | Proxy / CASB DLP         | Block upload of classified data
Cloud storage sync      | CASB (Netskope/MCAS)     | Block sensitive file sync to personal
Endpoint (USB/print)    | Endpoint DLP agent       | Block USB; watermark prints
Chat/collaboration      | M365 Purview / DLP API   | Alert on PII in Slack/Teams/email
Database export         | DAM + DLP                | Alert on bulk export; require approval
API responses           | API gateway              | Scan for PII in API responses; mask if found

DLP Policy for PII (GDPR / CCPA minimum):
Detect:
  - SSN pattern: \b\d{3}-\d{2}-\d{4}\b
  - Credit card: Luhn-validated 13-19 digit sequences
  - Email addresses in bulk (>10 in document)
  - Date of birth + name combination
  - Driver's license numbers (per state patterns)
  - Passport numbers
  - Medical record numbers / PHI indicators
  - Financial account numbers

Action on Detection:
  - Internal transfer: audit log + alert SOC if unexpected
  - External email: quarantine + notify sender + require manager approval
  - Web upload: block + user education popup
  - USB: block + alert + log
  - Large bulk export: alert + require justification
```

---

## Phase 7 — Data Classification & Information Security

**Data Classification Framework:**

```
Level 1 — Public:
  Definition: Information approved for public distribution
  Examples: Marketing materials, public documentation, press releases
  Controls: None special; no access control required
  Handling: May be shared freely

Level 2 — Internal:
  Definition: Business information not meant for public but not sensitive
  Examples: Employee directories, internal policies, org charts
  Controls: Authenticated access; do not share externally without approval
  Handling: Standard access controls; no encryption required in transit on internal network

Level 3 — Confidential:
  Definition: Sensitive business information; exposure causes competitive harm
  Examples: Customer lists, financial forecasts, M&A info, source code, vendor contracts
  Controls: Role-based access; encryption at rest and in transit; DLP enabled
  Handling: Need-to-know; NDA before sharing with third parties; no personal devices

Level 4 — Restricted:
  Definition: Highly sensitive; regulatory data or information whose exposure causes significant harm
  Examples: PII, PHI, PCI data, trade secrets, executive compensation, legal privilege
  Controls: Strict RBAC; encryption mandatory; MFA for access; DLP with block; audit all access
  Handling: Minimum necessary; never on personal devices; third-party sharing requires legal review

Level 5 — Secret:
  Definition: Information whose exposure causes catastrophic harm (reserved for defense/regulated)
  Examples: Encryption keys, HSM credentials, nation-state classified (ITAR/CMMC Level 3)
  Controls: Physical controls; dedicated systems; dual-person access; FIPS 140-2 Level 3 HSM
  Handling: Paper-based or air-gapped systems only; no email; strict chain-of-custody
```

**Data handling requirements by classification:**

```
Classification | Encryption at Rest | Encryption in Transit | DLP | Audit Logging | Retention
Public         | Optional           | Optional              | No  | Optional      | Per policy
Internal       | Optional           | TLS 1.2+              | No  | Optional      | Per policy
Confidential   | AES-256            | TLS 1.2+              | Yes | Yes           | 3–7 years
Restricted     | AES-256 + KMS      | TLS 1.3               | Yes | Yes (all)     | 7 years min
Secret         | FIPS 140-3 HSM     | mTLS + TLS 1.3        | Yes | Yes (all)     | Permanent
```

---

## Phase 8 — DDoS Protection

**DDoS defense layers:**

```
Layer 1 — Upstream scrubbing (cloud-based):
  - Provider: Cloudflare Magic Transit / AWS Shield Advanced / Akamai Prolexic
  - Capacity: ≥1 Tbps mitigation capacity
  - Detection: <5 second automated detection; <60 second mitigation
  - Anycast routing: traffic routed to nearest scrubbing center

Layer 2 — CDN / Edge:
  - Static assets served from CDN (reduce origin load)
  - Rate limiting at CDN edge: per-IP, per-user, per-endpoint
  - Bot management: distinguish legitimate users from bots; challenge suspicious

Layer 3 — Application layer (L7) protection:
  - WAF with DDoS rules: HTTP flood, slow POST, Slowloris detection
  - Rate limiting: per-API endpoint (not just global)
  - CAPTCHA: escalating challenges under load
  - IP reputation: auto-block known DDoS infrastructure

DDoS Response Runbook:
1. Detection: CDN/WAF alert fires → SOC notified within 5 minutes
2. Assessment: confirm DDoS vs. traffic spike (legitimate viral event?)
3. Mitigation: activate enhanced filtering at CDN; notify upstream scrubbing provider
4. Communication: internal status page updated; customer communication if >5min impact
5. Recovery: confirm clean traffic before scaling down mitigation
6. Post-incident: traffic analysis; update rate limits; WAF rule improvements
```

---

## Non-Negotiable Network & Data Security Rules

1. **Default deny** — all firewall rules start from deny; only explicitly permitted traffic flows
2. **No cleartext sensitive data** — PII, PHI, PCI data never transmitted or stored unencrypted
3. **DMARC p=reject enforced** — no email domain sends unauthenticated mail
4. **Certificate expiry = incident** — expired TLS cert in production triggers immediate P2 response
5. **DLP is always on** — no gaps in DLP coverage for any channel handling classified data
6. **Network segmentation is mandatory** — flat networks are a security failure; zones enforced
7. **Firewall rules reviewed annually** — unused rules removed; undocumented rules removed
