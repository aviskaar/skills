# Page Blueprints Reference

Detailed section-by-section specifications for every page in the auto-website-builder skill.

---

## Homepage — Conversion Architecture

The homepage has one job: convert a first-time visitor into a lead or signup within 90 seconds.

### Above the Fold (0–800px viewport)
Must contain:
- Logo + nav
- Hero headline (H1, ≤ 10 words)
- Hero subheadline (1 sentence, ≤ 20 words)
- Primary CTA button (high contrast, ≥ 48px tall)
- Secondary CTA (text link or ghost button)
- Social proof signal (logo strip OR "X companies trust [Product]" OR star rating)
- Hero visual (product screenshot, illustration, or 3D render — right side or below on mobile)

Rules:
- Zero ambiguity: a stranger should understand what the product does in 5 seconds
- No auto-playing videos without mute
- CTA button color must contrast against background by ≥ 7:1

### Section 2 — Problem Agitation
Structure: 3-column problem cards
```
[Icon]
[Problem headline — 4 words max]
[1–2 sentence elaboration. Be specific: name the pain, not the category.]
```
Purpose: Make the visitor feel understood. Do NOT mention your product yet.

### Section 3 — Solution Overview
Structure: Large product screenshot or demo video embed, flanked by 3 benefit bullets
```
[Product visual — full width or 60% column]

[Checkmark] [Benefit 1 headline] — [1 line elaboration]
[Checkmark] [Benefit 2 headline] — [1 line elaboration]
[Checkmark] [Benefit 3 headline] — [1 line elaboration]

[CTA button — repeated here]
```

### Section 4 — How It Works
Structure: 3 or 4 numbered steps
```
Step 1: [Connect / Install / Integrate]
[Icon + 2-sentence description]

Step 2: [Configure / Set up / Define]
[Icon + 2-sentence description]

Step 3: [Run / Launch / Go live]
[Icon + 2-sentence description]

[Optional Step 4: Iterate / Optimize / Scale]
```
Rule: If it takes more than 4 steps to explain, the product is too complex to explain on a homepage — simplify the narrative.

### Section 5 — Feature Highlights
Structure: Alternating left/right layout for 3–6 features
```
[Left: feature screenshot or illustration]  [Right: icon + H3 headline + 2-para benefit copy + "Learn more →" link]
[Right: icon + H3 headline + 2-para benefit copy + "Learn more →" link]  [Left: feature screenshot]
```
Alternative: 3×2 grid of feature cards for products with many features.

### Section 6 — Metrics Bar
Structure: 4-column strip with large numbers
```
[43%]          [2.4 billion]     [< 50ms]        [99.99%]
Cost reduction  Requests/month   P99 latency     Uptime SLA
```
Rules:
- Numbers must be real or clearly labeled estimates
- Use animation on scroll-enter (count up from 0)
- Add source footnote if claim is from a study

### Section 7 — Social Proof — Testimonials
Structure: 3-column testimonial cards
```
★★★★★
"[Specific, outcome-focused quote — not generic praise. Include a number if possible.]"
[Photo] [Full Name] — [Title], [Company] [Company Logo]
```
Rules:
- Never use anonymous testimonials
- Quotes must mention specific outcomes, not just "great product"
- Include company logo for B2B products

### Section 8 — Case Study Feature
Structure: Full-width card with dark background
```
[Customer Logo]
"[Pull quote with specific metric]"
[Name, Title]

[Before / After stats or outcome metrics]
[Read full case study →]
```

### Section 9 — Integrations
Structure: Logo grid with headline
```
Works with the tools your team already uses.
[Logo] [Logo] [Logo] [Logo] [Logo] [Logo] [Logo] [Logo]
[Logo] [Logo] [Logo] [Logo] [Logo] [Logo] [Logo] [Logo]
[See all integrations →]
```

### Section 10 — Trust & Compliance
For B2B / enterprise products:
```
[SOC 2 Type II badge]  [GDPR compliant badge]  [ISO 27001]  [HIPAA]
Enterprise-grade security. [2-line description of security posture.]
[Security overview →]
```

### Section 11 — Final CTA Banner
Structure: Full-width, brand-color background
```
[Large headline: Transform how your team works. / Start shipping faster. / etc.]
[Subline: Free 14-day trial. No credit card required. Cancel anytime.]
[Primary CTA button]   [Secondary: "Talk to sales"]
```

### Section 12 — Footer
4-column layout:
```
Col 1 — Product:        Col 2 — Company:       Col 3 — Resources:     Col 4 — Legal:
Features                About                  Blog                   Privacy Policy
Pricing                 Careers                Documentation          Terms of Service
Changelog               Press                  API Reference          Security
Integrations            Investors              Status                 Cookie Policy
Roadmap                 Contact                GitHub

[Logo]  [Tagline — 1 line]  [© Year Company, Inc.]  [Social icons: Twitter/X, LinkedIn, GitHub, YouTube]
```

