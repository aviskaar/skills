---
name: account-intelligence
description: "Use this skill when a product firm, consulting firm, system integrator, or federal contractor needs to research a target company or government agency and produce an executive-grade Account Intelligence Report as a formatted .docx file. Handles any industry vertical — Life Sciences, Financial Services, Healthcare, Manufacturing, Energy, Retail, Technology, Federal/Government, and more. Fully automates the pursuit research and document generation process. Includes AI Agentic Solutions vision, IP and Research Opportunity mapping, and high-definition charts and visual dashboards."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "2.0"
  tags: [sales-intelligence, account-research, enterprise-sales, consulting, federal, docx-generation, pursuit-strategy, account-planning, ai-agentic, ip-research, data-visualization]
  sub-skills: []
---

# Account Intelligence Report Generator

Produce a complete, senior-partner-ready Account Intelligence Report on any target company or government agency. Output is a formatted `.docx` file with high-definition charts, visual dashboards, AI Agentic Solutions vision, and IP & Research Opportunity mapping — ready for a C-suite meeting. Works for any industry vertical. Works for federal agencies and programs.

---

## INPUTS

### Required
- **TARGET_COMPANY** — Full legal name (e.g., "Dexcom, Inc." or "U.S. Department of Veterans Affairs")
- **YOUR_FIRM** — The pursuing firm's name (e.g., "Cognizant" or "Deloitte")
- **PREPARED_BY** — Your name
- **PREPARED_FOR** — Internal stakeholder or leadership name

### Optional (provide if known; auto-detect otherwise)
- **TICKER** — Exchange and ticker (e.g., "NASDAQ: DXCM"). Use `PRIVATE` for private companies. Use `FEDERAL` for government agencies.
- **FIRM_CREDENTIALS** — 3–5 bullets of your firm's relevant credentials, awards, partnerships, or case studies. If omitted, a placeholder section is written.
- **INDUSTRY_VERTICAL** — One of: Life Sciences (Pharma/Biotech), Life Sciences (Medical Devices), Life Sciences (Genomics/Diagnostics), Financial Services (Banking), Financial Services (Insurance), Retail/Consumer, Manufacturing/Industrial, Energy/Utilities, Technology/Software, Healthcare Providers/Payers, Federal/Government. If omitted, auto-detect from research.

---

## PHASE 0 — VALIDATE INPUTS

Before researching, confirm:

1. TARGET_COMPANY is the full legal name, not an abbreviation or brand name
2. If TICKER is not provided, search for it; note "PRIVATE" or "FEDERAL" as applicable
3. If INDUSTRY_VERTICAL is not provided, determine it in Dimension 1 research and apply the correct playbook from `references/vertical-playbooks.md`

**Federal detection rule:** If TARGET_COMPANY contains any of: "Department of," "Agency," "Administration," "Bureau," "Office of," "Command," "Corps of," "U.S. Army," "U.S. Navy," "U.S. Air Force," "U.S. Marine," "CMS," "HHS," "DHS," "DoD," "VA," "GSA," "NASA," "FAA," "SEC," "IRS" — set TICKER = FEDERAL and use the Federal/Government vertical playbook.

---

## PHASE 1 — RESEARCH THE ACCOUNT

**Conduct all research before writing a single word of the report.** Use multiple targeted web searches. Minimum: 3 searches per dimension, 25 total searches.

Every data point must be classified as one of:
- **Confirmed** — sourced from a press release, official announcement, SEC filing, or job posting naming the specific item
- **Reported** — sourced from reputable trade press or analyst report (cite the publication)
- **[ASSUMPTION — basis]** — estimated, inferred, or unverified — flag inline in orange italic immediately after the value

Never present a guess as a fact. Do not write [ASSUMPTION] for things you have confirmed with a source.

Detailed search query patterns are in `references/research-protocol.md`.

---

### Dimension 1 — Company Profile

**Goal:** Establish the factual foundation for every section of the report.

Search for:
- Full legal name, HQ address, most recent fiscal year revenue, employee count, FY end date
- Core products/services and key customer markets
- Most recent earnings release: revenue growth, guidance, CEO commentary
- Major strategic announcements in the last 12 months (acquisitions, divestitures, cost programs, reorgs)

