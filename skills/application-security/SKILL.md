---
name: application-security
description: "Use this skill when you need application security program design, secure SDLC implementation, SAST/DAST/SCA toolchain setup, OWASP Top 10 remediation, API security, penetration testing coordination, vulnerability management, bug bounty program management, security code review standards, or web application firewall configuration. Trigger for secure development practices, release security gates, or vulnerability remediation programs."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [appsec, sast, dast, owasp, pen-test, vulnerability-management, secure-sdlc, api-security, code-review]
  sub-skills:
    - penetration-tester
---

# Application Security — VP Application Security

## Role

VP Application Security owns the end-to-end security of all software applications: from secure design through development, testing, deployment, and runtime defense. This skill integrates security into every phase of the SDLC and coordinates the vulnerability management and penetration testing programs.

---

## Phase 1 — Secure SDLC Integration

### Security Gates by SDLC Phase:

```
Requirements  → Threat modeling; security user stories; compliance requirements
Design        → Architecture review; data flow diagram; trust boundary analysis
Development   → IDE security plugins; pre-commit hooks; secrets detection
Build/CI      → SAST (code); SCA (dependencies); IaC scan; container scan
Test          → DAST (running app); API fuzzing; integration security tests
Staging       → Pen test (quarterly+); DAST full scan; security regression suite
Production    → WAF; RASP; runtime monitoring; patch management
Post-Release  → Vulnerability triage; bug bounty; CVE monitoring; patch cadence
```

### Threat Modeling (mandatory for all new features):

**STRIDE methodology:**
| Threat | Description | Mitigation |
|---|---|---|
| Spoofing | Identity impersonation | Authentication, MFA, certificate pinning |
| Tampering | Data modification | Integrity checks, digital signatures, HMAC |
| Repudiation | Deny actions | Audit logging, non-repudiation controls |
| Information Disclosure | Unauthorized data access | Encryption, least privilege, DLP |
| Denial of Service | Resource exhaustion | Rate limiting, WAF, DDoS protection |
| Elevation of Privilege | Unauthorized access escalation | RBAC, authorization checks, input validation |

**Threat model minimum requirements:**
- Data flow diagram with trust boundaries
- All external inputs identified and threat-cataloged
- Top 5 risks per feature with mitigations
- Security stories added to sprint backlog

---

## Phase 2 — Toolchain Standards

### SAST (Static Application Security Testing):
```
Languages → Tools:
Python:     Bandit + Semgrep + SonarQube
Java:       SpotBugs + Checkmarx + Semgrep
JavaScript: ESLint-security + Semgrep + SonarQube
Go:         gosec + Semgrep
Ruby:       Brakeman + Semgrep
C/C++:      Coverity + Flawfinder + Semgrep
IaC:        Checkov + tfsec + Snyk IaC

Thresholds (block merge on):
- Critical severity: 0 tolerance (block)
- High severity: 0 new findings (block)
- Medium: tracked, must close within sprint
- Low: backlog with 30-day SLA
```

### SCA (Software Composition Analysis):
```
Tools: Snyk Open Source, OWASP Dependency-Check, GitHub Dependabot
Scope: All direct and transitive dependencies
Policy:
- Critical CVE in dependency → block merge, immediate remediation
- High CVE → remediate within 7 days or apply compensating control
- SBOM (Software Bill of Materials) generated for every release
- License compliance: GPL/AGPL flagged; legal review required
- No dependencies with EOL/unmaintained status in production
```

### DAST (Dynamic Application Security Testing):
```
Tools: OWASP ZAP, Burp Suite Enterprise, Nuclei
Frequency:
- Every PR (baseline scan, fast mode): <10 min
- Nightly (full authenticated scan): complete coverage
- Pre-release (full + authenticated + API): mandatory gate
- Quarterly (manual + automated): coordinated with pen-tester
```

### Container Security:
```
Image scanning: Trivy, Grype, Snyk Container
Policy:
- No base images with critical CVEs (scan at build + runtime)
- Minimal base images (distroless preferred)
- Non-root user in all containers
- Read-only filesystem where possible
- No privileged containers in production (exception requires CISO)
- Image signing: Cosign/Notary for supply chain integrity
- SBOM attached to every image
```

---

## Phase 3 — OWASP Top 10 Controls

**Mandatory controls for every application:**

| OWASP Risk | Control |
|---|---|
| A01: Broken Access Control | RBAC/ABAC enforced; server-side authorization checks; directory traversal prevention |
| A02: Cryptographic Failures | TLS 1.2+ only; AES-256 at rest; no MD5/SHA1; secrets in vault |
| A03: Injection | Parameterized queries; ORM; input validation; output encoding; WAF |
| A04: Insecure Design | Threat modeling; security requirements; fail-safe defaults |
| A05: Security Misconfiguration | Hardened defaults; CSP headers; HSTS; error handling (no stack traces) |
| A06: Vulnerable Components | SCA in pipeline; dependency pinning; SBOM; license compliance |
| A07: Auth Failures | MFA; account lockout; brute-force protection; secure session mgmt |
| A08: Software Integrity Failures | Code signing; dependency pinning; CI/CD pipeline integrity |
| A09: Logging Failures | Centralized logging; security events logged; alerts on anomalies |
| A10: SSRF | URL allowlisting; network egress controls; metadata endpoint blocking |

