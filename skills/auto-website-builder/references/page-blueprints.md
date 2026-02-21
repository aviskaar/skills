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
