---
name: incident-responder
description: "Use this skill when you need incident response execution, breach containment, forensic investigation, regulatory breach notification, root cause analysis, post-incident review, change management integration, problem management, or tabletop exercise design. Trigger for active security incidents, suspected breaches, ransomware events, insider threat investigations, or post-incident improvement programs."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [incident-response, breach-notification, forensics, containment, post-mortem, change-management, problem-management, ransomware, insider-threat]
---

# Incident Responder — Incident Response & Change/Problem Management Specialist

## Role

The Incident Responder executes the full incident response lifecycle from detection to post-incident improvement, integrates with change and problem management disciplines, and ensures regulatory notification obligations are met. This skill treats every incident as an opportunity to improve detection, response, and resilience.

---

## Phase 1 — Incident Triage & Classification

**Immediate triage checklist (execute within 15 minutes of alert):**

```
□ Confirm alert is not a false positive (basic sanity check)
□ Identify affected systems, users, and data types
□ Classify severity (P1/P2/P3/P4 — see table below)
□ Assign incident commander (IC) for P1/P2
□ Open incident ticket with timeline started
□ Notify required stakeholders per severity
□ Begin evidence preservation (do NOT remediate before preserving)
```

**Severity matrix:**

| Severity | Indicators | Stakeholder Notification | SLA |
|---|---|---|---|
| P1 — Critical | Active breach, ransomware, data exfiltration, nation-state IOC | CISO + CEO + Legal + Board (if breach) within 1h | Contain within 4h |
| P2 — High | Confirmed compromise (no exfil confirmed), insider threat, persistent malware | CISO + Legal within 2h | Contain within 8h |
| P3 — Medium | Suspicious activity, isolated malware, policy violation | security-operations VP within 4h | Investigate within 24h |
| P4 — Low | Informational, failed attack, compliance flag | SOC lead within 24h | Close within 72h |

---

## Phase 2 — Containment Playbooks

### Ransomware Response:
```
IMMEDIATE (0–30 minutes):
□ Isolate affected endpoints from network (EDR isolation or VLAN quarantine)
□ Disable compromised accounts
□ Block IOCs at firewall, DNS, email gateway
□ Alert CISO + Legal + executive team
□ Do NOT pay ransom without Legal/executive decision
□ Preserve: memory dumps, running process list, network connections before isolation
□ Engage cyber insurance provider (if applicable)

SHORT-TERM (30 min – 4 hours):
□ Identify patient zero via EDR telemetry and log analysis
□ Determine blast radius: how many systems encrypted?
□ Identify C2 infrastructure (block all C2 IPs/domains)
□ Assess backup integrity (are backups also encrypted? test restore)
□ Engage external IR firm if internal capacity insufficient
□ Begin regulatory notification clock (confirm if PII/PHI affected)

RECOVERY:
□ Restore from known-good backups (verify backup integrity first)
□ Rebuild affected systems from golden images
□ Reset ALL credentials (domain admin, service accounts, user passwords)
□ Re-image endpoints (do not restore encrypted endpoints, rebuild fresh)
□ Monitor for re-infection (threat actor may have persistence elsewhere)
```

### Data Exfiltration Response:
```
□ Identify exfiltration vector (email, web upload, USB, cloud sync)
□ Block ongoing exfiltration at network/DLP layer
□ Preserve evidence: proxy logs, DLP alerts, email headers, file access logs
□ Identify data exfiltrated: type, volume, data subjects affected
□ Regulatory notification assessment:
  - GDPR: notify DPA within 72h if PII of EU residents
  - HIPAA: notify HHS within 60 days; notify individuals within 60 days
  - State breach laws: check by state (CA: 72h for CA residents)
  - SOX: notify audit committee if financial data
□ Engage Legal for privilege protection on investigation
□ Identity-lock affected data subjects' accounts
```

### Insider Threat Response:
```
□ COVERT investigation phase (do not alert subject):
  - Preserve all logs without modifying systems
  - Legal review: ensure investigation scope is lawful
  - HR + Legal involved from start
  - Collect: email, file access, badge records, endpoint activity
□ Determine intent: malicious vs. accidental
□ Scope assessment: what was accessed, modified, or exfiltrated?
□ If malicious:
  - Coordinate termination with HR + Legal
  - Revoke access (coordinated at time of notification)
  - File criminal referral if warranted
  - Preserve evidence chain-of-custody for potential litigation
□ If accidental:
  - Remediate data exposure
  - Security training remediation for individual
  - Policy review for controls that failed
```

---

## Phase 3 — Forensic Investigation Standards

**Evidence collection (chain-of-custody required):**