---

## Product / Features Page Blueprint

### Hero
- H1: "[Product Name] — [Core capability in ≤ 6 words]"
- Subheadline: Full positioning statement
- Hero image: Product UI screenshot at full fidelity (not a mockup)

### Feature Deep-Dive Sections (repeat per feature)
```
[Full-width product screenshot or animated GIF]
[H2: Feature headline — outcome-first]
[2 paragraphs: What it does, Why it matters, How it's different]
[3 bullet points: concrete sub-capabilities]
["Read the docs →"] link
```

### Competitor Comparison Table
```
| Capability              | [Product] | Competitor A | Competitor B |
|-------------------------|-----------|--------------|--------------|
| [Feature 1]             | ✅        | ✅           | ❌           |
| [Feature 2]             | ✅        | ⚠️ Partial   | ❌           |
| [Feature 3]             | ✅        | ❌           | ❌           |
| [Feature 4]             | ✅        | ✅           | ✅           |
| Pricing model           | Per-seat  | Per-seat     | Usage-based  |
| Free tier               | ✅        | ❌           | ✅           |
| Enterprise SSO          | ✅        | ✅           | ❌           |
```

### Architecture Diagram Spec
For technical products, produce this description for the diagram:
```
ARCHITECTURE DIAGRAM DESCRIPTION:
Components:
- [User/Client] → [Entry point: API / SDK / Web app]
- [Entry point] → [Core service layer]
- [Core service] → [Data layer: DB / Cache / Queue]
- [Core service] ↔ [Integration layer: 3rd party APIs]
- [Control plane: Dashboard / Config]

Data flow:
1. User sends [request type] to [entry point]
2. [Entry point] authenticates via [auth method]
3. Request routed to [core service]
4. [Core service] reads/writes to [data layer]
5. Response returned in [format] within [latency target]

Style: Clean boxes with rounded corners, connecting arrows with labels,
color-coded by layer (blue=client, purple=core, green=data, gray=external)
```

---

## Pricing Page Blueprint

### Structure
```
[H1: Simple, transparent pricing]
[Subline: Start free. Scale as you grow. No surprises.]

[Annual/Monthly Toggle — default annual to show savings]

[Pricing card grid — 3 columns]

[Feature comparison table — full width]

[FAQ section]

[Enterprise CTA strip]
```

### Pricing Card Structure
```
[TIER NAME] — [Starter / Pro / Enterprise]
[1-line positioning: "For individuals and small teams" etc.]

$[Price] / [user/month or month]
[If annual: billed annually — save X%]

[PRIMARY CTA — "Start free" / "Get started" / "Contact sales"]

[Feature list: 8–12 items]
[✅ Feature]
[✅ Feature]
[❌ Not included — links to next tier]
```

Tier personality:
- **Starter**: Remove friction. Free trial or freemium. Generous limits. Goal: get them in.
- **Pro**: Most popular badge. 3–4× price jump from Starter. This is where 70% of revenue comes from.
- **Enterprise**: No price shown. "Contact sales". Custom contract. Emphasize: SSO, SLAs, dedicated support, compliance.

### FAQ — Required Questions
1. Can I change plans later?
2. What happens when I exceed my [usage unit] limit?
3. Do you offer discounts for nonprofits / startups / education?
4. What payment methods do you accept?
5. Is there a free trial?
6. Do I need a credit card to start?
7. What's your refund policy?
8. How do I cancel?
9. What does "unlimited" actually mean?
10. Do you offer annual invoicing for Enterprise?

---

## Case Studies Page Blueprint

### Page Hero
```
[H1: Trusted by teams at [Type of company] companies]
[Subline: See how [X]+ companies [achieved outcome] with [Product]]

[Customer logo wall — 20–40 logos in 4–5 rows, grayscale]
[Filter tabs: All | [Industry 1] | [Industry 2] | [Industry 3] | By use case]
```

### Case Study Card
```
[Company logo]         [Industry tag]  [Use case tag]
[H3: How [Company] [achieved specific outcome] with [Product]]
[2-line excerpt]
[Metric 1: 3× faster]  [Metric 2: 60% cost reduction]  [Metric 3: 2 weeks to deploy]
[Read story →]
```

### Individual Case Study Page Structure
1. **Header**: Customer logo + Product logo + "Customer story" label
2. **Stats bar**: 3 outcome metrics (large numbers, short labels)
3. **About the company**: 2–3 sentences, industry, size, location
4. **The challenge**: 2–3 paragraphs. Name the pain specifically. Quantify if possible.
5. **Why [Product]**: Decision criteria, alternatives considered, what tipped the balance
6. **The solution**: How they use the product, configuration, integration with their stack
7. **The results**: Before/after comparison. Quantified outcomes. Direct quotes.
8. **What's next**: Future plans with the product (shows retention signal to investors)
9. **Quote block**: Full-width pull quote from executive sponsor
10. **CTA**: "Ready to see results like [Company]? [Start free trial]"

