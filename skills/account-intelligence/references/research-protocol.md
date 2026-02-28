# Research Protocol — Account Intelligence

This document defines the exact search query patterns, source prioritization rules, confidence scoring system, and data handling standards for the Account Intelligence skill.

Follow this protocol in Phase 1 before writing any report content.

---

## RESEARCH PRINCIPLES

1. **Research before writing.** Complete all 7 dimensions before populating any section of the report. Writing while researching causes sections to contradict each other.

2. **Minimum searches, not maximum.** The goal is confident, sourced content — not exhaustive coverage. Three targeted searches that return confirmed information beat thirty searches that return noise.

3. **Source everything.** Every fact in the report must trace to a source. If you cannot cite a source, the data point is an [ASSUMPTION].

4. **Separate confirmation from inference.** A platform appearing in a job posting description is Confirmed. A platform you would expect a company in this vertical to use, absent any evidence, is [ASSUMPTION — vertical standard].

5. **Flag rather than omit.** If you cannot confirm a leadership name, write "[NAME NOT CONFIRMED — verify on official leadership page]" rather than guessing or leaving it blank.

---

## SOURCE PRIORITY RANKING

Use this ranking to determine how to classify each data point:

| Tier | Source Type | Classification |
|---|---|---|
| 1 | SEC filing (10-K, 10-Q, 8-K), earnings release | Confirmed |
| 1 | Press release from company's newsroom | Confirmed |
| 1 | Official leadership bio page on company website | Confirmed |
| 1 | SAM.gov contract award | Confirmed (Federal only) |
| 1 | Job posting naming a specific vendor platform | Confirmed |
| 2 | Vendor case study (SAP, Salesforce, Workday, etc.) | Confirmed (verify date) |
| 2 | Reputable trade press: WSJ, Reuters, Bloomberg, FT | Reported |
| 2 | Industry-specific press: Fierce Biotech, Healthcare IT News, CIO.com | Reported |
| 2 | LinkedIn profile (executive tenure dates) | Reported (verify against official sources) |
| 3 | Glassdoor, Indeed, or Blind (technology mentions) | [ASSUMPTION — corroborate before using] |
| 3 | Industry analyst report (Gartner, IDC, Forrester) | Reported if named; [ASSUMPTION] if inferred |
| 4 | Inference from vertical norms (vertical playbooks) | [ASSUMPTION — vertical standard] |
| 4 | Your own estimate based on revenue and benchmarks | [ASSUMPTION — basis: X% of revenue benchmark] |

---

## DIMENSION-BY-DIMENSION SEARCH QUERY GUIDE

### Dimension 1 — Company Profile

**Primary searches (run all three):**
```
"[COMPANY NAME]" revenue employees fiscal year 2024 2025
"[COMPANY NAME]" annual report 2024 2025
"[COMPANY NAME]" earnings Q4 2025 results
```

**Secondary searches (run if primary returns incomplete data):**
```
"[COMPANY NAME]" site:ir.[companywebsite].com
"[COMPANY NAME]" 10-K annual report SEC filing
"[COMPANY NAME]" investor day presentation 2025
```

**What to capture:**
- Revenue: most recent fiscal year, labeled with FY year (e.g., "FY2025 revenue: $4.2B")
- Employee count: note source date — LinkedIn counts are often stale
- HQ: city, state, and country
- Fiscal year end: critical for timing outreach around budget and earnings cycles
- Strategic moment: one sentence on what is happening at the company right now that makes this a relevant pursuit

**Federal targets:**
```
"[AGENCY NAME]" budget FY2026 congressional justification
"[AGENCY NAME]" appropriations FY2025 FY2026
site:usaspending.gov "[AGENCY NAME]" technology
```

---

### Dimension 2 — Leadership Mapping

**Primary searches (run all):**
```
"[COMPANY NAME]" CIO CTO CEO CFO leadership 2025
"[COMPANY NAME]" chief information officer appointed 2024 2025
"[COMPANY NAME]" executive leadership team site:[company domain]
```

