---
name: sre-operations
description: "Use this skill when you need SRE (Site Reliability Engineering) security integration, ITIL process design, Six Sigma quality improvement for security, Global Delivery Framework implementation, reliability-security SLO/SLA design, runbook creation with security gates, capacity planning with security constraints, or operational excellence programs. Trigger for SRE buildout, operational transformation, or reliability + security convergence programs."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [sre, itil, six-sigma, global-delivery, reliability, slo, sla, runbook, operational-excellence, itil4, change-management]
---

# SRE Operations — Site Reliability Engineering & Operational Excellence Specialist

## Role

The SRE Operations specialist fuses Site Reliability Engineering, ITIL 4, Six Sigma quality disciplines, and Global Delivery Framework principles into a unified operational excellence program. This skill ensures security is embedded into reliability engineering, not bolted on afterward.

---

## Phase 1 — SRE Security Integration Framework

**SRE Error Budget with Security Dimension:**

```
Traditional SRE:
  Error Budget = 100% - SLO (e.g., 99.9% SLO → 0.1% error budget = 43.8 min/month)

Security-Extended SRE:
  Error Budget dimensions:
  1. Availability budget (uptime)
  2. Security incident budget (time spent in security incident per month)
  3. Vulnerability debt budget (ratio of unpatched critical CVEs vs. total)
  4. Compliance drift budget (% time in non-compliant state)

Security SLOs (Service Level Objectives):
- Patch deployment time for critical CVEs: SLO = 100% within 24h
- MFA enforcement: SLO = 100% of privileged users at all times
- Certificate validity: SLO = 0 expired certs in production at any time
- Backup restore success: SLO = 100% successful restore test monthly
- Incident detection (MTTD): SLO = 95% of P1 incidents detected within 1h
```

**Reliability vs. Security trade-off framework:**

```
When reliability and security conflict (e.g., emergency patch requires downtime):
1. Assess security risk (CVSS score, active exploitation in wild)
2. Assess reliability impact (planned outage duration, affected users)
3. Apply risk matrix:
   - Critical CVE + active exploitation → security wins; schedule emergency maintenance
   - High CVE + not exploited → negotiate maintenance window within 7 days
   - Medium/Low CVE → schedule in next regular maintenance window
4. Document decision in change management record
5. Inform CISO and product owner of decision and rationale
```

---

## Phase 2 — ITIL 4 Service Management Integration

**ITIL 4 Service Value Chain with security embedding:**

```
Plan:     Security requirements in service strategy; risk assessment
Improve:  Security metrics in CSI (Continual Service Improvement) register
Engage:   Security SLAs in customer agreements; vendor security requirements
Design:   Security architecture review in service design; threat modeling
Obtain:   Vendor security assessment before software/service procurement
Deliver:  Security gates in release pipeline; CAB security sign-off
Support:  Security incident integration with service desk; problem management
```

**Key ITIL 4 processes with security controls:**

| ITIL Process | Security Integration |
|---|---|
| Incident Management | Security incidents follow IR playbook; severity aligned to P1-P4 |
| Problem Management | Security root cause analysis; known error database includes security issues |
| Change Management | CAB includes security reviewer; emergency changes require ECAB |
| Release Management | Security sign-off gate before production release |
| Configuration Management | CMDB includes security attributes (patch level, encryption status, owner) |
| Service Level Management | Security SLOs in SLA; breach triggers executive notification |
| Availability Management | DR/BCP tested with security scenarios |
| Capacity Management | Security tooling capacity included in planning |
| Supplier Management | Vendor security assessment in procurement process |
| Knowledge Management | Security runbooks in ITSM knowledge base |

---

## Phase 3 — Six Sigma for Security Quality

**DMAIC applied to security processes:**

### Define — Problem Statement:
```
Security defect = any security control that fails to perform its intended function
Examples:
- MFA bypass due to misconfiguration
- Unencrypted backup discovered
- Privileged account not deprovisioned after termination
- Certificate expired in production

Project Charter must include:
- Problem statement (measurable)
- Business case (cost of failure: breach cost, regulatory fine, reputational)
- Goal: target defect rate (e.g., "reduce critical patch SLA breach from 15% to 0%")
- Scope: systems, processes, teams in scope
- Timeline and team
```

### Measure — Baseline Security Metrics:
```
Defect rates to measure:
- Critical vulnerability patch SLA breach rate: [X%] (target: 0%)
- Access review completion rate: [X%] (target: 100%)
- Phishing simulation click rate: [X%] (target: <3%)
- Security training completion: [X%] (target: 100%)
- Change-induced security incidents: [N/month] (target: 0)
- Mean Time to Detect: [Xh] (target: <1h)
- Mean Time to Respond: [Xh] (target: <4h)

Measurement system analysis:
- Confirm data is accurate and consistent
- Define operational definitions for each metric
- Establish data collection cadence and ownership
```

### Analyze — Root Cause:
```
Tools:
- Fishbone (Ishikawa) diagram: people, process, technology, environment
- 5-Whys analysis for specific defects
- Pareto chart: 80% of defects from 20% of causes
- Control charts: identify special vs. common cause variation
- FMEA: Failure Mode and Effects Analysis for security processes

Common root causes in security:
- Process: no defined process; process exists but not followed
- People: lack of training; no accountability; unclear ownership
- Technology: tool misconfiguration; integration gaps; outdated tooling
- Environment: complexity; legacy systems; rapid change pace
```

