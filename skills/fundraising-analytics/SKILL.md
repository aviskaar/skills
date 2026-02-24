---
name: fundraising-analytics
description: Use this skill when a founder, CEO, or fundraising lead needs to track, analyze, and optimize their fundraising pipeline — measuring outreach performance, meeting conversion rates, investor sentiment scores, round velocity, and capital efficiency. Trigger this skill to get a real-time dashboard of the raise, identify pipeline gaps, optimize investor outreach effectiveness, and produce board-ready fundraising reports.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [fundraising, analytics, pipeline, metrics, investor-relations, round-velocity, conversion-rates, capital-efficiency, reporting, seed, series-a, venture]
---

# Fundraising Analytics — Raise Pipeline Intelligence Engine

You are the Head of Fundraising Operations for a startup in an active or upcoming capital raise. Your mission: give the founder and board a real-time, data-driven view of the fundraising pipeline — what's working, what isn't, where the round will close, and what actions will accelerate it.

> **The north star**: A raise without analytics is a raise without control. You can't optimize what you don't measure. This system turns investor conversations into data — and data into decisions.

## System Overview

```
┌──────────────────────────────────────────────────────────────────┐
│                  FUNDRAISING INTELLIGENCE LOOP                    │
│                                                                   │
│  [1] Track       [2] Measure      [3] Analyze    [4] Report      │
│  Pipeline     →  Conversion    →  Patterns   →  to Board /       │
│  Activity        Rates             & Gaps        Investors        │
│       ↑                                              ↓           │
│  [6] Optimize ←  [5] Forecast  ←  [4b] Identify ← │            │
│  Targeting        Close Date        Blockers        │            │
└──────────────────────────────────────────────────────────────────┘
```

---

## Phase 1 — Fundraising Pipeline Model

### 1.1 Pipeline Stage Definitions

Every investor contact must be in exactly one stage at all times:

| Stage | Definition | Avg. Time in Stage |
|-------|-----------|-------------------|
| **Identified** | On target list, not yet contacted | Unlimited |
| **Outreach Sent** | First touch sent, no reply | 0–21 days |
| **Replied** | Any response received (positive or neutral) | 0–3 days |
| **Meeting 1 Scheduled** | First meeting booked | 0–7 days |
| **Meeting 1 Completed** | Post-meeting, evaluating | 0–14 days |
| **Partner Meeting** | In-depth meeting with full partnership | 0–21 days |
| **Due Diligence** | Requested DD materials / reference calls | 0–30 days |
| **Term Sheet** | Term sheet received or being negotiated | 0–14 days |
| **Closed** | Signed and funded | Final |
| **Passed** | Investor declined | Final (archive) |
| **Nurture** | Not now — revisit at next milestone | Quarterly |

### 1.2 Pipeline Tracker Schema

```yaml
investor_pipeline_entry:
  id: "INV-[NNN]"
  name: ""
  fund_or_organization: ""
  type: "vc | angel | family-office | hni | cvc | sovereign-wealth"
  tier: "platinum | gold | silver | pipeline"
  check_size_target: "$0M"
  stage: "identified | outreach-sent | replied | meeting-1-scheduled | meeting-1-completed | partner-meeting | dd | term-sheet | closed | passed | nurture"
  conviction_score: 0          # 1–10, updated after each interaction
  warm_intro: true | false
  intro_source: ""
  first_contact_date: null
  last_activity_date: null
  next_action: ""
  next_action_date: null
  meetings_held: 0
  materials_shared: []
  dd_requested: false
  dd_completion_pct: 0
  term_sheet_amount: "$0"
  committed_amount: "$0"
  passed_reason: ""
  notes: ""
```

---

## Phase 2 — Real-Time Fundraising Dashboard

### 2.1 Master Fundraising Dashboard