**Secondary searches (for specific executives):**
```
"[EXECUTIVE NAME]" "[COMPANY NAME]" CIO career background
"[EXECUTIVE NAME]" LinkedIn prior company role
"[EXECUTIVE NAME]" interview technology priorities 2025
```

**What to capture:**
- Full name: must be confirmed — never infer from title
- Exact title: use the title on the company's official leadership page, not a news headline
- Start date: month and year — critical for the "New Leader" flag
- Prior companies: the last 2–3 roles — reveals what tools and vendors they know and trust
- A public quote if available — use in the outreach strategy

**Confidence rules for leadership:**
- Name Confirmed = found on official company page, SEC filing, or press release
- Tenure dates Confirmed = found in press release announcing appointment
- Tenure dates Reported = found in reputable trade press covering the appointment
- Never guess a person's name. If not found, write "[CIO NAME NOT CONFIRMED — verify at company.com/leadership]"

**Federal targets:**
```
"[AGENCY]" CIO appointed 2024 2025 site:cio.gov
"[AGENCY]" chief information officer leadership
"[AGENCY]" program executive officer [program name]
```

---

### Dimension 3 — Strategic Priorities

**Primary searches:**
```
"[COMPANY NAME]" investor day strategy 2025 2026
"[COMPANY NAME]" CEO earnings call transcript Q4 2025
"[COMPANY NAME]" strategic priorities annual report 2024 2025
```

**Secondary searches:**
```
"[COMPANY NAME]" cost reduction program transformation 2025
"[COMPANY NAME]" CEO keynote conference speech 2025
"[COMPANY NAME]" CFO technology investment guidance
```

**Extraction rules:**
- Only include priorities that leadership explicitly stated. Do not infer from the industry — that goes in the Opportunity Map as your own thesis, not as a stated priority.
- For each priority found: note the source (earnings call Q4 FY2025, investor day March 2025, press release date)
- Look for capital allocation signals: "We are investing $X in [area]" = funded priority
- Look for cost reduction signals: "We are reducing spending in [area]" = headcount freeze, incumbent pressure, need for efficiency tech

**Federal targets:**
```
"[AGENCY]" IT modernization plan strategic plan FY2026
"[AGENCY]" FITARA scorecard
"[AGENCY NAME]" GAO report IT management 2024 2025
"[AGENCY]" president's management agenda technology
```

---

### Dimension 4 — Technology Signals

**Primary searches:**
```
"[COMPANY NAME]" ERP SAP Oracle technology platform 2025
"[COMPANY NAME]" Salesforce Workday ServiceNow platform 2025
"[COMPANY NAME]" managed services outsourcing partner 2024 2025
```

**Secondary searches:**
```
"[COMPANY NAME]" technology vendor partnership announcement
"[COMPANY NAME]" digital transformation cloud migration 2025
"[COMPANY NAME]" "[PLATFORM NAME]" implementation go-live
```

**Vendor case study search (high value):**
```
site:sap.com "[COMPANY NAME]" customer story
site:salesforce.com "[COMPANY NAME]" customer story
site:workday.com "[COMPANY NAME]" customer
site:servicenow.com "[COMPANY NAME]"
site:aws.amazon.com/solutions/case-studies "[COMPANY NAME]"
```

**Confirmation rules:**
- Platform is Confirmed only if: a press release names it, an official vendor case study names the company, or a job posting specifies the platform (not just a category)
- "We use cloud technology" is not a confirmation of AWS vs. Azure vs. GCP
- "SAP ERP" in a job posting JD confirms SAP but not which module or version

**Federal targets:**
```
site:sam.gov "[AGENCY]" contract award SAP Oracle Salesforce
"[AGENCY]" FITARA cloud score FY2025
"[AGENCY]" IT modernization contract award
```

---

### Dimension 5 — Job Posting Intelligence

**Primary searches:**
```
"[COMPANY NAME]" careers jobs "SAP" OR "ERP" OR "Salesforce" 2025
"[COMPANY NAME]" jobs "cloud architect" OR "data engineer" OR "AI" 2025
"[COMPANY NAME]" site:linkedin.com/jobs 2025 2026
```

