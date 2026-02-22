---
name: proposal-automation
description: "Use this skill when a Client Partner, Account Manager, Sales Engineer, Solutions Engineer, or Solutions Architect needs to transform a raw customer problem statement into a complete, enterprise-grade commercial package. This skill automates the full pre-sales and proposal lifecycle: deep problem analysis, use case identification, competitive analysis and industry benchmarking, enterprise architecture design, autonomous build of a fully functional enterprise-grade POC or MVP (no placeholders, no AI slop — real working code with competitive UI/UX), full proposal document, team structure and resourcing, US and offshore costing with blended rates, and a legally structured Statement of Work. Trigger this skill when any of these roles receives a customer brief, RFP, RFI, discovery call notes, or pain-point description and needs to move quickly to a polished, boardroom-ready proposal backed by a working product demo."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "2.0"
  tags: [sales, pre-sales, proposal, sow, costing, architecture, poc, mvp, build, competitive-analysis, ux, client-partner, account-manager, solutions-engineer, solutions-architect]
  sub-skills: []
---

# Proposal Automation — End-to-End Pre-Sales, Build & Commercial Workflow

Transforms a raw customer problem statement into a complete commercial package **and a fully functional, enterprise-grade POC/MVP** — use cases, competitive analysis, architecture, working code with production UX, proposal, team plan, cost model, and signed-ready SOW.

