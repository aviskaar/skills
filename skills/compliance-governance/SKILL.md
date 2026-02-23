---
name: compliance-governance
description: "Use this skill when you need regulatory compliance strategy, framework gap analysis, audit preparation, policy management, or risk governance across SOC 2, NIST CSF, ISO 27001, HIPAA, SOX, GDPR, CCPA, EU AI Act, PCI-DSS, or industry-specific standards. Trigger for compliance program buildout, audit readiness, regulatory change management, or cross-framework harmonization."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [compliance, governance, soc2, nist, iso27001, hipaa, sox, gdpr, ccpa, eu-ai-act, pci-dss, risk-management]
  sub-skills:
    - compliance-auditor
    - industry-compliance
---

# Compliance & Governance — VP Compliance & Governance

## Role

VP Compliance & Governance owns the enterprise regulatory compliance posture, policy framework, audit lifecycle, and cross-framework control harmonization. This skill ensures the organization meets all mandatory obligations, anticipates regulatory change, and maintains audit-ready evidence at all times.

---

## Compliance Framework Universe

### Tier 1 — Mandatory (Legally Binding)

| Framework | Applicability | Regulatory Body |
|---|---|---|
| GDPR | EU personal data processing | European Data Protection Board |
| HIPAA/HITECH | US healthcare PHI | HHS Office for Civil Rights |
| SOX | US public companies (financial reporting) | SEC / PCAOB |
| PCI-DSS v4.0 | Payment card data | PCI Security Standards Council |
| CCPA/CPRA | California consumer data | California AG / CPPA |
| EU AI Act | AI systems serving EU | EU AI Office |
| DORA | EU financial entities digital resilience | ESAs |

### Tier 2 — Industry Standard (Audit-Required)

| Framework | Scope | Certification Body |
|---|---|---|
| SOC 2 Type II | Service organizations, trust principles | AICPA-licensed CPA |
| ISO 27001:2022 | ISMS certification | Accredited CB (BSI, DNV, etc.) |
| ISO 27017 | Cloud service controls | Accredited CB |
| ISO 27018 | Cloud PII protection | Accredited CB |
| ISO 42001 | AI management system | Accredited CB |
| NIST CSF 2.0 | Cybersecurity framework | Self-attested / third-party |
| NIST SP 800-53 Rev5 | Federal/FedRAMP | 3PAO |
| FedRAMP | US federal cloud | FedRAMP PMO |

### Tier 3 — Industry-Specific (delegate to `industry-compliance`)

- FFIEC / OCC guidelines (Banking)
- FINRA / SEC cybersecurity rules (Finance)
- FDA 21 CFR Part 11 (Life Sciences)
- HITRUST CSF (Healthcare)
- NERC CIP (Energy)
- ITAR / EAR (Defense/Aerospace)

---

## Phase 1 — Compliance Obligation Mapping

**Inputs required:**
| Input | Description |
|---|---|
| Organization profile | Jurisdictions, industries, customer types |
| Data inventory | Data types processed, stored, transmitted |
| Technology stack | Cloud providers, SaaS tools, data processors |
| Business activities | Payment processing, healthcare data, AI systems |
| Customer contracts | Enterprise agreements with compliance clauses |

**Actions:**
1. Map all applicable frameworks to organization profile.
2. Identify overlapping controls across frameworks (harmonization opportunities).
3. Classify obligations: mandatory vs. voluntary vs. contractual.
4. Define compliance calendar with all audit windows, renewal dates, regulatory deadlines.
5. Assign framework owners within organization.

**Output:** Compliance Obligation Register + Harmonized Control Framework

---

## Phase 2 — Control Framework Design

**Unified Control Library approach** — map one control to multiple frameworks:

```
Example: Encryption at Rest
├── SOC 2:     CC6.1 (Logical Access Controls)
├── ISO 27001: A.8.24 (Use of cryptography)
├── NIST CSF:  PR.DS-1 (Data-at-rest protected)
├── HIPAA:     §164.312(a)(2)(iv) (Encryption)
├── GDPR:      Art. 32 (Appropriate technical measures)
└── PCI-DSS:  Req 3.5 (Protect stored account data)
```

**Control categories (NIST SP 800-53 aligned):**
- Access Control (AC)
- Awareness and Training (AT)
- Audit and Accountability (AU)
- Configuration Management (CM)
- Contingency Planning (CP)
- Identification and Authentication (IA)
- Incident Response (IR)
- Maintenance (MA)
- Media Protection (MP)
- Physical Protection (PE)
- Planning (PL)
- Personnel Security (PS)
- Risk Assessment (RA)
- System and Services Acquisition (SA)
- System and Communications Protection (SC)
- System and Information Integrity (SI)
- Supply Chain Risk Management (SR)

---

## Phase 3 — SOC 2 Program

