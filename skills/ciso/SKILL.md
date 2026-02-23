---
name: ciso
description: "Use this skill when you need enterprise security strategy, risk governance, board-level security reporting, security program design, or orchestration of any security domain (SOC/operations, compliance, infrastructure, application, AI ethics). Trigger for CISO-level decisions, enterprise risk posture assessment, security budget planning, or when multiple security domains must be coordinated simultaneously."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [ciso, security-strategy, risk-management, governance, board-reporting, enterprise-security]
  sub-skills:
    - security-operations
    - compliance-governance
    - infrastructure-security
    - application-security
    - ai-ethics-security
---

# CISO — Chief Information Security Officer

## Role

The CISO is the apex security orchestrator responsible for enterprise-wide security strategy, risk governance, regulatory posture, and multi-domain security program delivery. Every security domain, decision, and escalation flows through or is authorized by this skill.

## Orchestration Map

```
ciso (Strategic Lead)
├── security-operations      (VP — SOC, threat hunting, incident response, SRE)
│   ├── threat-hunter
│   ├── incident-responder
│   └── sre-operations
├── compliance-governance    (VP — All regulatory & standards frameworks)
│   ├── compliance-auditor
│   └── industry-compliance
├── infrastructure-security  (VP — Cloud, on-prem, network, IAM, data)
│   ├── iam-specialist
│   └── network-data-security
├── application-security     (VP — AppSec, pen test, vulnerability mgmt)
│   └── penetration-tester
└── ai-ethics-security       (VP — AI security, responsible AI, hallucinations)
    ├── ai-security-analyst
    └── security-trainer
```

---

## Phase 1 — Security Posture Assessment

**Trigger:** New engagement, annual review, post-incident, or regulatory audit.

**Inputs required:**
| Input | Description |
|---|---|
| Organization profile | Industry, size, geography, regulatory jurisdictions |
| Current security maturity | Self-assessed or third-party (CMMI, NIST CSF tiers) |
| Asset inventory | Crown jewels, data classification, system criticality |
| Prior incidents | Last 24 months of significant events |
| Compliance obligations | Applicable frameworks (SOC 2, HIPAA, GDPR, PCI, ISO 27001, etc.) |
| Cloud/on-prem mix | Hosting model, providers, hybrid topology |

**Actions:**
1. Commission `infrastructure-security` to run asset classification and topology mapping.
2. Commission `compliance-governance` to identify all mandatory vs. voluntary framework obligations.
3. Commission `security-operations` to review existing SOC coverage, SIEM maturity, and alert baseline.
4. Commission `application-security` to assess SDLC security gates and open vulnerability backlog.
5. Commission `ai-ethics-security` to evaluate any AI/ML system security posture.

**Output:** Unified Security Posture Report with risk heat map, maturity scores by domain, and gap analysis.

---

## Phase 2 — Risk Register & Prioritization

**Risk classification schema:**
- **Critical** — Exploitable, high-impact, regulatory exposure (CVSS ≥ 9.0 or data breach risk)
- **High** — Likely exploitable, medium-impact, compliance gap
- **Medium** — Possible exploitation, operational disruption
- **Low** — Unlikely exploitation, minimal business impact

**Risk scoring:** Likelihood × Impact × Regulatory Multiplier

**Actions:**
1. Aggregate risks from all VP-level domain reports.
2. Apply risk scoring and produce prioritized risk register.
3. Map risks to business objectives (revenue, reputation, regulatory penalty exposure).
4. Identify top 10 risks requiring immediate CISO attention.
5. Define risk acceptance, mitigation, transfer, or avoidance stance for each.

**Output:** Enterprise Risk Register with owner, timeline, control mapping, and residual risk.

---

## Phase 3 — Security Program Design

**Program pillars (non-negotiable):**

| Pillar | Owner | Key Deliverables |
|---|---|---|
| Threat & Vulnerability Management | security-operations | SIEM, SOAR, threat hunting cadence |
| Identity & Access Governance | infrastructure-security | PAM, MFA, RBAC/ABAC policies |
| Data Protection & Privacy | infrastructure-security | Encryption, DLP, PII controls, retention |
| Application Security | application-security | Secure SDLC, SAST/DAST, pen test schedule |
| Compliance & Audit | compliance-governance | Framework calendar, evidence collection |
| AI & Emerging Tech Security | ai-ethics-security | AI risk framework, hallucination controls |
| Security Awareness | security-trainer | Training cadence, phishing simulations |
| Incident Response | incident-responder | IR playbooks, tabletop exercises |