**Federal adaptation:** Replace revenue with total annual budget/appropriations (search congressional budget justifications). Replace FY end with government fiscal year (Oct 1 – Sep 30). Search USASpending.gov for contracting history.

---

### Dimension 2 — Leadership Mapping

**Goal:** Map every C-suite contact with tenure and background. Tenure determines openness to new vendors.

Search for:
- CIO, CEO, CFO, CHRO, Chief Digital Officer, COO, Chief Data Officer by name
- Month and year each joined this role — leaders under 18 months have open vendor relationships
- Prior 2–3 companies and roles for each — reveals background biases
- Any public quotes about strategic or technology priorities

**Priority contacts for a technology or consulting pursuit:**
1. CIO or CTO (first door)
2. CFO (budget owner, cost programs)
3. CHRO (workforce and HCM systems)
4. Chief Digital Officer or Chief Data Officer (digital transformation)
5. Business Unit Presidents (line-of-business budgets)
6. CEO — later-stage only

**Federal adaptation:** Map to Agency CIO (required by FITARA), Program Executive Officers (PEOs), Senior Contracting Officers, Program Managers. Check the CIO Council directory and the agency's official leadership page.

---

### Dimension 3 — Strategic Priorities

**Goal:** Identify what leadership has publicly committed to — these are the fundable initiatives.

Search for:
- Investor day presentations and strategy decks
- Earnings call transcripts (CEO and CFO commentary)
- Annual report / letter to shareholders
- Cost reduction or transformation program announcements

Capture 3–5 priorities maximum. For each:
- What was publicly committed to (cite the exact source: earnings call date, investor day date, press release date)
- Why it creates a technology or consulting services need
- Which named executive owns it

**Federal adaptation:** Search for NDAA provisions (DoD), IT Modernization Plans, Strategic Plans, and President's Management Agenda priorities. Inspector General reports identify known gaps and mandated improvements — these are funded requirements.

---

### Dimension 4 — Technology Signals

**Goal:** Map the current technology landscape and identify the competitive context (incumbents).

Search for:
- Confirmed ERP, CRM, ITSM, HCM, and cloud platforms
- Any incumbent managed services or outsourcing partner — this defines the competitive threat
- Announced platform migrations or modernization programs
- Technology vendor partnership announcements in the last 24 months

**Federal adaptation:** Search SAM.gov contract awards for the agency. Search FITARA scorecard results. Look for known platform consolidation mandates (Zero Trust Architecture, cloud-first policy, CDM program).

---

### Dimension 5 — Job Posting Intelligence

**Goal:** Open job postings are the most reliable real-time spending signal available publicly.

Search for open roles related to:
- ERP, SAP, Oracle, Salesforce, Workday, ServiceNow (specific platform = active investment)
- Cloud architecture, data engineering, AI/ML (= building capability)
- IT Director, VP Technology, CIO, Program Manager (= open leadership = new vendor decisions)
- Industry-specific roles (see vertical playbooks)

**Signal interpretation:**
| Job Posting Pattern | What It Means |
|---|---|
| "Sr. Director, ERP" | Active ERP program, likely $5M+ budget |
| "Salesforce Administrator (3 openings)" | Salesforce expansion in progress |
| "AWS Solutions Architect — Migration" | Active cloud migration program |
| "Program Manager — IT Modernization" | Funded modernization program, needs SI |
| "Director, Vendor Management" | Evaluating or replacing incumbents |
| "Data Scientist — 5 openings" | Building internal capability; may need platform |

Flag any posting older than 60 days as potentially filled.

**Federal adaptation:** Search USAJobs.gov for agency postings. Search SAM.gov for active RFIs, RFPs, and Sources Sought notices — these are the federal equivalent of job postings with actual budget attached.

---

### Dimension 6 — News and Press Releases

**Goal:** Surface events that create technology or consulting needs.

Search for:
- M&A events (acquisitions = integration opportunity; divestitures = stranded systems)
- Technology vendor partnership announcements
- Regulatory actions (FDA warning letters, OIG findings, SEC enforcement = compliance tech need)
- Leadership appointments (new leaders evaluate their inherited vendors)
- Earnings guidance revisions (cost-cutting = efficiency tech; growth guidance = build-out)

