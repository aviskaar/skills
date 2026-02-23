---
name: compliance-auditor
description: "Use this skill when you need audit evidence collection, control testing, SOC 2 readiness assessment, NIST CSF gap analysis, ISO 27001 implementation, HIPAA compliance review, SOX IT controls testing, GDPR audit, CCPA compliance assessment, EU AI Act conformity assessment, policy review, third-party vendor risk assessment, or GRC platform management. Trigger for audit preparation, control testing cycles, or regulatory readiness reviews."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [compliance-audit, soc2, nist-csf, iso27001, hipaa, sox, gdpr, ccpa, eu-ai-act, grc, evidence-collection, control-testing]
---

# Compliance Auditor — Regulatory Compliance & Audit Specialist

## Role

The Compliance Auditor executes the operational compliance program: collects evidence, tests controls, identifies gaps, manages remediation tracking, and prepares audit packages for SOC 2, ISO 27001, NIST, HIPAA, SOX, GDPR, CCPA, EU AI Act, and other applicable frameworks.

---

## Phase 1 — Audit Readiness Assessment

**Pre-audit gap assessment process (90 days before audit):**

```
Step 1: Control Inventory
- Export all controls from GRC platform (or spreadsheet if no GRC)
- For each control: owner, frequency, evidence type, last tested date

Step 2: Evidence Currency Check
- Flag all evidence older than 12 months as stale
- Flag all controls never tested as "untested"
- Identify controls with no owner assigned

Step 3: Gap Classification
- Critical gap: control does not exist or has never been implemented
- High gap: control exists but evidence is missing or inadequate
- Medium gap: control exists, evidence exists, but last tested >12 months
- Low gap: administrative/documentation issue

Step 4: Remediation Prioritization
- Critical gaps: remediate within 30 days
- High gaps: remediate within 60 days
- Medium gaps: remediate within 90 days (before audit window)

Step 5: Management Attestation
- Control owners sign off on completeness of evidence
- Exceptions documented with risk acceptance from CISO
```

---

## Phase 2 — SOC 2 Control Testing

**Evidence requirements by Trust Service Criteria:**

### Security (CC) — Common Criteria (All SOC 2 engagements):

| Control Area | Evidence Required | Frequency |
|---|---|---|
| CC6.1 — Logical Access | User access list; provisioning records; quarterly access review results | Quarterly |
| CC6.2 — New user registration | Sample of onboarding tickets showing approval and provisioning | Per event |
| CC6.3 — User modification | Sample of role change requests with approvals | Per event |
| CC6.6 — User deprovisioning | Terminated user list cross-referenced with access revocation within SLA | Per event |
| CC6.7 — Remote access | VPN access logs; MFA enforcement evidence | Continuous |
| CC7.1 — Change detection | FIM alerts; configuration change logs | Continuous |
| CC7.2 — Security events | SIEM alert log; SOC triage records; P1/P2 incident register | Continuous |
| CC8.1 — Change management | Sample of change requests with CAB approvals | Per event |
| CC9.1 — Vendor management | Vendor risk assessment register; critical vendor SOC 2 reports | Annual |

**Testing approach:**
```
Population-based sampling:
- Large population (>100 events): sample 25–40 items
- Medium population (25–100): sample 15–25 items
- Small population (<25): test all items

Testing types:
- Inquiry: interview control owner (document in memo)
- Observation: observe control being performed (screenshot/recording)
- Inspection: review documentation/evidence (retained as audit artifact)
- Re-performance: independently repeat the control and compare results
```

---

## Phase 3 — NIST CSF 2.0 Assessment

**NIST CSF 2.0 Function assessment (self-assessment or third-party):**