**Secondary searches:**
```
"[COMPANY NAME]" jobs "CIO" OR "director IT" OR "VP technology"
"[COMPANY NAME]" careers "[PLATFORM NAME]" engineer architect
"[COMPANY NAME]" jobs site:indeed.com OR site:glassdoor.com 2025
```

**Directly on company careers page:**
```
site:[company].com/careers "[PLATFORM]" OR "ERP" OR "digital"
```

**Posting age handling:**
- Postings dated > 60 days ago: note as "potentially filled" in the Signal column
- Postings dated < 30 days: active and reliable signal
- Multiple postings for the same role (2+): strong signal of a funded, scaling program

**Signal interpretation guide:**

| Pattern | Signal Strength | Interpretation |
|---|---|---|
| 1 posting, senior IC level | Medium | Active program, early stage |
| 1 posting, VP/Director level | High | Leadership vacancy = new decisions imminent |
| 3+ postings, same platform | Very High | Funded program, scaling |
| 0 postings in tech area | Signal | Program may be internal-only or stalled |
| "Sr. Director, [Program]" open | Very High | Program exists, leadership unclear |
| Platform-specific roles + adjacent roles | Very High | Implementation active, not just vendor selection |

**Federal targets:**
```
site:usajobs.gov "[AGENCY]" IT program manager
site:usajobs.gov "[AGENCY]" cloud architect
site:sam.gov "[AGENCY]" request for information technology 2025 2026
```

---

### Dimension 6 — News and Press Releases

**Primary searches:**
```
"[COMPANY NAME]" press release technology 2025
"[COMPANY NAME]" acquisition merger announcement 2024 2025
"[COMPANY NAME]" regulatory FDA SEC warning 2025
```

**Secondary searches:**
```
"[COMPANY NAME]" technology partnership vendor 2025
"[COMPANY NAME]" leadership hire appointment 2025
"[COMPANY NAME]" restructuring cost program 2025
```

**Event-to-opportunity mapping:**

| News Event | Creates Opportunity |
|---|---|
| Acquisition close | ERP/CRM/HR integration; data migration |
| Divestiture | Stranded systems that need separation |
| New CIO/CDO/CTO hire | Vendor portfolio evaluation opens |
| FDA warning letter | QMS/CAPA technology; compliance consulting |
| Earnings beat + raised guidance | Growth investment; platform build-out budget |
| Earnings miss + cost program | Efficiency technology; outsourcing evaluation |
| Regulatory fine or consent decree | Compliance systems; managed services |
| Announced M&A (not yet closed) | Pre-position for integration work |

**Federal targets:**
```
"[AGENCY]" OIG report findings IT 2025
"[AGENCY]" GAO high risk IT management 2024 2025
"[AGENCY]" contract award press release 2025
Congress "[AGENCY]" appropriations hearing technology 2025
```

---

### Dimension 7 — Federal Contract Intelligence (Federal only)

**Primary searches on SAM.gov:**
```
Search: [AGENCY] + "IT services" (contract awards, last 24 months)
Search: [AGENCY] + "information technology" (active solicitations)
Search: [AGENCY] + RFI OR RFP (sources sought notices)
```

**Secondary searches:**
```
site:usaspending.gov "[AGENCY]" technology prime contractor
"[AGENCY]" IDIQ task order 2024 2025 award
"[AGENCY]" contract vehicle GWAC BIC award
"[AGENCY]" recompete IT services 2025 2026
```

**What to capture:**
- Prime contractors by program area (this is the competitive landscape)
- Contract values and periods of performance (expiration date = recompete window)
- Active solicitations (respond directly if qualified; note in Opportunity Map as Tier 1)
- GWAC/BIC vehicles the agency uses (must have vehicle to compete on task orders)
- Any protest history (signals incumbent may be vulnerable)

---

### Dimension 8 — AI Maturity & Agentic Readiness

**Goal:** Score the company's AI maturity across 5 dimensions, map agentic use case opportunities, and surface IP / research partnership potential. This is mandatory for all targets — it informs Section 12 (AI Agentic Vision) and Section 13 (IP & Research Opportunities).