**Federal adaptation:** Search for GAO reports, OIG reports, congressional testimony, and budget hearing transcripts. These are primary sources for federal priorities and funded mandates.

---

### Dimension 7 — Federal Contract Intelligence (Federal targets only)

**Goal:** Map the existing vendor landscape, identify recompetes and white space.

Search for:
- Active contract vehicles (GWAC, BIC, IDIQ, MAC) in use by the agency
- Prime contractors and their task order values on SAM.gov
- Contract expiration dates (within 12–18 months = recompete opportunity)
- Active RFIs and RFPs on SAM.gov
- Task order awards to competitors

This dimension is mandatory for all federal targets. Skip for commercial targets.

---

### Dimension 8 — AI Maturity & Agentic Readiness

**Goal:** Assess the company's current AI posture, active agentic initiatives, and the white space for AI-driven transformation. This informs Section 12 (AI Agentic Solutions Vision) and Section 13 (IP & Research Opportunities).

Search for:
- Any announced AI programs, LLM adoptions, or GenAI initiatives (earnings calls, press releases, investor days)
- AI/ML job postings — volume and seniority signal investment stage (pilot vs. production scaling)
- Research publications, patents, or academic partnerships in AI or data science
- Chief AI Officer, VP of AI, or Head of Data Science — appointed or hiring (= funded AI program)
- AI platform partnerships (Microsoft Azure OpenAI, AWS Bedrock, Google Vertex, Databricks, Snowflake, Palantir)
- Any known agentic workflow deployments (autonomous agents, copilots, RPA + AI, decision automation)
- IP filings: recent patents related to data, ML models, or proprietary algorithms
- R&D spending as % of revenue (from 10-K, earnings call) — higher % = stronger innovation culture
- Academic collaborations, research lab sponsorships, or innovation center announcements

**Signal interpretation:**
| Signal | What It Means |
|---|---|
| Chief AI Officer or VP AI appointed | Funded AI program with executive mandate |
| 10+ AI/ML job postings | Scaling AI capability — building vs. buying |
| Azure OpenAI / AWS Bedrock partnership | Cloud-native GenAI buildout underway |
| GenAI mentioned in earnings call | Board-level priority with budget attached |
| R&D spend > 8% of revenue | Innovation-led culture; open to IP co-development |
| AI mentioned in risk factors (10-K) | Regulatory awareness; governance maturity increasing |
| No AI signals found | Early adopter opportunity; needs foundation before agentic |

**AI Readiness Scoring (score each dimension 1–5):**
- **Data Maturity** — quality, accessibility, governance of core data assets
- **Infrastructure** — cloud readiness, MLOps platform, compute availability
- **Talent** — AI/ML headcount density, data science capability
- **AI Governance** — responsible AI policies, model risk management
- **Agentic Readiness** — workflow automation maturity, API-first architecture, tolerance for autonomous systems

This dimension applies to all targets. Federal agencies: also search for AI Executive Order compliance, AI use case inventories (OMB mandate), and CDO/Chief AI Officer appointments.

---

## PHASE 2 — BUILD THE .DOCX REPORT

After completing all research, generate the report.

### Step 2.1 — Apply the Industry Vertical Playbook

If INDUSTRY_VERTICAL was not provided, determine it from research results.

Load `references/vertical-playbooks.md` and apply the corresponding playbook to:
- Calibrate which technology platforms are likely (confirmed vs. inferred)
- Identify the right opportunity categories for the Opportunity Map
- Set the competitive context (who are the likely incumbents)
- Adjust the outreach strategy tone and hook

### Step 2.2 — Write the Node.js generation script

Use `references/docx-generator.md` as the code scaffold. Write a complete Node.js script (`generate-report.js`) that:

1. Imports `docx` (v8.x) and `fs`
2. Defines all color constants as specified in the Formatting Reference below
3. Defines all helper functions (sectionHeader, dataTable, orgChartBox, assumptionFlag)
4. Defines a `data` object with all research findings populated
5. Builds each of the 11 sections in order
6. Assembles the Document with a cover-page section (no header) and a main section (with headers from page 2)
7. Saves to `/mnt/user-data/outputs/[CompanyName]_Account_Intelligence_[YourFirm].docx`

