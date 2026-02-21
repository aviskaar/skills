---
name: calendar-pipeline
description: Use this skill when an account executive, client partner, sales engineer, or revenue leader at a product-based or consulting company needs to autonomously identify VP/Director/C-suite decision makers, research their pain points, craft hyper-personalized outreach, run multi-touch follow-up sequences, and book meetings — keeping the calendar full with zero manual prospecting effort.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: sales, revenue, outreach, prospecting, calendar, pipeline, AE, account-executive, B2B, enterprise
---

# Calendar Pipeline — Autonomous Revenue Engine

A fully autonomous pipeline that fills your calendar with high-value meetings with VPs, Product Directors, and C-suite executives — so account executives, client partners, and sales engineers can spend 100% of their time in conversations, not in research and chase.

> **The north star**: Your future depends on what your calendar looks like. Eight hours of booked meetings every day. This system makes that the default, not the exception.

## System Overview

The system operates as a closed loop that runs continuously:

```
┌──────────────────────────────────────────────────────────────────┐
│                     REVENUE ENGINE LOOP                          │
│                                                                  │
│  [1] Define ICP    [2] Find Targets   [3] Build Intel            │
│  & Offering    →   VP/Dir/C-Suite  →  Pain + Context            │
│       ↑                                     ↓                    │
│  [7] Optimize  ←  [6] Book Meeting  ←  [4] Craft Outreach       │
│  & Refill          Calendar             [5] Run Sequence         │
└──────────────────────────────────────────────────────────────────┘
```

Each cycle answers: **"Who is the right person to talk to next, what do they care about, and what is the most compelling reason for them to spend 30 minutes with us?"**

---

## Phase 1 — Offering & ICP Definition

Do this once at setup; revisit quarterly or when entering a new market.

### 1.1 Capture the Offering

Collect from the user or CRM:

```yaml
offering:
  company_name: ""
  type: product | consulting | hybrid
  one_liner: ""               # e.g. "We help mid-market fintechs cut data pipeline costs by 40%"
  problems_solved:
    - ""                      # specific, painful, measurable problems
  proof_points:
    - customer: ""
      outcome: ""             # quantified result
  differentiators:
    - ""
  demo_available: true | false
  avg_deal_size: ""
  sales_cycle_length: ""
```

### 1.2 Define the Ideal Customer Profile (ICP)

```yaml
icp:
  company:
    industries: []            # e.g. [fintech, healthtech, SaaS]
    sizes: []                 # e.g. [200-1000 employees, Series B-D]
    geographies: []
    tech_signals: []          # tools/stack they use that indicate fit
    growth_signals: []        # e.g. recent funding, hiring surge, expansion
    pain_triggers: []         # e.g. post-merger integration, compliance deadline
  buyer_personas:
    - title_patterns: []      # e.g. ["VP Engineering", "Head of Product", "CTO"]
      seniority: [VP, Director, C-suite]
      owns_budget: true
      feels_pain: true        # directly affected by the problem you solve
      notes: ""
```

See `references/prospect-research-guide.md` for ICP scoring criteria.

### 1.3 Set Calendar Targets

```yaml
calendar_targets:
  meetings_per_day: 8
  meeting_duration_minutes: 30
  buffer_between_meetings: 15
  weekly_new_prospects_to_contact: 50
  target_meeting_conversion_rate: 0.15   # 15% of sequences → meeting
  channels_priority: [email, linkedin, phone]
```

---

## Phase 2 — Target Discovery

### 2.1 Signal-Based Prospecting

Don't spray and pray. Every prospect must have at least one **buying signal** before outreach. Signals ranked by conversion impact:

| Signal | Conversion Multiplier | Where to Find |
|--------|----------------------|---------------|
| Company just raised funding | 3× | Crunchbase, LinkedIn News |
| New VP/Director hired in last 90 days | 2.5× | LinkedIn, job boards |
| Actively hiring for roles your product replaces | 2.5× | LinkedIn Jobs, Indeed |
| Recent press/earnings mentioning pain you solve | 2× | Google News, 10-K/10-Q |
| Tech stack includes your integration partners | 1.8× | BuiltWith, job postings |
| Company in growth mode (headcount +20% YoY) | 1.5× | LinkedIn Insights |
| Competitor customer (if known) | 1.5× | G2, review sites |