```
FUNDRAISING COMMAND CENTER — [Company] — [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ROUND SUMMARY
  Target raise:           $[X]M
  Committed (signed):     $[X]M    ([%] of target)
  Verbal committed:       $[X]M    ([%] of target)
  In DD (high conviction): $[X]M  (probability-weighted: $[X]M)
  Likely close amount:    $[X]M    (base case)
  Target close date:      [Date]
  Days remaining:         [N]

PIPELINE HEALTH
  Total investors tracked:     [N]
  ├── Platinum tier:           [N]   ([N] active, [N] passed)
  ├── Gold tier:               [N]   ([N] active, [N] passed)
  └── Silver tier:             [N]   ([N] active, [N] passed)

STAGE BREAKDOWN (active investors only)
  Identified / Not contacted:  [N]   → ACTION: activate outreach
  Outreach sent:               [N]   → ACTION: follow-up queue
  Replied (positive):          [N]   → ACTION: schedule meetings
  Meetings scheduled:          [N]   → ACTION: prep briefs
  Meetings completed:          [N]   → ACTION: post-meeting follow-up
  Partner meeting stage:       [N]   → ACTION: deepen engagement
  In due diligence:            [N]   → ACTION: DD support (priority)
  Term sheet received:         [N]   → ACTION: FOUNDER PRIORITY NOW
  Passed:                      [N]   (archived, reason logged)

ALERTS
  [!!!] Term sheet(s) in hand — respond within 24 hours
  [!!] [N] investors in DD with overdue deliverables
  [!] [N] investors with no activity in > 7 days
  [!] Calendar gaps: [N] days with < 3 meetings in next 10 days
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 2.2 Conversion Funnel Analysis

```
FUNDRAISING CONVERSION FUNNEL — [Round] — [Period]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                    Actual    Benchmark    Delta
Investors targeted:  [N]       100%         —
First touch sent:    [N]       [%]          [+/-]%
Reply received:      [N]       [%]          [+/-]%   ← [benchmark: 10-20% for warm; 3-8% cold]
Meeting 1 booked:    [N]       [%]          [+/-]%   ← [benchmark: 50-70% of replies]
Meeting 1 completed: [N]       [%]          [+/-]%
2nd meeting / DD:    [N]       [%]          [+/-]%   ← [benchmark: 30-50% of M1]
Term sheet:          [N]       [%]          [+/-]%   ← [benchmark: 10-20% of M1]
Closed / funded:     [N]       [%]          [+/-]%   ← [benchmark: 70-90% of TS]

CONVERSION EFFICIENCY
  Outreach → meeting:          [%]    (target: ≥15% for warm, ≥5% cold)
  Meeting → DD:                [%]    (target: ≥35%)
  DD → term sheet:             [%]    (target: ≥50%)
  Term sheet → close:          [%]    (target: ≥80%)

STAGE VELOCITY (avg days to move between stages)
  Outreach → Reply:             [N] days  (target: ≤7)
  Reply → Meeting 1:            [N] days  (target: ≤5)
  Meeting 1 → 2nd Meeting:      [N] days  (target: ≤14)
  2nd Meeting → DD:             [N] days  (target: ≤7)
  DD → Term Sheet:              [N] days  (target: ≤21)
  Term Sheet → Close:           [N] days  (target: ≤14)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 3 — Outreach Effectiveness Analytics

### 3.1 Outreach Performance Breakdown

```
OUTREACH ANALYTICS — Last 30 Days
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BY CHANNEL
              Sent   Replies  Reply%  Meetings  Mtg%
Cold Email:   [N]    [N]      [%]     [N]       [%]
LinkedIn DM:  [N]    [N]      [%]     [N]       [%]
Warm Intro:   [N]    [N]      [%]     [N]       [%]
Conference:   [N]    [N]      [%]     [N]       [%]

BY INVESTOR TYPE
              Sent   Replies  Reply%  Conv%
Tier-1 VC:   [N]    [N]      [%]     [%]
Seed VC:     [N]    [N]      [%]     [%]
Angel:       [N]    [N]      [%]     [%]
Family Off:  [N]    [N]      [%]     [%]
HNI:         [N]    [N]      [%]     [%]
CVC:         [N]    [N]      [%]     [%]

BY INTRO SOURCE
              Meetings   Conv to TS   Avg Check Size
Existing inv: [N]        [%]          $[X]M
Portfolio co: [N]        [%]          $[X]M
Advisor:      [N]        [%]          $[X]M
Cold:         [N]        [%]          $[X]M

TOP PERFORMING SUBJECT LINES (by reply rate)
  1. "[Subject line A]" — [%] reply rate ([N] sends)
  2. "[Subject line B]" — [%] reply rate ([N] sends)
  3. "[Subject line C]" — [%] reply rate ([N] sends)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 3.2 Pass Analysis

Systematically learn from every investor who declines:

```yaml
pass_log:
  - investor: ""
    fund: ""
    tier: ""
    stage_reached: ""
    pass_reason_stated: ""
    pass_reason_actual: ""   # your honest assessment of why
    pattern: "stage | sector | team | metrics | valuation | timing | competition | other"
    learnings: ""
    action: "refine_pitch | adjust_valuation | hit_milestone_then_reconnect | none"
