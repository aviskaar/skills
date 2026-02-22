# PM Research Frameworks & Decision Tools

Reference guide for the `pm-ai-research` and `pm-lead` skills. Contains prioritization frameworks, research methodologies, and decision tools used throughout the PM planning pipeline.

---

## 1. Prioritization Frameworks

### 1A — RICE Scoring

**When to use**: When you have reasonable estimates of customer reach and engineering effort.

**Formula**: `(Reach × Impact × Confidence) / Effort`

| Factor | Definition | Measurement |
|---|---|---|
| **Reach** | Number of customers / users impacted per quarter | Count of accounts or users |
| **Impact** | Magnitude of impact per person | 0.25=minimal, 0.5=low, 1=medium, 2=high, 3=massive |
| **Confidence** | Certainty in your Reach and Impact estimates | % (e.g., 80% = 0.8) |
| **Effort** | Total engineering effort in person-months | Sum across all disciplines |

**Interpretation**: Higher RICE = higher priority. Compare items within a planning cycle; do not compare across cycles.

**Pitfall**: Teams inflate Impact scores to justify pet projects. Require evidence for any score above 1.

---

### 1B — Opportunity Scoring (Ulwick)

**When to use**: When you have Jobs-to-Be-Done research and customer satisfaction data.

**Formula**: `Importance + max(Importance − Satisfaction, 0)`

- **Importance**: How important is this outcome to the customer? (survey 1–10)
- **Satisfaction**: How satisfied are customers with current solutions? (survey 1–10)
- Score > 15: Underserved opportunity — strong candidate for investment
- Score 10–15: Competitive battleground — table stakes to maintain
- Score < 10: Overserved — reduce investment

**Pitfall**: Requires actual customer survey data. Do not estimate importance and satisfaction without research.

---

### 1C — Weighted Strategic Stack Rank

**When to use**: When executive alignment and OKR contribution are the primary prioritization drivers.

**Process**:
1. Define strategic pillars and assign weights (must total 100%).
   - Example: Revenue Growth 35%, Customer Retention 30%, Platform Scale 20%, Compliance 15%
2. Score each initiative against each pillar (1–5).
3. Calculate: `Σ (pillar weight × pillar score)` for each initiative.
4. Rank by weighted total.

**Pitfall**: Pillar weights are themselves a strategic choice — get explicit executive alignment on weights before scoring.

---

### 1D — MoSCoW Prioritization

**When to use**: For PRD-level story prioritization within a defined release scope.

| Category | Definition |
|---|---|
| **Must Have** | Non-negotiable. Release cannot ship without this. |
| **Should Have** | Important but not critical. Ship if possible. |
| **Could Have** | Nice to have. Cut first under pressure. |
| **Won't Have** | Explicitly out of scope for this release. |

**Rule**: If everything is "Must Have," the framework isn't being used correctly. Force hard conversations.

---

### 1E — Kano Model

**When to use**: For understanding customer delight vs. dissatisfaction drivers — particularly useful for new feature decisions.

| Category | Description | Strategy |
|---|---|---|
| **Basic** | Expected features. Not having them causes dissatisfaction; having them causes no delight. | Must deliver; not a differentiator. |
| **Performance** | More = better. Linear relationship with satisfaction. | Invest based on competitive benchmark. |
| **Delighter** | Unexpected. Not having them causes no dissatisfaction; having them causes delight. | Differentiators and NPS drivers. |
| **Indifferent** | Customers don't care. | Do not invest. |
| **Reverse** | Having them causes dissatisfaction (feature overload). | Avoid or make optional. |

---

## 2. Research Methodologies

### 2A — Jobs to Be Done (JTBD) Framework

**Core concept**: Customers "hire" products to do a job. The job is stable; the solution is replaceable.

**Job statement format**: "When [situation], I want to [motivation / capability], so I can [desired outcome]."

**Mapping the full job**:
1. Define the main job (the high-level goal the customer is trying to achieve).
2. Map the job steps (the sequence of tasks within the main job).
3. Identify metrics for each step (how the customer measures success at that step).
4. Find underserved steps (high importance, low satisfaction — use Opportunity Scoring).

**Research method**: Customer interviews focused on the chronology of behavior, not opinions. Ask "walk me through the last time you did X" rather than "what features do you want?"

---

### 2B — Win / Loss Analysis

**Purpose**: Understand why deals are won or lost to identify competitive gaps, positioning weaknesses, and product friction.

**Data sources**: CRM deal notes, post-mortem calls with sales reps, direct customer interviews (especially churned accounts), and close-lost surveys.