**Research method for each prospect:**
1. Search `"{company name}" + "{pain keyword}" site:linkedin.com OR site:techcrunch.com`
2. Check the prospect's recent LinkedIn activity (posts, comments, likes) for pain signals
3. Read the company's job postings — they reveal internal priorities and tech gaps
4. Scan earnings calls, press releases, or blog posts from the last 90 days

### 2.2 Build the Target List

For each target, populate a prospect record:

```yaml
prospect:
  id: ""
  name: ""
  title: ""
  company: ""
  linkedin_url: ""
  email: ""                   # use enrichment tools or hunter.io pattern
  buying_signals:
    - signal: ""
      source_url: ""
      date_found: ""
  company_context:
    recent_news: ""
    pain_indicators: []
    tech_stack: []
    headcount: ""
    funding_stage: ""
  personalization_hooks:
    - ""                      # specific, concrete detail for first touch
  outreach_status: not_contacted
  sequence_step: 0
  last_contact_date: null
  meeting_booked: false
  notes: ""
```

### 2.3 Prioritization Scoring

Score each prospect before adding to the active outreach queue:

```
Priority Score = (Signal Strength × 40%)
               + (ICP Fit × 35%)
               + (Seniority × 15%)
               + (Reachability × 10%)
```

Only work prospects with score ≥ 70. Below that, move to a nurture list.

---

## Phase 3 — Prospect Intelligence

Before writing a single word of outreach, spend 5 minutes building a **Prospect Intel Brief**. This is what makes the difference between a 2% and a 25% reply rate.

### 3.1 Intel Brief Format

```markdown
## Prospect Intel Brief — [Name], [Title] at [Company]

### Their World Right Now
- What is the company publicly focused on? (product launches, market expansion, cost cutting)
- What did they recently post/comment on LinkedIn?
- What problems do their open job postings signal?

### Why They Personally Feel This Pain
- Does their role own the function your product affects?
- Any direct quotes from their public writing about related challenges?
- How long have they been in this role? (new = change agent; long-tenured = entrenched)

### The Trigger
- What specific event (signal) makes this the RIGHT TIME to reach out?
- What happens if they do nothing in the next 90 days?

### Proof That Should Move Them
- Which customer story (from your proof_points) maps most closely to their situation?
- What outcome will resonate most: cost, speed, risk reduction, or competitive edge?

### Personalization Hook (for first line of outreach)
- One highly specific detail that shows you did not send a template
```

See `references/prospect-research-guide.md` for research workflow.

---

## Phase 4 — Outreach Crafting

### 4.1 The Anatomy of High-Converting Outreach

Every first touch must follow this structure — regardless of channel:

```
[Hook]     — A specific, relevant observation about their world (1-2 sentences)
[Bridge]   — Connect their situation to the problem you solve (1 sentence)
[Proof]    — One concrete result from a similar company (1 sentence)
[Ask]      — A single, low-friction call to action (1 sentence)
```

**Hard rules:**
- No "I hope this email finds you well"
- No feature lists in the first touch
- No attachments or case study links in the first touch — earn the right to send them
- Subject line: under 7 words, no exclamation marks, make it feel like a colleague wrote it
- Total length: under 100 words for email, under 300 characters for LinkedIn DM
- One ask per message — never "let me know if you'd like to chat OR I can send over a case study"

### 4.2 Outreach by Channel

**Email — best for senior buyers who live in inbox:**
- Send Tuesday–Thursday, 7–9am or 4–6pm recipient's timezone
- From a human name, not a role ("Alex Chen", not "Sales Team")
- Plain text format outperforms HTML for cold outreach
- Subject lines that work: a specific question, their company name + number, a relevant observation

**LinkedIn — best for engaging with their content first:**
- Like + comment on their last 2 posts before sending a DM (warms the connection)
- Connection request note: under 250 characters, focus on the trigger, no pitch
- DM only after connection is accepted
- Reference something specific from their profile or posts

**Phone — for hot signals or after 2+ email/LinkedIn touches with no reply:**
- Call between 7:45–8:30am or 4:30–5:30pm — decision-makers are more reachable
- Have a 30-second voicemail script referencing the email thread
- Never call more than twice without a new trigger

See `assets/email-sequences.md` and `assets/linkedin-sequences.md` for templates.

### 4.3 Personalization Depth Tiers

Tier the personalization effort by prospect priority score:

| Priority | Tier | Research Time | Personalization Level |
|----------|------|---------------|-----------------------|
| 90–100 | Platinum | 20 min | Full intel brief + custom content |
| 75–89 | Gold | 10 min | 3+ specific hooks woven through sequence |
| 60–74 | Silver | 5 min | 1 strong hook in first touch, templates after |

