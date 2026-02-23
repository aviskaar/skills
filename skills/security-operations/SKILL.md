---
name: security-operations
description: "Use this skill when you need SOC (Security Operations Center) setup or management, threat detection and hunting programs, incident response coordination, SIEM configuration and tuning, security monitoring strategy, SRE security integration, or security operations metrics and KPIs. Trigger for active threats, SOC buildout, or operational security program design."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [soc, threat-detection, incident-response, siem, threat-hunting, security-operations, monitoring]
  sub-skills:
    - threat-hunter
    - incident-responder
    - sre-operations
---

# Security Operations — VP Security Operations

## Role

VP Security Operations owns the 24×7 detection, response, and resilience capability. This skill orchestrates the SOC, threat hunting program, incident response lifecycle, and SRE-security integration to ensure continuous monitoring, rapid detection, and effective containment.

---

## Phase 1 — SOC Architecture & SIEM Design

**SOC maturity model:**

| Level | Capability | Description |
|---|---|---|
| L1 | Alert Triage | Ingest logs, triage alerts, escalate |
| L2 | Investigation | Deep analysis, threat intel correlation |
| L3 | Threat Hunting | Proactive hunt, adversary emulation |
| L4 | Engineering | Detection engineering, toolchain dev |
| L5 | Strategic | Program governance, threat intelligence |

**SIEM architecture requirements:**
- Centralized log ingestion: endpoints, network, cloud, applications, identity
- Log retention: 90 days hot, 365 days warm, 7 years cold (compliance minimum)
- Normalization: CEF/LEEF/ECS format standardization
- Correlation rules: MITRE ATT&CK mapped detections
- Alert deduplication and priority scoring (CVSS × asset criticality)
- Automated enrichment: threat intel feeds (STIX/TAXII), IP reputation, CVE data
- SOAR integration for automated playbook execution

**Required log sources (non-negotiable):**
```
Identity:      Active Directory / Entra ID / Okta / IAM
Endpoints:     EDR (CrowdStrike/SentinelOne/Defender)
Network:       Firewall, IDS/IPS, DNS, DHCP, proxy
Cloud:         CloudTrail/Audit Logs (AWS/Azure/GCP)
Applications:  WAF, API gateway, application logs
Email:         O365/Google Workspace security events
Data:          DLP events, database audit logs
Physical:      Badge access, CCTV event integrations
```

---

## Phase 2 — Detection Engineering

**Detection rule tiers:**
- **Tier 1 (Always-on):** Known bad IOCs, signature-based, high-fidelity automated block
- **Tier 2 (Behavioral):** Anomaly-based, ML-assisted, requires L2 validation
- **Tier 3 (Hunt-driven):** Hypothesis-based, custom KQL/SPL queries from threat-hunter

**MITRE ATT&CK coverage targets:**
```
Initial Access:       ≥90% detection coverage
Execution:            ≥85%
Persistence:          ≥80%
Privilege Escalation: ≥90%
Defense Evasion:      ≥70%
Credential Access:    ≥90%
Discovery:            ≥60%
Lateral Movement:     ≥85%
Collection:           ≥75%
Exfiltration:         ≥80%
Command & Control:    ≥85%
Impact:               ≥90%
```

**Alert quality standards:**
- False positive rate target: <10% per rule
- Rules exceeding 25% FP → auto-suppressed pending engineering review
- True positive validation: all P1/P2 alerts require post-closure validation

---

## Phase 3 — Incident Response Orchestration

**Severity classification:**

| Severity | Definition | Response SLA | Escalation |
|---|---|---|---|
| P1 — Critical | Active breach, data exfiltration, ransomware | 15 min acknowledge, 1h contain | CISO + Legal + Exec |
| P2 — High | Confirmed compromise, insider threat | 1h acknowledge, 4h contain | security-operations VP + CISO |
| P3 — Medium | Suspicious activity, policy violation | 4h acknowledge, 24h investigate | L2 SOC |
| P4 — Low | Informational, compliance flag | 24h acknowledge, 72h close | L1 SOC |

**IR lifecycle (delegate to `incident-responder`):**
1. Detection → Alert fired in SIEM
2. Triage → L1 analyst classifies severity
3. Containment → Automated + manual isolation
4. Eradication → Root cause removal
5. Recovery → Service restoration
6. Post-Incident Review → Lessons learned, detection improvement

**Playbook requirements:**
- Every P1/P2 scenario must have a documented playbook
- Playbooks reviewed and tabletop-tested annually minimum
- Playbooks cover: ransomware, BEC, data exfiltration, insider threat, DDoS, supply chain compromise, cloud account takeover, AI system compromise

---

## Phase 4 — Threat Hunting Program

**Delegate to `threat-hunter` for execution.**

**Hunting cadence:**
- Weekly: IOC sweeps from threat intel feeds
- Bi-weekly: MITRE ATT&CK technique hypothesis hunts
- Monthly: Deep dives on crown jewel systems
- Quarterly: Adversary emulation (purple team)

**Hunt hypothesis sources:**
- Threat intelligence (ISAC, commercial feeds, OSINT)
- Incident post-mortems from peer organizations
- New MITRE ATT&CK techniques published
- Newly disclosed CVEs affecting environment
- Behavioral anomalies identified by ML

---

## Phase 5 — Security Operations Metrics

**Operational KPIs (track weekly):**

| Metric | Target | Critical Threshold |
|---|---|---|
| MTTD (Mean Time to Detect) | <1 hour | >4 hours → escalate |
| MTTR (Mean Time to Respond) | <4 hours | >24 hours → escalate |
| Alert Volume | Baseline ±20% | >50% spike → investigation |
| False Positive Rate | <10% | >25% → rule review |
| P1 Incident Count | 0 per month | Any P1 → CISO report |
| Hunt Coverage (ATT&CK) | ≥80% techniques | <60% → gap report |
| SOC Analyst Utilization | 70–85% | >90% → staff review |
| Playbook Currency | 100% reviewed annually | Any expired → immediate |

---

## Phase 6 — SRE-Security Integration

**Delegate to `sre-operations`** for reliability + security fusion.

**Integration requirements:**
- Security chaos engineering: inject security failures in staging
- Runbook integration: security steps embedded in all SRE runbooks
- SLO/SLA: security event response included in service reliability objectives
- Change management gate: security review required for all production changes (CAB process)
- Blameless post-mortems: security incidents follow SRE post-mortem culture

---

## Non-Negotiable SOC Rules

1. **24×7 coverage** — no unmonitored windows; follow-the-sun or automated coverage
2. **Alert fatigue prevention** — never allow >200 daily alerts per analyst
3. **Evidence preservation** — all IR actions logged and chain-of-custody maintained
4. **No silent failures** — every alert receives a documented disposition
5. **Least-privilege tool access** — SOC tools scoped to read-heavy, surgical-write
6. **Encrypted communications** — all SOC internal comms on encrypted channels
7. **Annual IR tabletop mandatory** — no exceptions; test all P1 playbooks
