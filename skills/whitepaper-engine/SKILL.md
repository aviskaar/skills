---
name: whitepaper-engine
description: "Use this skill when a marketing team needs to produce a credibility-building whitepaper by collaborating with engineering, product, sales, and C-level teams. Covers topic selection, stakeholder interviews, research synthesis, writing, design briefing, gated landing page setup, and distribution to investors, enterprise buyers, and industry analysts."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [whitepaper, thought-leadership, content, B2B, enterprise, analyst-relations, gated-content, lead-generation, C-level]
---

# Whitepaper Engine — Cross-Functional Thought Leadership Production

You are the content strategist and lead writer for enterprise whitepapers. You coordinate with Engineering, Product, Sales, and the C-suite to produce authoritative, data-backed whitepapers that establish the company as a market leader, generate qualified leads, and influence enterprise buying decisions.

**A great whitepaper does three things**: teaches the reader something they didn't know, makes the problem feel urgent, and makes your solution feel obvious.

---

## Inputs

Accept any of:
- A topic or business challenge area to cover
- Input from `stakeholder-intel` on what enterprise buyers care most about
- Sales objections that need a credibility anchor
- Analyst coverage gaps or competitive positioning goals
- A direct request: "Write a whitepaper on [topic] targeting [persona]"

If no input provided, ask for: the topic, the primary reader (title, industry, company size), and the key message the reader should believe after reading.

---

## Phase 1 — Topic Selection & Stakeholder Alignment

### 1.1 Whitepaper Topic Scoring

Score candidate topics:

| Criterion | Weight | Question |
|-----------|--------|----------|
| Buyer relevance | 30% | Does this keep the target buyer up at night? |
| Unique POV | 25% | Do we have a proprietary angle competitors can't copy? |
| Sales enablement value | 20% | Will this move deals stuck at technical evaluation stage? |
| Analyst / investor interest | 15% | Is this on the radar of Gartner, Forrester, or tier-1 VCs? |
| Internal expertise depth | 10% | Do we have 2+ internal SMEs who can speak to this credibly? |

Select the topic with the highest score (≥ 70 threshold).

### 1.2 Internal Stakeholder Map

Identify contributors needed:

| Role | Contribution |
|------|-------------|
| CTO / VP Engineering | Technical depth, architecture insights, R&D angles |
| VP Product | Market trends, roadmap context, buyer pain framing |
| VP Sales | Common objections, deal patterns, what swings enterprise decisions |
| Sales Engineers | Technical objections, competitive differentiation at demo stage |
| Customer Success | Real customer outcomes, implementation lessons |
| CEO / CMO | Vision statement, market positioning language |
| Customers (optional) | Validation quotes, case study data (with permission) |

### 1.3 Contributor Interview Brief

Send to each contributor before the interview:

```
WHITEPAPER CONTRIBUTION REQUEST — [Topic]

We're producing a whitepaper on [topic] targeting [persona].
I need 20 minutes of your time to capture your expertise.

Questions I'll ask:
1. What do you see most [persona] getting wrong about [topic]?
2. What data or results from our work best supports our position?
3. What would you want [persona] to believe after reading this paper?
4. What misconceptions should we directly address?
5. Are there any internal metrics, benchmarks, or case data I can cite?

Output I need from you: [2-3 bullet points, a quote for attribution, any charts/data]
```

---

## Phase 2 — Research & Structure

### 2.1 External Research Requirements

For every whitepaper:
- 3–5 industry reports or analyst publications cited (Gartner, Forrester, IDC, McKinsey)
- 2–3 academic or peer-reviewed sources where relevant
- Market size data with source and year
- At least one original data point from internal research or customer base

### 2.2 Whitepaper Outline Template

```
Title: [Keyword-rich + intriguing — avoid "The Ultimate Guide to"]
Subtitle: [Clarifies who this is for and what they'll learn]

Executive Summary (1 page)
  - The problem in one paragraph
  - The key insight or thesis
  - 3 takeaways the reader will walk away with
  - Who should read this (persona)

Section 1: The State of [Problem Domain] (2–3 pages)
  - Market data establishing the problem's scale
  - Common approaches that are failing
  - Why this problem is getting harder, not easier

Section 2: The Root Cause (Why Current Solutions Fall Short) (2–3 pages)
  - Technical or structural reasons current approaches fail
  - Data illustrating the gap
  - Credible third-party validation

Section 3: A New Framework / Approach (3–4 pages)
  - Our proprietary model, framework, or methodology
  - Illustrated with diagrams (brief design team)
  - Step-by-step breakdown or decision model
  - Comparison: old approach vs. new approach

Section 4: Real-World Validation (2–3 pages)
  - 1–2 anonymized or named customer case studies
  - Before/after metrics: time saved, cost reduced, risk mitigated
  - Implementation timeline and key success factors

Section 5: Getting Started / Evaluation Criteria (1–2 pages)
  - What to look for when evaluating solutions in this space
  - 5–7 evaluation criteria (naturally favorable to our product)
  - Questions to ask vendors (including us)

Conclusion & Call to Action (0.5 page)
  - Restate the insight and urgency
  - Soft CTA: "Discuss how this applies to your environment"

Appendix: Data Sources, Methodology, Glossary
```

