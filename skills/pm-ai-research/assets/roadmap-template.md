# Roadmap Templates

Two formats: **Now/Next/Later** (rolling horizon) and **Quarterly** (calendar-based). Use `roadmap-planner` skill to populate these templates. Choose the format most appropriate for your audience.

---

## Format A — Now / Next / Later (Rolling Horizon)

Best for: Internal engineering and design teams. Avoids locking customers or executives into fixed-date commitments.

```
# Product Roadmap — [Product Name]
**Format**: Now / Next / Later
**Version**: v0.1
**Last Updated**: [YYYY-MM-DD]
**Audience**: Internal — Engineering & Design
**Owner**: [PM name]
**Feedback**: [how to submit feedback or questions]

---

## Strategic Context
[2–3 sentences: What market moment is this roadmap responding to? What does winning look like this year?]

## OKR Alignment
| Company OKR | Roadmap Theme | Key Initiatives |
|---|---|---|
| [OKR 1] | [theme] | [item names] |
| [OKR 2] | [theme] | [item names] |

---

## NOW — Current Quarter (Q[X] [YYYY])
Items in active development or committed for delivery this quarter. High confidence.

| # | Initiative | Type | Size | DRI | Success Metric | Confidence |
|---|---|---|---|---|---|---|
| 1 | [name] | Feature / Infra / Research | S/M/L | [owner] | [metric] | High |
| 2 | | | | | | |

**Committed dependencies this quarter**:
- [dependency name] — owned by [team] — status [on track / at risk]

---

## NEXT — Next 1–2 Quarters (Q[X+1] – Q[X+2])
Prioritized and scoped, not yet started. Medium confidence. Subject to revision based on learnings from NOW.

| # | Initiative | Type | Size | Key Assumption | Confidence |
|---|---|---|---|---|---|
| 1 | [name] | | | [what must be true for this to ship as planned] | Medium |
| 2 | | | | | |

**Items that could pull forward into NOW if capacity opens**:
- [item name]

**Items that could shift to LATER if priorities change**:
- [item name]

---

## LATER — Strategic Horizon (3+ Quarters Out)
Long-horizon bets and initiatives not yet scoped. Low confidence. Directional only. These are not commitments.

| # | Initiative | Type | Horizon | Strategic Bet | Evidence | Confidence |
|---|---|---|---|---|---|---|
| 1 | [name] | | H2/H3 | [one sentence] | [signals] | Speculative |
| 2 | | | | | | |

---

## Trade-Off Log
Items we considered and explicitly chose NOT to do in this cycle, with rationale.

| Item | Considered For | Deprioritized Because | Conditions to Reconsider |
|---|---|---|---|
| [name] | NOW | [evidence-based reason] | [trigger that would move it up] |

---

## Roadmap Risks
| Risk | Impact | Mitigation |
|---|---|---|
| [e.g., dependency on Platform team API] | High | Weekly sync with Platform lead; fallback plan defined |

## Revision Triggers
Conditions that should prompt a roadmap review meeting:
- [ ] Competitor ships [capability]
- [ ] Win rate for [segment] drops below [X]%
- [ ] [Key customer] churns or signals dissatisfaction
- [ ] OKR [X] is off track at midpoint review
```

---

## Format B — Quarterly Roadmap (Calendar-Based)

Best for: Executive reviews, board presentations, investor updates. Shows dates and themes but avoids feature-level commitments in outer quarters.

```
# Product Roadmap — [Product Name]
**Format**: Quarterly
**Version**: v0.1
**Last Updated**: [YYYY-MM-DD]
**Period**: [YYYY] — Full Year
**Audience**: [Executive / Board / Investors]
**Owner**: [PM name]

---

## One-Line Vision
[Single sentence: What will this product be at the end of this year that it is not today?]

## Strategic Priorities This Year
1. [Priority 1]
2. [Priority 2]
3. [Priority 3]

---

## Q1 [YYYY] — [Quarter Theme]
Focus: [One sentence on the quarter's primary objective]
OKR link: [which OKR this quarter primarily advances]

| Initiative | Outcome | Customer Segment | Confidence |
|---|---|---|---|
| [name] | [measurable outcome, not feature name] | [ICP] | High |

**Key milestone**: [What defines Q1 success?]

---

## Q2 [YYYY] — [Quarter Theme]
Focus: [One sentence]
OKR link: [OKR]

| Initiative | Outcome | Customer Segment | Confidence |
|---|---|---|---|
| [name] | [outcome] | [ICP] | High / Medium |

**Key milestone**: [What defines Q2 success?]

---

## Q3 [YYYY] — [Quarter Theme]
Focus: [One sentence — more thematic, less feature-specific]
OKR link: [OKR]

| Theme | Description | Customer Value | Confidence |
|---|---|---|---|
| [theme name] | [description] | [value delivered] | Medium |

**Conditions that could shift Q3**: [list of dependencies or assumptions]

---

## Q4 [YYYY] — [Quarter Theme]
Focus: [Strategic horizon — directional only]
OKR link: [OKR]

| Theme | Strategic Bet | Evidence | Confidence |
|---|---|---|---|
| [theme name] | [bet] | [signals] | Low / Speculative |

**Note**: Q4 plans are directional. Specific Q4 initiatives will be defined at Q3 planning.

---

## Portfolio Summary (All Products)
For multi-product roadmaps:

| Product Area | Q1 Theme | Q2 Theme | Q3 Theme | Q4 Theme |
|---|---|---|---|---|
| [Product A] | | | | |
| [Product B] | | | | |

## Shared Platform Investments
Capabilities being built that benefit multiple product areas:

| Investment | Benefiting Products | Quarter | Owner |
|---|---|---|---|
| [e.g., Unified Data Model] | Product A, B, C | Q2 | Platform |

---

## GTM Launch Calendar
| Launch | Product Area | Quarter | Segment | Launch Type |
|---|---|---|---|---|
| [name] | | Q[X] | [ICP] | GA / Beta / Early Access |

---

## Assumptions and Revision Conditions
This roadmap assumes:
- [Engineering capacity assumption]
- [Market or competitive assumption]
- [Dependency assumption]

Roadmap will be reviewed if any of the following occur:
- [Trigger 1]
- [Trigger 2]
```

---

## Format C — Customer / GTM Roadmap (External)

Best for: Strategic account conversations, customer advisory boards, partner briefings. Feature-outcome framing only, no engineering detail, no uncommitted capabilities.

```
# [Product Name] — What's Coming
**Prepared for**: [Customer or CAB audience]
**Date**: [YYYY-MM-DD]
**Confidential**: For discussion purposes only. Not a commitment to deliver.

---

## Our Direction
[2–3 sentences on product vision and the customer problems we're solving this year]

---

## Recently Delivered
| Capability | What it means for you | Available |
|---|---|---|
| [name] | [customer outcome] | [date / now] |

---

## Coming Soon
(Next 1–2 quarters — planned and in development)

| Capability | What it means for you | Timing |
|---|---|---|
| [name] | [outcome customers will experience] | Q[X] [YYYY] |

---

## On the Horizon
(Planning stage — not yet committed. We want your input.)

| Theme | Problem we're solving | Your interest? |
|---|---|---|
| [theme] | [customer pain] | [Y/N/Tell us more] |

---

## We Want Your Input
[List 2–3 open questions where customer feedback will shape roadmap direction]

1. [Question]
2. [Question]

**Contact**: [PM name and email for roadmap feedback]

---

*Note: This document represents our current planning direction and does not constitute a commitment to deliver specific features by specific dates. Product plans may change based on customer feedback, technical feasibility, and market conditions.*
```
