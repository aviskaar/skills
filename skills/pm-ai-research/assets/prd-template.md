# PRD Template

Use this template with the `prd-writer` skill or directly when writing a Product Requirements Document. Fill in every section; if a section has nothing to say, write "N/A — [reason]" rather than leaving it blank.

---

```
# [Feature / Initiative Name] — PRD

**Status**: Draft | In Review | Approved
**Version**: 0.1
**Author**: [PM name]
**Date**: [YYYY-MM-DD]
**Target Release**: [Quarter or sprint]
**Stakeholders**:
  - Approvers: [names]
  - Reviewers: [names]
  - Informed: [names]
**Related Docs**:
  - Stakeholder Brief: [link]
  - Competitive Research: [link]
  - Design: [link]
  - Engineering Spike: [link]

---

## 1. Executive Summary

[3–5 sentences. Answer: What are we building? Who is it for? Why now? What does success look like?]

---

## 2. Problem Statement

### Customer Problem
[Describe the problem from the customer's perspective. Include verbatim quotes where available. Quantify where possible.]

**Evidence**:
- Quote: "[customer quote]" — [Source: customer name / segment / ticket ID]
- Data: [metric — e.g., "42% of churned accounts cited X as a primary reason"]

### Business Problem
[Impact on the business of NOT solving this. Include revenue risk, churn risk, win rate impact, or strategic implications.]

**Evidence**:
- [metric or data point]

### Current State vs. Desired State

| User Action / Workflow | Current State | Desired State |
|---|---|---|
| [step 1] | [how it works today] | [how it should work] |
| [step 2] | | |

---

## 3. Goals and Non-Goals

### Goals
- [ ] [Specific, measurable goal with target metric]
- [ ] [Specific, measurable goal with target metric]

### Non-Goals (explicitly out of scope)
- [What we are NOT building and why]
- [What we are NOT building and why]

---

## 4. User Personas

### Persona 1: [Name and Role]
- **Context**: [When and where they encounter this problem]
- **Job to Be Done**: "When [situation], I want to [motivation], so I can [outcome]."
- **Current Workaround**: [How they solve this today without our feature]
- **Success Indicator**: [What this person says or does when the feature works]

### Persona 2: [Name and Role]
[Repeat structure]

---

## 5. User Stories and Acceptance Criteria

### Story 1 — [Story Name]
**As a** [persona], **I want to** [action], **so that** [outcome].
**Priority**: Must Have | Should Have | Nice to Have
**Acceptance Criteria**:
  - Given [context], when [action], then [result].
  - Given [edge case], when [action], then [expected behavior].
**Out of Scope for this story**: [explicit exclusions]

### Story 2 — [Story Name]
[Repeat structure]

**MVP Definition**: Stories marked "Must Have" constitute the minimum viable product.

---

## 6. Functional Requirements

All requirements must be testable and unambiguous.

| ID | Requirement | Priority | Story Ref |
|---|---|---|---|
| FR-001 | The system shall... | Must | Story 1 |
| FR-002 | The system shall... | Should | Story 2 |

---

## 7. Non-Functional Requirements

| Category | Requirement | Measurement Method |
|---|---|---|
| Performance | [e.g., P99 API response < 200ms] | [Load test spec] |
| Scalability | [e.g., support 50k concurrent sessions] | [Test approach] |
| Security | [e.g., PII must not appear in logs] | [Audit criteria] |
| Accessibility | [e.g., WCAG 2.1 AA] | [Tool: axe, Lighthouse] |
| Availability | [e.g., 99.9% uptime SLA] | [Monitoring alert] |
| Data Retention | [e.g., user data retained per region policy] | [Compliance ref] |

---

## 8. Dependencies and Risks

### Dependencies
| Dependency | Team / System | Status | Mitigation if Delayed |
|---|---|---|---|
| [e.g., Auth service v2 API] | Platform | In progress | Use v1 with adapter |

### Risks
| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| [e.g., ML model accuracy below threshold] | Medium | High | Fallback to rule-based system |

---

## 9. Success Metrics

| Metric | Baseline | Target (30d) | Target (90d) | Measurement |
|---|---|---|---|---|
| [e.g., Feature adoption rate] | [0%] | [30%] | [60%] | [Analytics event name] |
| [Counter-metric] | [current] | [must not decrease] | [must not decrease] | [source] |

---

## 10. Open Questions

| Question | Owner | Due Date | Status |
|---|---|---|---|
| [Unresolved decision] | [Name] | [date] | Open |

---

## 11. Appendix

### A. Competitive Context
[Summary or link to competitive research]

### B. Research Data
[Summary or link to stakeholder brief, customer research]

### C. Design Explorations
[Links to Figma, prototypes, design explorations]

### D. Technical Spike Outputs
[Engineering findings, feasibility notes]

### E. Rejected Approaches
| Approach | Considered | Why Rejected |
|---|---|---|
| [Alternative 1] | [date] | [reason] |
```