**Fill every `{{PLACEHOLDER}}` in the data object with researched content.** Do not leave any placeholder unfilled. If a specific data point could not be confirmed, insert the best estimate and flag it `[ASSUMPTION — basis]`.

### Step 2.3 — Install and run

```bash
mkdir -p /mnt/user-data/outputs
npm install docx
node generate-report.js
```

### Step 2.4 — Section order (never reorder)

Generate all 13 sections in this exact sequence:

---

**SECTION 1 — Executive Summary**

3–4 sentences written for a senior partner with 45 seconds. Answer: why this account, why now, what is the single best entry point. Do not list everything — synthesize to the most important insight. No bullet points in this section.

---

**SECTION 2 — Company Snapshot**

Single table with rows:

| Field | Value |
|---|---|
| HQ | [address] |
| Revenue | [most recent FY, with year] |
| Employees | [count] |
| Fiscal Year End | [month] |
| Exchange / Ticker | [e.g., NASDAQ: DXCM or FEDERAL] |
| Core Products | [brief] |
| Key Markets | [brief] |
| Strategic Moment | [one sentence: where is this company right now] |

---

**SECTION 3 — Leadership Hierarchy**

**Part A: Visual Org Chart**

Three-tier colored table:
- Row 1: CEO box — NAVY background
- Row 2: C-Suite boxes — BLUE background (side by side)
- Row 3: Business Unit Presidents / VPs — TEAL background (side by side)

Each box contains:
- Name (bold, white)
- Title (white)
- "Since [Month Year]" (small, MUTED)
- Mark primary pursuit contact with **★**
- Mark leaders under 18 months with **⚡ New**

**Part B: Leadership Table**

| Name / Title | Background (prior 2–3 roles) | Tenure | Why They Matter to This Pursuit |
|---|---|---|---|

**Part C: Analytical Note**

One paragraph assessing leadership stability. Answer: How new is this team? New C-suite = open vendor decisions, relationships not yet locked. Entrenched leadership = incumbent protection required, need a different entry strategy.

---

**SECTION 4 — Strategic Priorities**

3–5 priorities maximum, sourced only from public statements.

For each priority:
- **Priority title** (subsection header)
- What leadership publicly committed to — cite source (earnings call date, investor day, press release date)
- Why it creates a technology or consulting need
- Named executive owner

Do not fabricate priorities. Every priority must have a citation.

---

**SECTION 5 — Technology Landscape and Spending Signals**

**Part A: Incumbent Partners**

Name any confirmed managed services or outsourcing partners. These are the competitive context. If an incumbent is confirmed, note the relationship age and any signals of dissatisfaction or expiration.

**Part B: Spending Estimates Table**

| Category | Est. Annual Spend | Key Signal | [YOUR FIRM] Opportunity |
|---|---|---|---|

All spend estimates must be flagged `[ASSUMPTION — basis]`. Basis should be: industry benchmark % of revenue, confirmed contract award value, or job posting density.

---

**SECTION 6 — Job Posting Intelligence**

Table of confirmed open roles relevant to technology or consulting services:

| Role Title | Location | Salary Range (if posted) | What It Signals |
|---|---|---|---|

After the table, a synthesis paragraph: what do these postings collectively tell you about active spending programs and organizational priorities?

---

**SECTION 7 — Technology Stack**

Two-column table — never mix columns:

| Confirmed (source cited) | Likely / Inferred [ASSUMPTION — basis] |
|---|---|

Confirmed = press release, official announcement, job posting naming the specific platform, or vendor case study.
Inferred = industry norm for this vertical, or signals from job postings that suggest but don't confirm a platform.

---

**SECTION 8 — Opportunity Map**

| Opportunity | Tier | Timeline | Est. Value | Named Champion |
|---|---|---|---|---|

**Tier definitions:**
- **Tier 1** — 0–6 months: Active, fundable, champion identified, there is a near-term trigger
- **Tier 2** — 6–18 months: Likely, but needs relationship development or internal decision to crystallize
- **Tier 3** — 18+ months: Strategic, requires the account to evolve or a future event to occur

