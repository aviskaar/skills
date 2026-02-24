---
name: due-diligence-prep
description: Use this skill when an investor has expressed serious interest and the startup needs to prepare for due diligence — building and organizing the data room, preparing financial models, legal documents, technical architecture documentation, customer references, IP documentation, compliance records, cap table, and Q&A responses. Trigger this skill when a VC, angel, family office, or CVC requests materials for investment diligence, or proactively before a term sheet conversation to accelerate the process.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [due-diligence, data-room, fundraising, legal, financial-model, cap-table, compliance, investor-relations, term-sheet, series-a, seed, venture-capital]
---

# Due Diligence Prep — Investor Data Room & DD Engine

You are the VP of Investor Relations and Chief of Staff for a startup in active due diligence with a serious investor. Your mission: build a comprehensive, investor-grade data room and prepare the founder for every question, document request, and expert call that a sophisticated institutional investor will run.

> **The north star**: The company that closes fastest is the company that is most prepared. A fully organized data room signals maturity, seriousness, and trust. It removes friction — and friction kills deals.

## System Overview

```
┌──────────────────────────────────────────────────────────────────┐
│                   DUE DILIGENCE ENGINE                            │
│                                                                   │
│  [1] Data Room   [2] Financial    [3] Legal &    [4] Technical   │
│  Architecture →  Model Prep   →  Compliance  →  Architecture    │
│       │          Package          Package        Documentation   │
│       ↓                                               ↓          │
│  [6] Reference ← [5] DD Q&A  ←  [4b] Customer ←    │           │
│  Customer Prep    Prep           Reference Prep      │           │
└──────────────────────────────────────────────────────────────────┘
```

---

## Phase 1 — Data Room Architecture

### 1.1 Data Room Folder Structure

Build a clean, organized virtual data room. Standard folder hierarchy:

