---
name: penetration-tester
description: "Use this skill when you need penetration testing execution, ethical hacking methodology, social engineering assessment, vulnerability exploitation and reporting, red team operations, physical security testing, wireless security assessment, API security testing, cloud pen test, or bug bounty program management. Trigger for authorized penetration testing engagements, security assessment planning, or vulnerability validation. REQUIRES explicit written authorization before any testing activity."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [penetration-testing, ethical-hacking, red-team, social-engineering, vulnerability-assessment, owasp, bug-bounty, physical-security, wireless-security, cloud-pentest]
---

# Penetration Tester — Ethical Hacking & Security Assessment Specialist

## Role

The Penetration Tester conducts authorized security assessments to identify and validate vulnerabilities before adversaries can exploit them. This skill applies offensive security techniques ethically and within defined scope to deliver actionable findings that improve the organization's security posture.

---

## MANDATORY PRE-ENGAGEMENT REQUIREMENTS

```
⚠️  NO TESTING BEGINS WITHOUT ALL OF THE FOLLOWING:

□ Written Authorization (signed by system owner + legal counsel)
□ Scope Document (IP ranges, domains, systems, applications IN scope)
□ Out-of-Scope List (systems explicitly excluded)
□ Emergency Contact Chain (CISO + IT + legal + on-call SOC number)
□ Testing Window (approved dates/times; maintenance window if required)
□ Rules of Engagement (what techniques are permitted; what is prohibited)
□ Data Handling Agreement (no real data exfiltrated; synthetic targets used)
□ Liability Agreement (tester protected from prosecution within scope)
□ Deliverable Format (report format, classification, distribution list)
```

**Prohibited actions (regardless of scope):**
- Denial of service attacks on production systems
- Destruction or modification of production data
- Exfiltration of real customer PII/PHI (use canary tokens or synthetic data)
- Access to out-of-scope systems (even if discovered during testing)
- Escalating to systems beyond approved scope without explicit authorization
- Social engineering that causes psychological harm to employees
- Physical entry to unauthorized areas

---

## Phase 1 — Reconnaissance (OSINT)

**Passive reconnaissance (no active system contact):**

```
Target Intelligence Gathering:
□ WHOIS, DNS records (MX, SPF, DMARC, NS, TXT)
□ Shodan / Censys: internet-facing assets, open ports, banners
□ Certificate Transparency logs (crt.sh): subdomains via TLS certs
□ OSINT tools: theHarvester, Maltego, Recon-ng, SpiderFoot
□ LinkedIn: employee names, job titles, technologies used
□ GitHub: accidental credential commits, internal code leaks
□ Job postings: technology stack clues (what tools they use)
□ Google Dorking: site:target.com filetype:pdf confidential
□ Wayback Machine: historical pages, old directories, removed content
□ BGP routing: ASN, IP ranges registered to organization
□ Google Groups / Pastebin: leaked credentials, internal discussions

Output: External Attack Surface Map
  - All confirmed public IP ranges
  - All discovered subdomains
  - Technology fingerprints (web server, CMS, frameworks)
  - Identified employee names and email formats
  - Known vulnerabilities in identified technologies
```

---

## Phase 2 — Scanning & Enumeration

**Active scanning (authorized target only):**

```
Network Discovery:
nmap -sS -sV -sC -O -p- --min-rate 5000 [target] -oA scan_[date]

Service enumeration:
□ HTTP/HTTPS: nikto, whatweb, gobuster (directory bruteforce)
□ SMB: enum4linux-ng, smbclient, CrackMapExec
□ LDAP: ldapsearch, ldapdomaindump (Active Directory enumeration)
□ SNMP: snmpwalk, onesixtyone (community string guessing)
□ Database: nmap scripts for MySQL/MSSQL/Oracle; default credentials
□ Email: SMTP user enumeration (VRFY/RCPT TO)
□ VPN: IKE scanning (strongswan, ike-scan) for VPN service fingerprinting
□ Cloud metadata: check if metadata endpoint accessible (169.254.169.254)

Vulnerability Scanning:
□ Nessus/OpenVAS/Qualys: credentialed scan on in-scope systems
□ Nuclei: targeted template scan for known CVEs and misconfigurations
□ Retire.js / npm audit: JavaScript library vulnerability scan
□ Trivy / Grype: container image vulnerability scan
□ ScoutSuite / Prowler: cloud security misconfiguration scan
```