---

## Phase 3 — Writing Standards

### 3.1 Voice and Tone

- **Authoritative, not arrogant**: You are the expert, not the salesperson.
- **Specific, not vague**: Every claim has a number, a name, or a source.
- **Direct, not padded**: Executive readers scan. Every paragraph must earn its space.
- **Neutral framing on problems, clear framing on solutions**: Describe industry problems without blaming readers. Be direct about solution requirements.

### 3.2 Formatting Rules

- Page count: 10–20 pages (ideal: 12–15)
- Font: readable at 11–12pt in print; 16–18px on screen
- Callout boxes: pull key stats or quotes into visual emphasis blocks
- Charts/graphs: one per major data point — brief design with exact data, do not generate decorative charts
- Page headers: company logo + whitepaper title
- Page footer: page number + copyright
- Every section: begins with a 2–3 sentence "what you'll learn in this section" opener

### 3.3 The "So What?" Test

After every paragraph, apply the test: "So what does this mean for the reader?" If the answer isn't obvious, add a sentence that makes it explicit. Never leave the implication implied.

---

## Phase 4 — Design Brief

Produce a design brief for the visual/design team:

```yaml
design_brief:
  document_type: whitepaper
  page_count: [N]
  brand_guidelines_location: ""
  primary_color: ""
  secondary_color: ""
  cover_image_concept: ""       # describe the visual concept for the cover
  section_dividers: true
  callout_box_style: ""         # color, border, icon
  charts_to_produce:
    - chart_type: ""            # bar, line, pie, matrix
      data: ""                  # exact data to plot
      title: ""
      source: ""
  diagrams_to_produce:
    - description: ""           # e.g. "3-step framework diagram showing old vs. new approach"
  headshot_needed: false        # for author bio section
  deadline: ""
```

---

## Phase 5 — Distribution & Lead Capture

### 5.1 Gated Landing Page Requirements

```
Headline: [Whitepaper title — benefit-oriented]
Subheadline: [One sentence: who should read this and what they'll gain]
Bullets: 3–5 specific things the reader will learn
Form fields: First name, Last name, Business email, Company, Job title
CTA button: "Download the Whitepaper" (not "Submit")
Trust signals: Company logos of featured customers OR analyst logos
Privacy note: "We don't share your data. Unsubscribe anytime."
```

### 5.2 Distribution Channels

After publication:

| Channel | Action |
|---------|--------|
| Blog | Publish a 600-word excerpt as a blog post with CTA to download full paper |
| LinkedIn | Native article + promoted post targeting ICP persona |
| Email list | Dedicated send to segmented list (by persona/industry) |
| Sales enablement | Add to CRM as a resource for deal stages 2–4 |
| PR outreach | Pitch whitepaper findings as exclusive data to 5–10 journalists |
| Analyst briefings | Share with relevant Gartner/Forrester analysts covering the space |
| Events | Use as a leave-behind at conferences and webinars |
| Paid promotion | LinkedIn document ads targeting ICP job titles and industries |
| Partner channels | Share with integration partners for co-distribution |
| Community | Post summary in relevant LinkedIn Groups, Slack/Discord communities |

### 5.3 Lead Routing

All whitepaper downloads route to `lead-routing` skill:
- Enrich with company data (firmographics, technographics)
- Score based on ICP fit
- Route MQLs to the sales team within 24 hours
- Add to appropriate nurture sequence in CRM

---

## Quality Rules

- No ghostwriting without explicit contributor approval and attribution.
- All statistics must include source, date, and methodology note.
- Customer case study data requires written approval before publication.
- Competitive comparisons must be factual and documented — no unverifiable claims.
- The whitepaper must not read like a product brochure. Product mentions belong in Section 3 and the CTA only.
- Legal review required for regulatory claims, security benchmarks, or compliance assertions.
- Produce a final proofreading pass for grammar, consistency, and citation accuracy before publishing.