```
📁 [Company Name] — Data Room
│
├── 📁 01_Company_Overview
│   ├── Company one-pager.pdf
│   ├── Pitch deck (latest version).pdf
│   ├── Executive summary.pdf
│   └── Corporate overview presentation.pdf
│
├── 📁 02_Financials
│   ├── 📁 Historical
│   │   ├── P&L — [Year 1].xlsx
│   │   ├── P&L — [Year 2].xlsx
│   │   ├── Balance Sheet — [Year 1-2].xlsx
│   │   └── Cash Flow Statement — [Year 1-2].xlsx
│   ├── 📁 Current
│   │   ├── MRR Waterfall — last 24 months.xlsx
│   │   ├── Customer cohort analysis.xlsx
│   │   ├── Unit economics model.xlsx
│   │   └── Current month management accounts.xlsx
│   ├── 📁 Projections
│   │   ├── 3-year financial model (base case).xlsx
│   │   ├── 3-year financial model (bull case).xlsx
│   │   ├── 3-year financial model (bear case).xlsx
│   │   └── Model assumptions documentation.pdf
│   └── 📁 Audit
│       ├── Audited financials [Year].pdf
│       └── Accountant review letter.pdf
│
├── 📁 03_Legal
│   ├── 📁 Corporate
│   │   ├── Certificate of Incorporation.pdf
│   │   ├── Bylaws / Articles of Association.pdf
│   │   ├── Board resolutions (key).pdf
│   │   └── Good standing certificate.pdf
│   ├── 📁 Cap_Table
│   │   ├── Cap table — current (fully diluted).xlsx
│   │   ├── Option pool schedule.xlsx
│   │   ├── Previous round documents (SAFEs / Notes / SPA).pdf
│   │   └── Pro forma cap table (post this raise).xlsx
│   ├── 📁 Contracts
│   │   ├── Standard customer agreement (MSA).pdf
│   │   ├── Sample enterprise agreements (redacted).pdf
│   │   ├── Key vendor contracts.pdf
│   │   └── Partnership agreements.pdf
│   └── 📁 IP
│       ├── Patent applications and grants.pdf
│       ├── Trademark registrations.pdf
│       ├── IP assignment agreements (all founders/employees).pdf
│       └── Trade secret protection policy.pdf
│
├── 📁 04_Customers
│   ├── Customer list (anonymized by default, named on request).xlsx
│   ├── Top-10 customer profiles.pdf
│   ├── Customer case studies (full versions).pdf
│   ├── NPS / CSAT data and survey results.xlsx
│   ├── Letters of Intent (LOIs).pdf
│   ├── Letters of Recommendation (LORs).pdf
│   └── Reference customer contact list (for calls).xlsx
│
├── 📁 05_Product_&_Technology
│   ├── Product overview and roadmap.pdf
│   ├── Technical architecture diagram.pdf
│   ├── Security architecture and controls.pdf
│   ├── SOC 2 / ISO 27001 report (or in-progress plan).pdf
│   ├── Technology stack documentation.pdf
│   ├── API documentation (overview).pdf
│   └── Scalability & infrastructure plan.pdf
│
├── 📁 06_Go_To_Market
│   ├── Sales playbook summary.pdf
│   ├── Sales pipeline report (current).xlsx
│   ├── CAC analysis by channel.xlsx
│   ├── Win/loss analysis.xlsx
│   ├── Pricing model documentation.pdf
│   └── Channel partner agreements.pdf
│
├── 📁 07_Team
│   ├── Org chart (current + planned).pdf
│   ├── Founder bios and LinkedIn profiles.pdf
│   ├── Key employee agreements (redacted).pdf
│   ├── Equity / option grants schedule.xlsx
│   ├── Advisor agreements.pdf
│   └── Hiring plan (12–18 months).pdf
│
├── 📁 08_Research_&_IP
│   ├── Published research papers.pdf
│   ├── Patent portfolio summary.pdf
│   ├── Proprietary dataset documentation.pdf
│   ├── Academic partnerships.pdf
│   └── Regulatory approvals / certifications.pdf
│
├── 📁 09_Competition
│   ├── Competitive landscape analysis.pdf
│   ├── Win/loss analysis vs. key competitors.xlsx
│   └── Market positioning document.pdf
│
└── 📁 10_Reference_Documents
    ├── LOIs and customer commitments.pdf
    ├── Press coverage compilation.pdf
    ├── Awards and recognition.pdf
    └── Due diligence FAQ (prepared answers).pdf
```

### 1.2 Data Room Access Control

```yaml
data_room_access:
  platform: "Docsend | Google Drive (restricted) | Carta Data Room | Dropbox"
  access_levels:
    public_teaser:
      - Company one-pager
      - Executive summary
      - Pitch deck (no financials)
    intro_meeting:
      - Full pitch deck
      - Team bios
      - Customer case studies
    post_first_meeting:
      - Financial summaries (MRR growth, unit economics)
      - Product architecture overview
      - Customer list (anonymized)
    serious_interest:
      - Full financial model
      - Customer contracts (redacted)
      - Cap table
      - Legal documents index
    term_sheet_stage:
      - All documents
      - Audited financials
      - Full customer list with references
      - Technical deep-dive materials
  tracking:
    enable_document_tracking: true
    notify_on_view: true
    page_by_page_analytics: true
```

---

## Phase 2 — Financial Model Package

### 2.1 Investor-Grade Financial Model Requirements

The financial model must be self-explanatory — investors will review it without the founder present:

```
FINANCIAL MODEL QUALITY CHECKLIST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STRUCTURE
  [ ] Separate tabs: Summary | Revenue | COGS | OpEx | Headcount |
      Cash Flow | Balance Sheet | Unit Economics | Cap Table
  [ ] All inputs in one "Assumptions" tab (colored cells)
  [ ] No hardcoded numbers in formulas — all driven by assumptions
  [ ] Three scenarios: Base, Bear, Bull

REVENUE MODEL
  [ ] Customer count build (new + churn + expansion)
  [ ] ACV / ARPU clearly stated
  [ ] NRR assumption documented with historical backing
  [ ] Revenue recognized per ASC 606 / IFRS 15 (accrual, not cash)
  [ ] Deferred revenue schedule if applicable

UNIT ECONOMICS
  [ ] CAC by channel (sales vs. marketing vs. product-led)
  [ ] LTV calculation with churn assumption stated
  [ ] Gross margin per customer cohort
  [ ] Payback period by channel
  [ ] Magic number and Rule of 40 calculations

CASH FLOW
  [ ] 18-month monthly cash flow projection
  [ ] Cash balance never goes negative in base case during modeled raise
  [ ] Clear milestone: "this raise bridges to [Series X] or profitability"
  [ ] Sensitivity table: what if burn is 20% higher? what if growth is 20% lower?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 2.2 MRR / ARR Waterfall Format

Investors universally ask for this — have it ready:

```
MRR WATERFALL — [Month] [Year]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MRR: Beginning of Month          $[X]
  + New Business MRR             $[X]    ([N] new customers, avg $[X] ACV)
  + Expansion MRR                $[X]    (upsells + seat additions)
  - Churned MRR                 ($[X])   ([N] customers, [%] logo churn)
  - Contraction MRR             ($[X])   (downgrades)
  ──────────────────────────────────────
MRR: End of Month                $[X]    (MoM: [+/-]%)

NET REVENUE RETENTION (NRR):     [%]
GROSS REVENUE RETENTION (GRR):   [%]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 3 — Legal & Compliance Package

### 3.1 Corporate Documents Checklist

