---
name: proposal-automation
description: "Use this skill when a Client Partner, Account Manager, Sales Engineer, Solutions Engineer, or Solutions Architect needs to transform a raw customer problem statement into a complete, enterprise-grade commercial package. This skill automates the full pre-sales and proposal lifecycle: deep problem analysis, use case identification, enterprise architecture design, POC/MVP specification, full proposal document, team structure and resourcing, US and offshore costing with blended rates, and a legally structured Statement of Work. Trigger this skill when any of these roles receives a customer brief, RFP, RFI, discovery call notes, or pain-point description and needs to move quickly to a polished, boardroom-ready proposal with defensible cost estimates and a signed-ready SOW."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [sales, pre-sales, proposal, sow, costing, architecture, poc, mvp, client-partner, account-manager, solutions-engineer, solutions-architect]
  sub-skills: []
---

# Proposal Automation — End-to-End Pre-Sales & Commercial Workflow

Transforms a raw customer problem statement into a complete commercial package: use cases, enterprise architecture, POC/MVP specification, proposal document, team plan, cost model, and signed-ready SOW — in a single automated workflow.

```
PROBLEM STATEMENT
      │
      ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  PHASE 1    │───▶│  PHASE 2    │───▶│  PHASE 3    │───▶│  PHASE 4    │
│  Problem    │    │  Use Case   │    │  Architecture│    │  POC / MVP  │
│  Analysis   │    │  Discovery  │    │  Design     │    │  Blueprint  │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
                                                                │
      ┌─────────────────────────────────────────────────────────┘
      ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  PHASE 5    │───▶│  PHASE 6    │───▶│  PHASE 7    │───▶│  PHASE 8    │
│  Proposal   │    │  Team &     │    │  Cost       │    │  SOW        │
│  Document   │    │  Resourcing │    │  Model      │    │  Generation │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

---

## PHASE 1 — Problem Statement Analysis

**Trigger**: Customer problem statement, RFP, discovery notes, or pain-point brief received.

### 1.1 Intake & Parsing

Read the full input and extract:

| Dimension | What to Extract |
|---|---|
| **Industry** | Vertical, sub-sector, regulatory environment |
| **Business Pain** | Root causes, symptoms, urgency level (critical / high / medium) |
| **Current State** | Existing systems, tech stack hints, team size, process gaps |
| **Desired Outcomes** | Business KPIs the customer wants to move (revenue, cost, speed, compliance) |
| **Constraints** | Budget signals, timeline, compliance (HIPAA/SOC2/GDPR), data residency |
| **Stakeholders** | Who is the economic buyer, technical buyer, champion, blocker |
| **Decision Criteria** | What "success" looks like to the customer |

### 1.2 Assumption Log

For every ambiguity, state an explicit assumption. Format:

```
ASSUMPTION [A-001]: [What is assumed] — [Why reasonable] — [Risk if wrong: Low/Med/High]
```

List all assumptions; they will carry forward into the SOW.

### 1.3 Problem Statement Summary

Produce a crisp 150-word restatement of the customer's problem in your own words — the "We understand that…" paragraph used to open the proposal.

---

## PHASE 2 — Use Case Discovery

### 2.1 Use Case Generation

Generate a ranked list of use cases addressing the problem. For each:

```
USE CASE [UC-###]: [Name]
Category   : [Operational / Analytical / Customer-facing / Compliance / AI/ML]
Pain Solved: [Which pain point from Phase 1]
Outcome    : [Specific measurable business outcome]
Feasibility: [High / Med / Low] — [1-line rationale]
Impact     : [High / Med / Low] — [1-line rationale]
Priority   : [P1-POC / P2-Phase1 / P3-Phase2 / P4-Backlog]
```

### 2.2 Prioritization Matrix

Plot use cases on a 2×2 (Impact vs Feasibility). Identify:
- **P1 — POC Candidates**: High impact + High feasibility → prove value fast
- **P2 — Phase 1 Build**: High impact + Medium feasibility → core product
- **P3 — Phase 2 Build**: Medium impact or medium feasibility → roadmap
- **P4 — Backlog**: Low priority; note but don't scope

### 2.3 Success Metrics

For each P1 and P2 use case, define 2–3 measurable KPIs:
- Baseline value (current state)
- Target value (post-implementation)
- Measurement method and timeline

---

## PHASE 3 — Enterprise Architecture Design

### 3.1 Architecture Principles

Apply these non-negotiables to every design:
- **Security by Design**: Zero-trust, least-privilege, encryption at rest and in transit
- **Cloud-Native**: Prefer managed services; avoid undifferentiated heavy lifting
- **Event-Driven**: Async where possible; decouple producers from consumers
- **Observable**: Logs, metrics, traces (OpenTelemetry standard)
- **Resilient**: Target 99.9%+ availability; define RTO/RPO upfront
- **Compliant**: Enforce regulatory controls (see constraints from Phase 1)

### 3.2 High-Level Architecture

Design and describe the full architecture including:

**Layers to address**:
```
┌─────────────────────────────────────────────────┐
│  Presentation Layer  (Web / Mobile / API Portal) │
├─────────────────────────────────────────────────┤
│  API Gateway / BFF  (Rate limit, Auth, Routing)  │
├─────────────────────────────────────────────────┤
│  Application Services  (Microservices / Modules) │
├─────────────────────────────────────────────────┤
│  Integration Layer  (ESB / Event Bus / iPaaS)    │
├─────────────────────────────────────────────────┤
│  Data Layer  (Operational DB + Analytics + Lake) │
├─────────────────────────────────────────────────┤
│  Infrastructure  (Cloud / Kubernetes / IaC)      │
├─────────────────────────────────────────────────┤
│  Security & Compliance  (IAM / SIEM / DLP)       │
└─────────────────────────────────────────────────┘
```

For each layer: recommended services/tools, justification, alternatives considered.

### 3.3 Technology Stack Selection

Produce a stack decision table:

| Component | Recommended | Rationale | Alternative |
|---|---|---|---|
| Cloud Platform | AWS / Azure / GCP | [customer context] | Multi-cloud |
| API Gateway | Kong / AWS API GW | … | Apigee |
| Messaging | Kafka / SQS+SNS | … | RabbitMQ |
| Database | PostgreSQL / DynamoDB | … | MySQL |
| ML Platform | SageMaker / Vertex AI | … | Azure ML |
| Observability | Datadog / New Relic | … | Grafana Stack |
| IaC | Terraform | … | Pulumi |
| CI/CD | GitHub Actions / GitLab | … | Jenkins |

### 3.4 Integration Map

List all external systems that must integrate. For each:
- Integration pattern (REST / event / batch / CDC)
- Data exchanged
- Frequency and volume
- Authentication method
- Owner (customer team responsible)

### 3.5 Security & Compliance Architecture

Detail:
- Identity and Access Management (SSO, MFA, RBAC/ABAC)
- Network segmentation (VPC, private subnets, WAF)
- Data classification and handling policies
- Audit logging and SIEM integration
- Compliance controls mapping (SOC 2 / HIPAA / GDPR / PCI-DSS as applicable)

See `references/architecture-patterns.md` for common enterprise architecture patterns by industry.

---

## PHASE 4 — POC / MVP Blueprint

### 4.1 POC Scope Definition

Select 1–2 P1 use cases from Phase 2. The POC must:
- Be completable within 4–8 weeks
- Demonstrate the highest-risk technical assumption
- Produce a tangible, demonstrable artifact
- Map directly to a business KPI from Phase 2

### 4.2 POC Architecture (Thin Slice)

Design a simplified architecture that proves the concept without full production hardening. Mark explicitly what is IN and OUT of POC scope.

**POC Deliverables Template**:
```
Deliverable D1: [Name] — [Description] — [Demo format]
Deliverable D2: [Name] — [Description] — [Demo format]
Success Gate  : [Measurable pass/fail criteria for the POC]
```

### 4.3 MVP Scope (Post-POC)

After POC success, define the MVP:
- Minimum feature set for production-grade release
- P1 + selected P2 use cases
- Non-functional requirements (performance targets, SLA, security hardening)
- MVP exit criteria

### 4.4 POC Tech Stack

List the specific technologies for POC implementation — may differ from full production stack where justified (e.g., a monolith for POC vs microservices in production).

---

## PHASE 5 — Proposal Document

Structure the proposal as follows. Use `assets/proposal-template.md` as the document shell.

### 5.1 Executive Summary (1 page)
- Customer challenge restatement (from Phase 1.3)
- Proposed solution in 3 bullets
- Business value / ROI headline numbers
- Engagement model summary
- Call to action

### 5.2 Understanding of Requirements
- Restated problem (Phase 1.3)
- Assumption log (Phase 1.2)
- Stakeholder map

### 5.3 Proposed Solution
- Solution overview narrative
- Use case coverage table (all UC-### with priority)
- Architecture overview (from Phase 3)
- POC/MVP roadmap with phases

### 5.4 Implementation Roadmap

Build a phased plan:

| Phase | Name | Duration | Key Deliverables | Exit Criteria |
|---|---|---|---|---|
| 0 | POC | 4–8 wks | POC build, demo, success gate | POC sign-off |
| 1 | Foundation | 8–16 wks | Core platform, P1 use cases | MVP go-live |
| 2 | Expansion | 12–20 wks | P2 use cases, integrations | Feature complete |
| 3 | Optimization | 8–12 wks | Performance, AI/ML, analytics | Production SLA met |

### 5.5 Why Us
- Relevant industry experience and case studies (use placeholders if unknown)
- Differentiators (3–5 specific points)
- Partnership/alliance advantages (cloud partnerships, ISV relationships)

### 5.6 Risk Register

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Scope creep | Med | High | Change control process in SOW |
| Data access delays | High | High | Data access pre-conditions in SOW |
| … | … | … | … |

### 5.7 Investment Summary
- Reference cost model from Phase 7
- Present 3 options: POC only / POC + Phase 1 / Full engagement
- ROI calculation: [Cost avoided] + [Revenue enabled] vs [Engagement cost]

---

## PHASE 6 — Team Structure & Resourcing

### 6.1 Required Roles

For each phase of the roadmap, define the roles needed:

| Role | Seniority | Responsibility | Phase 0 | Phase 1 | Phase 2 | Phase 3 |
|---|---|---|---|---|---|---|
| Engagement Manager | Senior | Delivery oversight, client comms | 0.25 FTE | 0.5 FTE | 0.5 FTE | 0.25 FTE |
| Solutions Architect | Senior | Architecture, technical governance | 1.0 | 0.5 | 0.25 | 0.25 |
| Tech Lead / Sr. Engineer | Senior | Hands-on build, code quality | 1.0 | 1.0 | 1.0 | 0.5 |
| Backend Engineer | Mid | Service development | 1.0 | 2.0 | 2.0 | 1.0 |
| Frontend Engineer | Mid | UI/UX implementation | 0.5 | 1.0 | 1.0 | 0.5 |
| Data Engineer | Mid | Pipelines, data lake, ETL | 0.5 | 1.0 | 1.0 | 0.5 |
| ML Engineer | Mid | Model development, MLOps | 0.5 | 1.0 | 1.0 | 0.5 |
| QA / SDET | Mid | Test automation, quality | 0.5 | 1.0 | 1.0 | 0.5 |
| DevOps / SRE | Mid | Infrastructure, CI/CD, observability | 0.5 | 1.0 | 0.5 | 0.5 |
| Security Engineer | Senior | SecOps, compliance review | 0.25 | 0.5 | 0.25 | 0.25 |
| Business Analyst | Mid | Requirements, UAT support | 0.5 | 1.0 | 1.0 | 0.25 |

Adjust FTE allocations based on actual project scope from Phases 3–4.

### 6.2 Team Composition Models

Present three team models to the customer:

**Model A — US Onshore**: Full US-based team. Premium quality, timezone alignment, higher cost.

**Model B — Blended**: US leads + offshore execution. Balanced cost/quality. Standard recommendation.

**Model C — Offshore-Led**: Offshore team with US oversight only. Cost-optimized; suitable for well-defined scope.

### 6.3 Org Chart

Draw the team hierarchy for the recommended model:

```
Client Steering Committee
        │
Engagement Manager (US)
        │
   ┌────┴────────────┐
Solutions Architect  Tech Lead
(US)                 (US/offshore)
   │                  │
  [Support teams]    [Dev teams]
```

See `references/team-rate-guide.md` for role definitions, seniority criteria, and rate benchmarks.

---

## PHASE 7 — Cost Model

Use `assets/costing-template.md` as the calculation worksheet.

### 7.1 Rate Card Application

Apply rates from `references/team-rate-guide.md`. Structure as:

```
Role              | Level  | US Rate/hr | Offshore Rate/hr | Blended Rate/hr
Engagement Mgr    | Senior | $195       | $65              | $130
Solutions Arch    | Senior | $225       | $80              | $155
Tech Lead         | Senior | $200       | $70              | $135
Backend Engineer  | Mid    | $150       | $45              | $95
Frontend Engineer | Mid    | $140       | $40              | $90
Data Engineer     | Mid    | $155       | $50              | $100
ML Engineer       | Mid    | $165       | $55              | $110
QA / SDET         | Mid    | $120       | $35              | $75
DevOps / SRE      | Mid    | $155       | $50              | $100
Security Engineer | Senior | $190       | $70              | $130
Business Analyst  | Mid    | $130       | $40              | $85
```

### 7.2 Effort Estimation

For each phase, calculate:

```
Phase 0 (POC):
  Role × FTE × weeks × hours_per_week = hours
  hours × rate = cost

  Example:
  Solutions Architect: 1.0 FTE × 6 wks × 40 hrs = 240 hrs × $155 = $37,200
  ...
  Phase 0 Subtotal: $[X]
```

Repeat for Phases 1, 2, 3.

### 7.3 Non-Labor Costs

| Category | Estimate | Notes |
|---|---|---|
| Cloud Infrastructure (POC) | $2,000–5,000/mo | Size by architecture |
| Cloud Infrastructure (Prod) | $X,000–Y,000/mo | Estimate from architecture |
| Software Licenses | $X,000 | List tools requiring licenses |
| Third-party APIs | $X,000 | Based on volume estimates |
| Travel & Expenses | 5% of labor | If onsite required |

### 7.4 Cost Summary Table

| Phase | Duration | Labor Cost | Infra/Tools | Total |
|---|---|---|---|---|
| Phase 0 — POC | X wks | $X | $X | **$X** |
| Phase 1 — Foundation | X wks | $X | $X | **$X** |
| Phase 2 — Expansion | X wks | $X | $X | **$X** |
| Phase 3 — Optimization | X wks | $X | $X | **$X** |
| **TOTAL ENGAGEMENT** | **~X months** | **$X** | **$X** | **$X** |

### 7.5 ROI Narrative

Calculate and present:
```
Year 1 Benefits:
  Cost reduction:     $X (manual process automation)
  Revenue uplift:     $X (faster time-to-market, new capabilities)
  Risk avoidance:     $X (compliance penalties avoided)
  Total Year 1:       $X

Engagement Investment: $X
Payback Period:        X months
3-Year ROI:            X%
```

### 7.6 Pricing Options

Present as three tiers:
- **Option 1 — POC Only**: Fixed-price, lowest risk entry point
- **Option 2 — POC + Phase 1**: Phased commitment, most common
- **Option 3 — Full Engagement**: Time & materials or milestone-based, complete roadmap

---

## PHASE 8 — Statement of Work (SOW)

Generate a complete SOW using `assets/sow-template.md`. Populate every section:

### 8.1 SOW Sections (Required)

1. **Parties & Effective Date** — Legal names, addresses, execution date
2. **Background & Purpose** — Problem context (Phase 1.3), why this engagement
3. **Scope of Work** — Detailed description of what will be built/delivered
4. **Deliverables** — Numbered list with acceptance criteria for each
5. **Out of Scope** — Explicit exclusions to prevent scope creep
6. **Timeline & Milestones** — Phase schedule with milestone dates and payment triggers
7. **Team & Responsibilities** — RACI matrix (Responsible / Accountable / Consulted / Informed)
8. **Commercial Terms** — Fees, payment schedule, invoicing cadence
9. **Assumptions** — Carry forward all ASSUMPTIONs from Phase 1.2
10. **Dependencies** — What the customer must provide (access, data, decisions, environments)
11. **Change Management** — Process for scope changes, approval authority, cost impact
12. **Intellectual Property** — Ownership of deliverables, pre-existing IP, licensing
13. **Confidentiality** — Data handling, NDA reference or standalone clause
14. **Warranties & Representations** — Service quality commitments, defect correction period
15. **Limitation of Liability** — Cap language, exclusions
16. **Termination** — Notice period, termination for convenience, for cause
17. **Governing Law & Dispute Resolution** — Jurisdiction, arbitration/litigation preference
18. **Signatures** — Authorized signatories, title, date

### 8.2 RACI Matrix

Build a RACI for the key activities:

| Activity | Vendor PM | Vendor Tech | Client Sponsor | Client IT |
|---|---|---|---|---|
| Architecture approval | C | R | A | I |
| Environment provisioning | I | C | A | R |
| Data access setup | C | I | A | R |
| UAT execution | C | I | R | A |
| Go-live sign-off | C | C | A | R |

### 8.3 Milestone-Payment Schedule

| Milestone | Deliverable | % of Contract | Payment Due |
|---|---|---|---|
| Contract execution | SOW signed | 20% | On signing |
| POC completion | POC demo, success gate met | 15% | On acceptance |
| Phase 1 go-live | MVP in production | 30% | On acceptance |
| Phase 2 complete | All P2 use cases live | 25% | On acceptance |
| Final acceptance | Phase 3, production SLA met | 10% | On acceptance |

---

## FINAL OUTPUT PACKAGE

Deliver the following as a structured set of documents:

```
📁 [Customer Name] — Proposal Package
├── 01_Executive_Summary.md
├── 02_Full_Proposal.md          (Phases 1–5 content)
├── 03_Architecture_Diagrams.md  (Phase 3 diagrams)
├── 04_POC_Blueprint.md          (Phase 4 detail)
├── 05_Team_Plan.md              (Phase 6 org chart + FTE table)
├── 06_Cost_Model.md             (Phase 7 full costing)
└── 07_Statement_of_Work.md      (Phase 8 signed-ready SOW)
```

## CROSS-PHASE PRINCIPLES

**Consistency**: Every assumption, use case ID, cost figure, and role referenced in later phases must trace back to an earlier phase. No orphaned numbers.

**Customer Language**: Use the customer's own terminology from their problem statement wherever possible. Mirror their vocabulary in the proposal and SOW.

**Modular Output**: Each phase produces a standalone document section. The customer can receive outputs incrementally as phases complete.

**Version Control**: Every document starts with `Version 1.0 — Draft` and includes a revision table. Never send a document without a version label.

**Red Flags to Surface Immediately**:
- Budget signal is below $100K for a multi-phase enterprise build → flag mismatch, propose POC-only as entry point
- Timeline demand is unrealistic (e.g., full platform in 4 weeks) → document risk, propose phased delivery
- No data access commitment → make it a blocking dependency in the SOW
- Unclear decision-maker → identify economic buyer before proposal submission

---

## QUICK-START CHECKLIST

Before running the workflow, confirm:

- [ ] Customer problem statement or brief received (text, PDF, call notes)
- [ ] Industry and company name known
- [ ] Budget range known (even ballpark)
- [ ] Target go-live or demo date known
- [ ] Cloud platform preference known (or leave open)
- [ ] Compliance requirements known (HIPAA, SOC2, GDPR, PCI-DSS, none)
- [ ] Customer's existing tech stack known (even partial)
- [ ] Decision-maker and champion identified

**If fewer than 5 items are known**: run Phase 1 only and output a Discovery Questions document before proceeding to Phases 2–8.

**If 5 or more items are known**: run all 8 phases end-to-end and deliver the full proposal package.