**Primary searches — AI program signals (run all):**
```
"[COMPANY NAME]" artificial intelligence generative AI LLM 2025 2026
"[COMPANY NAME]" AI strategy chief AI officer announced 2024 2025
"[COMPANY NAME]" Azure OpenAI OR AWS Bedrock OR Google Vertex AI 2025
"[COMPANY NAME]" machine learning data science investment 2025
"[COMPANY NAME]" AI earnings call investor day 2025 2026
```

**Secondary searches — AI talent signals:**
```
"[COMPANY NAME]" jobs "machine learning engineer" OR "AI engineer" OR "data scientist" 2025
"[COMPANY NAME]" jobs "chief AI officer" OR "VP AI" OR "Head of AI" 2025
"[COMPANY NAME]" site:linkedin.com/jobs "LLM" OR "generative AI" OR "agentic"
```

**Secondary searches — IP and research signals:**
```
"[COMPANY NAME]" patent filing 2024 2025 AI machine learning algorithm
"[COMPANY NAME]" research publication academic partnership university 2025
"[COMPANY NAME]" R&D spending investment 2024 2025 annual report
site:patents.google.com "[COMPANY NAME]" AI OR "machine learning"
"[COMPANY NAME]" innovation lab center incubator 2025
```

**Secondary searches — agentic / automation signals:**
```
"[COMPANY NAME]" automation RPA workflow AI agent 2025
"[COMPANY NAME]" Salesforce Einstein OR ServiceNow AI OR SAP AI 2025
"[COMPANY NAME]" autonomous OR agentic OR copilot deployment 2025
"[COMPANY NAME]" API-first OR microservices OR event-driven architecture 2025
```

**Federal AI searches (federal targets only):**
```
"[AGENCY]" AI use case inventory OMB 2025
"[AGENCY]" Executive Order AI 2025 compliance
"[AGENCY]" chief AI officer CDO artificial intelligence 2025
site:ai.gov "[AGENCY]" use cases
```

**Signal interpretation table:**

| Signal Found | AI Readiness Score Guidance |
|---|---|
| Chief AI Officer appointed (< 18 months) | Agentic Readiness = 4–5; AI Governance = 3–4 |
| 10+ AI/ML job postings active | AI/ML Talent = 3–4 |
| Confirmed Azure OpenAI / AWS Bedrock partnership | Infrastructure = 4–5 |
| GenAI named in earnings call as strategic priority | All dimensions +1 vs. no-signal baseline |
| Zero AI job postings; no AI press releases | All dimensions = 1–2 |
| Active patents in AI/data domains | Data Maturity = 4–5; IP Landscape = High |
| R&D spend > 10% of revenue | Innovation culture confirmed; IP Landscape elevated |
| Only RPA / rule-based automation found | Agentic Readiness = 2 |
| Cloud migration recently completed | Infrastructure = 3–4 |

**AI Readiness scoring guidelines:**

Score each of the 5 dimensions on a 1–5 scale based on evidence found:

| Dimension | Score 1 | Score 3 | Score 5 |
|---|---|---|---|
| Data Maturity | No data strategy mentioned; siloed systems | Active data lake/warehouse project | Unified data platform live; ML-ready pipelines confirmed |
| Infrastructure | On-premise only; no cloud signals | Hybrid cloud in progress | Cloud-native; multi-cloud; MLOps platform confirmed |
| AI / ML Talent | No AI roles found | 3–9 AI/ML postings | 10+ AI/ML roles; Chief AI Officer present |
| AI Governance | No responsible AI policy found | AI risk mentioned in 10-K; governance starting | Published responsible AI policy; model risk framework active |
| Agentic Readiness | No API/automation signals | RPA live; some API-first signals | Agentic workflows confirmed; microservices architecture; autonomous agents piloted |

**What to capture for Section 12 data object:**
- Score (1–5) for each dimension
- The specific evidence signal that drove each score
- The implication of each score for the engagement approach

**What to capture for Section 13 data object:**
- Patent filing activity and domains (from Google Patents, USPTO)
- R&D spend as % of revenue (from 10-K or earnings press release)
- Any confirmed academic or research partnerships
- Any innovation lab or incubation center announcements
- The company's unique data assets (what data do they generate that competitors don't have?)

