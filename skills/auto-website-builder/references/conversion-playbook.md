# Conversion Playbook Reference

CRO patterns, investor signals, talent hooks, and messaging frameworks for the auto-website-builder skill.

---

## Conversion Rate Optimization (CRO) Patterns

### The 5-Second Test
A visitor who has never seen your product should be able to answer these three questions within 5 seconds of landing on your homepage:
1. What is this?
2. Who is it for?
3. Why should I care?

If they can't, the hero section fails. Rewrite until they can.

### CTA Hierarchy Rules
Every page has exactly one primary CTA. Secondary CTAs must be visually subordinate.

| CTA Type | Visual Treatment | Use When |
|---|---|---|
| Primary | Filled button, brand accent color | Main conversion goal |
| Secondary | Ghost/outline button or text link | Alternative action |
| Tertiary | Plain text link or icon link | Supplementary navigation |

**CTA Copy Formula**:
- Bad: "Submit" / "Click here" / "Learn more"
- Good: "[Verb] + [Value object]" → "Start building free" / "See a live demo" / "Get your report"
- Best: "[Verb] + [Value object] + [Implied timeframe]" → "Start free in 60 seconds" / "Book a 15-min demo"

### Above-the-Fold Conversion Maximizers
1. **Specificity wins**: "Reduce cloud costs by 40%" beats "Save money on infrastructure"
2. **Social proof proximity**: Place proof within visual scanning range of the CTA
3. **Risk reversal**: "No credit card required" next to every sign-up button
4. **Urgency without lying**: Real deadlines (beta access, limited seats) work; fake timers destroy trust
5. **Clarity over cleverness**: Clever taglines lose to clear ones in A/B tests — always

### Scroll Depth Optimization
Insert re-engagement CTAs at these scroll depths:
- 25%: CTA repeated after problem/solution section
- 50%: Testimonial-adjacent CTA
- 75%: Case study CTA
- 100%: Final CTA banner before footer

### Form Conversion Optimization
- Every additional form field reduces conversion by 10–15%
- For top-of-funnel: name + work email only (2 fields maximum)
- For demo requests: company + role + team size are acceptable (qualify the lead)
- Use progressive profiling: ask more questions AFTER initial conversion
- Auto-detect company name from work email domain (reduces friction)
- Real-time validation: show green checkmark or error as they type, not on submit

### Page Speed as Conversion Factor
- Every 100ms of load time = 1% decrease in conversion rate (Deloitte study)
- Target: < 2.5s LCP (Largest Contentful Paint) on 4G mobile
- Compress hero images to < 200KB
- Defer all non-critical JavaScript
- Use CDN for all static assets

---

## Investor-Facing Content Signals

Investors will visit your website before, during, and after due diligence. Every section should pass the investor scan test.

### What Investors Look For in 90 Seconds

1. **Market size signal**: Do the numbers suggest a large TAM?
   - Show: customer base breadth, data volume, transaction volume, geographic reach

2. **Traction proof**: Is there real momentum?
   - Show: customer logos (recognizable names), growth metrics, retention indicators

3. **Team credibility**: Are the founders qualified to win?
   - Show: prior company logos, titles, patents, academic credentials

4. **Category definition**: Is this company creating or leading a category?
   - Show: clear positioning, unique terminology, original research/data

5. **Moat signals**: Is there a defensible advantage?
   - Show: proprietary data, network effects, deep integrations, compliance certifications

### Investor-Specific Sections to Include

**Metrics Bar** (visible on homepage):
```
[ARR or revenue range — if public]    [Customer count]    [YoY growth %]    [NPS score]
```
If metrics are not public, use:
```
[X+ enterprise customers]    [Y million requests/month]    [Z countries]    [W% retention]
```

**Investor Relations Footer Link** (for post-Series A):
- Link to press releases, funding announcements, major milestones
- Do not disclose cap table or internal financials publicly

**"As seen in" Press Strip**:
- Credibility by association
- Include funding announcement coverage (TechCrunch, Forbes, Bloomberg)

**Strategic Partner Logos**:
- Cloud marketplace badges (AWS, Azure, GCP) signal enterprise readiness
- Partner program logos (Salesforce ISV, etc.) signal ecosystem integration

### Investor Language vs. Customer Language

| Investor Wants to Hear | Customer Wants to Hear |
|---|---|
| "Net revenue retention > 120%" | "Our customers expand their usage because it keeps working harder for them" |
| "$1.2B TAM with 15% CAGR" | "[Product category] is growing — and your team needs to be ready" |
| "Land and expand motion with 6-month payback" | "Start with one team, roll out to the org at your pace" |
| "Defensible data network effect" | "The more you use [Product], the smarter it gets for your specific context" |
| "Gross margins of 80%+" | (not relevant to customers) |

The homepage must use customer language. The "About" or investor section can layer in investor signals.

---

## Talent Attraction Hooks

### What Engineers Evaluate When Visiting a Careers Page

