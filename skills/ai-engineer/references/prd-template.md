# PRD Template — Research-to-Product

Use this template when writing `PRD.md` in Stage 2 of the ai-engineer skill. Fill every section; mark sections explicitly as "N/A — [reason]" rather than leaving them blank.

---

## Product Name

`[Product name]`

## Version

`v1.0 — [Date]`

## Authors

| Role | Name |
|------|------|
| AI Engineer | |
| Research Lead | |
| Researcher Team | |

## Status

`Draft / In Review / Approved`

---

## 1. Problem Statement

### 1.1 User Problem

> One paragraph. Written from the user's perspective. No research jargon.

_Example: "Data analysts at biotech firms spend hours manually scanning literature to find relevant protein interaction studies. There is no tool that automatically surfaces the most relevant papers and ranks their findings by relevance to a target protein."_

### 1.2 Research Opportunity

> One paragraph. How does the research paper's contribution directly address this user problem?

### 1.3 Why Now

> Why is this the right moment to build this? (e.g., research is mature enough, compute costs dropped, market timing).

---

## 2. Goals and Success Metrics

### 2.1 Goals

| # | Goal | Category |
|---|------|----------|
| G1 | | User outcome |
| G2 | | Business outcome |
| G3 | | AI/ML quality |
| G4 | | Technical |

### 2.2 Success Metrics (MVP)

| Metric | Definition | Target | How Measured | Owner |
|--------|-----------|--------|--------------|-------|
| | | | | |

> At least one metric must be tied to the AI/ML component (e.g., "Model precision ≥ X on production traffic, measured by research team evaluation pipeline").

### 2.3 Anti-Goals

Metrics we are explicitly NOT optimizing for in V1:

-

---

## 3. Users and Stakeholders

### 3.1 Primary User

| Attribute | Detail |
|-----------|--------|
| Who | |
| Job-to-be-done | |
| Current solution (workaround) | |
| Key pain with current solution | |

### 3.2 Secondary Users (if any)

### 3.3 Stakeholders

| Role | Name / Team | Interest |
|------|-------------|----------|
| Research Lead | | Model correctness, research fidelity |
| Researcher Team | | Model interface, data requirements |
| Product | | User experience, go-to-market |
| Engineering | | Feasibility, maintainability |

---

## 4. User Stories

Write in the format: `As a [user], I want to [action] so that [outcome].`

Mark each story with a priority: **P0** (MVP required), **P1** (MVP nice-to-have), **P2** (post-MVP).

### Core AI-powered workflow

| ID | Story | Priority | Research Dependency |
|----|-------|----------|-------------------|
| US-01 | As a [user], I want to … | P0 | Model: [name] |
| US-02 | As a [user], I want to … | P0 | |
| US-03 | As a [user], I want to … | P1 | |

### Supporting workflows

| ID | Story | Priority | Research Dependency |
|----|-------|----------|-------------------|
| US-10 | As a [user], I want to … | P0 | |

---

## 5. Feature Set

### 5.1 P0 Features (MVP Required)

| Feature | Description | Acceptance Criteria | Research Dependency |
|---------|-------------|-------------------|-------------------|
| F-01 | | | |
| F-02 | | | |

### 5.2 P1 Features (MVP Nice-to-Have)

| Feature | Description | Notes |
|---------|-------------|-------|
| F-10 | | |

### 5.3 P2 Features (Post-MVP)

| Feature | Description | Notes |
|---------|-------------|-------|
| F-20 | | |

---

## 6. Non-Goals (V1)

Explicitly state what this product will NOT do in V1:

1.
2.
3.

---

## 7. Research Dependencies

Map every product feature or success metric to its research dependency.

| Feature / Metric | Research Dependency | Type | Interface | Status | Owner |
|-----------------|-------------------|------|-----------|--------|-------|
| F-01 | [Model name / paper section] | Model artifact / Dataset / Algorithm / API | REST / gRPC / Python lib | Available / In development / Blocked | [Researcher name] |

> Review this table with the researcher team before finalizing the PRD. All "Blocked" items must have a resolution plan.

---

## 8. Acceptance Criteria

For each P0 feature, define testable criteria:

### F-01 — [Feature name]

- [ ] Given [context], when [action], then [outcome]
- [ ] Given [context], when [action], then [outcome]
- [ ] Model output meets quality threshold: [metric] ≥ [target]

### F-02 — [Feature name]

- [ ]

---

## 9. Technical Constraints

| Constraint | Detail | Source |
|------------|--------|--------|
| Latency | P95 response time ≤ [X]ms for inference | User requirement |
| Privacy | [Data handling requirements, PII policy] | Compliance |
| Cost | Max [X] per 1000 inference requests | Budget |
| Compliance | [HIPAA / GDPR / SOC2 / other] | Legal |
| Platform | Must run on [cloud / on-prem / edge] | IT policy |
| Model size | Max [X]GB GPU memory | Infrastructure |

---

## 10. Open Questions

| # | Question | Owner | Due |
|---|----------|-------|-----|
| Q1 | | | |
| Q2 | | | |

---

## 11. Out of Scope — Explicit Exclusions

Document any specific requests or features that were considered and explicitly deferred:

| Item | Reason Deferred | Revisit When |
|------|----------------|-------------|
| | | |

---

## Appendix

### A. Glossary

| Term | Definition |
|------|-----------|
| | |

### B. Related Documents

- Research paper: [link or title]
- Architecture doc: `ARCHITECTURE.md`
- Research dependencies: `RESEARCH-DEPENDENCIES.md`
- Engineering log: `ENGINEERING-LOG.md`