```
GOVERN (GV) — Organizational context, risk strategy, supply chain risk:
□ Cybersecurity risk management strategy documented and approved
□ Risk appetite defined and communicated
□ Cybersecurity roles and responsibilities defined
□ Supply chain risk management program operational
□ Policies aligned to NIST CSF controls
Target Tier: Tier 3 (Repeatable) minimum; Tier 4 (Adaptive) for mature orgs

IDENTIFY (ID) — Asset management, risk assessment, improvement:
□ Asset inventory complete and current (hardware, software, data, services)
□ Risk assessment process defined; assessments completed annually
□ Threat intelligence integrated into risk identification
□ Business environment documented (critical functions, dependencies)
Target coverage: ≥90% of in-scope assets identified and classified

PROTECT (PR) — Access control, awareness, data security, platform security:
□ IAM policy implemented and enforced
□ Secure configuration baselines applied (CIS benchmarks)
□ Data protection controls operational (encryption, DLP, backup)
□ Security awareness training completed (all staff, annually)
□ Platform security hardening documented
Target: All controls at Tier 3; critical controls at Tier 4

DETECT (DE) — Continuous monitoring, adverse event analysis:
□ SIEM operational with defined detection rules
□ Alert triage process defined and operational
□ Anomalies investigated within defined SLA
□ Threat hunting program active
Target MTTD: <1 hour for critical alerts

RESPOND (RS) — Incident management, analysis, mitigation, reporting:
□ IR playbooks documented for all P1/P2 scenarios
□ Incident response team trained and exercised annually
□ Communication plan for regulatory notification
□ Post-incident review process operational
Target MTTR: <4 hours for P1

RECOVER (RC) — Incident recovery, communication, improvements:
□ Recovery plans documented (BCP/DR)
□ DR tested quarterly (minimum)
□ Lessons learned incorporated from incidents
□ Recovery SLAs (RTO/RPO) defined and tested
Target: 100% of critical systems with tested recovery plan
```

---

## Phase 4 — ISO 27001:2022 Implementation

**Annex A controls implementation checklist (key controls):**

```
Organizational Controls (5.x):
□ 5.1  Information security policies — Board-approved, published, reviewed annually
□ 5.2  Information security roles — CISO, data owners, ISSO defined
□ 5.9  Inventory of information and assets — Complete CMDB with security attributes
□ 5.10 Acceptable use of information — Policy published; signed by all employees
□ 5.15 Access control — Policy + RBAC/ABAC implemented
□ 5.16 Identity management — SSO + MFA; lifecycle management
□ 5.23 Information security for cloud services — Cloud security policy; SLA with CSP
□ 5.29 Information security during disruption — BCP includes security controls
□ 5.30 ICT readiness for business continuity — DR tested; RTO/RPO defined
□ 5.36 Compliance with policies/standards — Internal audit program

People Controls (6.x):
□ 6.1  Screening — Background checks for all employees (role-appropriate)
□ 6.3  Information security awareness, education and training — Annual mandatory
□ 6.4  Disciplinary process — Defined for security violations
□ 6.5  Responsibilities after termination — Immediate access revocation

Physical Controls (7.x):
□ 7.1  Physical security perimeters — Locked, monitored facilities
□ 7.4  Physical security monitoring — CCTV with retention ≥90 days
□ 7.10 Storage media — Encrypted; secure disposal (NIST 800-88)

Technological Controls (8.x):
□ 8.5  Secure authentication — MFA enforced for privileged access
□ 8.8  Management of technical vulnerabilities — Vulnerability management program
□ 8.9  Configuration management — Hardened baselines; IaC; drift detection
□ 8.12 Data leakage prevention — DLP controls implemented and monitored
□ 8.15 Logging — Centralized logging; 90-day hot retention; 1-year minimum total
□ 8.16 Monitoring activities — SIEM operational; alerts tuned
□ 8.24 Use of cryptography — Policy implemented; AES-256/TLS 1.3 minimum
□ 8.28 Secure coding — Secure SDLC; SAST/DAST in pipeline
□ 8.32 Change management — CAB process; security review gate
```

---

## Phase 5 — HIPAA / HITECH Compliance

**HIPAA compliance checklist:**