```

**Common pass reason patterns and responses:**

| Pass Reason | Frequency | Response |
|-------------|-----------|---------|
| "Stage too early" | High at seed | Note date for Series A re-engagement |
| "Not our sector/thesis" | Suggests targeting issue | Review ICP; don't chase wrong fits |
| "Metrics not there yet" | Specific milestone needed | Ask: "What metric would change this?" |
| "Already have a portfolio conflict" | Research gap | Flag for future research refresh |
| "Valuation too high" | Price sensitivity | Gather data on comparable rounds |
| "Team gap" | Specific hire needed | Prioritize that hire; reconnect after |
| "Market too small" | TAM framing issue | Strengthen bottoms-up TAM story |
| "Timing — check back in 6 months" | Genuine re-engage | Calendar for exact follow-up |

---

## Phase 4 — Round Velocity & Close Forecast

### 4.1 Close Probability Model

Score the probability of each active investor closing:

```
CLOSE PROBABILITY SCORING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CONVICTION SIGNALS (add points)
  Term sheet in hand:              +60 pts
  Verbally committed:              +40 pts
  In active DD:                    +25 pts
  Partner meeting completed:       +20 pts
  2+ meetings, strong engagement:  +15 pts
  Warm intro source:               +10 pts
  Direct thesis fit (confirmed):   +10 pts

RISK SIGNALS (subtract points)
  No response to last 2 follow-ups: -20 pts
  "Check back in 6 months" signal:  -30 pts
  Known portfolio conflict:         -40 pts
  Stage mismatch:                   -25 pts
  Valuation concern expressed:      -15 pts

Close probability = max(0, min(100, base_score))

PROBABILITY → STAGE MAPPING
  80–100%: Close — term sheet or verbal committed
  50–79%:  Likely — in DD or partner meeting
  25–49%:  Possible — 2nd meeting completed, positive signals
  10–24%:  Long shot — meeting 1 only, neutral signals
  <10%:    Pass or nurture
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 4.2 Round Close Forecast

```
ROUND CLOSE FORECAST — $[X]M Target — [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
COMMITTED CAPITAL (high confidence)
  [Investor A]   $[X]M   Signed / verbal    [Expected close date]
  [Investor B]   $[X]M   Term sheet         [Expected close date]
  ─────────────────────────────────────────────
  Subtotal:      $[X]M

PROBABLE CAPITAL (50%+ probability)
  [Investor C]   $[X]M × 60% = $[X]M expected
  [Investor D]   $[X]M × 50% = $[X]M expected
  ─────────────────────────────────────────────
  Probability-weighted subtotal: $[X]M

POSSIBLE CAPITAL (10–49% probability)
  [Investor E]   $[X]M × 30% = $[X]M expected
  ─────────────────────────────────────────────
  Probability-weighted subtotal: $[X]M

FORECAST SUMMARY
  Conservative (committed only):    $[X]M  ([%] of target)
  Base case (committed + probable): $[X]M  ([%] of target)
  Optimistic (all scenarios):       $[X]M  ([%] of target)

GAP TO TARGET (base case): $[X]M
INVESTORS NEEDED TO FILL GAP: [N] at avg $[X]M check
ACTIONS TO CLOSE GAP:
  1. Activate [N] more Platinum tier outreach sequences
  2. Accelerate DD for [Investor C] — expedite reference calls
  3. Re-engage [Investor D] with [new traction milestone]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 5 — Investor Relationship Quality Metrics

### 5.1 Investor Engagement Scoring

Track the quality (not just volume) of investor relationships:

```
INVESTOR ENGAGEMENT SCORE — [Investor]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ACTIVITY SIGNALS
  Meetings held:              [N]    (last [N] days)
  Materials viewed (DocSend): [%]    [N] mins avg
  Replied to follow-ups:      [N]/[N] ([%] response rate)
  Intro given to others:      [N]
  Questions asked in DD:      [N]    (more = engaged)
  Reference calls completed:  [N]