```
PROBLEM STATEMENT
      │
      ▼
┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐
│ PHASE 1  │─▶│ PHASE 2  │─▶│PHASE 2.5 │─▶│ PHASE 3  │─▶│ PHASE 4  │
│ Problem  │  │ Use Case │  │Competitive│  │Enterprise│  │AUTONOMOUS│
│ Analysis │  │Discovery │  │ Analysis │  │ Arch     │  │BUILD     │
└──────────┘  └──────────┘  └──────────┘  └──────────┘  └──────────┘
                                                               │
      ┌────────────────────────────────────────────────────────┘
      ▼
┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐
│ PHASE 5  │─▶│ PHASE 6  │─▶│ PHASE 7  │─▶│ PHASE 8  │
│ Proposal │  │ Team &   │  │  Cost    │  │   SOW    │
│ Document │  │Resourcing│  │  Model   │  │Generation│
└──────────┘  └──────────┘  └──────────┘  └──────────┘
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

List all assumptions; they carry forward into the SOW.

### 1.3 Problem Statement Summary

Produce a crisp 150-word restatement — the "We understand that…" paragraph used to open the proposal.

---

## PHASE 2 — Use Case Discovery

### 2.1 Use Case Generation

Generate a ranked list of use cases. For each:

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

Plot on a 2×2 (Impact vs Feasibility):
- **P1 — POC Candidates**: High impact + High feasibility → prove value fast
- **P2 — Phase 1 Build**: High impact + Medium feasibility → core product
- **P3 — Phase 2 Build**: Medium impact or feasibility → roadmap
- **P4 — Backlog**: Note but don't scope

### 2.3 Success Metrics

For each P1 and P2 use case, define 2–3 measurable KPIs with baseline, target, and measurement method.

---

## PHASE 2.5 — Competitive Analysis & Industry Benchmarking

**Purpose**: Understand the competitive landscape before designing the architecture or building anything. The POC must be visibly superior to what already exists. Every design decision in Phases 3–4 is informed by this phase.

See `references/competitive-analysis-framework.md` for full research methodology, tooling, and output format.

### 2.5.1 Competitive Landscape Map

Identify 4–8 relevant competitors or comparable solutions (direct, indirect, DIY):

| Competitor | Type | Strengths | Weaknesses | Pricing Signal |
|---|---|---|---|---|
| [Name] | [Direct/Adjacent/DIY] | [Top 2–3] | [Top 2–3] | [Free/$/$$/$$$] |

### 2.5.2 Feature Gap Matrix

Build a matrix: your P1/P2 use cases as rows, top 5 competitors as columns. Mark each cell:
- `✓` competitor has it · `~` partial · `✗` gap · `★` you will do it better

### 2.5.3 Industry Benchmarks

Pull quantified benchmarks for the customer's domain. Example targets by vertical:

| Vertical | Benchmark KPI | Industry Standard | Best-in-Class |
|---|---|---|---|
| FinServ | Loan decisioning time | 3–5 days | < 4 hours |
| Healthcare | Claim processing time | 14 days | < 48 hours |
| Retail | Order fulfillment cycle | 3 days | Same-day |
| Logistics | Exception resolution | 24 hours | < 2 hours |

Replace with actual benchmarks for the customer's vertical (see `references/competitive-analysis-framework.md` §3 for benchmark sources by industry).

### 2.5.4 Differentiation Statement

Write a 3-bullet "We beat the market because…" statement that will anchor the proposal narrative and directly drive Phase 4 build decisions:

```
DIFF-1: [Specific capability] — competitors [do X]; we will [do Y] — visible in the POC
DIFF-2: [UX / speed / accuracy claim] — measurable in the demo
DIFF-3: [Integration / data / AI advantage] — unique to this customer's context
```

---

## PHASE 3 — Enterprise Architecture Design

### 3.1 Architecture Principles

Non-negotiables for every design:
- **Security by Design**: Zero-trust, least-privilege, encryption at rest and in transit
- **Cloud-Native**: Prefer managed services; avoid undifferentiated heavy lifting
- **Event-Driven**: Async where possible; decouple producers from consumers
- **Observable**: Logs, metrics, traces (OpenTelemetry standard)
- **Resilient**: Target 99.9%+ availability; define RTO/RPO upfront
- **Compliant**: Enforce regulatory controls (see Phase 1 constraints)

### 3.2 High-Level Architecture

Design and describe the full architecture:

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

For each external system: integration pattern, data exchanged, frequency/volume, auth method, owner.

### 3.5 Security & Compliance Architecture

Detail IAM (SSO, MFA, RBAC/ABAC), network segmentation, data classification, audit logging, and compliance controls mapping.

See `references/architecture-patterns.md` for industry-specific patterns.

---

## PHASE 4 — Autonomous POC/MVP Build Engine

**Build Mandate**: Produce a fully functional, enterprise-grade working application that a customer CTO can place in front of their engineering team without embarrassment. **Zero placeholders. Zero slop.** Every screen works. Every API returns domain-accurate data. Every business rule executes. The POC visually and functionally beats competitors identified in Phase 2.5.

See `references/build-quality-standards.md` for the complete anti-slop ruleset, code standards, and screen-level requirements.
See `references/ux-design-system.md` for UI component library selection and design system setup.

### 4.1 Pre-Build Gate (All Required Before Writing Code)

- [ ] Competitive differentiation points (Phase 2.5.4) mapped to specific build tasks
- [ ] P1 use cases documented with explicit acceptance criteria (each is a testable statement)
- [ ] Tech stack finalized (Phase 3.3) — no ambiguity
- [ ] Data model drafted: entity names, key fields, relationships, domain-accurate naming
- [ ] API contracts defined: every endpoint has method, path, request schema, response schema
- [ ] UX wireframes agreed for each screen (ASCII diagrams acceptable at minimum)
- [ ] Non-functional targets locked: response time, auth method, deployment target

### 4.2 Repository Structure

```
[project-name]/
├── .github/workflows/        # CI: lint → test → build → docker
├── apps/
│   ├── api/                  # Backend service
│   │   ├── src/
│   │   │   ├── modules/      # Domain modules — named after business domain, not "controller"
│   │   │   ├── middleware/   # Auth, validation, error handling
│   │   │   └── config/       # Environment, feature flags
│   │   ├── tests/            # ≥80% coverage on business logic
│   │   ├── openapi.yaml      # Contract-first: written before handlers
│   │   └── Dockerfile
│   └── web/                  # Frontend
│       ├── src/
│       │   ├── pages/        # Route-level components
│       │   ├── components/   # Reusable UI (from chosen component library)
│       │   ├── hooks/        # Data fetching, state abstractions
│       │   ├── services/     # API client (typed, generated from openapi.yaml)
│       │   └── types/        # TypeScript interfaces — match API contracts exactly
│       └── Dockerfile
├── db/migrations/            # Versioned schema migrations (never ad-hoc ALTER TABLE)
├── infra/terraform/          # Cloud resources as code
├── docker-compose.yml        # Full local stack: API + web + DB + cache
└── README.md                 # `docker-compose up` → working app in ≤5 commands
```

### 4.3 Backend Build Standards

**Contract-First API**:
- Write `openapi.yaml` before any handler code; generate server stubs from it
- Request validation on every endpoint (Zod / Pydantic / Bean Validation)
- Domain-specific field names — never `name`, `data`, `value`; use the actual domain noun
- Business logic lives in the service layer; controllers are thin wiring only
- Structured error responses: `{ "error": { "code": "DOMAIN_SPECIFIC_CODE", "message": "...", "details": {} } }`
- HTTP status codes used correctly (422 for validation, 404 not found, 409 conflict, 201 created)

**Data Layer**:
- Real schema: proper types, constraints (NOT NULL, UNIQUE, FK), indexes on every query column
- Domain-realistic seed data: minimum 15–20 records per core entity, statistically plausible values
- Every state-changing operation records audit trail: who, what, when, previous state
- Versioned migrations: every schema change is a migration file

**Forbidden Patterns** (any of these fails the quality gate):
- `// TODO: implement`, `pass`, `raise NotImplementedError`, `return null` for real paths
- Hardcoded credentials or API keys in source files
- `console.log` debug output left in production paths
- Generic test data: "John Doe", "test@test.com", "12345", "Lorem ipsum"