```
Administrative Safeguards (§164.308):
□ Security Officer designated (name + contact documented)
□ Risk analysis completed and documented (annual minimum)
□ Risk management plan implemented
□ Workforce security (background checks; access based on role)
□ Information access management (minimum necessary principle)
□ Security awareness training (annual; documented completion)
□ Security incident procedures (IR policy + playbooks)
□ Contingency plan (BCP/DR for PHI systems; tested)
□ Evaluation (annual security assessment)
□ Business Associate Agreements (BAA) with all BAs (current, signed)

Physical Safeguards (§164.310):
□ Facility access controls (physical security; badge access logged)
□ Workstation use policy (screen lock; clean desk)
□ Workstation security (encryption; EDR; screen privacy filters)
□ Device and media controls (encrypted devices; NIST 800-88 disposal)

Technical Safeguards (§164.312):
□ Unique user identification (no shared accounts)
□ Automatic logoff (15-minute idle session timeout)
□ Encryption (PHI encrypted at rest AES-256 and in transit TLS 1.2+)
□ Audit controls (logging all access to PHI systems)
□ Integrity controls (checksums; digital signatures for PHI transmission)
□ Person or entity authentication (MFA for all PHI system access)
□ Transmission security (TLS 1.2+ for all PHI in transit)

Breach Notification Rule:
□ Breach assessment process defined (risk of harm to individuals)
□ Notification timeline: HHS ≤60 days; individuals ≤60 days
□ Business associate breach notification to covered entity ≤60 days
□ Media notification if ≥500 individuals in a state
```

---

## Phase 6 — SOX IT Controls (ITGC)

**IT General Controls (ITGC) testing:**

```
Logical Access:
□ User access provisioning: sample 25 new users; verify role approval documented
□ User access termination: sample 25 terminated users; verify access removed ≤1 day
□ Periodic access review: verify quarterly review completed; inappropriate access removed
□ Privileged access: verify privileged users at expected count; no unauthorized additions
□ Password policy: verify policy enforced by technical controls (length, complexity, history)
□ MFA: verify MFA enforced for all privileged access and remote access

Change Management:
□ Change tickets: sample 25 production changes; verify each has approval, testing, CAB
□ Emergency changes: sample all emergency changes; verify ECAB approval and post-hoc review
□ Segregation of duties: verify developers cannot promote to production without approval

Operations:
□ Batch job monitoring: verify monitoring in place; failures alerted and investigated
□ Data backup: verify backup schedules; test restore quarterly; results documented
□ Data retention: verify retention policy implemented; old data destroyed per schedule

Incident Management:
□ Security incidents: verify P1/P2 incidents have IR process followed; PIR completed
□ Problem tickets: verify root cause and remediation tracked to closure
```

---

## Phase 7 — GRC Platform Management

**GRC platform requirements:**

```
Core functionality required:
- Control library (mapped to all applicable frameworks)
- Evidence management (upload, version, expiry tracking)
- Risk register with heat map
- Audit management (findings, remediation, closure tracking)
- Vendor risk management (questionnaires, assessments, SLA tracking)
- Policy management (version control, approval workflow, attestation)
- Reporting dashboards (CISO view, compliance status, overdue items)

Evidence best practices:
- Name evidence files: [ControlID]_[EvidenceType]_[YYYY-MM].ext
- Automated evidence collection where possible (API integrations with IAM, SIEM, etc.)
- Evidence review before submission: verify it proves what it claims
- Link every evidence item to specific control assertion
- Retain evidence for 7 years minimum (longer for regulated industries)

Audit trail in GRC:
- Every control status change logged with user and timestamp
- Risk acceptance: approver name, rationale, expiry date
- Finding lifecycle: open → remediation in progress → resolved → verified → closed
```

---

## Non-Negotiable Audit Rules

1. **Evidence speaks; opinions don't** — every control assertion backed by objective evidence
2. **No retroactive evidence creation** — audit evidence must have existed during the audit period
3. **Sampling is not coverage** — sampling gaps are risks; document what was not tested
4. **Exceptions must be risk-accepted** — no control exception closed without CISO sign-off
5. **Third-party auditors are independent** — no influence on auditor findings; manage management response only
6. **Continuous compliance > point-in-time** — GRC platform stays current; not only updated before audits