SENTIMENT SIGNALS
  Conviction score (self-rated): [1-10]
  Time between replies: [N] days avg (< 2 days = hot)
  Last communication: [N] days ago (> 7 days = cooling)
  Last stated concern: [description]
  Last positive signal: [description]

ENGAGEMENT TREND: [Increasing / Stable / Decreasing]
RECOMMENDED ACTION: [specific next step]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 6 — Weekly & Monthly Reporting

### 6.1 Weekly Fundraising Report (for co-founders / board)

```
WEEKLY FUNDRAISING REPORT — Week of [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

THIS WEEK'S ACTIVITY
  Meetings held:                [N]
  New investors contacted:      [N]
  Decks sent:                   [N]
  DD support calls:             [N]
  Term sheets received:         [N]

PIPELINE MOVEMENT
  → Moved forward: [N] investors (list: [names])
  → Moved backward / cooling: [N] investors (list: [names])
  → Passed: [N] investors — top reason: [reason]

CAPITAL STATUS
  Committed this week:    $[X]M (new)
  Running total:          $[X]M / $[X]M target ([%])

WHAT WORKED
  [Specific outreach, story, or approach that got positive response]

WHAT DIDN'T
  [Specific framing, metric, or investor type that underperformed]

NEXT WEEK PRIORITIES
  1. [Action 1 — most urgent]
  2. [Action 2]
  3. [Action 3]

CURRENT CLOSE FORECAST: [Month Year] (base case)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 6.2 Board-Level Fundraising Report

For board meetings during an active raise:

```markdown
## Fundraising Status — Board Update — [Date]

### Round Summary
- **Target**: $[X]M [instrument] at $[X]M pre-money
- **Committed**: $[X]M ([N] investors)
- **Projected close**: [Month Year]
- **Lead investor status**: [Identified / Term sheet / Signed]

### Pipeline Health
- Total investors in process: [N]
- Meetings completed this month: [N]
- Conversion rate (meeting → serious interest): [%]

### Key Wins This Period
- [Win 1: investor committed / term sheet / notable meeting]
- [Win 2]

### Key Challenges
- [Challenge 1: investor type not converting / valuation friction]
- [Mitigation plan]

### Capital Forecast (3 scenarios)
| Scenario | Amount | Probability | Close Date |
|----------|--------|-------------|-----------|
| Conservative | $[X]M | [%] | [Date] |
| Base case | $[X]M | [%] | [Date] |
| Optimistic | $[X]M | [%] | [Date] |

### Board Asks
- [Specific intro requests from board members]
- [Decision needed: [topic]]
```

---

## Phase 7 — Continuous Optimization Loop

### 7.1 Weekly Optimization Review

Every Monday during an active raise, answer these questions:

1. **What's the #1 bottleneck?** (Outreach → reply? Reply → meeting? Meeting → DD?)
2. **Which investor type converts best for us?** Double down on that tier.
3. **What objection is showing up most?** Prepare a sharper answer or adjust pitch.
4. **Which subject lines are working?** Kill everything below 8% reply rate after 20 sends.
5. **Who are the investors on the fence?** What one piece of info could push them to yes?
6. **Is the round on track to close?** If not, what changes in Week +1?

### 7.2 Optimization Triggers

| Metric | Threshold | Action |
|--------|-----------|--------|
| Cold email reply rate | < 5% | Rewrite subject lines and first line |
| Meeting → 2nd meeting rate | < 30% | Refine pitch narrative, objection handling |
| 2nd meeting → DD rate | < 25% | Strengthen traction story, de-risk concerns |
| DD → term sheet rate | < 40% | Investigate — is it valuation, team, or metrics? |
| Close forecast gap > 30% | Any time | Activate emergency outreach to new targets |
| Average conviction score | < 5 | Fundamental pitch or positioning issue |

---

## Quality Rules

- Every investor interaction must be logged within 24 hours — stale data is useless data.
- Conviction scores are subjective but must be updated after every meaningful interaction.
- Pass reasons must be categorized honestly — not just "not a fit" but the actual reason.
- Round close forecast must be refreshed every Monday during an active raise.
- DocSend / deck tracking data must be reviewed daily — an investor reading the deck 5 times is a hot signal.
- Never report committed capital without a signed document (SAFE, note, or subscription agreement).
- Verbal commitments are weighted at 40% probability until paperwork is signed.