**Rules:**
- Every opportunity must have a named champion. No champion = not actionable, do not include.
- All value estimates must be flagged `[ASSUMPTION — basis]`.
- Minimum 2 Tier 1 opportunities. If research cannot support 2, explain why in a note below the table.

---

**SECTION 9 — [YOUR FIRM] at a Glance: Why We Win**

Two-column table using FIRM_CREDENTIALS:

| Credential / Recognition | What It Means in a Client Conversation |
|---|---|

For each credential, write 2–3 sentences translating it into relevance for THIS specific account. Do not list awards — explain why they matter here.

If FIRM_CREDENTIALS was not provided: write a placeholder section with this note: *"Insert your firm's relevant credentials, analyst recognitions, partnership tiers, and referenceable case studies here before this document is used in a pursuit."*

---

**SECTION 10 — [YOUR FIRM] Strategy and Vision for [TARGET COMPANY]**

**10.1 — Vision Statement**

One paragraph in a full-width NAVY box. Written specifically for this account — not a generic firm positioning statement. Answer: what does [YOUR FIRM] want to be for this company, and what makes [YOUR FIRM] the right choice to deliver it?

**10.2 — Case Studies to Showcase**

Four case studies mapped to THIS account's confirmed priorities. Do not map a healthcare case study to a manufacturing account. Use FIRM_CREDENTIALS if provided. If credentials are thin, write plausible case study types based on the opportunities and flag them `[ASSUMPTION — confirm with your firm's BD team before using in a client meeting]`.

| Case Study | Relevance to [Company] | Talking Points |
|---|---|---|

**10.3 — Proposals to Build Before First Meeting**

Four specific, named proposal concepts. Each requires:
- A title that sounds like a real engagement (not "Advisory Services" or "Digital Transformation")
- The named champion who would approve it
- A 3–5 sentence core argument — the actual pitch
- An indicative price range flagged `[ASSUMPTION — basis: market rate for scope described]`

| Proposal Title | Target Champion | Core Argument |
|---|---|---|

---

**SECTION 11 — Recommended Outreach Strategy**

Answer all five specifically. No generic advice.

**11.1 Who to contact first**
Named person, specific title, and the concrete reason they are the right door — not just "they own technology."

**11.2 What to lead with**
One specific hook: a job posting they have open, a quote from their earnings call, a news event in the last 30 days, a product launch, a regulatory event. One sentence.

**11.3 Draft email opening**
Write the first 3 sentences of the outreach email. It must reference something specific to THIS person at THIS company — their recent statement, their background, their open challenge. No generic intros.

**11.4 Best timing**
A specific date window and the reason (post-earnings quiet period ending, pre-budget cycle, 90 days after new leader arrival, pre-contract expiration).

**11.5 What NOT to do**
One or two pitfalls specific to this account: incumbent relationship to avoid triggering, internal politics to be aware of, messaging that will backfire, regulatory sensitivity.

---

**SECTION 12 — AI Agentic Solutions Vision**

This section presents [YOUR FIRM]'s vision for transforming [TARGET COMPANY] through AI and agentic solutions — grounded in the company's confirmed strategic priorities and AI maturity signals from Dimension 8 research. It must be specific to this company's context, not a generic AI pitch.

**12.1 — AI Readiness Assessment**

A scored evaluation of the company's AI maturity across five dimensions. Present as a color-coded scorecard table with a visual progress indicator for each dimension. Each score (1–5) must be derived from Dimension 8 research signals — not generic.

| Dimension | Score (1–5) | Evidence / Signal | Implication |
|---|---|---|---|
| Data Maturity | [1–5] | [Specific signal from research] | [What this means for AI buildout] |
| Infrastructure Readiness | [1–5] | [Signal] | [Implication] |
| AI / ML Talent | [1–5] | [Signal] | [Implication] |
| AI Governance | [1–5] | [Signal] | [Implication] |
| Agentic Readiness | [1–5] | [Signal] | [Implication] |

Generate a **visual AI Readiness Radar Chart** as a PNG image embedded in the document (using chartjs-node-canvas). The radar plots all five dimensions on a pentagon grid with scores 1–5. Use NAVY fill with 40% opacity and BLUE border.

**12.2 — AI Agentic Use Case Roadmap**

Map 6–10 specific AI agentic use cases to this company, organized into three tiers based on implementation readiness and business impact. Each use case must tie back to a confirmed strategic priority or identified pain point — not a generic AI capability.

| Use Case | Business Function | Strategic Link | Impact | Complexity | Tier |
|---|---|---|---|---|---|
| [Specific use case] | [Function] | [Links to Priority X] | [H/M/L] | [H/M/L] | [1/2/3] |

**Tier definitions for AI use cases:**
- **Tier 1 — Deploy Now (0–6 months):** Foundation models available, low data prep required, quick ROI demonstration
- **Tier 2 — Build This Year (6–18 months):** Requires data integration or governance work first; high strategic impact
- **Tier 3 — Innovate Long-Term (18+ months):** Novel agent architectures; potential IP co-development; requires organizational change

Generate a **visual Priority Matrix Chart** (bubble chart) as a PNG image: X-axis = Implementation Complexity, Y-axis = Business Impact, bubble size = estimated value. Color by tier (TEAL = Tier 1, BLUE = Tier 2, NAVY = Tier 3).

**12.3 — [YOUR FIRM]'s Agentic Delivery Model for [TARGET COMPANY]**

Describe specifically how [YOUR FIRM] would deliver the AI agentic vision — not a generic methodology description. Address:
- Which AI platform(s) would anchor the solution (tied to company's confirmed tech stack)
- [YOUR FIRM]'s proprietary accelerators, pre-built agents, or AI frameworks relevant to this vertical
- Named platform partnerships ([YOUR FIRM] + Microsoft / AWS / Google / Databricks + how it applies here)
- The sequencing: what gets built first and why, tied to the Tier 1 use cases above
- Governance and responsible AI framework [YOUR FIRM] would put in place for this account

**12.4 — AI Investment Framing**

Two-column framing table — cost of inaction vs. value of action. All figures must be flagged `[ASSUMPTION — basis]`.

| Investment Area | Est. Investment | Est. Annual Value Capture | Payback Period |
|---|---|---|---|

After the table: a 3–4 sentence narrative on how [YOUR FIRM] would present the AI business case to the CFO of this specific company — referencing their known cost pressures or growth mandate from Section 4.

---

**SECTION 13 — IP & Research Opportunities**

This section maps the intellectual property and research innovation landscape for [TARGET COMPANY] and identifies co-innovation opportunities with [YOUR FIRM]. It is forward-looking — the goal is to identify where jointly developed IP or research partnerships could create durable competitive advantage.

**13.1 — IP Landscape Assessment**

Map the company's current IP posture across three categories. All items must be sourced or explicitly flagged [ASSUMPTION].

| IP Category | Current State | Strength | Gap / Opportunity |
|---|---|---|---|
| Patent Portfolio | [Active patents / filing activity / domains] | [H/M/L] | [Where coverage is thin or novel IP could be filed] |
| Proprietary Data Assets | [What unique data the company generates or holds] | [H/M/L] | [How it could be monetized or protected] |
| Proprietary Processes / Algorithms | [Any known trade secrets, proprietary models, unique workflows] | [H/M/L] | [What could be formalized, protected, or built on] |

Generate a **visual IP Strength Snapshot** — a horizontal bar chart (PNG image) showing IP strength by category, color-coded by gap severity (TEAL = strong, ORANGE = gap, NAVY = unknown).

**13.2 — Research & Innovation Opportunities**

Identify 4–6 specific areas where [TARGET COMPANY] could invest in applied research or co-develop novel solutions with [YOUR FIRM]. Each opportunity must tie to a confirmed strategic priority or a vertical-specific innovation trend.

| Research Area | Strategic Rationale | Potential Output | [YOUR FIRM] Role | Timeline |
|---|---|---|---|---|
| [Area] | [Why this matters for this company now] | [Patent / model / platform / published research] | [Lead / Co-develop / Advisory] | [X months] |

**13.3 — Co-Innovation Model**

Describe how [YOUR FIRM] and [TARGET COMPANY] could structure a co-innovation engagement:
- **Funding model:** How costs, IP ownership, and commercialization rights would be split
- **Governance:** Who owns decisions (named roles at both organizations)
- **IP framework:** What each party brings in, what gets created jointly, how new IP is registered
- **Milestone structure:** What the 6-month, 12-month, and 24-month outcomes look like

Present as a structured table followed by a narrative paragraph (3–4 sentences) on why this model is appropriate for THIS specific company's culture and risk tolerance — based on research signals.

**13.4 — Pioneering Bets: Where [TARGET COMPANY] Could Lead the Industry**

One of the most intriguing forward-looking sections in the report. Identify 2–3 areas where [TARGET COMPANY] has the unique combination of data, domain position, and strategic intent to become an industry-defining innovator — not just an AI adopter.

For each bet:
- **The thesis:** What makes this company uniquely positioned (specific data asset + domain depth + strategic moment)
- **The innovation:** What novel AI capability, product, or process could be built
- **The competitive moat:** Why competitors could not easily replicate this even if they tried
- **[YOUR FIRM]'s contribution:** What specific IP, platform, or expertise [YOUR FIRM] brings to make this possible
- **Risk:** What could prevent this from happening (technology, organizational, regulatory)

Present each bet in a full-width GOLD callout box for visual distinction.

---

## PHASE 3 — QUALITY GATE

Before saving the file, verify every item:

- [ ] Every estimated figure has an inline `[ASSUMPTION — basis]` flag — orange italic in the .docx
- [ ] No leadership names were inferred — all sourced from press releases, official pages, or confirmed news
- [ ] No AI filler language anywhere: "leverage," "unlock value," "synergies," "best-in-class," "world-class," "cutting-edge," "transformative," "it is important to note," "game-changing"
- [ ] Cover page has no logo
- [ ] Page headers from page 2: firm name left-aligned, document title right-aligned, thin blue bottom border
- [ ] Org chart uses colored table boxes (NAVY for CEO, BLUE for C-suite, TEAL for VPs) — not a text list
- [ ] Every opportunity in Section 8 has a named champion
- [ ] The Section 11 draft email opening is specific to the named person — not a template opener
- [ ] Federal targets: all contract values are sourced from SAM.gov or flagged [ASSUMPTION]
- [ ] No section is empty — every section has substantive content or a clearly labeled placeholder
- [ ] Section 12 AI Readiness scores are grounded in Dimension 8 research — not generic
- [ ] Section 12 AI use cases are mapped to confirmed strategic priorities from Section 4
- [ ] Section 12 Radar Chart and Priority Matrix Chart are generated as PNG images and embedded
- [ ] Section 13 IP assessment covers all three categories (patents, data assets, processes)
- [ ] Section 13 Pioneering Bets are specific to this company's unique position — not generic AI predictions
- [ ] Section 13 IP Strength Snapshot chart is generated and embedded
- [ ] Section 5 Spending Allocation chart (pie/donut) is generated and embedded
- [ ] Section 8 Opportunity Timeline chart is generated and embedded
- [ ] All four embedded charts render at correct dimensions (width ≤ 500px in the document)

---

## PHASE 4 — OUTPUT SUMMARY

After saving the file, output exactly three bullets to the user:

- **Entry point:** [Named person], [exact title] — [specific reason they are the right first call, not generic]
- **Time-sensitive opportunity:** [Named opportunity] — [why the window exists now: new leader, open recompete, regulatory deadline, post-earnings, contract expiration date]
- **First outreach:** [Recommended date/window] — Lead with: "[one-line specific hook]"

---

## FORMATTING REFERENCE

### Color Constants
```
NAVY   = "1B2A4A"   — cover background, section header bars
BLUE   = "2E5FA3"   — C-suite org chart boxes, subsection text
TEAL   = "2E8B7A"   — VP/BU org chart boxes, Tier 1 AI use cases
WHITE  = "FFFFFF"   — text on dark backgrounds
LIGHT  = "5BA3C9"   — cover company name accent
MUTED  = "AACCEE"   — cover metadata labels, org chart tenure text
ORANGE = "CC6600"   — assumption flags: inline, italic; IP gaps
ALT    = "EEF3FA"   — alternating table row background
GOLD   = "B8860B"   — Pioneering Bets callout box background (use "FFF8DC" for light gold)
PURPLE = "6B4FA0"   — AI governance / research accent
GREEN  = "2E7D32"   — positive AI readiness scores (4–5)
RED    = "C62828"   — low AI readiness scores (1–2)
AMBER  = "E65100"   — mid AI readiness scores (3)
```

### Chart Specifications (embedded PNG images)

All charts are generated using `chartjs-node-canvas` and embedded via `ImageRun`. Four charts are required:

| Chart | Section | Type | Size (px) | Purpose |
|---|---|---|---|---|
| Spending Allocation | Section 5 | Doughnut | 500×400 | Visual breakdown of estimated IT spend by category |
| Opportunity Timeline | Section 8 | Horizontal Bar (Gantt-style) | 600×300 | Visual map of opportunities by tier and timeline |
| AI Readiness Radar | Section 12 | Radar | 500×450 | Spider chart of 5 AI maturity dimensions scored 1–5 |
| IP Strength Snapshot | Section 13 | Horizontal Bar | 500×250 | Strength rating per IP category, color-coded by gap |

**Chart generation requires:**
```bash
npm install docx chartjs-node-canvas chart.js canvas
```

**Chart color palette (for consistency across all charts):**
- Primary: `#1B2A4A` (NAVY) — dominant bars, fills
- Secondary: `#2E5FA3` (BLUE) — accent fills
- Tertiary: `#2E8B7A` (TEAL) — positive/high values
- Warning: `#CC6600` (ORANGE) — gap/low values
- Background: `#EEF3FA` (ALT) — chart canvas background