---

## CONFIDENCE SCORING

Before populating the report, assign a confidence score to each major data block:

| Score | Definition | How to Handle |
|---|---|---|
| High | Found in Tier 1 or Tier 2 source, corroborated | Include as stated; cite source |
| Medium | Found in one Tier 2 source, not corroborated | Include; cite source; note if single-source |
| Low | Inferred from vertical playbook or industry norm | Apply [ASSUMPTION — basis] flag |
| Not Found | Searched 3+ times; no result | Write "[DATA NOT FOUND — verify directly]" |

Never upgrade a Low confidence item to Medium or High without finding a confirming source.

---

## HANDLING INCOMPLETE RESEARCH

If research is incomplete after minimum search attempts, handle as follows:

**Leadership name not found:**
Write `[NAME NOT CONFIRMED — verify at [company].com/leadership before outreach]` — flagged in orange.

**Revenue not found (private company):**
Write `[ASSUMPTION — estimated $X–$Y based on employee count and industry revenue-per-employee benchmarks for [vertical]]`

**Technology stack not confirmed:**
Populate only the Inferred column of Section 7 with [ASSUMPTION] flags. Do not leave Section 7 empty — apply the vertical playbook defaults.

**Job postings not found:**
Write: "No open technology roles found on [search date]. This may indicate the program is fully staffed, internally resourced, or on hold. Recommend direct channel verification with [NAME] before assuming no active program."

**Federal contract data not accessible:**
Note: "SAM.gov contract data for [AGENCY] is not publicly accessible at this classification level. Recommend agency team member verification through official channels."

---

## RESEARCH LOG FORMAT

Maintain a brief research log internally (not in the report) to track what was searched and found:

```
DIMENSION 1 — Company Profile
  Search 1: "[COMPANY]" revenue employees FY2025 → Found: FY2025 revenue $4.2B (10-K, Feb 2026)
  Search 2: "[COMPANY]" earnings Q4 2025 → Found: Q4 call transcript, CEO commentary on [priority]
  Search 3: "[COMPANY]" annual report 2025 → Found: Confirmed HQ, FY end, 3 strategic priorities

DIMENSION 2 — Leadership
  Search 1: "[COMPANY]" CIO appointed 2024 2025 → Found: [NAME] appointed CIO Jan 2025 (PR)
  Search 2: "[EXECUTIVE NAME]" prior company → Found: Prior role at [COMPANY] confirmed LinkedIn
  Search 3: "[COMPANY]" CFO CHRO executive team → Found: 4 confirmed C-suite names
  Search 4: "[EXECUTIVE NAME]" technology priorities interview → Found: Quote from CIO conference March 2025

[Continue for each dimension]
```

This log is for your own quality check — not included in the report.

---

## QUALITY CHECK BEFORE WRITING

Before starting Phase 2, verify:

- [ ] Company revenue confirmed or estimated with basis
- [ ] At least 3 C-suite names confirmed with tenure dates
- [ ] At least 3 strategic priorities sourced from public statements
- [ ] At least 1 confirmed technology platform (not all inferred)
- [ ] At least 3 job postings found (or absence documented with explanation)
- [ ] At least 1 news item from the last 12 months
- [ ] Federal: at least 1 contract award found on SAM.gov or absence documented
- [ ] Industry vertical confirmed and correct playbook loaded
- [ ] All 5 AI readiness dimensions scored with evidence (Dimension 8)
- [ ] At least 3 AI agentic use cases identified and mapped to confirmed strategic priorities
- [ ] IP landscape assessed across all 3 categories (patents, data assets, processes)
- [ ] At least 2 Pioneering Bets drafted with specific thesis tied to this company's unique position
- [ ] R&D spend signal found or absence documented for Section 13

If fewer than 4 of the first 8 items are satisfied, the research is insufficient. Do additional searches before writing. The AI and IP dimensions (items 9–13) may be partially inferred using vertical playbooks when direct signals are absent — but every inference requires an [ASSUMPTION — basis] flag.