### 4.4 Frontend Build Standards

**Design System** (select from `references/ux-design-system.md`):
- Use a production component library: shadcn/ui, Ant Design, MUI, Chakra UI, or Radix
- Establish design tokens (color, spacing, typography) in `theme.ts` / `tokens.css` before building screens
- Mobile-responsive from screen 1: CSS Grid / Flexbox; no fixed-width layouts
- WCAG 2.1 AA minimum: semantic HTML, ARIA labels, keyboard navigation

**UX Non-Negotiables**:
- Every form: inline validation, loading state, error state, success feedback
- Every data table: sortable, paginated, empty state with CTA, loading skeleton
- Every async action: visible loading indicator — no frozen UI
- Every error: recovery path visible — no dead ends

**Screens Required for Each P1 Use Case**:
1. **Dashboard**: KPI cards wired to real data — baseline vs. current vs. target from Phase 2.3
2. **Core Workflow**: The primary action screen — what a user does 20× a day
3. **Detail View**: Full record drill-down with all domain attributes and action buttons
4. **List/Search View**: Data table with filters, search, export — minimum 15 seeded records
5. **Configuration Panel**: System settings relevant to the use case

Implement happy path AND the two most common error/edge paths for every screen.

### 4.5 Competitive Advantage — Visible in the Demo

Map Phase 2.5 findings directly to POC features. The demo must visibly show each DIFF-1/2/3:

| Phase 2.5 Finding | Build Response |
|---|---|
| Competitors have slow load times | Instrument and display p95 latency in the UI footer |
| Competitors have no mobile support | Demo the same flow on a 375px viewport |
| Competitors lack real-time updates | Add WebSocket or SSE-based live refresh on the dashboard |
| Competitors have poor UX on main workflow | Invest extra design effort on that specific workflow |
| Competitors have no AI capability | Add one AI-enhanced feature: smart search, prediction, or summarization |

### 4.6 Quality Gates (All Must Pass Before Any Customer Demo)

**Functional**:
- [ ] Every P1 use case acceptance criterion passes end-to-end in the running application
- [ ] Zero console errors during any demo flow
- [ ] Zero 500 errors from API during any demo flow
- [ ] All forms: valid data submits successfully; invalid data shows correct field-level errors

**Code Quality**:
- [ ] Linter passes with zero errors (ESLint / pylint / golint configured as strict)
- [ ] All tests pass: `npm test` / `pytest` / `go test ./...`
- [ ] Business logic test coverage ≥ 80%
- [ ] No secrets in source; `.env.example` documents every required variable

**UX**:
- [ ] All screens render correctly at 1440px (desktop) and 375px (mobile)
- [ ] All interactive elements keyboard-accessible (tab order logical, focus visible)
- [ ] Lighthouse accessibility score ≥ 85 on every primary screen

**Infrastructure**:
- [ ] `docker-compose up` → full working stack within 60 seconds on a clean machine
- [ ] README setup instructions verified by a second person
- [ ] GitHub Actions CI pipeline green: lint → test → build → docker build

### 4.7 Demo Script (15 Minutes)

```
[0:00–2:00]  Context: "Before, the team had to [manual process]. Today..."
[2:00–6:00]  Core workflow: P1 use case happy path — show the actual business operation
[6:00–9:00]  Dashboard: KPI movement from baseline to current demo state
[9:00–12:00] Differentiator: AI feature / real-time update / mobile / speed advantage
[12:00–14:00] Integration: data flowing to/from the customer's existing system
[14:00–15:00] Success gate: "We committed to X. Here is X measured."
```