In order of importance:
1. **Technical challenge**: Is the problem technically interesting?
2. **Stack credibility**: Are they using modern, respected technology? (Show tech stack explicitly)
3. **Team**: Who am I going to learn from? (Show engineering blog, OSS contributions, conference talks)
4. **Compensation**: Is equity real? (Show vesting schedule, cliff, refresh policy)
5. **Growth**: Will this job stretch me? (Show promotion criteria, learning budget)
6. **Culture fit**: Will I actually enjoy this? (Show authentic team photos and culture copy)

### Engineering Credibility Signals
- Link to engineering blog with genuine technical depth
- Link to GitHub with real activity
- Mention specific technical problems solved ("We process 4TB of data per day in real-time")
- Show the tech stack without hiding anything
- Reference papers, patents, or open-source contributions

### Tech Stack Transparency Block (for Engineering pages)
```
HOW WE BUILD

Languages:    Go, TypeScript, Python
Infrastructure: Kubernetes on GCP, Terraform, Argo CD
Data:         PostgreSQL, ClickHouse, Kafka, Redis
Observability: Grafana, Tempo, Loki, Prometheus
Frontend:     Next.js, TypeScript, Tailwind CSS
Testing:      Playwright, Vitest, property-based testing
Review:       PRs reviewed within 24h; no bureaucracy
```

### Authentic Culture Signals (vs. Generic Culture Theater)

**Generic (avoid)**:
- "We work hard and play hard"
- "We're a family"
- "We value innovation"
- Stock photos of diverse people laughing

**Authentic (do this)**:
- Specific rituals: "Every Friday we do a 30-min demo of what shipped that week"
- Specific norms: "We don't do meetings before 10am — async is the default"
- Specific values with edge cases: "We value directness — that means we tell each other hard truths, and we do it kindly"
- Real team photos, even imperfect ones
- Engineering manager writing about how they give feedback

### Salary and Equity Transparency
Companies that publish salary bands attract better candidates faster:
- Reduces negotiation friction
- Signals fairness
- Filters out candidates who won't fit the comp range
- Increases diversity (published bands reduce pay gaps)

Recommended disclosure level:
```
Senior Software Engineer — $180K–$220K base + [0.05%–0.15%] equity
(Equity based on 4-year vest, 1-year cliff. Valued at Series B price of $X.)
```

---

## Messaging Frameworks

### The Problem-Agitate-Solve (PAS) Framework
Used for: hero copy, email campaigns, case study intros

```
PROBLEM: [Name the specific, painful situation]
"You're spending 3 days a month manually reconciling spreadsheets across 5 systems."

AGITATE: [Make the pain visceral — consequences, cost, emotion]
"Meanwhile, your competitors are making decisions in hours. Every week you wait is revenue at risk."

SOLVE: [Introduce the product as the specific solution]
"[Product] connects your systems in minutes and keeps everything in sync — automatically."
```

### The Before/After/Bridge (BAB) Framework
Used for: case studies, testimonials, "How it works" sections

```
BEFORE: [The world without the product]
"Sarah's team reviewed 200 support tickets a day manually. CSAT was at 62%."

AFTER: [The world with the product]
"After deploying [Product], her team handles 3× the volume with 94% CSAT."

BRIDGE: [The product is the bridge]
"[Product] triages and routes tickets automatically, letting her team focus on complex issues only humans can solve."
```

### The Value Proposition Canvas Alignment
For each customer segment:
```
Jobs to be done:    [What the customer is trying to accomplish]
Pains:              [What frustrates them, risks they fear, obstacles they face]
Gains:              [Outcomes they want, measures of success, aspirations]

Pain relievers:     [How the product specifically addresses each pain]
Gain creators:      [How the product creates each desired gain]
Products/features:  [The specific capabilities that deliver the above]
```

### Headline Formulas (proven high-conversion patterns)

1. **The Outcome Formula**: "[Do desired outcome] without [unwanted pain]"
   - "Ship features faster without breaking production"
   - "Cut cloud costs in half without re-architecting your stack"

2. **The Specificity Formula**: "How [Company Type] [achieved specific metric] in [timeframe]"
   - "How fintech teams cut compliance reporting from 2 weeks to 2 hours"

3. **The Category Creation Formula**: "[New category name] for [Audience]"
   - "The AI-native observability platform for platform engineering teams"

4. **The Comparison Formula**: "[Product] is [familiar product], but [key differentiator]"
   - "Like Datadog, but for the AI inference layer" (use sparingly — risks anchoring to competitor)

5. **The Future State Formula**: "Meet the [adjective] way to [verb] [object]"
   - "Meet the faster way to onboard enterprise customers"

### Competitor Differentiation Matrix Template

```markdown
| Dimension           | [Your Product] | [Competitor A] | [Competitor B] | [Competitor C] |
|---------------------|----------------|----------------|----------------|----------------|
| Setup time          | < 5 min        | 2–4 hours      | Days           | Weeks          |
| Pricing model       | Usage-based    | Per-seat       | Per-seat       | Custom only    |
| Open source         | ✅ Core        | ❌             | ✅ Agent only  | ❌             |
| Data residency      | ✅ Any region  | US only        | US + EU        | ❌             |
| Real-time sync      | ✅             | ⚠️ 15-min lag  | ❌             | ✅             |
| API-first           | ✅             | ⚠️ Limited     | ✅             | ❌             |
| Enterprise SLA      | ✅ 99.99%      | ✅ 99.9%       | ✅ 99.5%       | ✅ 99.9%       |
| Dedicated support   | ✅ All plans   | Enterprise only| Enterprise only| Enterprise only|
```