```
Digital Evidence:
- Memory dumps: use Volatility-compatible tools; document time of acquisition
- Disk images: bit-for-bit copy; hash (SHA-256) before and after
- Log exports: immutable copy; document log source, time range, hash
- Network captures: pcap with timestamp; document collection tool and scope
- Cloud forensics: export audit logs; preserve object storage versioning

Chain of Custody Documentation:
- Who collected: name + role
- When: exact timestamp (UTC)
- From where: system name, IP, physical location
- How: tool used, method, any deviations from standard process
- Hash: SHA-256 of all digital evidence files
- Storage: encrypted, access-controlled, separate from production

Forensic Analysis Order:
1. Volatile data first (memory, running processes, network connections)
2. Disk image (non-volatile)
3. Log analysis (SIEM, endpoint EDR, network, application)
4. Timeline reconstruction (super timeline with Plaso/log2timeline)
5. Attribution (TTPs, tools, infrastructure)
6. Scope finalization (all affected systems identified)
```

---

## Phase 4 — Regulatory Breach Notification

**Notification obligation calculator:**

| Regulation | Trigger | Authority | Individual Notice | Deadline |
|---|---|---|---|---|
| GDPR | PII of EU residents at risk | Lead DPA | If high risk to individuals | 72h to DPA; without undue delay to individuals |
| HIPAA | PHI of ≥500 individuals (or any PHI) | HHS OCR | Yes | 60 days post-discovery |
| State breach laws | PII of state residents | State AG | Yes | Varies: CA=72h, NY=30 days, TX=60 days |
| SOX | Financial system breach | SEC / Audit Committee | No | Promptly to audit committee |
| PCI-DSS | Payment card data | Card brands + acquirer | Varies | Immediately to acquirer |
| NY DFS 23 NYCRR 500 | Material cybersecurity event | NYDFS | Varies | 72h |
| SEC Rule 10b-5 | Material breach (public company) | SEC | No (public disclosure) | 4 business days (Item 1.05) |

**Notification package contents:**
- Incident description (what happened, when, how discovered)
- Data types affected and approximate number of individuals
- Likely consequences and risks
- Measures taken to address the incident
- Contact point for affected individuals

---

## Phase 5 — Change Management Integration (ITIL)

**Change Management gates for security:**

```
All production changes require:
□ Change Request (CR) submitted with security impact assessment
□ CAB (Change Advisory Board) review for standard changes
□ ECAB (Emergency CAB) for emergency changes (24h max review)
□ Security sign-off for changes to security controls, IAM, network, cloud
□ Rollback plan documented and tested
□ Change freeze windows: during active incident or regulatory audit

Change types:
- Standard: pre-approved, low-risk, repeatable (e.g., patch in maintenance window)
- Normal: full CAB review, planned (e.g., firewall rule change)
- Emergency: ECAB review, expedited (e.g., emergency patch for active exploit)

Security-specific change controls:
- Firewall rule additions: CISO or delegate approval
- IAM privilege changes: access governance team approval
- Encryption key rotation: dual-person approval
- Production database schema changes: DBA + AppSec sign-off
```

---

## Phase 6 — Problem Management (ITIL)

**Problem management for security incidents:**

```
Problem Record created for:
- Any P1 incident
- Any P2 incident that recurs within 90 days
- Systemic patterns (same control failing repeatedly)
- Near-misses with significant potential impact

Problem investigation structure:
1. Problem Statement: what failed and what was the impact?
2. Root Cause Analysis: 5-Whys or Fishbone diagram
   Why did it happen? → Why? → Why? → Why? → Why? (until root cause)
3. Contributing factors: process, technology, people, environment
4. Known Error Record: document workaround while permanent fix is developed
5. Permanent Fix: change request raised, tested, deployed
6. Verification: confirm problem does not recur (monitoring period: 90 days)
7. Problem Closure: review and close; add to lessons-learned library
```

---

## Phase 7 — Post-Incident Review (Blameless)

**Post-incident review (PIR) structure — blameless culture:**

```
PIR conducted for all P1/P2 incidents within 5 business days of closure.

Format:
1. WHAT HAPPENED — factual timeline, no blame
   - Detection: how was the incident detected? (automated vs. manual)
   - Scope: what was affected? (systems, data, users, duration)
   - Actions taken: chronological action log with times
   - Resolution: how was it resolved? what worked/didn't work?

2. ROOT CAUSES (multiple, systemic)
   - Technical: what technical control failed or was absent?
   - Process: what process was missing or not followed?
   - Human: what knowledge or training gap existed?

3. WHAT WENT WELL
   - Detection speed, communication, tooling, team response

4. WHAT TO IMPROVE
   - Specific, actionable improvements with owners and due dates
   - Detection improvements → threat-hunter
   - Control improvements → infrastructure-security or application-security
   - Process improvements → change/problem management
   - Training improvements → security-trainer

5. ACTION ITEMS (SMART — Specific, Measurable, Assignable, Realistic, Time-bound)
   - Format: [Action] | [Owner] | [Due Date] | [Success Criteria]
```

**PIR metrics:**
| Metric | Target |
|---|---|
| PIR completion (P1/P2) | 100% within 5 business days |
| Action items completed on time | >90% |
| Recurrence rate (same incident type within 12 months) | <10% |
| Time to detection improvement (YoY) | Improve MTTD by ≥20% annually |