---

## PHASE 5 — Proposal Document

Structure using `assets/proposal-template.md`.

### 5.1 Executive Summary (1 page)
- Problem restatement (Phase 1.3) · Solution in 3 bullets · ROI headline · Engagement model · CTA

### 5.2 Understanding of Requirements
- Restated problem · Assumption log · Stakeholder map

### 5.3 Proposed Solution
- Solution narrative · Use case coverage table · Architecture overview · Competitive positioning (Phase 2.5.4 DIFF statements) · POC/MVP roadmap

### 5.4 Implementation Roadmap

| Phase | Name | Duration | Key Deliverables | Exit Criteria |
|---|---|---|---|---|
| 0 | POC | 4–8 wks | Working POC, demo, success gate | POC sign-off |
| 1 | Foundation | 8–16 wks | Core platform, P1 use cases | MVP go-live |
| 2 | Expansion | 12–20 wks | P2 use cases, integrations | Feature complete |
| 3 | Optimization | 8–12 wks | Performance, AI/ML, analytics | Production SLA met |

### 5.5 Why Us
- Relevant case studies · Differentiators (Phase 2.5 grounded) · Partnership/certification advantages

### 5.6 Risk Register

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Scope creep | Med | High | Change control in SOW |
| Data access delays | High | High | Blocking dependency in SOW |

### 5.7 Investment Summary
- Cost model from Phase 7 · 3 options · ROI: [avoided cost + revenue enabled] vs. investment

---

## PHASE 6 — Team Structure & Resourcing

### 6.1 Required Roles

| Role | Seniority | Phase 0 | Phase 1 | Phase 2 | Phase 3 |
|---|---|---|---|---|---|
| Engagement Manager | Senior | 0.25 FTE | 0.5 | 0.5 | 0.25 |
| Solutions Architect | Senior | 1.0 | 0.5 | 0.25 | 0.25 |
| Tech Lead | Senior | 1.0 | 1.0 | 1.0 | 0.5 |
| Backend Engineer | Mid | 1.0 | 2.0 | 2.0 | 1.0 |
| Frontend Engineer | Mid | 0.5 | 1.0 | 1.0 | 0.5 |
| Data Engineer | Mid | 0.5 | 1.0 | 1.0 | 0.5 |
| ML / AI Engineer | Mid | 0.5 | 1.0 | 1.0 | 0.5 |
| QA / SDET | Mid | 0.5 | 1.0 | 1.0 | 0.5 |
| DevOps / SRE | Mid | 0.5 | 1.0 | 0.5 | 0.5 |
| Security Engineer | Senior | 0.25 | 0.5 | 0.25 | 0.25 |
| Business Analyst | Mid | 0.5 | 1.0 | 1.0 | 0.25 |

Adjust FTE allocations to actual scope from Phases 3–4.

### 6.2 Team Composition Models

- **Model A — US Onshore**: Premium quality, timezone alignment, highest cost
- **Model B — Blended** *(recommended)*: US leads + offshore execution; balanced cost/quality
- **Model C — Offshore-Led**: US oversight only; cost-optimized; suitable for well-defined scope

### 6.3 Org Chart

```
Client Steering Committee
        │
Engagement Manager (US)
        │
   ┌────┴────────────┐
Solutions Architect  Tech Lead
(US)                 (US/offshore)
```

See `references/team-rate-guide.md` for full role definitions and rate benchmarks.

---

## PHASE 7 — Cost Model

Use `assets/costing-template.md` as the worksheet.

### 7.1 Rate Card

Apply from `references/team-rate-guide.md`:

```
Role              | US Rate/hr | Offshore/hr | Blended (30/70)
Solutions Arch    | $225       | $80         | $123.50
Tech Lead         | $200       | $70         | $109.00
Backend Engineer  | $150       | $45         | $ 76.50
Frontend Engineer | $140       | $40         | $ 70.00
ML Engineer       | $165       | $55         | $ 88.00
DevOps / SRE      | $155       | $50         | $ 81.50
QA / SDET         | $120       | $35         | $ 60.50
Business Analyst  | $130       | $40         | $ 67.00
```

### 7.2 Effort Estimation

`Cost = FTE × weeks × 40 hrs × 0.875 (utilization) × blended rate`

Repeat per role per phase. Add 15% contingency to each phase subtotal.

### 7.3 Non-Labor Costs