---

## About Page Blueprint

### Sections in Order

**1. Mission Statement**
```
[H1: We believe [aspirational state of the world]]
[2 paragraph narrative: What we're building toward, not just what we make]
```

**2. The Problem We're Solving**
```
[3-stat or 3-fact context block: why this problem matters now]
[2 paragraphs: status quo pain, why existing solutions fail]
```

**3. Our Approach**
```
[3-column: Principle 1 | Principle 2 | Principle 3]
[Each: icon + title + 2-sentence belief]
```

**4. The Team**
```
[H2: The people building [Product]]
[Subline: From [Company], [Company], and [University] — we've been in your shoes.]

[Grid of team cards — 3 or 4 per row]
[Photo] [Name] [Title] [2-sentence bio — include one personal or surprising detail] [LinkedIn icon]
```

Rules:
- Include founder bios first
- Mention relevant prior companies (builds credibility)
- Add engineers and key non-engineering leaders
- Advisors get a separate smaller section

**5. Investors / Backers**
```
[H3: Backed by]
[Logo row: VC firm 1, VC firm 2, Angel 1...]
[Optional: Short quote from lead investor]
```

**6. Press & Recognition**
```
[Logo row: TechCrunch, Forbes, Wired, etc.]
["As seen in" label — do not fabricate]
[Link to press kit]
```

---

## Blog Architecture

### Category Taxonomy (standard)
- Announcements / Product news
- Tutorials / How-to guides
- Engineering / Technical deep-dives
- Company / Culture
- Industry insights / Thought leadership
- Customer stories

### Article Page Structure
```
[Breadcrumb: Blog > Category]
[H1: Article title — SEO-optimized, keyword in first 4 words]
[Author card: Photo, name, title, date, read time, social share buttons]
[Hero image — 1200×630]
[Table of contents — auto-generated from H2s, sticky on desktop]
[Article body: H2s, H3s, code blocks, callout boxes, inline CTAs]
[Author bio block at bottom]
[Related articles — 3 cards]
[Newsletter CTA]
[Comment section or link to GitHub Discussions]
```

### Content Calendar Seed — First 6 Articles
Generate these for every new product:
1. "Why we built [Product]" — Founder origin story
2. "[Product] vs [Top Competitor]: An honest comparison" — SEO gold
3. "How [Customer] achieved [Metric] with [Product]" — Case study
4. "The [Industry] problem nobody is talking about" — Thought leadership
5. "[Technical deep-dive] How [Product] handles [Hard problem]" — Engineering credibility
6. "[Product] launch: everything you need to know" — Announcement

---

## Careers Page Blueprint

### Sections

**1. Culture Hero**
```
[H1: Build something that matters. With people who give a damn.]
[2-sentence culture statement]
[Team photo or culture collage — authentic, not stock]
```

**2. Values**
```
[H2: What we believe in]
[4–6 value cards: Icon + Title + 2-sentence authentic description]
```
Anti-pattern: Generic values (Integrity, Innovation, Customer-first) that every company claims.
Do this instead: Specific, opinionated values that would repel the wrong person ("We'd rather ship than perfect" / "We write things down, always" / "We disagree out loud and commit fully").

**3. Benefits**
```
[Grid: 8–12 benefit items]
[Icon + Benefit title + 1-line elaboration]

Compensation:     Competitive salary + equity (we share the upside)
Health:           Medical, dental, vision — 100% covered for you + dependents
Remote:           Work from anywhere. Async-first. [# of meetups/year] offsites.
Learning:         $[Amount] annual learning budget — no approval needed
Equipment:        $[Amount] home office budget
Time off:         Unlimited PTO (we mean it — minimum 2 weeks encouraged)
Parental leave:   [X] weeks fully paid
401k:             [X]% match, vested immediately
```

**4. Open Roles**
```
[Filter: All | Engineering | Product | Design | Sales | Marketing | Operations]
[Role card: Title | Team | Location | Type (Full-time/Contract) | [Apply →]]
```

**5. Interview Process**
```
[Timeline: 4–5 steps, no more]
Step 1: Application review (48h response SLA)
Step 2: 30-min intro call with recruiter
Step 3: Technical screen / Take-home (≤ 2 hours)
Step 4: Team interviews (half day, one day)
Step 5: Offer (within [X] business days)
```

**6. Closing CTA**
```
[Don't see your role? We're always interested in exceptional people.]
[Drop us a line →]
```