**Trust Service Criteria (TSC) coverage:**

| Criteria | Scope | Key Controls |
|---|---|---|
| Security (CC) | All audits | Access controls, encryption, monitoring, change mgmt |
| Availability (A) | SLA-critical systems | Uptime SLOs, DR, capacity planning |
| Processing Integrity (PI) | Data processing systems | Input/output validation, error handling |
| Confidentiality (C) | Sensitive data | Encryption, NDA, data classification |
| Privacy (P) | Personal data | Notice, consent, retention, subject rights |

**SOC 2 audit readiness checklist:**
- [ ] All controls documented with owner, frequency, evidence type
- [ ] Evidence collection automated where possible (GRC platform integration)
- [ ] Control testing completed 90 days before audit window
- [ ] Exception register reviewed and remediated or risk-accepted
- [ ] Vendor SOC 2 reports reviewed for all critical third parties
- [ ] Management assertion drafted and legal-reviewed
- [ ] Complementary User Entity Controls (CUECs) documented

**Delegate to `compliance-auditor`** for evidence collection and testing execution.

---

## Phase 4 — GDPR & Privacy Governance

**GDPR compliance requirements:**

| Requirement | Implementation |
|---|---|
| Lawful basis | Document legal basis for each processing activity |
| Data Subject Rights | DSAR process: <30-day response, automated where possible |
| Data Minimization | PIA/DPIA for new systems; minimize collection |
| Retention Limits | Retention schedule enforced; automated deletion |
| Breach Notification | <72h to DPA; <30 days to affected individuals |
| DPA/SCCs | Executed for all data processors; SCCs for non-EU transfers |
| ROPA | Records of Processing Activities maintained current |
| DPO | Appointed where required; accessible contact |

**CCPA/CPRA additional requirements:**
- Consumer rights: Know, Delete, Opt-Out of Sale, Correct, Limit
- Annual privacy policy update
- Data broker registration if applicable
- Sensitive personal information controls (SPI category)

**EU AI Act obligations (by risk tier):**

| AI Risk Tier | Requirements |
|---|---|
| Prohibited | No deployment (social scoring, real-time biometric surveillance) |
| High-Risk | Conformity assessment, CE marking, registration, human oversight |
| Limited Risk | Transparency obligations (chatbot disclosure) |
| Minimal Risk | Voluntary codes of practice |

---

## Phase 5 — Audit Lifecycle Management

**Audit calendar management:**
```
Q1: SOC 2 Type II observation period start; ISO 27001 surveillance
Q2: GDPR annual review; PCI-DSS self-assessment (SAQ)
Q3: Penetration test (application-security); SOC 2 interim testing
Q4: SOC 2 Type II audit fieldwork; ISO 27001 certification renewal
Ongoing: HIPAA privacy reviews; SOX controls testing (quarterly)
```

**Pre-audit actions (90 days out):**
1. Commission `compliance-auditor` for gap assessment.
2. Remediate all critical/high findings.
3. Assemble evidence packages by control domain.
4. Brief control owners on auditor interview prep.
5. Review and refresh all policies (must be <12 months old).

**During audit:**
- Designate audit coordinator (single point of contact)
- Use GRC platform for evidence delivery (no ad-hoc email transfers)
- Daily auditor status call during fieldwork
- Exception escalation to CISO within 24h

**Post-audit:**
- Management response to all findings within 15 business days
- Remediation plan tracked in risk register
- Letter of engagement for next audit cycle

---

## Phase 6 — Policy & Standards Management

**Policy hierarchy:**
```
Level 1: Security Policy (Board-approved, annual review)
Level 2: Standards (CISO-approved, semi-annual review)
Level 3: Procedures (Domain-owner approved, quarterly review)
Level 4: Guidelines (Advisory, team-level)
```

**Mandatory policies (must exist and be current):**
- Information Security Policy
- Acceptable Use Policy
- Access Control Policy
- Data Classification & Handling Policy
- Incident Response Policy
- Business Continuity & DR Policy
- Vendor Risk Management Policy
- Privacy Policy (external-facing)
- AI Governance Policy
- Change Management Policy

**Policy lifecycle:** Draft → Legal Review → CISO Approval → Board Ratification (Level 1) → Publish → Annual Review → Retire

---

## Non-Negotiable Compliance Rules

1. **No compliance gaps go untracked** — every gap in risk register with owner and date
2. **Evidence must be audit-ready at all times** — not "we can produce it" but "it is ready"
3. **Regulatory deadlines never missed** — breach notifications, filings, renewals in calendar with 30-day advance alert
4. **No self-certification for high-risk frameworks** — SOC 2, ISO 27001, HIPAA require independent assessment
5. **Third-party risk is first-party risk** — vendor compliance posture assessed before onboarding and annually
6. **Policy exceptions require CISO approval** — no informal exceptions; all documented in risk register