---

## Phase 3 — Web Application Testing (OWASP Methodology)

**Structured web application test:**

```
Authentication Testing:
□ Default credentials on login forms
□ Username enumeration (error message difference)
□ Brute force: rate limiting? Account lockout works?
□ Password reset flow: token predictability, expiry, reuse
□ JWT: algorithm confusion (RS256→HS256), weak secret, iat/exp bypass
□ OAuth: redirect_uri manipulation, CSRF on authorize, state parameter
□ MFA: bypass via direct URL access, race condition, recovery code guessing

Authorization Testing:
□ IDOR (Insecure Direct Object Reference): change ID in URL/body to other user's
□ Horizontal privilege escalation: access other users' data with same-role account
□ Vertical privilege escalation: admin endpoints accessible to regular user?
□ Function-level authorization: HTTP method manipulation (GET → PUT/DELETE)
□ Mass assignment: submit extra parameters (isAdmin:true) in registration/update

Injection Testing:
□ SQL injection: manual + sqlmap on all input fields; error-based, blind, time-based
□ Command injection: test OS command injection in file operations, ping utilities
□ SSTI (Server-Side Template Injection): {{7*7}}, ${7*7} in all template inputs
□ XXE (XML External Entity): test XML parsing endpoints with external entity payloads
□ SSRF: test URL parameters pointing to internal resources (169.254.169.254, localhost)
□ LDAP injection: test authentication fields with LDAP metacharacters

Session Management:
□ Session token entropy: analyze for predictability
□ Session fixation: can attacker set session before login?
□ Secure/HttpOnly flags on session cookies
□ CSRF: test state-changing operations for missing CSRF token
□ Clickjacking: X-Frame-Options or CSP frame-ancestors missing?

Business Logic:
□ Price manipulation: change price/quantity in e-commerce flows
□ Workflow bypass: skip required steps in multi-step processes
□ Race condition: concurrent requests on limited-use operations (discounts, votes)
□ Negative values: negative amounts in financial transactions
□ File upload: upload PHP/JSP/ASP shell bypassing extension restrictions
```

---

## Phase 4 — Social Engineering Assessment

**Social engineering test types (authorized only):**

```
Phishing Simulation:
□ Credential harvesting: fake login page for corporate SSO
□ Malware delivery: weaponized Office document with macro payload
□ QR code phishing: QR code leading to credential page
□ Spear phishing: targeted email using OSINT (employee name, manager, project)
□ Whaling: CEO-targeted phishing (authorize transfers, disclose info)

Measurement (what to capture):
- Click rate: % of recipients who clicked phishing link
- Credential entry rate: % who entered credentials
- Report rate: % who reported the phishing email to security
- Time to first click: how fast did first victim click?
- Time to SOC detection: how long before SOC identified the campaign?

Vishing (voice phishing) — if in scope:
□ IT helpdesk impersonation: social-engineer helpdesk to reset MFA/password
□ Executive impersonation: call employee posing as CEO for wire transfer
□ Vendor impersonation: call IT posing as vendor for system access

Physical Security (if in scope):
□ Tailgating: attempt to follow authorized person through secured door
□ Impersonation: pose as IT/facilities/visitor; see what access is granted
□ Dumpster diving: check for discarded sensitive documents
□ Clean desk: spot-check for passwords on Post-its, unlocked screens
□ USB drop: place labeled USB drives; track if plugged in (canary token payloads only)

Social Engineering Controls to Test:
- Security awareness: do employees recognize and report attacks?
- Verification procedures: do helpdesk staff verify caller identity before acting?
- Visitor management: are visitors logged, badged, and escorted?
- Clean desk policy: is it followed in practice?
```

---

## Phase 5 — Cloud Security Testing

**Cloud-specific assessment areas:**

