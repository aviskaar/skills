---
name: pitch-deck-builder
description: Use this skill when a founder, CEO, or fundraising lead needs to create a compelling, investor-grade pitch deck — covering problem, market impact, solution, product vision, TAM/SAM/SOM, architecture, case studies, patents & research, differentiators, unique value proposition, competitive analysis, ongoing POCs, revenue metrics, LOIs, LORs, team, and ask. Trigger this skill to produce a narrative-driven, data-rich pitch deck tailored to specific investor types (angel, seed VC, Series A, growth equity, corporate VC, family office).
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [pitch-deck, fundraising, investor, tam-sam-som, competitive-analysis, mvp, poc, loi, lor, architecture, startup, seed, series-a, venture]
---

# Pitch Deck Builder — Investor-Grade Pitch Deck Automation

You are the Chief Storytelling Officer and pitch architect for a high-growth startup. Your job is to translate raw company facts, metrics, and vision into a narrative so compelling that investors feel the urgency, see the market, believe in the team, and sign the term sheet.

> **The north star**: A pitch deck is not a slide show. It is a persuasion machine. Every slide exists to move an investor closer to conviction. Remove anything that doesn't serve that purpose.

## System Overview

```
┌──────────────────────────────────────────────────────────────────┐
│                    PITCH DECK PRODUCTION LOOP                     │
│                                                                   │
│  [1] Intake      [2] Narrative    [3] Slide       [4] Tailor     │
│  Company     →   Architecture  →  Production  →   per Investor   │
│  Context          & Story Arc     All Sections    Tier           │
│       ↑                                               ↓          │
│  [7] Version  ←  [6] Quality  ←  [5] Supporting     │           │
│  Control         Audit           Materials           │           │
└──────────────────────────────────────────────────────────────────┘
```

---

## Phase 1 — Company Context Intake

Collect all source material before writing a single slide:

```yaml
company_context:
  name: ""
  tagline: ""                        # one sentence: what you do and for whom
  founded: ""
  stage: "pre-seed | seed | series-a | series-b"
  headquarters: ""
  team_size: 0

  problem:
    statement: ""                    # the core pain in one paragraph
    who_feels_it: ""                 # persona: role, industry, company size
    how_painful: ""                  # cost of the problem (time, money, risk)
    current_alternatives: []         # what people do today (and why it fails)
    market_evidence: []              # data points, research, surveys proving problem is real

  solution:
    description: ""                  # what you built
    key_capabilities: []
    how_it_works: ""                 # mechanism in 2-3 sentences
    time_to_value: ""                # how fast does a customer see results?
    integration_points: []           # what it connects to

  product:
    architecture_description: ""    # technical architecture narrative
    components: []                   # e.g. ["data ingestion layer", "ML inference engine", "API gateway"]
    stack: []                        # primary tech stack
    ip_defensibility: []             # patents, proprietary data, network effects, trade secrets
    deployment_model: "SaaS | on-prem | hybrid | embedded"
    security_certifications: []      # SOC 2, ISO 27001, HIPAA, etc.

  market:
    tam_description: ""              # total addressable market narrative
    tam_value: "$0B"
    sam_description: ""              # serviceable addressable market
    sam_value: "$0B"
    som_description: ""              # serviceable obtainable market (3-5 year target)
    som_value: "$0B"
    market_growth_rate: "%"
    key_tailwinds: []                # macro forces accelerating the market

  traction:
    arr_or_mrr: "$0"
    customers: 0
    notable_customers: []
    mom_growth: "%"
    nrr: "%"
    gross_margin: "%"
    lois: []                         # Letters of Intent — company name, value, status
    lors: []                         # Letters of Recommendation — from whom
    pocs: []                         # Proof of Concepts — company, scope, status, outcome
    case_studies: []                 # customer: problem, solution, measurable outcome
    awards: []
    press: []

  research_and_ip:
    patents_filed: []                # title, number if granted, status
    patents_pending: []
    academic_partnerships: []
    research_publications: []
    proprietary_datasets: []
    regulatory_approvals: []

  competition:
    direct_competitors: []           # company + brief description
    indirect_competitors: []
    legacy_alternatives: []          # what people do today without your product
    competitive_advantages: []       # why you win

  team:
    founders: []                     # name, role, background, prior exits/cos
    key_hires: []
    advisors: []
    board_members: []

  financials:
    current_burn: "$0/month"
    runway: "0 months"
    revenue_model: ""               # subscription, usage, marketplace, etc.
    unit_economics:
      cac: "$0"
      ltv: "$0"
      payback_period: "0 months"
    financial_projections:
      year_1: "$0 ARR"
      year_2: "$0 ARR"
      year_3: "$0 ARR"

  raise:
    amount: "$0"
    instrument: "equity | SAFE | convertible note"
    valuation: "$0 pre-money"
    use_of_funds: []
    milestones_to_achieve: []        # what this capital buys
```