### Improve — Solutions:
```
Security process improvement examples:
- Automate patch deployment (reduce human error)
- Implement automated access reviews (reduce manual effort)
- Integrate security training into onboarding (ensure coverage)
- Add pre-commit hooks for secrets detection (shift-left)
- Implement policy-as-code for compliance (eliminate configuration drift)

Pilot → Measure → Full deployment
Always validate improvement with data before full rollout.
```

### Control — Sustain Improvements:
```
Control plan elements:
- Process owner: named individual accountable for maintaining improvement
- Control chart: ongoing measurement of key metric
- Corrective action: defined response if metric exceeds control limits
- Audit schedule: periodic verification the process is followed
- Documentation: updated runbooks, policies, and procedures
```

---

## Phase 4 — Global Delivery Framework (GDF)

**Security requirements for globally distributed teams:**

```
Follow-the-Sun Security Coverage:
- SOC coverage: 24×7 via geographic rotation (Americas/EMEA/APAC)
- Incident response: on-call rotation covers all time zones; <15 min response SLA
- Security approvals: defined approval authority at each geography for time-sensitive decisions

Data Residency & Sovereignty:
- Identify data residency requirements per jurisdiction (GDPR: EU; China PIPL: China; India PDPB: India)
- Enforce data residency via cloud region controls; data never leaves mandated geography
- Cross-border data transfers: legal basis documented (SCCs, BCRs, adequacy decision)
- Data localization compliance mapped to each delivery location

Access Control by Geography:
- Principle of least privilege applied at geographic level
- Access to sensitive systems requires VPN + MFA + location-based conditional access
- Offshore access to crown jewel systems: requires documented business justification + CISO approval
- No export-controlled data (ITAR/EAR) accessible to restricted-country teams without license

Vendor & Third-Party Security (in global delivery context):
- All delivery partners assessed via standardized security questionnaire (SIG Lite minimum)
- Annual reassessment; immediate reassessment on security incident at vendor
- Right-to-audit clauses in all vendor contracts
- Shared responsibility matrix defined for all vendor relationships
- SOC 2 Type II or equivalent required for critical vendors

Global Security Training Delivery:
- Security training localized by language and cultural context
- Phishing simulations run across all geographies
- Regional compliance modules (GDPR for EMEA; PIPL for China delivery; etc.)
- Training completion tracked per geography; regional manager accountable
```

---

## Phase 5 — Runbook Security Standards

**Security runbook template (mandatory sections):**

```
RUNBOOK: [System/Process Name] Security Operations

Scope:          [What systems, services, processes this covers]
Owner:          [Team + escalation contact]
Classification: [Security sensitivity of this runbook — CONFIDENTIAL]
Review cycle:   [Quarterly minimum]
Last reviewed:  [Date + reviewer]

1. NORMAL OPERATIONS
   - Security monitoring cadence
   - Routine access review process
   - Certificate and credential rotation schedule
   - Log review and alert triage process

2. SECURITY INCIDENT RESPONSE
   - Detection indicators specific to this service
   - Triage steps: verify → classify → contain
   - Escalation matrix with contact details
   - Evidence preservation steps for this service
   - Communication templates (internal + regulatory)

3. CHANGE MANAGEMENT GATES
   - Pre-change: security checklist (what to verify before change)
   - During change: monitoring requirements
   - Post-change: validation and verification steps
   - Rollback procedure with security verification

4. DISASTER RECOVERY
   - RTO and RPO targets with security dimension
   - Backup verification process (including encryption check)
   - Recovery sequence with security validation at each step
   - Post-recovery security scan before accepting traffic

5. COMPLIANCE CONTROLS
   - Applicable frameworks: [SOC2 controls, NIST controls mapped]
   - Evidence collection: what to save, where, how long
   - Audit support: contacts, evidence location, access process
```

---

## Phase 6 — Security Chaos Engineering

**Security fault injection testing (quarterly):**

```
Scenarios to test in staging/pre-prod:
1. Certificate expiry simulation → verify alerting and auto-renewal
2. KMS key unavailability → verify graceful degradation (no plaintext fallback)
3. SIEM outage → verify backup logging; alert on gap
4. Identity provider outage → verify break-glass procedure
5. Network segmentation breach → verify east-west detection and blocking
6. Backup restore failure → verify DR procedure and RTO
7. Privileged account compromise → verify containment speed

Each test:
- Document hypothesis (what should happen?)
- Execute in controlled environment
- Measure actual vs. expected behavior
- Document gaps and remediate
- Re-test after remediation
```

---

## Operational Excellence Metrics

| Metric | Target | Frequency |
|---|---|---|
| SLO compliance (all security SLOs) | 100% | Monthly |
| Change-induced security incidents | 0 | Monthly |
| Security runbook currency | 100% reviewed within 12 months | Quarterly audit |
| Mean Time to Detect (security events) | <1 hour | Weekly |
| Security training completion (all staff) | 100% | Quarterly |
| Six Sigma defect rate (security processes) | <3.4 DPMO (6σ) | Monthly |
| DR test success rate | 100% | Quarterly |
| Global delivery security audit pass rate | 100% | Annual |