| Category | Estimate |
|---|---|
| Cloud Infra (POC) | $2,000–5,000/mo |
| Cloud Infra (Prod) | Sized from Phase 3 architecture |
| Software Licenses | Itemized from Phase 3.3 stack |
| Third-party APIs | Estimated from integration map |
| Travel & Expenses | 5% of labor if onsite required |

### 7.4 Cost Summary

| Phase | Duration | Labor | Infra/Tools | Total |
|---|---|---|---|---|
| Phase 0 — POC | X wks | $X | $X | **$X** |
| Phase 1 — Foundation | X wks | $X | $X | **$X** |
| Phase 2 — Expansion | X wks | $X | $X | **$X** |
| Phase 3 — Optimization | X wks | $X | $X | **$X** |
| **TOTAL** | **~X months** | **$X** | **$X** | **$X** |

### 7.5 ROI & Pricing Options

```
Year 1 Benefits: $X  |  Investment: $X  |  Payback: X months  |  3-yr ROI: X%
```

Options: POC Only (fixed) · POC + Phase 1 · Full Engagement (T&M NTE)

---

## PHASE 8 — Statement of Work (SOW)

Generate using `assets/sow-template.md`. All 21 sections required:

Parties · Background · Scope of Work · Deliverables (with acceptance criteria) · Out of Scope · Timeline & Milestones · Team & RACI · Commercial Terms · Assumptions (from Phase 1.2) · Dependencies · Change Management · IP · Confidentiality · Data Protection · Warranties · Limitation of Liability · Indemnification · Termination · Governing Law · General Provisions · Signatures

### 8.1 Milestone-Payment Schedule

| Milestone | Deliverable | % | Trigger |
|---|---|---|---|
| Contract execution | SOW signed | 20% | On signing |
| POC acceptance | Working POC, success gate met | 15% | On acceptance |
| Phase 1 go-live | MVP in production | 30% | On acceptance |
| Phase 2 complete | P2 use cases live | 25% | On acceptance |
| Final acceptance | Phase 3, SLA met | 10% | On acceptance |

---

## FINAL OUTPUT PACKAGE

```
📁 [Customer Name] — Proposal Package
├── 01_Executive_Summary.md
├── 02_Full_Proposal.md           (Phases 1–5 narrative)
├── 03_Competitive_Analysis.md    (Phase 2.5 full output)
├── 04_Architecture_Diagrams.md   (Phase 3 diagrams)
├── 05_POC_Repository/            (Phase 4 — working code)
│   ├── apps/api/
│   ├── apps/web/
│   ├── db/migrations/
│   ├── docker-compose.yml
│   └── README.md
├── 06_Team_Plan.md               (Phase 6 org chart + FTE table)
├── 07_Cost_Model.md              (Phase 7 full worksheet)
└── 08_Statement_of_Work.md       (Phase 8 signed-ready SOW)
```

---

## CROSS-PHASE PRINCIPLES

**No Slop, Ever**: Every output — document or code — must be production-quality. No `[placeholder]`, no generic filler, no half-implemented functions. If a section requires information not yet known, state the gap explicitly and provide a reasoned estimate.

**Consistency**: Every assumption, use case ID, cost figure, and role referenced in later phases traces back to an earlier phase. No orphaned numbers.

**Competitive Edge is Built In**: Phase 2.5 findings must visibly manifest in Phase 4 — the POC should make the customer think "we cannot get this elsewhere."

**Customer Language**: Mirror the customer's vocabulary throughout. Use their terminology in the proposal and SOW.

**Version Control**: Every document starts `Version 1.0 — Draft` with a revision table.

**Red Flags to Surface Immediately**:
- Budget < $100K for a multi-phase enterprise build → propose POC-only entry
- Timeline demand is unrealistic → document risk, propose phased delivery
- No data access commitment → make it a blocking dependency in SOW
- Unclear decision-maker → identify economic buyer before proposal submission

---

## QUICK-START CHECKLIST

- [ ] Customer problem statement or brief received
- [ ] Industry and company name known
- [ ] Budget range known (even ballpark)
- [ ] Target go-live or demo date known
- [ ] Cloud platform preference known (or leave open)
- [ ] Compliance requirements known
- [ ] Customer's existing tech stack known (even partial)
- [ ] Decision-maker and champion identified

**< 5 items known** → Run Phase 1 only; output a Discovery Questions document.
**≥ 5 items known** → Run all phases end-to-end; deliver the full proposal package including working POC code.