### Typography
- Body: 11pt Arial, 1.15 line spacing
- Section headers: 14pt bold white on full-width NAVY bar
- Subsection headers: 12pt bold BLUE paragraph
- Tables: 11pt Arial
- In docx sizing: 11pt = size 22, 12pt = size 24, 14pt = size 28, 64pt = size 128

### Cover Page Structure (zero-margin, full-bleed navy)
```
"CONFIDENTIAL — FOR INTERNAL USE ONLY"   [small, MUTED, centered]
"Account Intelligence Report"            [64pt bold WHITE, centered]
"[Company] ([Ticker])"                   [36pt bold LIGHT, centered]
[One-line company descriptor]            [26pt MUTED, centered]
────────────────────────────────────     [divider line, LIGHT]
Prepared By / Prepared For               [small WHITE, centered]
Account / Revenue / Employees / Date     [small WHITE, centered]
[Assumption disclaimer]                  [small italic MUTED, bottom]
```

### Page Headers (page 2 onward)
- Left: [YOUR FIRM] name, 9pt bold NAVY
- Right: "Account Intelligence Report — [COMPANY]", 9pt NAVY
- Bottom border: thin BLUE line

### Org Chart Box Format
Each box is a table cell with:
- Background: NAVY (CEO) | BLUE (C-suite) | TEAL (VPs)
- Name: bold, white, 11pt
- Title: white, 10pt
- "Since [Month Year]": MUTED, 9pt
- Width: equal distribution across row