Rules for the comparison table:
- Be accurate — false comparisons are a legal and reputational liability
- Use ⚠️ for "partial" — shows intellectual honesty and builds trust
- Focus on dimensions where you genuinely win
- Do NOT include dimensions where competitors clearly win (remove from table)
- Offer to link to sources for each claim

---

## SEO Architecture

### URL Structure Best Practices
```
/                           Homepage
/product                    Not /features or /solutions — "product" is highest intent
/pricing                    Not /plans — "pricing" is the searched term
/blog/[category]/[slug]     Category in URL for SEO clustering
/customers/[company-slug]   Each case study as an indexable page
/integrations/[tool-name]   One page per integration — massive long-tail SEO
/vs/[competitor-name]       Comparison landing pages — highest purchase intent traffic
/alternatives               "[Product] alternatives" — captures competitor-branded search
```

### High-Value Content Clusters

**Cluster 1 — Product education** (top of funnel):
- "What is [category]?"
- "How does [category] work?"
- "Benefits of [category]"
- "[Category] best practices"

**Cluster 2 — Comparison** (bottom of funnel):
- "[Product] vs [Competitor A]"
- "[Product] vs [Competitor B]"
- "Best [category] tools"
- "[Competitor A] alternatives"

**Cluster 3 — Integration** (middle/bottom):
- "[Product] + [Integration A]"
- "How to connect [Product] to [Tool]"
- "[Product] [Integration A] tutorial"

**Cluster 4 — Use case** (middle):
- "[Product] for [Industry]"
- "[Product] for [Team type]"
- "How [Job role] uses [Product]"

### Meta Description Template
```
[Primary keyword] — [unique value prop in ≤ 120 chars]. [CTA: Try free, Learn more, See how]. [Brand name].
```
Example: "AI-powered log analysis — find root cause 10× faster with [Product]. No query language needed. Try free. [Company]."

### Open Graph Image Spec
- Size: 1200×630px
- Content: Logo + tagline + product screenshot or illustration
- Background: Brand primary color or gradient
- Text: Must be readable at small sizes (avoid body copy in OG images)
- Format: PNG (not JPEG — better text rendering)

---

## Social Proof Hierarchy

Rank social proof assets by trust level (highest to lowest):

1. **Quantified case study**: "[Company name] reduced X by Y% in Z weeks" — most believable
2. **Named executive quote with specific outcome**: High credibility if name is recognizable
3. **G2 / Capterra aggregate rating**: "4.8/5 from 500+ reviews" — third-party verified
4. **Recognizable company logo**: Logo of Fortune 500 or category-leader customer
5. **Press coverage**: TechCrunch headline, Forbes quote, etc.
6. **Social media screenshot**: Real tweet/post from real user with username visible
7. **Generic testimonial without specifics**: Least believable — avoid if possible

### Review Embeds
Embed live G2, Capterra, or Product Hunt badges:
- G2: `<script src="https://www.g2.com/products/[slug]/widgets.js">` type="text/javascript"
- Capterra: badge widget from vendor portal
- Product Hunt: embed upvote button + badge

### Customer Logo Display Rules
- Use official brand logos (not screenshots — ask customers for SVG/PNG)
- Grayscale on light backgrounds — prevents color clash
- Show logos of recognizable companies prominently
- 5–8 logos for startups, 20–40 for growth-stage

---

## Technical SEO Checklist

Generate these files and configurations:

**robots.txt**:
```
User-agent: *
Allow: /
Disallow: /api/
Disallow: /admin/
Sitemap: https://[domain]/sitemap.xml
```

**sitemap.ts** (Next.js):
```typescript
import { MetadataRoute } from 'next'

export default function sitemap(): MetadataRoute.Sitemap {
  return [
    { url: 'https://[domain]', changeFrequency: 'weekly', priority: 1 },
    { url: 'https://[domain]/product', changeFrequency: 'monthly', priority: 0.9 },
    { url: 'https://[domain]/pricing', changeFrequency: 'monthly', priority: 0.9 },
    // ... dynamic blog/case study pages from CMS
  ]
}
```

**Schema.org Organization**:
```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "[Company Name]",
  "url": "https://[domain]",
  "logo": "https://[domain]/logo.png",
  "sameAs": [
    "https://twitter.com/[handle]",
    "https://linkedin.com/company/[handle]",
    "https://github.com/[handle]"
  ]
}
```

**Schema.org SoftwareApplication**:
```json
{
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  "name": "[Product Name]",
  "applicationCategory": "BusinessApplication",
  "offers": {
    "@type": "Offer",
    "price": "[starting price]",
    "priceCurrency": "USD"
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.8",
    "reviewCount": "500"
  }
}
```