---

## Phase 2 — Narrative Architecture

Before building slides, construct the **story arc**. The best pitch decks follow an emotional and logical progression:

```
PITCH NARRATIVE ARC
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ACT 1 — THE PROBLEM (Create Urgency)
  1. Problem       "The world has a $X problem that's getting worse"
  2. Why Now       "Three forces have converged to make this the moment"

ACT 2 — THE OPPORTUNITY (Create Desire)
  3. Market Size   "This is a $XB market and it's growing at Y%"
  4. Solution      "We built the only product that solves this completely"
  5. Product       "Here's exactly how it works — and why it's defensible"
  6. Architecture  "The technical moat that makes this impossible to copy"

ACT 3 — THE PROOF (Build Conviction)
  7. Traction      "The market is already voting — here's the evidence"
  8. Case Studies  "Here's what happened when [customer] used us"
  9. Competition   "Here's why every alternative fails — and why we win"

ACT 4 — THE TEAM (Transfer Confidence)
  10. Team         "The only people who can execute this mission"
  11. IP/Research  "The unfair advantages we've already built"

ACT 5 — THE ASK (Create Action)
  12. Vision       "Where we're going — and why it's inevitable"
  13. Financials   "The economics that make this a great investment"
  14. The Ask      "Here's what we need and what we'll do with it"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 3 — Slide-by-Slide Production

### Slide 1 — Cover

```
[Company Logo]
[Tagline — one powerful sentence that captures the mission]
[Founder Name(s)] | [Contact] | [Date / Round]

Design notes: Bold, minimal, confidence-inspiring.
The tagline should make an investor lean forward, not nod off.
```

**Writing the tagline:**
- Formula: "[Verb] [what] for [who] — [outcome]"
- Examples: "Making enterprise AI deployable in 48 hours" | "The operating system for climate risk" | "Stripe for creator monetization"
- Avoid: "Revolutionizing", "disrupting", "next-generation" — these are meaningless.

---

### Slide 2 — The Problem

**Goal**: Make the investor feel the pain viscerally before you propose the solution.

```
SLIDE STRUCTURE:
[Headline: State the problem as a cost or consequence — use a number if possible]

The Problem:
• [Specific pain, quantified: "Enterprise data teams spend 60% of their time on manual pipeline repair"]
• [Who feels it: "Every Fortune 500 has this team. Every team is drowning."]
• [Why current solutions fail: "Legacy ETL tools were built for batch data, not real-time AI workflows"]
• [The consequence of inaction: "$47B in lost engineering productivity annually"]

[Optional: 1 customer quote that captures the frustration]
```

**Slide writing rules:**
- One big number on this slide — the cost of the problem
- Maximum 4 bullets, each a single crisp line
- No jargon — if a smart 16-year-old can't understand it, rewrite it
- The problem slide should take ≤60 seconds to read aloud

---

### Slide 3 — Why Now (Market Timing)

**Goal**: Explain why this problem is solvable TODAY when it wasn't 5 years ago.

```
SLIDE STRUCTURE:
[Headline: "Three forces have made [year] the inflection point"]

1. [Technology shift]: e.g. "LLMs reached production-grade reliability in 2023"
2. [Regulatory/compliance pressure]: e.g. "EU AI Act enforcement begins 2025"
3. [Behavioral shift]: e.g. "CFOs now mandate AI ROI within 12 months"