---

## Phase 5 — Multi-Touch Sequence Engine

### 5.1 The Core Sequence (No Reply Path)

Execute this cadence for every prospect. Personalization decreases, value increases with each step:

```
Day 1  → Email (first touch, full personalization)
Day 3  → LinkedIn connection request
Day 5  → LinkedIn comment on their recent post
Day 7  → Email follow-up (add one new insight or relevant content)
Day 10 → LinkedIn DM (after connection accepted)
Day 14 → Email (reframe — different angle, different pain)
Day 18 → Phone + voicemail
Day 21 → Final email ("breakup" — create urgency, close the loop)
```

Total sequence: 21 days, 8 touches. If no response after Day 21: move to long-term nurture (quarterly check-in).

### 5.2 Sequence Rules

- **Never send two touches on the same day** (except phone + email same day, max once)
- **Advance the conversation** — each touch must add new information, not just bump the thread
- **Personalization in touch 1 and 2 is non-negotiable.** Touches 3–8 can use light templates.
- **Pause the sequence immediately** if they:
  - Reply (even to unsubscribe — note it and move on gracefully)
  - Book a meeting
  - Get flagged as wrong contact

### 5.3 Reply Handling

| Reply Type | Action |
|------------|--------|
| "Interested, let's talk" | Immediately offer 3 calendar slots, send within 5 min |
| "Not the right person, talk to X" | Thank them, add X to pipeline with referral context |
| "Not right now, check back in Q3" | Add to calendar as a reminder, note specific timing |
| "We have this handled" | Probe: "What are you using?" — use to refine ICP |
| "Remove me" | Immediately suppress from all sequences, note in CRM |

---

## Phase 6 — Meeting Booking

### 6.1 Converting Interest to Booked Time

When a prospect shows interest, the #1 failure point is friction in scheduling. Eliminate it:

1. **Offer 3 specific slots, not a link** (for high-priority prospects):
   > "I have Tuesday at 10am ET, Wednesday at 2pm ET, or Thursday at 9am ET — which works?"
2. **Send a calendar link** (Calendly/Cal.com) as a fallback if they don't pick from slots
3. **Confirm within 5 minutes** of their reply — responsiveness is a first impression
4. **Send a calendar invite with a clear agenda** so they don't cancel

### 6.2 Meeting Confirmation Template

```
Subject: [Your Name] / [Their Name] — [Date] [Time]

Hi [Name],

Confirming our call for [Day, Date] at [Time] [Timezone].

Quick agenda:
1. 5 min: Understand where [Company] is headed on [relevant initiative]
2. 15 min: Show how we helped [similar company] achieve [specific outcome]
3. 10 min: Open Q&A

[Calendar link / dial-in]

Looking forward to it.
[Your name]
```

### 6.3 Pre-Meeting Prep Brief

Generate a 1-page brief before every meeting:

```markdown
## Pre-Meeting Brief — [Name], [Title] at [Company]
**Meeting**: [Date, Time, Duration]

### Their Context
- Company snapshot: [size, stage, recent news]
- Their role: [scope, tenure, likely priorities]
- Known pain: [what research surfaced]

### Our Angle
- Lead with: [most relevant proof point]
- Avoid: [anything that might not resonate — competitor conflicts, etc.]
- Key question to ask: [one open-ended discovery question]

### Success Criteria for This Meeting
- [ ] Understand their top 3 priorities for [relevant function]
- [ ] Identify if there is a live initiative or budget for this problem
- [ ] Get agreement on a follow-up action (demo, pilot, intro to economic buyer)
```

---

## Phase 7 — Pipeline Reporting & Calendar Health

### 7.1 Daily Calendar Health Dashboard