---

## Legal Pages

### Privacy Policy — Required Sections
1. Introduction and last updated date
2. Information we collect (enumerate: account info, usage data, cookies, device info, payment info)
3. How we use information (legal basis under GDPR: consent / legitimate interest / contract)
4. Information sharing (list all third-party processors with purpose)
5. Cookies and tracking technologies
6. Data retention (specify periods per data type)
7. Your rights (GDPR: access, rectification, erasure, portability, restriction, objection; CCPA: opt-out of sale)
8. International transfers (if applicable: Standard Contractual Clauses)
9. Children's privacy (COPPA: do not knowingly collect data from under-13)
10. Security measures (describe at a high level, do not list specific tools)
11. Changes to this policy
12. Contact information (DPO email if applicable)

**Tone**: Plain language. No legalese without plain-English translation. GDPR requires this.

### Terms of Service — Required Sections
1. Agreement to terms
2. Account registration and security
3. License grant (SaaS: limited, non-exclusive, non-sublicensable)
4. Acceptable use policy (explicit prohibited list)
5. Customer data (who owns it: customer owns their data; grant of license to provide service)
6. Intellectual property (company owns the product; customer IP not transferred)
7. Payment, billing, and refunds
8. Term and termination (conditions for termination by either party)
9. Warranty disclaimer (provided "as is", no uptime guarantee in ToS — that's in the SLA)
10. Limitation of liability (cap at fees paid in prior 12 months)
11. Indemnification
12. Governing law and dispute resolution
13. Changes to terms (30-day notice for material changes)
14. General provisions (severability, waiver, entire agreement)

**Note to user**: Always include — "This is AI-generated content. Have it reviewed by a qualified attorney before publishing."

---

## GitHub Integration Page Blueprint

For developer tools and open-source adjacent products:

```
[H1: Open source. Community-driven. Enterprise-ready.]
[Subline: [Product] is built in the open. Join [X] contributors.]

[4 metric boxes: Stars | Forks | Contributors | Releases]

[H2: What's open source]
[Table: Component | License | GitHub link]

[H2: How to contribute]
[4-step contribution guide with code snippets]

[H2: Community]
[Discord invite card | GitHub Discussions | Twitter/X | Newsletter]

[H2: Governance]
[RFC process, decision-making, roadmap visibility]

[CTA: View on GitHub →] [Join the community →]
```

---

## Implementation Steps Page Blueprint (`/implementation`)

Purpose: eliminate the "how do I get started?" objection. This page is linked from the homepage "How it works" section, the product page, and the pricing page. It closes deals by making implementation feel trivially easy.

### Page Hero
```
[H1: From zero to [value metric] in [timeframe]]
Examples: "From zero to production in 15 minutes" / "First insight in under 5 minutes"

[Subline: No professional services required. No week-long onboarding. Just [action].]

[3 trust chips: ✓ No vendor lock-in  ✓ Rollback in one command  ✓ Free migration support]

[Two CTAs: "Start now →"  |  "Talk to a solutions engineer"]
```

### Prerequisites Block
```
[H2: Before you begin]
[Checklist card:]
□ [Prerequisite 1] — e.g., "Node.js 18+ installed"
□ [Prerequisite 2] — e.g., "AWS account with S3 access"
□ [Prerequisite 3] — e.g., "API key from your dashboard"
[→ Create a free account in 30 seconds]
```

### Implementation Phases

Use a tabbed layout for multi-environment scenarios (Cloud / Self-hosted / Kubernetes / Docker).

**Phase 1 — Install** (target: < 2 minutes)
```
[Phase badge: 01]
[H3: Install [Product]]

[Tab: npm | pip | brew | curl | Docker]

[Code block with copy button:]
npm install @[product]/sdk

[Expected output block:]
✓ [Product] SDK v2.4.1 installed
✓ 3 dependencies resolved

[Validation step: "Verify installation"]
[package]/sdk --version
# Expected: [Product] CLI 2.4.1
```

**Phase 2 — Connect** (target: < 3 minutes)
```
[Phase badge: 02]
[H3: Connect to your environment]

[Code block:]
import { [Product]Client } from '@[product]/sdk'

const client = new [Product]Client({
  apiKey: process.env.[PRODUCT]_API_KEY,
  environment: 'production', // or 'staging'
})

[Callout box: "Where do I find my API key? →"]
[Validation: describe what a successful connection looks like]
```

**Phase 3 — Configure** (target: < 5 minutes)
```
[Phase badge: 03]
[H3: Configure for your use case]

[2–3 most common configuration patterns, each as a tabbed code example]

[Config file example with annotations:]
# [product].config.yaml
[annotated YAML or JSON configuration]

[Link to full configuration reference →]
```

**Phase 4 — Go Live** (target: < 2 minutes)
```
[Phase badge: 04]
[H3: Deploy and verify]

[Deploy command:]
[product] deploy --env production

[Expected output with success indicators]

[Validation dashboard screenshot or CLI output showing "Connected ✓"]
["You're live! Here's what happens next →"]
```

### Integration Recipes

For the top 5 integrations, produce copy-paste setup blocks:
```
[H2: Quick integration recipes]
[Tab pills: Slack | GitHub | Datadog | PagerDuty | Salesforce | ...]

[Each tab contains:]
[H3: [Product] + [Integration name]]
[2-sentence context: why this integration is useful]
[Code block: complete integration setup, copy-paste ready]
[Link: Full [Integration name] integration docs →]
```

### Troubleshooting Section
```
[H2: Common setup issues]
[Accordion FAQ:]

❌ "Error: ECONNREFUSED" — [cause + fix in 2 lines + code snippet]
❌ "API key invalid" — [cause + fix]
❌ "[Product] not found in PATH" — [cause + fix]
❌ "Permission denied on /etc/[product]" — [cause + fix]
❌ "Timeout after 30s" — [cause + fix]

[Link: Full troubleshooting guide →]
[CTA: Still stuck? Chat with support →]
```

### Next Steps Block
```
[H2: What's next]
[3-card grid:]
📖 Read the docs     → link
🎓 Take the tutorial → link
💬 Join the community → link
```

### Code Snippet React Component Spec
```tsx
// components/ImplementationSteps.tsx
// Features: numbered steps, tab switcher for language/env, copy-to-clipboard,
// line highlighting, expected output blocks, validation checkmarks
// State: activePhase (1–4), activeTab per phase
// Animation: step enters from right on phase change (Framer Motion)
// Mobile: steps stack vertically, code scrolls horizontally
```

---

## Pricing Page Deep-Dive

This expands the basic pricing blueprint with full strategy and all components.

### Pricing Model Selection Guide

Before generating the pricing page, select the right model:

| Model | Best For | Example |
|---|---|---|
| **Per-seat** | Collaboration tools, team tools | Notion, Linear, Figma |
| **Usage-based** | API products, infrastructure, AI | Stripe, Twilio, OpenAI |
| **Flat-rate** | Simple single-product SaaS | Basecamp |
| **Tiered usage** | Products with natural usage tiers | Mailchimp, Datadog |
| **Hybrid** | Enterprise SaaS with usage component | Snowflake, HubSpot |

State the chosen model at the top of the pricing page: "Priced per [seat/request/GB/event] — only pay for what you use."

### Tier Design Strategy

**Starter tier** — designed to create addiction, not revenue:
- Price: free or very low ($0–$29/month)
- Limits: generous enough to get real value, tight enough to hit a wall
- Target: individuals, small teams, developers evaluating
- Missing: the one thing power users need (SSO, audit logs, advanced analytics)
- Goal: 100% of revenue accounts should start here

**Pro tier** — the money tier:
- Price: 5–10× the Starter (signal: this is serious)
- Limits: effectively unlimited for most companies
- Target: growing teams, startup to mid-market
- Includes: everything Starter lacks + 3 "wow" features
- Badge: "Most Popular" — always highlight this tier
- Goal: 70% of paying customers should live here

**Enterprise tier** — the relationship tier:
- Price: never displayed ("Contact sales")
- Includes: custom contract, SLA, dedicated support, SSO, audit logs, data residency, procurement support
- Target: >500 seats, regulated industries, security-sensitive
- Differentiator: it's not features — it's peace of mind and accountability
- Goal: 5–10% of customers, 40–60% of revenue

### ROI Calculator Spec
```
[H2: How quickly does [Product] pay for itself?]

[3 input sliders:]
Your team size: [slider: 5–500 people]
Hours saved per person per week: [slider: 0.5–10 hours]  ← default: 2
Average hourly cost: [$50–$250] ← default: $100

[Calculated output, updates live:]
Weekly savings:    $[calculated]
Annual savings:    $[calculated]
[Product] Pro cost: $[calculated]/year
ROI multiple:      [calculated]×
Payback period:    [calculated] weeks

[CTA: "Get these results for your team →"]
```

### Add-Ons and Overages Section
```
[H2: Only pay for what you need]
[Add-on table:]

| Add-on              | Price          | Description |
|---------------------|----------------|-------------|
| Extra seats         | $X/seat/month  | Beyond plan limit |
| Data retention      | $X/GB/month    | Beyond 90-day default |
| Advanced analytics  | $X/month       | BI-grade dashboards |
| Priority support    | $X/month       | 4-hour SLA |
| Custom integrations | $X/month each  | Unlisted connectors |
| Audit log export    | $X/month       | SIEM integration |
```

### Feature Comparison Table (Full)
Generate a complete table. Every row is a capability. Columns are the tiers. Format:

```
| Capability                    | Starter    | Pro         | Enterprise  |
|-------------------------------|------------|-------------|-------------|
| [Core feature 1]              | ✅         | ✅          | ✅          |
| [Core feature 2]              | ✅         | ✅          | ✅          |
| [Advanced feature]            | Limited    | ✅          | ✅          |
| [Power feature]               | ❌         | ✅          | ✅          |
| [Enterprise feature]          | ❌         | ❌          | ✅          |
| Users                         | Up to 5    | Up to 50    | Unlimited   |
| Data retention                | 7 days     | 90 days     | Custom      |
| API rate limit                | 100 req/s  | 1,000 req/s | Custom      |
| SLA uptime                    | 99.5%      | 99.9%       | 99.99%      |
| Support                       | Community  | Email (48h) | Dedicated   |
| SSO / SAML                    | ❌         | ❌          | ✅          |
| Audit logs                    | ❌         | 30-day      | Custom      |
| Custom data residency         | ❌         | ❌          | ✅          |
| Procurement / invoicing       | ❌         | ❌          | ✅          |
```

### Upgrade Path Narrative
After the feature table, include a 3-sentence upgrade story:
> "Start on Starter — it's free and you'll get value in minutes. When your team grows past 5 people or you need [power feature], Pro is $[X]/month and pays for itself in [N] weeks (see calculator above). When you're ready for enterprise security, SLAs, and dedicated support, we'll work with your procurement team directly."

---

## Product Architecture Page Blueprint (`/architecture`)

Purpose: close deals with skeptical engineers and security teams. This is the page a CTO sends to their team before approving a vendor.

### Page Hero
```
[H1: Built for scale. Designed for trust.]
[Subline: [Product] is a [deployment model] platform built on [key infrastructure choices]. Here's exactly how it works.]

[Trust badges: SOC 2 Type II | GDPR | ISO 27001 | HIPAA-ready | 99.99% uptime]
[Link: Download architecture whitepaper (PDF) →]
```

### System Architecture Diagram

Generate a complete SVG architecture diagram. Use this structure:

```
LAYERS (top to bottom in the diagram):

┌─────────────────────────────────────────────────────┐
│  CLIENT LAYER                                        │
│  [Web App]  [Mobile SDK]  [REST API]  [CLI]          │
└──────────────────────┬──────────────────────────────┘
                       │ HTTPS / WSS
┌──────────────────────▼──────────────────────────────┐
│  EDGE / ENTRY LAYER                                  │
│  [CDN / WAF]  [API Gateway]  [Auth: JWT/OAuth]       │
│  [Rate Limiter]  [Load Balancer]                     │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│  APPLICATION LAYER                                   │
│  [Service A: Core logic]   [Service B: Processing]   │
│  [Service C: Notifications] [Service D: Reporting]   │
│  [Worker Pool: Async jobs]                           │
└──────┬───────────────┬────────────────┬─────────────┘
       │               │                │
┌──────▼───────┐ ┌─────▼──────┐ ┌──────▼──────────────┐
│  DATA LAYER  │ │  CACHE     │ │  MESSAGE QUEUE       │
│  PostgreSQL  │ │  Redis     │ │  Kafka / SQS         │
│  (Primary +  │ │  (Session, │ │  (Event streaming,   │
│  Replicas)   │ │  Hot data) │ │  job queue)          │
└──────────────┘ └────────────┘ └─────────────────────┘
       │
┌──────▼──────────────────────────────────────────────┐
│  INTEGRATIONS / EXTERNAL                             │
│  [Customer's systems]  [3rd party APIs]  [Webhooks]  │
└─────────────────────────────────────────────────────┘
```

Adapt this template to the actual product. Replace service names with real component names. Add or remove layers as appropriate.

SVG generation rules:
- Use `<rect>` with `rx="8"` for component boxes
- Color-code by layer: client=#EFF6FF, edge=#F0FDF4, app=#FAF5FF, data=#FFF7ED, external=#F8FAFC
- Use `<line>` or `<path>` with arrowheads for connections
- Label connections with protocol/method (HTTPS, gRPC, WebSocket, SQL, pub/sub)
- Minimum viewBox: `0 0 900 600`

### Component Inventory Table
```
| Component          | Role                        | Technology      | Scales via        |
|--------------------|-----------------------------|-----------------|--------------------|
| API Gateway        | Entry point, auth, routing  | Kong / Nginx    | Horizontal (K8s)  |
| Core Service       | [Primary business logic]    | Go / Node.js    | Horizontal        |
| Processing Worker  | [Async heavy jobs]          | Python          | Queue depth       |
| Primary DB         | Source of truth             | PostgreSQL 15   | Read replicas     |
| Cache              | Session, hot data           | Redis Cluster   | Horizontal        |
| Object Store       | Files, exports, artifacts   | S3-compatible   | Unlimited         |
| Message Queue      | Event streaming             | Kafka           | Partition scaling |
| CDN                | Static assets, edge caching | Cloudflare      | Global edge       |
```

### Data Flow Walkthrough

Narrate a typical request through the full system:

```
[H2: How a [typical request] flows through [Product]]

Step 1: [User action in the client]
"When a user [does X], the client sends a [method] request to [endpoint]."

Step 2: Authentication
"The API Gateway validates the JWT token against [auth service]. Invalid tokens receive a 401 immediately — no request reaches the application layer."

Step 3: Routing
"Validated requests are routed to [Core Service] by [routing logic]."

Step 4: Business logic
"[Core Service] [performs operation]. If the operation requires [heavy processing], a job is enqueued to [Message Queue] and the response returns immediately with a job ID."

Step 5: Data persistence
"Results are written to [PostgreSQL] and cached in [Redis] for [TTL]."

Step 6: Response / async notification
"The response is returned to the client within [target latency]. If async, [notification mechanism] notifies the client when the job completes."
```

### Deployment Architecture
```
[H2: How [Product] deploys]

[Deployment model: Cloud-hosted / Self-hosted / Hybrid / Multi-cloud]

CLOUD-HOSTED (default):
Region options: [List of AWS/GCP/Azure regions]
Availability: Multi-AZ within each region; cross-region failover in Enterprise
Provisioning: New environments provisioned in < [X] minutes
Data residency: Customer data stays in the selected region — never crosses region boundaries

SELF-HOSTED (Enterprise):
Requirements: Kubernetes 1.28+ or Docker Compose
Installation: Helm chart (3 commands) or Terraform module
Air-gap: ✅ supported — no outbound internet required in locked-down mode
Image registry: Images published to [registry]; can be mirrored to private registry
```

### Security Architecture
```
[H2: Security by design]

AUTHENTICATION & AUTHORIZATION
- All API calls require a signed JWT or API key
- RBAC: [roles] with [permission model]
- SSO via SAML 2.0 and OIDC (Enterprise)
- MFA enforced for admin accounts

ENCRYPTION
- In transit: TLS 1.3 minimum for all connections
- At rest: AES-256 for database volumes and object storage
- Keys: Managed via [KMS: AWS KMS / GCP Cloud KMS / HashiCorp Vault]
- Customer-managed encryption keys (CMEK): available in Enterprise

NETWORK ISOLATION
- Application layer runs in private subnets (no public IPs)
- Ingress only through API Gateway and CDN
- VPC peering available for self-hosted Enterprise deployments
- No persistent inbound connections to customer environments

SECRETS MANAGEMENT
- No secrets in environment variables or code
- All secrets stored in [Vault / AWS Secrets Manager]
- Secrets rotated every [90] days automatically
```

### SLA and Scalability
```
[H2: Built to scale with you]

[4-column metrics strip:]
99.99% uptime SLA    |  < 50ms P99 latency  |  10M req/min peak  |  Auto-scales in < 30s

SCALABILITY DESIGN:
- Stateless application tier: scales horizontally with zero-downtime rolling deploys
- Database: PostgreSQL primary with read replicas; connection pooling via PgBouncer
- Cache: Redis Cluster with automatic failover
- Queue: Kafka with [N] partition default; scales to [X] partitions for Enterprise

LOAD HANDLING:
- Typical load: [X] requests/second per application instance
- Burst handling: auto-scaling triggers at 70% CPU; new instance ready in < 30 seconds
- Rate limiting: [X] requests/minute per API key (configurable in Enterprise)

INCIDENT RESPONSE:
- P0 (full outage): 15-minute response SLA, status page updated within 5 minutes
- P1 (major degradation): 1-hour response SLA
- Post-incident report: published within 5 business days for all P0/P1 events
```

---

## Explainer Video Blueprint

### Placement Strategy

| Page | Placement | Format | Goal |
|---|---|---|---|
| Homepage | Below hero, above problem section | 60–90 sec brand explainer | Reduce bounce, increase signup intent |
| Product page | Hero section (replaces static screenshot) | 2–3 min product walkthrough | Feature comprehension |
| Resources page | Featured ungated resource | 60–90 sec brand explainer | Lead nurturing |
| Pricing page | Sidebar on Enterprise tier | 30–60 sec testimonial reel | Accelerate enterprise deal |

### 60–90 Second Script Structure

Produce a complete voiceover script following this timing:

```
[0:00–0:05] — HOOK (5 seconds)
One punchy statement of the problem. No intro. No logo. Start with pain.
"Right now, [persona] spends [time] every [period] doing [painful thing]."

[0:05–0:20] — PROBLEM (15 seconds)
Expand the pain. Make it vivid. Use specific numbers.
"That's [X hours/year] per team member — wasted on [manual process] instead of [valuable activity]. And every time [bad consequence] happens, [further pain]."

[0:20–0:50] — SOLUTION (30 seconds)
Introduce the product by name. Explain the mechanism — not the feature list.
"[Product] [verb]s [object] so that [outcome]. [Short sentence on how.] Instead of [old way], you [new way]."
Show: product UI, the key interaction, the result.

[0:50–1:10] — HOW IT WORKS (20 seconds)
3 steps — no more.
"Step 1: [One line]. Step 2: [One line]. Step 3: [One line]. That's it."
Visualize: a fast montage of each step.

[1:10–1:30] — PROOF (20 seconds)
One customer quote or stat. Make it specific.
"Teams like [Company] [achieved outcome] in [timeframe]."
Show: customer logo, outcome metric.

[1:30–1:40] — CTA (10 seconds)
Low-friction ask.
"[Product]. [Tagline]. Try it free at [domain]."
Show: product logo, URL, CTA button.
```

### Scene-by-Scene Storyboard Template

For each scene, generate:

```
SCENE [N]
Duration: [Xs]
Screen/Visual: [Describe what's on screen — specific, directable]
Voiceover: "[Exact script line]"
Motion: [Describe animation — e.g., "zoom in from center", "fade to white", "screen recording plays at 1.5×", "text appears word by word"]
Sound: [Music note: upbeat / tension / calm / triumphant] [SFX if any]
```

Example Scene 1:
```
SCENE 1
Duration: 5s
Screen/Visual: Black screen. Single white text line, centered, appears word by word.
Voiceover: "Your team spends 14 hours a week in spreadsheets they didn't ask for."
Motion: Each word fades in at 0.3s intervals. On "14 hours", number pulses in brand accent color.
Sound: Ambient tension music begins at 0dB, rises to -18dB
```

### Thumbnail Design Spec
```
THUMBNAIL SPEC (1280×720px)
Background: Brand primary gradient (left: --color-primary-700, right: --color-primary-500)
Center element: Product UI screenshot at 80% scale with subtle drop shadow
Top-left: Company logo (white variant, 48px height)
Bottom-left: 2-line text:
  Line 1: "[Product] in 90 seconds" — font: heading, 32px, white, bold
  Line 2: "[Tagline]" — font: body, 18px, white/80% opacity
Play button: White circle, 80px diameter, centered over screenshot
  Inner triangle: brand accent color fill
No "YouTube" or platform chrome in the thumbnail
```

### Embed Component Spec (Next.js)
```tsx
// components/ExplainerVideo.tsx
// Props: videoId (YouTube/Vimeo), thumbnail (/public/video-thumbnail.png), title
// Behavior:
//   - Renders a static branded thumbnail by default (no iframe, no external request)
//   - On click: replaces thumbnail with iframe embed (lazy load)
//   - Play button: branded circle with product accent color
//   - Loading state: thumbnail stays visible until iframe fires onLoad
//   - Mobile: aspect-ratio: 16/9 preserved, touch-friendly play area
//   - SEO: <VideoObject> schema.org JSON-LD for rich results
// Accessibility: aria-label="Play [Product] explainer video", keyboard-focusable
```

### Production Brief (for video agency or AI video tool)

```
VIDEO PRODUCTION BRIEF

Title: [Product] — [Tagline]
Duration: 60–90 seconds
Aspect ratio: 16:9 (1920×1080 master; export 1080p for web)
Style: [Clean motion design / SaaS screen recording / Mixed: animation + screencap]

Brand:
  Primary color: [hex]
  Accent color: [hex]
  Font: [Heading font name]
  Logo: [Link to SVG]

Voiceover:
  Tone: [Confident and direct / Warm and conversational / Technical and precise]
  Gender/voice: [Leave to production unless specified]
  Pace: Medium-fast — no pause longer than 0.5s except for dramatic effect

Screen recordings:
  Record at: 1440×900 on a clean OS profile
  Zoom level: 125%
  Highlight mouse clicks
  Speed: 1.5× for navigation, 1× for key interactions

Music:
  Style: Modern, optimistic, minimal — no lyrics
  Volume: -24dB under voiceover, -18dB during CTA
  [Royalty-free source: Epidemic Sound / Artlist / Musicbed]

Deliverables:
  □ Master video (1080p MP4, H.264)
  □ Captions file (SRT)
  □ Thumbnail (1280×720 PNG)
  □ 15-second social cut (square 1:1 and vertical 9:16)
  □ GIF preview (first 5 seconds, 480×270, looped)
```