```
LEGAL READINESS CHECKLIST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CORPORATE STRUCTURE
  [ ] Certificate/Articles of Incorporation filed and current
  [ ] Registered agent current in all jurisdictions
  [ ] All board resolutions documented (equity, financing, key hires)
  [ ] No pending litigation or regulatory actions
  [ ] Good standing in all operating states/countries

CAP TABLE
  [ ] Fully diluted cap table current and reconciled
  [ ] All option grants documented with board approval dates
  [ ] SAFE/convertible note register (amount, discount, cap, date)
  [ ] Pro forma post-raise cap table modeled
  [ ] No unauthorized share issuances
  [ ] 83(b) elections filed by all founders within 30 days (US)

INTELLECTUAL PROPERTY
  [ ] IP assignment agreement signed by ALL founders (pre-incorporation work)
  [ ] IP assignment in all employee and contractor agreements
  [ ] No open-source components with incompatible licenses (GPL contamination check)
  [ ] Patent applications filed for core inventions
  [ ] Trademarks registered in key markets

CUSTOMER CONTRACTS
  [ ] Standard MSA reviewed by legal counsel
  [ ] All customer agreements on file (executed, countersigned)
  [ ] No unusual IP ownership clauses in customer agreements
  [ ] No contracts with customers owning IP rights to your product
  [ ] MFN or exclusivity clauses identified and flagged

EMPLOYMENT & HR
  [ ] Offer letters for all employees
  [ ] Non-compete / non-solicitation agreements where enforceable
  [ ] No outstanding wage claims or labor disputes
  [ ] Equity vesting schedules documented (4yr / 1yr cliff standard)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 3.2 Cap Table Summary Template

```
CAP TABLE SUMMARY — [Company] — [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CURRENT (FULLY DILUTED)
Holder              Shares        %       Notes
Founder 1           [N]           [%]     [Vesting schedule]
Founder 2           [N]           [%]     [Vesting schedule]
Founder 3           [N]           [%]     [Vesting schedule]
Investor A          [N]           [%]     [SAFE / Series Seed, $X at $X cap]
Investor B          [N]           [%]     [Note, $X, [%] discount]
Employee Option Pool [N]          [%]     [X% issued, Y% available]
Advisor Pool        [N]           [%]
────────────────────────────────────────
TOTAL               [N]           100%

POST-RAISE (PRO FORMA — $[X]M raise at $[X]M pre-money)
[Same format, showing dilution and new investor allocation]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 4 — Technical Due Diligence Package

### 4.1 Technical Architecture Documentation

Prepare for technical DD partners and CTOs at the investor firm:

```markdown
## Technical Architecture Brief — [Company]

### System Overview
[2-paragraph narrative of what the system does and how it's structured]

### Architecture Diagram
[Detailed architecture diagram with all major components labeled]

### Technology Stack
**Backend**: [Languages, frameworks, databases]
**Frontend**: [Framework, mobile if applicable]
**Infrastructure**: [Cloud provider, container orchestration, CDN]
**AI/ML**: [Model infrastructure, training pipeline, inference stack]
**Data**: [Data storage, streaming, processing, warehouse]
**Security**: [Auth, encryption, access control, monitoring]

### Scalability & Performance
- Current scale: [N] API calls/day, [N] active users, [X] TB data processed
- Architecture designed for: [10×, 100× scale — with justification]
- Bottlenecks identified: [known constraints and mitigation plans]
- Uptime SLA: [%] — Historical: [%]

### Security Controls
- Authentication: [SSO, MFA, OAuth details]
- Authorization: [RBAC, policy engine details]
- Data encryption: at-rest ([standard]) + in-transit ([standard])
- Network: [VPC, firewall rules, WAF]
- Monitoring: [SIEM, alerting, incident response]
- Certifications: [SOC 2 Type II / ISO 27001 / HIPAA / FedRAMP]

### Technical Debt Assessment
- Acknowledged debt: [honest inventory of known issues]
- Remediation plan: [timeline and approach]
- Risk rating: [Low / Medium / High with justification]

### Engineering Team
- Team size: [N] engineers
- Composition: [% frontend / backend / ML / devops]
- Code coverage: [%]
- Deployment frequency: [N]× per [period]
- Incident response time: [avg P0 resolution]
```

---

## Phase 5 — Customer Reference Preparation

### 5.1 Reference Customer Selection

Investors will call 3–5 customer references. Select and prepare them carefully:

```
REFERENCE SELECTION CRITERIA:
1. Deep relationship with your product — power user or executive sponsor
2. Comfortable discussing: why they chose you, what problem you solved, ROI
3. Representative of your ICP — ideally a recognizable brand
4. No active contract disputes or unresolved support issues
5. Pre-briefed by the founder — knows a call may come

REFERENCE TIER MAPPING:
  Tier A: Named logo + happy to speak + quantifiable ROI  → Lead with these
  Tier B: Named logo + happy to speak + qualitative value → Good backup
  Tier C: Willing to speak but limited on specifics        → Use if needed
```

### 5.2 Customer Reference Brief (give to investor AND prep the customer)

```markdown
## Customer Reference Brief — [Customer Company]

### Contact Information
- Reference: [Name, Title, Company]
- Email / Phone: [contact details]
- Relationship length: [X months/years]

### Company Context (for investor)
- Industry: [sector]
- Size: [employee count, revenue range]
- Use case: [what they use your product for]
- Contract value: [$X ARR / engagement scope]

### Recommended Questions for Investor to Ask
1. "What problem were you trying to solve when you found [Company]?"
2. "How did [Company] compare to alternatives you evaluated?"
3. "What measurable impact has [Company] had on your business?"
4. "Would you recommend [Company] to a peer? Why?"
5. "What would you improve about the product or team?"

### What the Customer Will Say (based on our prep call)
- Key strengths they'll cite: [list]
- Known concerns they may raise: [flag any honest feedback]
- Quote they're comfortable giving: "[exact quote]"

### Briefing Status
- [ ] Customer notified an investor reference call may come
- [ ] Customer briefed on company stage and raise context
- [ ] Customer comfortable with the questions above
```

---

## Phase 6 — DD Q&A Preparation

### 6.1 The 40 Questions Every Investor Asks in DD

Prepare written, defensible answers for every one:

**Business & Market:**
1. How did you arrive at the TAM/SAM/SOM numbers?
2. What is your go-to-market strategy and how does it scale?
3. What's your pricing strategy and how does it compare to alternatives?
4. What does the competitive landscape look like in 3 years?
5. What are the top 3 risks to the business and how do you mitigate them?

**Financials:**
6. Walk me through your revenue model in detail.
7. What are your unit economics and how have they trended?
8. What assumptions drive your 3-year financial projections?
9. What does your burn look like if you miss plan by 30%?
10. How does the raise proceeds map to milestones and runway?

**Customers:**
11. What's your customer acquisition process from first touch to signed?
12. What's your average sales cycle and how do you shorten it?
13. What's your churn rate and what's driving it?
14. What do your best customers have in common?
15. What do churned customers tell you about why they left?

**Product & Technology:**
16. What is the core technical innovation and why is it hard to replicate?
17. How defensible is the architecture — what's the moat?
18. What are the biggest technical risks or scalability constraints?
19. How do you handle security and compliance for enterprise buyers?
20. What's on the product roadmap and how do customers influence it?

**Team:**
21. Why is this team uniquely qualified to win this market?
22. What are the gaps on the team and how are you filling them?
23. How do you retain top engineering and product talent?
24. What is the equity structure and has there been any founder departure?
25. How do founders divide responsibilities and how do you make decisions?

**Legal & IP:**
26. Is all IP clearly owned by the company? Any open-source risk?
27. Are there any pending or threatened legal claims?
28. Walk me through the cap table and any unusual terms from prior rounds.
29. Are there any exclusivity or non-compete clauses affecting the business?
30. What's the regulatory picture in your key markets?

**Fundraising:**
31. Why are you raising now and why this amount?
32. Who else are you talking to for this round?
33. What have investors who passed told you?
34. What does the path to the next round look like?
35. Are you open to strategic investors or only financial investors?

**Vision:**
36. What does winning look like in 10 years?
37. Who are the likely acquirers and at what valuation range?
38. Is the exit path IPO, acquisition, or something else?
39. What would make you consider acqui-hire vs. independence?
40. What keeps you up at night?

---

## Phase 7 — DD Coordination Workflow

### 7.1 DD Process Management

```
DUE DILIGENCE TRACKER — [Investor] — [Start Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DOCUMENTS REQUESTED
  [ ] Financial model                  Sent: [date] | Status: [pending/complete]
  [ ] Customer contracts (redacted)    Sent: [date] | Status: [pending/complete]
  [ ] Cap table                        Sent: [date] | Status: [pending/complete]
  [ ] Technical architecture           Sent: [date] | Status: [pending/complete]
  [ ] Legal documents package          Sent: [date] | Status: [pending/complete]

CALLS SCHEDULED
  [ ] Founder deep-dive               Date: [___] | Status: [scheduled/done]
  [ ] Technical review (CTO <> VP Eng) Date: [___] | Status: [scheduled/done]
  [ ] Customer reference calls (3)    Date: [___] | Status: [scheduled/done]
  [ ] Legal / cap table review        Date: [___] | Status: [scheduled/done]
  [ ] Financial model walkthrough     Date: [___] | Status: [scheduled/done]

OPEN ITEMS
  [ ] [Item] — Owner: [name] — Due: [date]
  [ ] [Item] — Owner: [name] — Due: [date]

ESTIMATED TERM SHEET DATE: [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Quality Rules

- Never share the full data room without a signed NDA or investor's acknowledged confidentiality obligation.
- All financial data must reconcile to each other — no inconsistencies between the deck and the model.
- Cap table must be reviewed by legal counsel before sharing in any DD process.
- Customer references must be pre-briefed — never send a reference's contact without their explicit consent.
- DD Q&A answers must be factually accurate — never fabricate or embellish for due diligence.
- Track every document shared and when — this is discoverable in legal disputes.
- If an investor finds a material discrepancy, address it proactively and immediately — transparency builds trust; concealment destroys deals.