```
CALENDAR HEALTH — [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Meetings booked today:        [N] / 8 target
Meetings this week:           [N] / 40 target
Pipeline coverage:            $[X] (target: 3× quota)

SEQUENCE ACTIVITY (last 7 days)
New prospects contacted:      [N]
Emails sent:                  [N]   Reply rate: [%]
LinkedIn touches:             [N]   Reply rate: [%]
Sequences completed (no reply): [N]
Meetings booked from sequence: [N]  Conversion: [%]

TOP OF FUNNEL HEALTH
Active prospects in sequence: [N]
Due for follow-up today:      [N]
Overdue (no touch in 3+ days): [N]  ← FIX FIRST

CALENDAR GAPS (days with < 8 meetings)
[List dates with gaps and recommended actions]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 7.2 Weekly Optimization Review

Every Monday, answer these questions before starting outreach:

1. **What worked?** Which subject lines, hooks, or angles got the highest reply rate?
2. **What didn't?** Which sequences had zero replies — what did they have in common?
3. **Where are the calendar gaps?** Which days next week are under-booked?
4. **What signals are emerging?** Any industry news, competitor moves, or triggers to exploit?
5. **ICP drift?** Are the meetings you're booking converting to pipeline? If not, revisit the ICP.

Adjust messaging templates based on what worked. Kill anything below 5% reply rate after 50 sends.

### 7.3 Calendar Gap Fill Protocol

When the calendar has gaps for the next 3–5 business days:

1. **Priority 1**: Check if any warm prospects (replied, engaged with content) haven't been followed up.
2. **Priority 2**: Run a "hot signal sweep" — search for new buying signals for prospects already in the pipeline.
3. **Priority 3**: Reach out to past customers or prospects who went dark 90+ days ago with a new trigger.
4. **Priority 4**: Add net-new prospects from the ICP list to fill the active sequence queue.

---

## Phase 8 — Continuous Improvement

### 8.1 A/B Testing Framework

Always have one variable being tested:

```yaml
active_test:
  variable: subject_line | first_line | cta | send_time
  variant_a:
    description: ""
    sends: 0
    replies: 0
  variant_b:
    description: ""
    sends: 0
    replies: 0
  winner_threshold: 50_sends_each_and_p<0.10
```

Test one thing at a time. Never test without a control.

### 8.2 Benchmark Metrics (B2B Enterprise SaaS/Consulting)

| Metric | Below Avg | Good | Exceptional |
|--------|-----------|------|-------------|
| Cold email open rate | < 25% | 35–45% | > 50% |
| Cold email reply rate | < 3% | 6–10% | > 15% |
| LinkedIn acceptance rate | < 15% | 25–35% | > 40% |
| LinkedIn reply rate | < 5% | 10–15% | > 20% |
| Sequence → meeting rate | < 5% | 10–15% | > 20% |
| Meeting → opportunity rate | < 20% | 35–50% | > 60% |

If any metric is below average for 2+ consecutive weeks, pause and redesign before scaling.

---

## Execution Principles

- **Research before you write.** One minute of research prevents ten bad emails. A bad first impression is permanent.
- **Personalization is the product.** A VP gets 50+ cold messages a week. Generic = deleted. Specific = replied.
- **The calendar is the scorecard.** Track booked meetings, not activities. Emails sent mean nothing if no one shows up.
- **One ask per touch.** Never confuse the prospect. One email, one ask, one next step.
- **Speed on reply is non-negotiable.** A prospect who replies is hot. Every hour of delay cuts conversion. Respond within 5 minutes during business hours.
- **Sequences are for volume; personalization is for conversion.** Use sequences to build pipeline. Use personalization to open doors with your top 20 accounts.
- **What your calendar looks like today is the result of the outreach you did 3 weeks ago.** Never stop filling the top of the funnel, even when the calendar looks full.
- **Every "no" is data.** Log why prospects didn't respond. Patterns reveal ICP gaps, messaging flaws, or timing issues.

---

## Quick-Start Checklist

**One-time setup:**
- [ ] Complete the offering definition (Phase 1.1)
- [ ] Define the ICP with at least 3 persona types (Phase 1.2)
- [ ] Set calendar targets and weekly prospecting goals (Phase 1.3)
- [ ] Customize email and LinkedIn templates (assets/)
- [ ] Configure enrichment source for emails (Hunter, Apollo, ZoomInfo, etc.)

**Weekly recurring (every Monday):**
- [ ] Run weekly optimization review (Phase 7.2)
- [ ] Check calendar gaps for the next 2 weeks (Phase 7.3)
- [ ] Add 50+ new prospects to the active sequence queue
- [ ] Review active A/B test and rotate winner if thresholds met

**Daily (every morning):**
- [ ] Check daily calendar health dashboard
- [ ] Execute all due sequence touches for the day
- [ ] Respond to all replies within 5 minutes
- [ ] Review pre-meeting briefs for all meetings today

**Escalate to human only when:**
- [ ] Prospect replies asking for a price/contract (AE takes over)
- [ ] A strategic account (Fortune 500, logo account) replies (dedicated human follow-up)
- [ ] Meeting conversion rate drops below 5% for 3 consecutive weeks (messaging overhaul needed)
