# Enterprise Security Risk Register Template

## Risk Scoring Methodology

**Risk Score = Likelihood × Impact × Regulatory Multiplier**

### Likelihood Scale (1–5):
| Score | Definition | Frequency |
|---|---|---|
| 5 | Almost certain | >1x per year in similar orgs |
| 4 | Likely | 1x per 1–3 years |
| 3 | Possible | 1x per 3–5 years |
| 2 | Unlikely | 1x per 5–10 years |
| 1 | Rare | <1x per 10 years |

### Impact Scale (1–5):
| Score | Definition | Business Impact |
|---|---|---|
| 5 | Catastrophic | Business closure; regulatory shutdown; >$100M loss |
| 4 | Major | Significant business disruption; $10M–$100M loss; major regulatory fine |
| 3 | Moderate | Operational disruption; $1M–$10M loss; regulatory notice |
| 2 | Minor | Limited disruption; $100K–$1M loss; minor regulatory finding |
| 1 | Negligible | Minimal disruption; <$100K loss; no regulatory impact |

### Regulatory Multiplier:
| Multiplier | Condition |
|---|---|
| 1.5 | Risk involves regulated data (PII, PHI, PCI) or regulated industry |
| 1.25 | Risk involves compliance framework obligation |
| 1.0 | Standard (no regulatory element) |

### Risk Rating Thresholds:
| Total Score | Rating | Treatment |
|---|---|---|
| 18–37.5 | Critical | Immediate CISO action; board notification if score ≥30 |
| 12–17.9 | High | CISO-owned; remediation within 30 days |
| 6–11.9 | Medium | VP-owned; remediation within 90 days |
| 1–5.9 | Low | Domain team-owned; remediation within 180 days |

---

## Risk Register Format

| Field | Description |
|---|---|
| Risk ID | RISK-[YYYY]-[NNN] |
| Risk Title | Short descriptive name |
| Risk Description | Detailed description of the risk scenario |
| Risk Category | Technical / Operational / Compliance / Third-party / Physical / AI |
| Threat Actor | External attacker / Insider / Natural disaster / Vendor / Regulatory |
| Asset(s) Affected | Systems, data, or processes at risk |
| Current Controls | Controls already in place |
| Control Effectiveness | Strong / Adequate / Weak / None |
| Likelihood | 1–5 (pre-control and residual) |
| Impact | 1–5 |
| Regulatory Multiplier | 1.0 / 1.25 / 1.5 |
| Inherent Risk Score | Likelihood × Impact × Multiplier (without controls) |
| Residual Risk Score | Likelihood × Impact × Multiplier (with current controls) |
| Risk Rating | Critical / High / Medium / Low |
| Risk Treatment | Mitigate / Accept / Transfer / Avoid |
| Treatment Plan | Specific actions, tools, or process changes |
| Risk Owner | Named individual accountable |
| Target Completion | Date for residual risk to reach acceptable level |
| Risk Acceptance | If accepting residual risk: CISO name + date + justification |
| Status | Open / In Progress / Accepted / Closed |
| Last Reviewed | Date |

---

## Sample Risk Register Entries

### RISK-2025-001: Ransomware Attack on Production Systems
```
Category:     Technical
Threat Actor: External — Cybercrime groups (RaaS operators)
Assets:       All production servers, databases, file shares
Controls:     EDR (deployed), backup (daily), network segmentation (partial)
Control Eff:  Adequate (EDR + backup) / Weak (segmentation gaps)
Likelihood:   4 (Likely — ransomware is prevalent; partial segmentation = elevated risk)
Impact:       5 (Catastrophic — full prod outage; potential data loss; customer impact)
Multiplier:   1.5 (customer PII at risk)
Inherent:     4 × 5 × 1.5 = 30 (Critical)
Residual:     3 × 4 × 1.5 = 18 (Critical — controls reduce but risk remains critical)
Treatment:    Mitigate — complete network micro-segmentation; implement ZTNA
Owner:        VP Infrastructure Security
Target:       Q3 2025
Status:       In Progress
```

### RISK-2025-002: GDPR Non-Compliance — Data Subject Rights Process
```
Category:     Compliance
Threat Actor: Regulatory
Assets:       Customer PII database; DSAR process
Controls:     Privacy policy (published); DSAR intake (email only; manual)
Control Eff:  Weak (manual process; risk of exceeding 30-day deadline)
Likelihood:   3 (Possible — manual processes fail; DPA complaints filed)
Impact:       4 (Major — GDPR fine up to €20M; reputational damage)
Multiplier:   1.5 (regulatory)
Inherent:     3 × 4 × 1.5 = 18 (Critical)
Residual:     2 × 3 × 1.5 = 9 (Medium — after automation)
Treatment:    Mitigate — implement automated DSAR portal; set SLA alerts at 20 days
Owner:        VP Compliance & Governance
Target:       Q2 2025
Status:       In Progress
```

### RISK-2025-003: AI System Hallucination Causing Incorrect Medical Advice
```
Category:     AI / Operational
Threat Actor: System failure / Design flaw
Assets:       Patient-facing AI symptom checker
Controls:     Disclaimer (displayed); human review (not enforced; bypass possible)
Control Eff:  Weak (disclaimer is not a technical control)
Likelihood:   4 (Likely — hallucination is inherent to LLMs without RAG + validation)
Impact:       5 (Catastrophic — patient harm; HIPAA; FDA regulatory; litigation)
Multiplier:   1.5 (PHI + healthcare regulation)
Inherent:     4 × 5 × 1.5 = 30 (Critical)
Residual:     2 × 3 × 1.5 = 9 (Medium — after RAG + validation layer + HITL)
Treatment:    Mitigate — implement RAG with verified medical corpus; clinical review gate for
              all outputs above threshold; confidence scoring mandatory
Owner:        VP AI Ethics & Security
Target:       Q1 2025
Status:       Critical — immediate action required
```

---

## Risk Treatment Definitions

**Mitigate:** Implement controls to reduce likelihood and/or impact to acceptable level.
Required: Specific control actions, owner, timeline, success criteria.

**Accept:** Acknowledge risk exists and consciously choose not to address it further.
Required: CISO written acceptance, justification (cost vs. benefit), expiry date (max 12 months), annual re-review.
Prohibited for: Critical risks (score ≥18) without Board notification.

**Transfer:** Shift financial impact to third party (cyber insurance) or contractual liability (vendor SLA).
Note: Transfer does not eliminate the risk; it reduces financial impact only. Reputational and regulatory risk remains.
Required: Insurance policy details, coverage limits, exclusions documented.

**Avoid:** Discontinue the activity that creates the risk.
Example: Discontinue processing certain data types to avoid GDPR obligation.
Required: Business owner sign-off on discontinued activity.