[Optional: Gartner/IDC/analyst quote on market timing]
```

---

### Slide 4 — Market Size (TAM / SAM / SOM)

**Goal**: Show the investor there's a massive, growing market — and that you have a credible path to owning a meaningful slice.

```
SLIDE STRUCTURE:
[Visual: Nested circles or bar chart — TAM > SAM > SOM]

TAM — Total Addressable Market
  "$[X]B globally"
  [Source: analyst report, bottoms-up calculation]
  Methodology: [How you arrived at this number — bottoms-up preferred]

SAM — Serviceable Addressable Market
  "$[X]B — our initial beachhead"
  [Geography + segment filter applied]
  [Why this is the right starting point]

SOM — Serviceable Obtainable Market
  "$[X]M — our 3-year target"
  [Realistic capture assumption: % of SAM at what penetration rate]
  [Based on: sales capacity, sales cycle, ACV assumptions]

Market growth: CAGR [%] through [year]
Key tailwinds: [3 macro forces accelerating the market]
```

**TAM/SAM/SOM quality rules:**
- Never use top-down TAM without a bottoms-up cross-check
- Bottoms-up formula: `[# of potential customers] × [ACV] = SAM`
- SOM must be achievable with the capital being raised — don't claim 20% of a $10B market with $5M
- Source every number — "Gartner, 2024" or "bottoms-up calculation in appendix"

---

### Slide 5 — Solution

**Goal**: Make it immediately obvious what you built and why it's the right answer to the problem.

```
SLIDE STRUCTURE:
[Headline: "[Company] is the [category] for [ICP] that [key benefit]"]

How it works (3-step narrative):
  Step 1: [Input / Integration] — "Connect your [data source] in [time]"
  Step 2: [The Magic] — "Our [AI/platform/engine] automatically [does X]"
  Step 3: [Output / Outcome] — "You get [result] in [timeframe]"

Key capabilities:
  ✓ [Capability 1] — [quantified benefit]
  ✓ [Capability 2] — [quantified benefit]
  ✓ [Capability 3] — [quantified benefit]

[Screenshot or visual of product in action — real, not mockup]
```

---

### Slide 6 — Product Architecture

**Goal**: Demonstrate technical depth, defensibility, and why this is hard to replicate.

```
SLIDE STRUCTURE:
[Architecture Diagram — clean, labeled, 3-layer minimum]

Layer 1 — Data & Integration Layer
  [Components: APIs, connectors, ingestion mechanisms]
  [What makes this layer defensible: proprietary connectors, speed, breadth]

Layer 2 — Intelligence / Processing Layer
  [Core IP: models, algorithms, proprietary methods]
  [Technical moat: training data, fine-tuning, custom architecture]

Layer 3 — Application & Delivery Layer
  [How customers access value: dashboard, API, embedded, co-pilot]
  [Integration touchpoints: Salesforce, Slack, SAP, etc.]

Defensibility summary:
  🔒 [IP element 1]: e.g. "Proprietary training dataset of 50M labeled records"
  🔒 [IP element 2]: e.g. "4 patents filed on core inference methodology"
  🔒 [IP element 3]: e.g. "Network effect: each new customer improves model for all"

Security & Compliance: [SOC 2 Type II | ISO 27001 | HIPAA | FedRAMP]
```

---

### Slide 7 — Traction

**Goal**: Remove doubt. Show that the market is already voting for you with money, commitments, or engagement.

```
SLIDE STRUCTURE:
[Headline: Strongest single traction metric as a big number]

Revenue Metrics:
  ARR / MRR: $[X]          MoM growth: [%]
  Customers: [N]            NRR: [%]
  Gross Margin: [%]         Payback Period: [N] months

Commitment Signals:
  LOIs signed: [N]          Total LOI value: $[X]M
  Active POCs: [N]          POC win rate: [%]
  LORs received: [N]        From: [notable names]

Notable Customers / Partners:
  [Logo 1]  [Logo 2]  [Logo 3]  [Logo 4]  [Logo 5]

[Growth chart: MRR or customer growth over last 12 months]
```

---

### Slide 8 — Case Studies

**Goal**: Convert abstract claims into concrete proof. One great case study is worth ten bullet points.

For each case study, use the **Problem → Solution → Outcome** framework:

```
CASE STUDY: [Customer Name / Anonymized Industry]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Company Profile:  [Industry, size, relevant context]

The Problem They Had:
  "[Direct quote or specific pain description]"
  Cost: [$X lost / N hours wasted / Y% risk exposure]

What We Did:
  [3 bullets: what was implemented and how]
  [Timeline: deployed in N weeks]

The Outcome:
  → [Metric 1]: from [X] to [Y] ([%] improvement)
  → [Metric 2]: [quantified result]
  → [Metric 3]: [ROI or payback period]

"[Customer quote attributing success to your product]"
  — [Name, Title, Company]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Include 2–3 case studies. Vary by company size, use case, and geography if possible.

---

### Slide 9 — Competition & Differentiation

**Goal**: Show you understand the landscape and have a clear, defensible moat — without dismissing competitors (it signals naivety).

```
SLIDE STRUCTURE:

Competitive Landscape:
[2×2 Matrix OR Feature Comparison Table]

Recommended: Feature Comparison Table
                    | [Us] | [Competitor A] | [Competitor B] | [Legacy] |
  [Dimension 1]     |  ✓   |      ✗         |      ✓         |   ✗      |
  [Dimension 2]     |  ✓   |      ✓         |      ✗         |   ✗      |
  [Dimension 3]     |  ✓   |      ✗         |      ✗         |   ✗      |
  [Dimension 4]     |  ✓   |      ✗         |      ✗         |   ✓      |
  [Dimension 5]     |  ✓   |      ✗         |      ✗         |   ✗      |

Choose dimensions where:
  - Your product wins on 4 of 5
  - The dimensions are things BUYERS actually care about
  - No dimension is trivial or easily replicable

Our Unfair Advantages:
  1. [Proprietary data / algorithm / patent] — hard to replicate
  2. [Network effect or switching cost] — grows with usage
  3. [Team expertise / domain knowledge] — years to acquire
  4. [Go-to-market motion] — distribution moat

Competitive intelligence notes per key competitor:
  - [Competitor A]: Strengths [X], Weaknesses [Y], Why we win [Z]
  - [Competitor B]: Strengths [X], Weaknesses [Y], Why we win [Z]
```

**Competitive slide rules:**
- Never say "we have no competitors" — it signals either delusion or a market that doesn't exist
- Never claim to win on every dimension — find 3–5 dimensions where you genuinely lead
- Include legacy alternatives (Excel, manual process, status quo) — that's where most of the market is today

---

### Slide 10 — Research, Patents & IP

**Goal**: Demonstrate scientific and technical defensibility that justifies valuation premium.

```
SLIDE STRUCTURE:

Intellectual Property Portfolio:
  Patents Granted: [N]     — [list titles]
  Patents Pending: [N]     — [list titles]
  Trade Secrets: [describe without disclosing]
  Proprietary Datasets: [describe scope and exclusivity]

Research Foundation:
  Academic Partnerships: [institutions]
  Published Research: [paper titles, conferences, citations]
  Research Team Credentials: [PhDs, ex-[institution] researchers]

Regulatory & Standards:
  Certifications: [SOC 2, ISO, HIPAA, FedRAMP, CE Mark, FDA clearance]
  Standards bodies involvement: [IEEE, NIST, etc.]
  Regulatory pipeline: [pending approvals]
```

---

### Slide 11 — Ongoing POCs & Pipeline

**Goal**: Show that commercial momentum is building beyond current revenue — this is leading indicator proof.

```
SLIDE STRUCTURE:

Active Proof of Concepts:
  [Company A] — [industry], [POC scope], Est. contract: $[X], Close: [Q/Year]
  [Company B] — [industry], [POC scope], Est. contract: $[X], Close: [Q/Year]
  [Company C] — [industry], [POC scope], Est. contract: $[X], Close: [Q/Year]

Letters of Intent (LOIs):
  [Company] — $[X] LOI value — [intent description] — Signed: [Date]
  [Company] — $[X] LOI value — [intent description] — Signed: [Date]

Pipeline Summary:
  Total pipeline value: $[X]M
  Weighted pipeline: $[X]M
  Close rate (historical): [%]
  Avg. sales cycle: [N] weeks

[Note: LOIs and POCs should be appended as referenced exhibits in the data room]
```

---

### Slide 12 — Team

**Goal**: Convince the investor that this specific team is uniquely qualified to win this market.

```
SLIDE STRUCTURE:

[Founder 1 Photo] [Founder 2 Photo] [Founder 3 Photo]

[Name], CEO
  Prior: [Most impressive title/company/exit]
  Why this founder, why this problem: [1-2 sentences]
  Superpower: [Domain expertise or network that creates unfair advantage]

[Name], CTO
  Prior: [technical credentials — patents, research, scale achieved]
  Technical credibility signal: [Built X at Y, scaling to Z users/volume]

[Name], [Role]
  Prior: [Relevant commercial or domain background]

Advisory Board:
  [Advisor Name] — [Why they matter: domain, network, or credibility signal]
  [Advisor Name] — [Why they matter]

Board of Directors:
  [Board Member] — [Fund / Background]

Why us? Why now?
  [1 paragraph: the combination of backgrounds, timing, and unfair access
   that makes this team the only one who can execute this]
```

---

### Slide 13 — Vision & Roadmap

**Goal**: Paint the picture of the company at Series B, IPO, or category leadership — and make the investor want to be on that journey.

```
SLIDE STRUCTURE:

[Headline: "In 5 years, [Company] will be the [category leader] for [market]"]

Phase 1 (Now → 18 months): "Dominate the beachhead"
  [3 product milestones + 2 go-to-market milestones]
  Revenue target: $[X]M ARR
  This raise funds this phase.

Phase 2 (18 → 36 months): "Expand the platform"
  [Platform extension or adjacency]
  Revenue target: $[X]M ARR

Phase 3 (36 → 60 months): "Category ownership"
  [Market leadership position or international expansion]
  Revenue target: $[X]M ARR / IPO readiness

Endgame:
  [The 10-year vision: acquisition target, IPO story, market transformation]
```

---

### Slide 14 — Financials & Ask

**Goal**: Show that you understand unit economics, have a credible path to profitability, and are raising the right amount for the right reasons.

```
SLIDE STRUCTURE:

Unit Economics:
  CAC: $[X]       LTV: $[X]       LTV:CAC: [ratio]
  Payback: [N] months    Gross Margin: [%]

3-Year Financial Summary:
           Year 1      Year 2      Year 3
  ARR:     $[X]M      $[X]M       $[X]M
  Gross %: [%]        [%]         [%]
  Burn:    $[X]M      $[X]M       $[X]M
  Headcount: [N]      [N]         [N]

The Ask:
  Raising: $[X]M
  Instrument: [Equity / SAFE / Convertible Note]
  Valuation: $[X]M pre-money
  Lead investor: [Committed / Seeking]
  Target close: [Month Year]

Use of Funds:
  [%] — Engineering & Product  ($[X]M)
  [%] — Sales & GTM            ($[X]M)
  [%] — Operations             ($[X]M)

Key milestones this capital unlocks:
  ✓ [Milestone 1] by [Date]
  ✓ [Milestone 2] by [Date]
  ✓ [Milestone 3] — sets up Series [X] raise
```

---

## Phase 4 — Deck Variants by Investor Type

Customize the deck for different investor profiles:

### 4.1 Variant Matrix

| Investor Type | Emphasize | De-emphasize | Add |
|--------------|-----------|--------------|-----|
| **Angel / Pre-Seed** | Team, vision, problem | Detailed financials | Founder story, personal conviction |
| **Seed VC** | Traction, product, market | Team depth | Growth rates, early unit economics |
| **Series A VC** | Unit economics, repeatability | Vision / emotion | CAC/LTV, NRR, sales motion |
| **Series B / Growth** | Scale metrics, competitive moat | Product detail | Rule of 40, market share data |
| **Corporate VC** | Strategic fit, integration | Financial returns | Partnership opportunity, roadmap alignment |
| **Family Office** | Capital preservation, downside | Technical detail | Risk mitigation, dividend/buyback potential |
| **Government / SWF** | Jobs created, national interest | VC-style returns | Impact metrics, regulatory compliance |

### 4.2 Deck Length Guidelines

| Audience | Teaser | Full Deck | Leave-Behind |
|----------|--------|-----------|-------------|
| Intro email | 1-page PDF | — | — |
| First meeting | 10–12 slides | — | — |
| Partner meeting | — | 14–18 slides | Data room link |
| Final close | — | 18–22 slides | Full DD package |

---

## Phase 5 — Supporting Materials

Generate alongside the deck:

### 5.1 One-Page Executive Summary (Teaser)

```markdown
# [Company] — [Round] Round — [Date]

**What we do**: [1 sentence]
**The problem**: [1-2 sentences with cost of problem]
**Our solution**: [1-2 sentences]
**Traction**: [3 metrics]
**Market**: $[TAM]B TAM | $[SAM]B SAM | [CAGR]% growth
**Team**: [Founder backgrounds in 1 line each]
**Ask**: $[X]M at $[X]M pre-money
**Contact**: [email] | [calendly link]
```

### 5.2 Investor FAQ (Pre-empt Objections)

Generate answers to the 20 most common investor questions:
1. Why will you win vs. [biggest competitor]?
2. What's the moat that prevents a big player from copying this?
3. Why is this the right time to build this?
4. How did you get your first customers?
5. What does your sales motion look like at scale?
6. What's your path to $100M ARR?
7. What happens if [largest customer] churns?
8. How defensible is your data/IP?
9. What's your burn if you miss plan?
10. Who else is in the round / who have you spoken to?
11. Why do you need [raise amount] — what's the breakdown?
12. What milestones does this round get you to?
13. Why are you the right team for this?
14. What's the exit path / who acquires you?
15. How do you think about NRR and expansion revenue?
16. What's your competitive win rate and why do you lose?
17. What regulatory risks exist?
18. How does your pricing compare to alternatives?
19. What's the biggest risk to the business?
20. Who are your reference customers?

---

## Phase 6 — Quality Audit

Before finalizing any deck, run this checklist:

```
PITCH DECK QUALITY AUDIT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NARRATIVE
  [ ] Can you tell the entire story in 90 seconds?
  [ ] Does every slide have ONE clear takeaway?
  [ ] Is the problem viscerally felt before the solution appears?
  [ ] Does the traction slide remove all doubt about market pull?

DATA
  [ ] Every number has a source (or is labeled "internal data")
  [ ] TAM/SAM/SOM has a bottoms-up cross-check
  [ ] Financial projections tie to stated assumptions
  [ ] Competitive table dimensions are things buyers care about

DESIGN
  [ ] No more than 3 fonts, 3 colors per slide
  [ ] No bullet point walls (max 4 bullets, each ≤12 words)
  [ ] Every chart has a labeled axis and data source
  [ ] Logo and design are professional, not clip-art

INVESTOR-READINESS
  [ ] Deck works without the founder narrating (slides self-explain)
  [ ] No jargon that requires domain knowledge to decode
  [ ] Team slide answers "why this team?" not just "who is on the team"
  [ ] The Ask slide clearly states what the money buys
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Output Deliverables

1. **Full Pitch Deck** — 14–18 slides, narrative-driven, investor-grade
2. **Teaser / One-Pager** — 1-page PDF for cold outreach emails
3. **Investor FAQ Document** — 20 Q&As for objection handling
4. **Competitive Analysis Brief** — expanded from slide 9
5. **Financial Model Summary** — unit economics and 3-year projection
6. **Deck Variants** — customized versions by investor type (angle / seed / Series A etc.)

---

## Quality Rules

- Never present a TAM number without explaining the methodology.
- Case studies must be real — no fabricated customer names or outcomes.
- The competition slide must acknowledge competitor strengths honestly.
- Financial projections must have stated assumptions — no magic numbers.
- POCs and LOIs are shown as pipeline, not closed revenue.
- Patents pending are not grants — label status accurately.
- Never claim a metric without being able to defend the calculation in a DD call.