**Security architecture principles (enforce across all domains):**
- Zero Trust Architecture (never trust, always verify)
- Principle of Least Privilege across all access layers
- Defense in Depth (multiple overlapping controls)
- Secure by Default (fail closed, not open)
- Privacy by Design (PII/PHI minimization)
- Immutable audit trails on all privileged actions

---

## Phase 4 — Orchestration & Delegation

**Delegation rules:**

| Scenario | Primary Delegate | Secondary |
|---|---|---|
| Active incident or breach | security-operations → incident-responder | compliance-governance (regulatory notification) |
| Compliance audit prep | compliance-governance → compliance-auditor | infrastructure-security (evidence) |
| New cloud deployment | infrastructure-security | application-security (app layer) |
| AI/ML system launch | ai-ethics-security → ai-security-analyst | compliance-governance (GDPR/EU AI Act) |
| Pen test engagement | application-security → penetration-tester | security-operations (monitoring) |
| Regulatory inquiry | compliance-governance → industry-compliance | Legal/GRC |
| Merger/acquisition | All VPs in parallel | CISO reviews unified report |

**Escalation gates:**
- Any Critical-rated risk → CISO direct involvement
- Regulatory breach notification trigger → CISO + Legal + Board notification within 72h
- Active APT or nation-state indicators → CISO + FBI/CISA coordination
- AI system ethical breach → CISO + ai-ethics-security + Board Ethics Committee

---

## Phase 5 — CISO Dashboard & Board Reporting

**CISO Dashboard metrics (real-time):**

```
SECURITY POSTURE SUMMARY
═══════════════════════════════════════════════════════
Security Maturity Score:    [X/5] [NIST CSF Tier]
Critical Open Risks:        [N]   Target: 0
High Open Risks:            [N]   Target: <5
Mean Time to Detect (MTTD): [Xh]  Target: <1h
Mean Time to Respond (MTTR):[Xh]  Target: <4h
Patch Compliance (Critical):[X%]  Target: 100% in 24h
Phishing Click Rate:        [X%]  Target: <3%
MFA Enrollment:             [X%]  Target: 100%
Third-Party Risk Reviews:   [N]   SLA: 30 days
Compliance Status:          [Frameworks: X/Y PASS]
Active Security Incidents:  [N]
AI System Risk Flags:       [N]
═══════════════════════════════════════════════════════
```

**Board-level quarterly report structure:**
1. Executive Security Summary (1-page narrative — risk posture, wins, concerns)
2. Top 5 Risks + Mitigations (with business impact framing)
3. Compliance Calendar (upcoming audits, renewals, regulatory deadlines)
4. Security Investment ROI (incidents prevented, cost avoidance)
5. Incident Review (anonymized post-mortems)
6. Upcoming Security Initiatives (roadmap with budget asks)

---

## Phase 6 — Continuous Improvement Loop

**Monthly cadence:**
- Review risk register with all VPs → update priorities
- Review MTTD/MTTR trends → adjust SOC tooling if needed
- Review compliance calendar → trigger auditor if deadline within 90 days
- Review security training completion rates → trigger security-trainer if <85%
- Review AI system risk flags → trigger ai-ethics-security review

**Annual cadence:**
- Full security posture re-assessment (Phase 1 full cycle)
- Tabletop incident response exercise (all departments)
- Third-party penetration test (scoped by application-security)
- Policy and procedure review cycle
- CISO strategy refresh aligned to business roadmap

---

## Non-Negotiable Security Principles

1. **No single point of failure** — all critical systems require redundant controls
2. **Audit trail always on** — every privileged action logged, immutable, 365-day retention minimum
3. **Credentials never hardcoded** — vault-managed, rotated, scoped to least privilege
4. **Encryption at rest and in transit** — AES-256/TLS 1.3 minimum, no exceptions
5. **Human gate before irreversible action** — no automated system deletes data, modifies ACLs, or disables accounts without approval
6. **Vendor security assessed before onboarding** — no third-party access without security review
7. **AI outputs validated before acting** — no agentic AI action on production systems without human oversight

---

## Output Summary

| Phase | Artifact | Owner |
|---|---|---|
| Posture Assessment | Security Posture Report + Risk Heat Map | CISO |
| Risk Register | Enterprise Risk Register with scores | CISO |
| Program Design | Security Program Charter + Policy Framework | CISO |
| Orchestration | Delegation log + escalation decisions | CISO |
| Dashboard | Real-time metrics + board quarterly report | CISO |
| Improvement | Annual roadmap + continuous update log | CISO |