**Analysis structure**:
| Dimension | Win Drivers | Loss Drivers |
|---|---|---|
| Product capabilities | [what we had that they needed] | [gaps that mattered] |
| Competitive alternatives | [why we were chosen over X] | [why X was chosen over us] |
| Pricing / packaging | [where we won on value] | [where price was a blocker] |
| Sales process | [where we excelled] | [where we fell short] |
| Trust / brand | [what built confidence] | [what created doubt] |

**Rule**: Win/loss analysis conducted only with reps is biased. Always include lost deals where the customer can be interviewed directly.

---

### 2C — Five Whys (Root Cause Analysis)

**When to use**: When a problem is understood at a surface level but the root cause is unclear. Prevents building solutions for symptoms.

**Process**: Ask "why" five times, each time digging one layer deeper.

**Example**:
- Problem: Feature adoption rate is 12%.
- Why? Most users never discover the feature.
- Why? It's buried in a settings panel.
- Why? Settings was the only logical place during initial design.
- Why? We had no research on how users expect to find this feature.
- Why? We skipped user research to hit a launch deadline.
- **Root cause**: Process failure in skipping user research under deadline pressure.

**PRD implication**: Build discoverability research into the PRD process, not as an afterthought.

---

### 2D — Assumption Mapping

**When to use**: Before committing to a roadmap item, map the assumptions the initiative depends on.

**Process**:
1. List every assumption the initiative requires to be true.
2. Plot each on a 2×2: Importance (if wrong, the initiative fails) × Evidence (how well-supported is this assumption today).
3. Focus testing effort on high-importance, low-evidence assumptions.

| Quadrant | Action |
|---|---|
| High importance, low evidence | Validate first before investment |
| High importance, high evidence | Monitor; don't assume this is permanent |
| Low importance, low evidence | Accept risk or deprioritize |
| Low importance, high evidence | Proceed with confidence |

---

### 2E — Analogous Market Research

**When to use**: When generating ideas or validating a bet by looking at adjacent industries.

**Process**:
1. Identify the core job or problem (not the solution).
2. Find industries where this same job exists in a different context.
3. Research what solutions work in that industry and why.
4. Translate the mechanism (not the specific solution) back to your context.

**Examples**:
- Product analytics learning from financial trading dashboards.
- Onboarding flows borrowing from consumer games (progressive disclosure, early wins).
- Enterprise SLA models borrowed from aviation maintenance protocols.
- Data governance structures adopted from healthcare compliance.

**Pitfall**: Do not copy solutions directly — translate the underlying design principle.

---

## 3. Decision Tools

### 3A — Decision Log Template

Use throughout the planning cycle to document key decisions and their rationale.

```
## Decision Log

| Date | Decision | Options Considered | Rationale | Made By | Reversible? |
|---|---|---|---|---|---|
| [date] | [what was decided] | [alternatives] | [why this one] | [name] | Y/N |
```

**Why this matters**: Decisions get relitigated when the rationale isn't recorded. A decision log also catches when circumstances have changed and a decision should be revisited.

---

### 3B — Pre-Mortem Analysis

**When to use**: Before committing to a major initiative. Stress-test the plan by imagining it has failed.

**Process**:
1. Assume it is 12 months from now and the initiative has failed completely.
2. Write down every plausible reason why it failed.
3. For each failure mode, assess: How likely? How severe? Do we have a mitigation?
4. Use the output to strengthen the PRD risk section or reconsider the initiative.

**Why it works**: Pre-mortem bypasses the groupthink and optimism bias that prevent teams from surfacing risks in traditional risk planning.

---

### 3C — Strategy Scorecard

**When to use**: Evaluating multiple strategic options at portfolio level.

| Criterion | Weight | Option A | Option B | Option C |
|---|---|---|---|---|
| Revenue impact | 30% | [1–5] | [1–5] | [1–5] |
| Customer retention impact | 25% | [1–5] | [1–5] | [1–5] |
| Competitive differentiation | 20% | [1–5] | [1–5] | [1–5] |
| Feasibility | 15% | [1–5] | [1–5] | [1–5] |
| Strategic alignment | 10% | [1–5] | [1–5] | [1–5] |
| **Weighted total** | 100% | | | |

**Rule**: Scores must be evidence-based. Require each score to cite a data point or signal.

---

## 4. Continuous Improvement

### After Each Planning Cycle

Capture:
1. **What worked**: Which frameworks produced the most useful outputs?
2. **What didn't**: Which steps added little value or produced inaccurate outputs?
3. **Data gaps**: Which decisions were made on thin evidence? What data collection should be initiated to improve the next cycle?
4. **Cycle time**: How long did each stage take? Where were the bottlenecks?
5. **Forecast accuracy**: For prior cycle items — were the success metrics achieved as predicted?

Use this retrospective to calibrate confidence levels in future cycles.