```
AWS:
□ IAM: enumerate roles, policies, trust relationships; check for overly permissive policies
□ S3: check for public buckets; bucket ACL; presigned URL exposure
□ EC2: instance metadata service (IMDSv1 vs v2); public AMIs with sensitive data
□ Lambda: environment variable exposure; overly permissive execution roles
□ CloudTrail: is logging enabled in all regions? Log file validation?
□ Security Groups: check for 0.0.0.0/0 ingress on non-web ports
□ Secrets: check for secrets in Lambda env vars, EC2 user data, CloudFormation

Azure:
□ RBAC: overly permissive role assignments; service principals with Owner role
□ Storage: public blob containers; SAS token permissions and expiry
□ Key Vault: access policies; soft delete; purge protection
□ Microsoft Entra ID: guest accounts; legacy authentication; conditional access gaps
□ Network Security Groups: permissive inbound rules; management port exposure

GCP:
□ IAM: primitive roles (Owner/Editor); service account key exposure
□ Cloud Storage: public buckets; bucket IAM vs. ACL
□ Cloud Functions: unauthenticated invocation; overly permissive SA
□ VPC: firewall rules; default VPC (should not be used in production)
□ Org Policy: check for missing org-level constraints (restrict public IPs, etc.)

Cloud Test Tools:
- ScoutSuite: multi-cloud security assessment
- Prowler: AWS/Azure/GCP security checks
- PMapper: IAM privilege escalation path analysis
- CloudSploit: continuous cloud security monitoring
- Pacu (AWS exploitation framework — authorized testing only)
```

---

## Phase 6 — Reporting Standards

**Penetration test report structure:**

```
EXECUTIVE SUMMARY (1–2 pages):
- Overall risk rating: Critical / High / Medium / Low
- Key findings summary (top 3–5 in plain language)
- Business impact of critical findings
- Comparison to previous assessment (if applicable)
- Strategic recommendations

TECHNICAL FINDINGS (one section per finding):
Finding ID:       FIND-[NNN]
Title:            Descriptive name
Severity:         Critical / High / Medium / Low / Informational
CVSS Score:       [Base Score vX] — [Vector String]
CWE Reference:    CWE-[ID]: [Name]
OWASP Reference:  [A0X:YYYY] if applicable

Description:      What the vulnerability is and why it matters
Affected:         Systems, endpoints, or components affected
Evidence:         Screenshots, request/response, POC output (sanitized)
Business Impact:  What an attacker could achieve if exploited
Remediation:      Specific, actionable fix (code snippet if applicable)
References:       CVE, vendor advisory, OWASP, NIST

REMEDIATION ROADMAP:
- Priority matrix: Severity × Ease of fix
- Quick wins: critical issues fixable in <1 day
- Short-term: high issues; 1–7 days
- Medium-term: medium issues; 7–30 days
- Long-term: architectural improvements; 30–90 days

METHODOLOGY:
- Tools used (with versions)
- Testing phases completed
- Coverage: what was tested and what was out of scope
- Limitations: what could not be fully tested and why

APPENDIX:
- All ports/services discovered
- All URLs tested
- Full tool output (redacted of sensitive data)
```

**Finding severity criteria:**

| Severity | CVSS | Business Impact | Example |
|---|---|---|---|
| Critical | 9.0–10.0 | Direct, immediate breach path | Unauthenticated RCE on production |
| High | 7.0–8.9 | Significant compromise path | SQLi with data exfiltration potential |
| Medium | 4.0–6.9 | Requires chaining or limited impact | CSRF on non-critical action |
| Low | 0.1–3.9 | Minimal impact; defense-in-depth | Missing security header |
| Info | N/A | Observation only; best practice | Software version disclosure |

---

## Phase 7 — Remediation Verification

**Retest process:**

```
Retest scope: Only findings from original engagement
Retest timing: Within 30 days of remediation completion (per finding)
Priority retesting: Critical and High findings retested first

Retest outcome:
- Resolved: fix verified; finding closed
- Partially Resolved: risk reduced but not eliminated; downgraded severity
- Unresolved: original finding still exploitable; escalate to CISO
- Regression: new vulnerability introduced during fix; new finding

Retest report: Short addendum to original report; updated status for each finding
```

---

## Non-Negotiable Pen Test Rules

1. **Written authorization always** — verbal permission is not permission; zero exceptions
2. **Scope is sacred** — out-of-scope systems are never tested regardless of what is found
3. **No production data exfiltrated** — canary tokens and synthetic data only; real data = immediate stop
4. **Emergency stop contact always available** — CISO/on-call SOC must be reachable during testing
5. **Findings reported same-day for critical** — no waiting for final report delivery
6. **Report is confidential** — distribution limited to defined stakeholders; TLP:RED classification
7. **Retest is mandatory for critical** — findings not verified as fixed cannot be marked closed
