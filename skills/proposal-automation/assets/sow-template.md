# STATEMENT OF WORK

---

**Document Control**

| Field | Value |
|---|---|
| Document Title | Statement of Work — [Project Name] |
| Version | 1.0 — Draft |
| Prepared By | [Your Name / Company] |
| Prepared For | [Customer Legal Name] |
| Date | [YYYY-MM-DD] |
| Status | Draft / Under Review / Executed |

**Revision History**

| Version | Date | Author | Changes |
|---|---|---|---|
| 1.0 | [Date] | [Author] | Initial draft |

---

## 1. PARTIES & EFFECTIVE DATE

This Statement of Work ("SOW") is entered into as of **[Effective Date]** ("Effective Date") by and between:

**Service Provider**: [Your Company Legal Name], a [State] [corporation / LLC] with its principal place of business at [Address] ("Provider" or "[Short Name]")

**Client**: [Customer Legal Name], a [State] [corporation / LLC] with its principal place of business at [Address] ("Client" or "[Short Name]")

This SOW is incorporated into and governed by the Master Services Agreement ("MSA") dated [MSA Date] between the parties, or in the absence of an MSA, the terms herein shall govern.

---

## 2. BACKGROUND & PURPOSE

### 2.1 Background

[Insert customer context — 2–3 sentences describing the customer's business and the environment in which this engagement arises. Use the Phase 1.3 "We understand that…" paragraph here.]

### 2.2 Purpose

The purpose of this engagement is to [state the high-level objective]. Provider will deliver the services described herein to enable Client to [primary business outcome from Phase 2.3].

---

## 3. SCOPE OF WORK

### 3.1 Engagement Overview

This engagement is structured in the following phases:

| Phase | Name | Duration | Description |
|---|---|---|---|
| 0 | Proof of Concept (POC) | [X] weeks | [Brief description] |
| 1 | Foundation Build | [X] weeks | [Brief description] |
| 2 | Expansion | [X] weeks | [Brief description] |
| 3 | Optimization & Handover | [X] weeks | [Brief description] |

### 3.2 Detailed Scope — Phase 0: Proof of Concept

Provider will:
- [ ] [Specific activity 1]
- [ ] [Specific activity 2]
- [ ] [Specific activity 3]
- [ ] [Specific activity 4]

**POC Success Criteria**: [Measurable pass/fail criteria for POC acceptance]

### 3.3 Detailed Scope — Phase 1: Foundation Build

Provider will design, develop, and deploy:

**Platform Infrastructure**:
- [ ] [Infrastructure component 1 — e.g., "Cloud environment setup on AWS with VPC, subnets, and IAM roles"]
- [ ] [Infrastructure component 2]

**Core Application Services**:
- [ ] [Service/feature 1 — e.g., "User authentication and authorization module (SSO + RBAC)"]
- [ ] [Service/feature 2]
- [ ] [Service/feature 3]

**Data Layer**:
- [ ] [Data component 1]
- [ ] [Data component 2]

**Integrations**:
- [ ] [Integration 1 — e.g., "REST API integration with Salesforce CRM"]
- [ ] [Integration 2]

### 3.4 Detailed Scope — Phase 2: Expansion

Provider will extend the platform with:
- [ ] [Feature/use case 1]
- [ ] [Feature/use case 2]
- [ ] [Feature/use case 3]

### 3.5 Detailed Scope — Phase 3: Optimization & Handover

Provider will:
- [ ] Performance tuning and load testing to meet SLA targets
- [ ] Security hardening and penetration test remediation
- [ ] Observability and alerting configuration
- [ ] Documentation (architecture, runbooks, user guides)
- [ ] Knowledge transfer and training sessions ([X] sessions × [Y] hours)
- [ ] Production go-live support ([X] weeks hypercare)

---

## 4. DELIVERABLES

The following deliverables will be produced. Each deliverable requires written acceptance from Client's designated approver within [10] business days of delivery. Silence after [10] business days constitutes acceptance.

| # | Deliverable | Phase | Format | Acceptance Criteria |
|---|---|---|---|---|
| D-01 | Architecture Design Document | 0 | PDF / Markdown | Client technical lead sign-off |
| D-02 | POC Working Demo | 0 | Live demo + code repository | POC success gate met |
| D-03 | Infrastructure as Code (IaC) | 1 | Terraform / CloudFormation repo | Peer review passed, env deployed |
| D-04 | Core Application — Release 1 | 1 | Deployed application + test report | UAT passed; defect rate < 2 critical |
| D-05 | Integration Specifications | 1 | OpenAPI spec + integration test suite | All integration tests green |
| D-06 | Core Application — Release 2 | 2 | Deployed application + test report | UAT passed; defect rate < 2 critical |
| D-07 | Performance Test Report | 3 | PDF report | SLA targets demonstrated under load |
| D-08 | Security Assessment & Remediation | 3 | Pen test report + fix confirmation | No critical/high findings open |
| D-09 | Architecture & Runbook Documentation | 3 | Confluence / Markdown | Client review complete |
| D-10 | Training Materials & Sessions | 3 | Slides + recordings + wiki | [X] sessions delivered, attendance confirmed |
| D-11 | Final Handover & Project Closure | 3 | Closure report | Client sign-off on acceptance form |

---

## 5. OUT OF SCOPE

The following are explicitly excluded from this engagement. Any items below require a signed Change Order before work can commence:

- [ ] Migration of legacy data unless specifically described in Section 3
- [ ] Mobile application development (iOS / Android native apps)
- [ ] Ongoing managed services or production support beyond the hypercare period
- [ ] Third-party software procurement, licensing, or negotiation
- [ ] Regulatory certification or compliance audit execution (Provider will support; Client is responsible for certification)
- [ ] Hardware procurement
- [ ] End-user training beyond the sessions defined in D-10
- [ ] [Any other explicit exclusion relevant to the engagement]

---

## 6. TIMELINE & MILESTONES

### 6.1 Indicative Schedule

| Milestone | Description | Target Date | Payment Trigger |
|---|---|---|---|
| M-0 | Contract execution | [Date] | 20% of contract value |
| M-1 | POC completion and acceptance (D-01, D-02) | [Date] | 15% of contract value |
| M-2 | Phase 1 go-live acceptance (D-03, D-04, D-05) | [Date] | 30% of contract value |
| M-3 | Phase 2 acceptance (D-06) | [Date] | 25% of contract value |
| M-4 | Final acceptance (D-07 through D-11) | [Date] | 10% of contract value |

### 6.2 Schedule Assumptions

The timeline above assumes:
- Client provides all required access, environments, and data within [5] business days of request
- Client reviews and approves deliverables within [10] business days of submission
- Key decisions are made within [3] business days of being presented for approval
- No material changes to scope are introduced after Phase 0 completion

Any Client-caused delay will extend the schedule by an equivalent number of business days without penalty to Provider.

---

## 7. TEAM & RESPONSIBILITIES

### 7.1 Provider Team

| Role | Name / Placeholder | FTE Allocation | Responsibility |
|---|---|---|---|
| Engagement Manager | [Name] | [X]% | Overall delivery, client comms, risk |
| Solutions Architect | [Name] | [X]% | Technical governance, architecture |
| Tech Lead | [Name] | [X]% | Engineering leadership, code quality |
| [Role] | [Name] | [X]% | [Responsibility] |

### 7.2 Client Team (Required)

Client shall provide the following personnel or equivalents. Failure to provide will be treated as a dependency delay:

| Role | Responsibility | Time Commitment |
|---|---|---|
| Executive Sponsor | Strategic decisions, escalation authority | [X] hrs/month |
| Project Owner / Champion | Day-to-day liaison, requirements decisions | [X] hrs/week |
| IT/Technical Lead | Infrastructure access, technical approvals | [X] hrs/week |
| Business SME(s) | Requirements validation, UAT, sign-off | [X] hrs/week |
| Data / Systems Owner | Data access, API credentials, system access | [X] hrs/week |

### 7.3 RACI Matrix

R = Responsible | A = Accountable | C = Consulted | I = Informed

| Activity | Provider PM | Provider Tech | Client Sponsor | Client Tech |
|---|---|---|---|---|
| Architecture design | C | R | I | A |
| Architecture approval | C | C | A | R |
| Environment provisioning | I | C | A | R |
| Data access & credentials | C | I | A | R |
| Sprint planning | R | C | I | I |
| UAT test case execution | C | I | R | A |
| UAT sign-off | C | I | A | R |
| Go-live approval | C | C | A | R |
| Defect triage & prioritization | R | C | A | I |
| Change order approval | A | I | R | I |

---

## 8. COMMERCIAL TERMS

### 8.1 Fees

Total fees for this engagement are as follows:

| Phase | Basis | Amount (USD) |
|---|---|---|
| Phase 0 — POC | Fixed price | $[X] |
| Phase 1 — Foundation | Fixed price / T&M* | $[X] |
| Phase 2 — Expansion | Fixed price / T&M* | $[X] |
| Phase 3 — Optimization | Fixed price / T&M* | $[X] |
| **Total Engagement** | | **$[X]** |

*If Time & Materials: Not to exceed $[X] per phase without a signed Change Order.

Non-labor costs (infrastructure, licenses, third-party services) are billed at cost plus [0–10]% and require pre-approval for items exceeding $[threshold] per month.

### 8.2 Payment Schedule

| Invoice Event | Amount | Net Terms |
|---|---|---|
| Contract execution | $[X] (20%) | Due on signing |
| M-1 — POC acceptance | $[X] (15%) | Net [30] days |
| M-2 — Phase 1 acceptance | $[X] (30%) | Net [30] days |
| M-3 — Phase 2 acceptance | $[X] (25%) | Net [30] days |
| M-4 — Final acceptance | $[X] (10%) | Net [30] days |

Late payments accrue interest at [1.5]% per month (18% per annum) after the due date.

### 8.3 Expenses

Reasonable pre-approved travel and out-of-pocket expenses will be billed at cost. Provider will obtain written approval for any single expense exceeding $[500]. Travel will comply with Client's travel policy if provided in writing.

---

## 9. ASSUMPTIONS

The following assumptions underpin this SOW. If any assumption proves incorrect, the parties will negotiate in good faith to adjust scope, timeline, and fees accordingly.

| ID | Assumption | Risk if Wrong |
|---|---|---|
| A-001 | [Assumption from Phase 1.2] | [Low / Med / High] |
| A-002 | Client will provide API access to [System X] within [Y] days of kick-off | High |
| A-003 | Existing data is in [format/location] and accessible without legal restrictions | High |
| A-004 | Cloud environment will be provisioned by Client before Phase 1 kick-off | High |
| A-005 | Client's IT team will support firewall/network configuration within [X] business days of request | Med |
| A-006 | Third-party vendor [Name] will provide integration support as needed | Med |

---

## 10. CLIENT DEPENDENCIES

Client must provide the following for Provider to deliver on schedule. These are hard dependencies. Delays in fulfilling dependencies extend Provider's timeline without penalty:

- [ ] **Access & Credentials**: Admin access to relevant cloud accounts, systems, and APIs by [Date]
- [ ] **Data Access**: Sample/production data (anonymized if PII) available for integration testing by Phase 1 kick-off
- [ ] **Environment**: [Dev / Staging / Prod] cloud environments provisioned or designated by [Date]
- [ ] **SME Availability**: Named business SMEs available for [X] hours/week throughout the engagement
- [ ] **Decision Latency**: Key decisions made within [3] business days of being raised
- [ ] **Tools Access**: Confluence, JIRA (or equivalent), source code repository access granted by kick-off
- [ ] **Review Timelines**: All deliverable reviews completed within [10] business days
- [ ] **Third-Party Coordination**: Client will introduce Provider to [Vendor Name] and facilitate required agreements

---

## 11. CHANGE MANAGEMENT

### 11.1 Change Request Process

Any change to scope, timeline, team, or fees requires a written Change Order ("CO") following this process:

1. Either party submits a Change Request describing the proposed change
2. Provider responds within [5] business days with impact analysis (scope, timeline, cost)
3. Client approves or rejects the CO in writing within [5] business days
4. Work on changed items begins only after both parties sign the CO

### 11.2 Change Order Authority

| Change Type | Client Approver | Provider Approver |
|---|---|---|
| Scope addition < $[25,000] | Project Owner | Engagement Manager |
| Scope addition $[25,000–100,000] | VP/Director level | Practice Director |
| Scope addition > $[100,000] | C-Suite / CFO | CEO / COO |
| Timeline extension (any) | Project Owner | Engagement Manager |

### 11.3 Emergency Changes

If a change is required to prevent material harm to the project, Provider may begin work at risk while the CO is being processed, provided Client provides written (email) acknowledgment of the change and cost impact within [48] hours.

---

## 12. INTELLECTUAL PROPERTY

### 12.1 Client IP

All pre-existing Client IP (data, systems, brand assets, business processes) remains Client's exclusive property. Provider receives a limited, non-exclusive license to use Client IP solely to perform services under this SOW.

### 12.2 Deliverable IP

Upon receipt of full payment for each deliverable, Provider assigns to Client all right, title, and interest in the custom deliverables developed specifically for Client under this SOW ("Work Product"), including all intellectual property rights therein.

### 12.3 Provider Pre-Existing IP & Tooling

Provider retains ownership of:
- Provider's pre-existing frameworks, libraries, tools, methodologies, and know-how ("Provider IP")
- Generic code, accelerators, or components not developed specifically for Client

Provider grants Client a perpetual, non-exclusive, royalty-free license to use Provider IP embedded in the deliverables solely for Client's internal business purposes.

### 12.4 Open Source

Provider may use open-source software components subject to licenses that do not impose copyleft obligations on Client's proprietary code (e.g., MIT, Apache 2.0, BSD). Provider will disclose material open-source dependencies upon request.

---

## 13. CONFIDENTIALITY

Each party agrees to protect the other party's Confidential Information using the same degree of care it uses for its own confidential information (but no less than reasonable care), and not to disclose Confidential Information to third parties without prior written consent.

"Confidential Information" means all non-public information disclosed by one party to the other that is designated as confidential or that reasonably should be understood to be confidential.

Exceptions: information that is (a) publicly known, (b) rightfully received from a third party, (c) independently developed, or (d) required by law or court order to be disclosed (with notice to the other party).

This obligation survives termination for [3] years.

---

## 14. DATA PROTECTION

### 14.1 Data Processing

If Provider processes personal data on behalf of Client, Provider acts as a Data Processor and Client acts as Data Controller. Provider will process personal data only as instructed by Client.

### 14.2 Security Measures

Provider will maintain industry-standard technical and organizational security measures appropriate to the risk, including encryption, access controls, and incident response procedures.

### 14.3 Data Breach Notification

Provider will notify Client without undue delay (and within [72] hours) upon becoming aware of a personal data breach involving Client's data.

### 14.4 Sub-processors

Provider may engage sub-processors (cloud providers, tools) to deliver services, provided they are bound by equivalent data protection obligations. Key sub-processors: [List AWS / Azure / GCP as applicable].

---

## 15. WARRANTIES & REPRESENTATIONS

### 15.1 Provider Warranties

Provider warrants that:
- Services will be performed in a professional and workmanlike manner consistent with industry standards
- Deliverables will substantially conform to the specifications in this SOW
- Provider has the right and authority to enter this SOW and grant the IP rights herein
- Services will be performed in compliance with applicable laws

### 15.2 Defect Correction Period

For [90] days following final acceptance of each deliverable, Provider will correct material defects (defects that prevent the deliverable from performing its intended function) at no additional charge. This warranty does not cover defects caused by Client modifications, misuse, or third-party components.

---

## 16. LIMITATION OF LIABILITY

### 16.1 Limitation

Each party's total aggregate liability to the other party for all claims arising from or related to this SOW, whether in contract, tort, or otherwise, shall not exceed the total fees paid by Client to Provider in the [12] months preceding the claim.

### 16.2 Exclusions

Neither party shall be liable for indirect, incidental, special, consequential, punitive, or exemplary damages, including loss of revenue, profits, business, or data, even if advised of the possibility of such damages.

### 16.3 Exceptions

The limitations above do not apply to: (a) death or personal injury caused by negligence, (b) fraud or willful misconduct, (c) IP indemnification obligations, or (d) breach of confidentiality obligations.

---

## 17. INDEMNIFICATION

Each party ("Indemnitor") agrees to defend, indemnify, and hold harmless the other party ("Indemnitee") from third-party claims arising from Indemnitor's: (a) gross negligence or willful misconduct, (b) infringement of third-party intellectual property rights by Indemnitor's pre-existing IP, or (c) breach of data protection obligations.

---

## 18. TERMINATION

### 18.1 Termination for Convenience

Either party may terminate this SOW with [30] days' written notice. Upon termination, Client will pay for all work completed and accepted prior to the termination effective date, plus reasonable wind-down costs.

### 18.2 Termination for Cause

Either party may terminate this SOW immediately upon written notice if the other party: (a) commits a material breach and fails to cure within [15] business days of written notice, or (b) becomes insolvent or files for bankruptcy.

### 18.3 Effect of Termination

Upon termination, Provider will deliver all work-in-progress and completed deliverables to Client. Client will provide final payment for accepted deliverables within [30] days.

---

## 19. GOVERNING LAW & DISPUTE RESOLUTION

### 19.1 Governing Law

This SOW is governed by the laws of the State of [State], without regard to conflict-of-law principles.

### 19.2 Dispute Resolution

The parties will attempt to resolve disputes through good-faith negotiation for [30] days. If unresolved, disputes will be submitted to binding arbitration under [AAA / JAMS] Commercial Arbitration Rules in [City, State]. The prevailing party in arbitration is entitled to recover reasonable attorneys' fees.

---

## 20. GENERAL PROVISIONS

- **Entire Agreement**: This SOW, together with any MSA, constitutes the entire agreement between the parties regarding its subject matter.
- **Amendment**: This SOW may only be amended by a written document signed by authorized representatives of both parties.
- **Severability**: If any provision is found unenforceable, the remaining provisions continue in full force.
- **Waiver**: Failure to enforce any right is not a waiver of that right.
- **Force Majeure**: Neither party is liable for delays caused by circumstances beyond their reasonable control (natural disasters, government actions, pandemics), provided the affected party gives prompt written notice.
- **Notices**: Notices must be in writing and sent to the addresses below, effective on receipt.
- **Counterparts**: This SOW may be executed in counterparts, including electronic signatures (DocuSign / Adobe Sign), each of which is an original.

---

## 21. SIGNATURES

By signing below, the parties agree to the terms of this Statement of Work.

**SERVICE PROVIDER — [Provider Company Name]**

Signature: ___________________________

Printed Name: ________________________

Title: _______________________________

Date: ________________________________

Address: _____________________________

Email: _______________________________

---

**CLIENT — [Client Company Name]**

Signature: ___________________________

Printed Name: ________________________

Title: _______________________________

Date: ________________________________

Address: _____________________________

Email: _______________________________

---

*This document was prepared in confidence for [Client Name] by [Provider Name]. Version 1.0 — Draft.*