---

## Phase 4 — API Security

**API security requirements (enforce on all APIs):**

```
Authentication:
- OAuth 2.0 + OIDC for user-delegated access
- API keys for service-to-service (rotated, scoped, stored in vault)
- mTLS for internal service mesh
- No API keys in URLs, logs, or error messages

Authorization:
- Resource-level authorization checks (not just endpoint-level)
- RBAC/ABAC for API endpoints
- Scope-based access tokens (claim validation on every request)
- No "admin=true" patterns; always check permissions server-side

Input Validation:
- Schema validation on all inputs (OpenAPI spec enforced)
- Max payload size enforced (prevent DoS via large payloads)
- Content-type validation; reject unexpected types
- Rate limiting: per-user, per-IP, per-endpoint

API Inventory:
- All APIs documented in API gateway catalog
- Undocumented/shadow APIs identified via traffic analysis
- Deprecated APIs decommissioned within 90 days of replacement
- API versioning policy: support N-1 versions; communicate deprecation 180 days in advance
```

---

## Phase 5 — Vulnerability Management

**Vulnerability lifecycle:**

```
Discovery → Triage → Prioritization → Remediation → Verification → Closure
```

**Prioritization model (CVSS + asset criticality + exploitability):**

| Severity | CVSS Range | Remediation SLA |
|---|---|---|
| Critical | 9.0–10.0 | 24 hours (production); 72h (staging) |
| High | 7.0–8.9 | 7 days |
| Medium | 4.0–6.9 | 30 days |
| Low | 0.1–3.9 | 90 days |
| Informational | N/A | Best effort |

**EPSS (Exploit Prediction Scoring System) integration:**
- CVSS High with EPSS >0.7 → treat as Critical (upgrade SLA)
- CISA KEV (Known Exploited Vulnerabilities) → emergency patch within 24h regardless of CVSS

**Vulnerability tracking requirements:**
- All findings tracked in centralized vulnerability management platform
- Owner assigned within 24h of triage
- Weekly vulnerability burn-down report to CISO
- No vulnerability exceeds SLA without documented risk acceptance (CISO sign-off)

**Delegate pen test execution to `penetration-tester`.**

---

## Phase 6 — Penetration Testing Program

**Pen test types and cadence:**

| Type | Frequency | Scope | Provider |
|---|---|---|---|
| External network | Annual minimum | Internet-facing perimeter | Third-party |
| Web application | Annual + post major release | All production web apps | Third-party or internal |
| API security | Annual + post major release | All public/partner APIs | Third-party or internal |
| Internal network | Annual | Internal segments, AD | Third-party |
| Social engineering | Annual | Phishing, vishing, physical | Third-party |
| Cloud configuration | Semi-annual | Cloud environments | Third-party or CSPM |
| Red team | Bi-annual (mature orgs) | Full kill chain simulation | Specialized third-party |

**Pen test rules of engagement (non-negotiable):**
- Written scope document signed before testing begins
- Emergency contact chain: CISO + security-operations on standby
- No production data exfiltration (use canary tokens, synthetic data)
- Daily status check-in from tester
- All critical findings reported same-day (no waiting for final report)
- Final report within 10 business days of engagement close
- Retest within 30 days of remediation for critical/high findings

---

## Phase 7 — Security Code Review

**Code review security checklist:**

```
Authentication & Authorization:
□ All endpoints have authorization checks
□ No hardcoded credentials or secrets
□ Session management follows security standards
□ Password storage uses bcrypt/Argon2 (no MD5/SHA1)

Input Handling:
□ All inputs validated against allowlist
□ SQL queries use parameterized statements/ORM
□ Output encoded for context (HTML, JS, URL, SQL)
□ File uploads: type validation, size limits, malware scan

Error Handling:
□ No stack traces or internal paths in error responses
□ Generic error messages to users; details logged internally
□ All exceptions caught and logged

Cryptography:
□ No custom cryptography implementations
□ Approved algorithms only (AES-256, RSA-2048+, ECDSA P-256+)
□ Secrets loaded from vault, not config files

Logging:
□ Security events logged (auth, access denied, data export)
□ No PII/secrets in logs
□ Structured logging format for SIEM ingestion
```

---

## Non-Negotiable AppSec Rules

1. **Security is a merge gate** — SAST critical findings block merge; no bypass without CISO sign-off
2. **No secrets in code** — enforced via pre-commit hooks, SAST, and periodic repo scanning
3. **Every release has a security sign-off** — checklist completed and signed by AppSec
4. **SBOM generated for every production release** — supply chain visibility mandatory
5. **All critical vulnerabilities patched within SLA** — no exceptions without risk acceptance
6. **Pen tests are mandatory** — not optional; finding-free is the goal, not the reality
7. **Security training before code commit** — developers must complete secure coding training annually