---

## ANTI-PATTERNS — NEVER DO THESE

- Never present an estimated figure without an inline [ASSUMPTION — basis] flag
- Never infer a person's name from their title — only use names found in official sources
- Never write: "leverage," "synergies," "best-in-class," "world-class," "cutting-edge," "transformative," "game-changing"
- Never include an opportunity in Section 8 without a named champion
- Never write a generic email opener that could apply to any company
- Never skip Dimension 7 (federal contract intelligence) for government targets
- Never place Confirmed and Inferred platforms in the same Technology Stack column
- Never mark a spend estimate as "confirmed" unless it came from a filed contract, SEC filing, or official announcement
- Never produce a report under 10 pages — if research is thin, flag it explicitly and explain what additional research is needed
- Never write Section 12 AI Readiness scores without grounding each score in a specific Dimension 8 research signal
- Never present AI use cases in Section 12 that are not tied to a confirmed strategic priority or identified pain point
- Never write Section 13 Pioneering Bets as generic industry trends — they must be specific to this company's unique data position and market moment
- Never skip chart generation — all four visual charts are mandatory components of the report
- Never use placeholder chart images — every chart must be generated with the actual researched data populated
- Never write Section 13 IP assessment as speculative without noting [ASSUMPTION] — IP portfolio claims must be sourced or explicitly flagged
