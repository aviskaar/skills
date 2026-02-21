# Research Frameworks for PM Lead

Quick reference for frameworks used within the `pm-lead` planning cycle. See `pm-ai-research/references/pm-research-frameworks.md` for the full reference guide.

---

## Stage Entry Checklist

Before entering each stage, verify:

### Stage 1 — Stakeholder Intel
- [ ] Stakeholder groups identified and input sources gathered
- [ ] Scope and product area clearly defined (from Stage 0)
- [ ] At least 3 stakeholder groups represented in the input

### Stage 2 — Competitive Research
- [ ] At least 3 direct competitors identified
- [ ] Stakeholder brief from Stage 1 available to guide research focus
- [ ] Data sources available (product pages, changelogs, analyst reports, win/loss notes)

### Stage 3 — Idea Generation
- [ ] Stakeholder brief and competitive report both available
- [ ] Innovation horizon targets set (H1/H2/H3 balance)
- [ ] At least one constraint defined (timeline, tech, team)

### Stage 4 — PRD Writing
- [ ] Approved idea shortlist from Stage 3 gate review
- [ ] Core problem statement is unambiguous
- [ ] At least one measurable success metric defined

### Stage 5 — Roadmap Planning
- [ ] PRD(s) complete and reviewed
- [ ] Engineering capacity data available (or "TBD by engineering" documented)
- [ ] Company OKRs for the planning period available

### Stage 6 — Proposal Writing
- [ ] Proposal audience specified (internal vs. customer-facing)
- [ ] Desired outcome defined (approval, funding, partnership)
- [ ] Customer proposals reviewed for roadmap exposure before finalizing

---

## Evidence Quality Standards

Use these labels consistently throughout all pipeline stages:

| Label | Meaning |
|---|---|
| **Confirmed** | Directly observable from a primary source (product page, official announcement, signed contract) |
| **Reported** | Cited by a credible secondary source (customer quote, analyst report, community discussion) |
| **Inferred** | Logical conclusion from observable signals (job posting patterns, pricing page changes) |
| **Speculative** | Based on reasoning without direct supporting evidence — flag prominently |

Never present Speculative findings as Confirmed. Always surface the evidence label alongside the finding.

---

## Escalation Reference Card

When to pause and alert the PM immediately:

| Stage | Trigger | Action |
|---|---|---|
| Stage 1 | Stakeholder groups contradict each other on a fundamental question | Do not synthesize a false consensus. Surface the contradiction explicitly and pause for PM decision. |
| Stage 2 | Competitor has shipped what we believed to be our differentiated bet | Flag immediately. May require scope change or differentiation pivot before proceeding to ideation. |
| Stage 3 | No high-confidence (score ≥ 10 weighted) ideas emerge | The problem scope may be too narrow or too broad. Pause for PM re-scoping. |
| Stage 4 | PRD goals cannot be made measurable after two revision attempts | The strategy is unclear. Return to Stage 3 or Stage 0 for re-scoping. |
| Stage 5 | All items placed have no measurable success criteria | Roadmap is theater, not strategy. Halt and clarify OKRs. |
| Stage 6 | Customer proposal references features not on approved roadmap | Remove or label clearly as "under exploration." Do not proceed with uncommitted commitments. |

---

## Artifact Handoff Template

At the end of each stage, record the artifact in the Product Intelligence Log:

```
## Artifact: [Artifact Name]
**Stage produced**: [Stage number]
**Date**: [YYYY-MM-DD]
**Status**: Draft | In Review | Approved
**Key findings** (3 bullets max):
  - [Finding 1]
  - [Finding 2]
  - [Finding 3]
**Open questions carried forward**:
  - [Question — Owner]
**Location**: [Link or file reference]
```
