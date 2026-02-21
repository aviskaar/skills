---
name: auto-website-builder
description: Use this skill when a user wants to build a high-converting product or company website from scratch — including brand naming, logo SVG design, landing page architecture, messaging strategy, competitor benchmarking, investor-grade content, implementation steps page, explainer video script, product architecture diagrams, full pricing tier strategy, and all supporting pages (contact, privacy policy, terms, blog, resources, events, whitepapers, GitHub, social media). Triggers when a user describes a product, solution, or startup idea and needs a fully automated website that replaces what a top-tier agency would produce. Also triggers for: redesigning an existing site to be more conversion-focused, building an MVP marketing site for a new product, or creating a complete brand + web presence from zero.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.1"
  tags: website, branding, landing-page, conversion, startup, product-marketing, design-system, logo, copywriting, pricing, architecture, explainer-video
---

# Auto Website Builder

Produce a complete, investor-grade, high-converting website and brand identity for any product or company — end to end, no agency required.

---

## Phase 1 — Intake & Intelligence

### 1.1 Gather Core Context

Ask the user for the following. If answers are missing, infer from context and state assumptions explicitly.

| Question | Why It Matters |
|---|---|
| What does the product/solution do? (1–3 sentences) | Foundation for all messaging |
| Who is the primary buyer and end user? | ICP definition |
| What is the biggest pain it eliminates? | Hero headline |
| What are 3 direct or indirect competitors? | Differentiation matrix |
| What industry vertical? (SaaS, DevTools, HealthTech, FinTech, etc.) | Color palette, tone |
| Is this B2B, B2C, or developer-facing? | Copy register and CTA strategy |
| What stage? (Idea, MVP, Series A, Growth) | Social proof level needed |
| Any existing name, logo, or brand assets? | Preserve or replace |
| Primary goal of the site? (Leads, signups, downloads, hires, investors) | CTA hierarchy |

### 1.2 Competitor Intelligence

For each competitor identified:
- Identify their hero message, primary CTA, and positioning statement
- Note what they do well (do not copy — benchmark to exceed)
- Identify messaging gaps, underserved audiences, and visual weaknesses
- Produce a **Differentiation Matrix**: a table with rows = key value dimensions, columns = you vs. each competitor, cells = ✅ / ❌ / ⚠️

### 1.3 Define Three Audiences

For every website, write explicit profiles for:
1. **Buyer/Customer** — the person who signs the contract or credit card
2. **Investor** — what they need to see to believe in the TAM and team
3. **Talent** — what makes an engineer or designer want to work here

All three audiences will land on this site. Every section must serve at least one of them.

---

## Phase 2 — Brand Identity

### 2.1 Product & Company Naming

If no name exists, generate 5 name candidates using these criteria:

- **Memorable**: One or two syllables preferred; survives "say it in a loud room" test
- **Meaningful**: Evokes the product's core value or feeling — not the feature
- **Ownable**: .com available or acquirable; no trademark conflicts in the target vertical
- **Scalable**: Works as a company name if this becomes a platform, not just a product
- **Pronounceable globally**: No sounds that break in Mandarin, Hindi, Spanish, or Portuguese

For each name candidate produce:
- Rationale (2 sentences)
- Domain status check note (advise user to verify)
- Logo wordmark style suggestion (all-caps, lowercase, camelCase, stylized letter)

Recommend one name and justify the choice.

### 2.2 Logo Design Brief

Generate a complete logo design brief that a designer or AI image tool can execute:

```
LOGO BRIEF
Company: [Name]
Style: [Wordmark | Lettermark | Icon + Wordmark | Abstract mark]
Concept: [2-sentence description of the visual metaphor]
Primary mark: [Describe the icon/shape/symbol in precise geometric terms]
Wordmark font class: [Geometric sans | Humanist sans | Slab serif | Modern serif]
Font weight: [Light / Regular / Medium / Bold]
Color mode: Full color | Single color (white on dark, dark on white)
Clearspace: Minimum 1x height of the wordmark on all sides
Minimum size: 24px height for digital; 0.5 inch for print
Favicon: [Describe the simplified mark for 16×16 and 32×32]
Dark background variant: [Describe]
```

Also generate the actual SVG code for a clean, professional wordmark logo using:
- A geometric SVG path or shape as the icon mark
- The company name in a clean sans-serif font path or `<text>` element
- Primary brand color fill
- Proper viewBox and namespace

### 2.3 Color System

Select a color palette using industry standards (see `references/brand-system.md` for per-industry palettes).

Output the full design token set:

```css
:root {
  /* Primary — main brand color */
  --color-primary-900: #[hex];
  --color-primary-700: #[hex];
  --color-primary-500: #[hex];   /* default primary */
  --color-primary-300: #[hex];
  --color-primary-100: #[hex];

  /* Neutral */
  --color-gray-950: #[hex];      /* headings, body text on light */
  --color-gray-700: #[hex];
  --color-gray-400: #[hex];
  --color-gray-100: #[hex];
  --color-gray-50:  #[hex];      /* page background */

  /* Accent — for CTAs, highlights */
  --color-accent:   #[hex];

  /* Semantic */
  --color-success:  #[hex];
  --color-warning:  #[hex];
  --color-error:    #[hex];
}
```

Verify WCAG AA contrast (4.5:1) for all text/background combinations. State the contrast ratios.

### 2.4 Typography System

```
HEADINGS: [Font name] — Bold/700 — tracking: -0.02em
SUBHEADINGS: [Font name] — SemiBold/600
BODY: [Font name] — Regular/400 — line-height: 1.6
MONO/CODE: [Font name] — for technical products
SCALE: 12 / 14 / 16 / 20 / 24 / 32 / 40 / 48 / 64 / 80px
```

---

## Phase 3 — Messaging & Positioning

### 3.1 Positioning Statement

Use the Geoffrey Moore framework:
> For [target customer] who [has this pain], [Product Name] is a [category] that [key benefit]. Unlike [primary competitor], we [key differentiator].

### 3.2 Tagline Options

Generate 5 taglines. Each must:
- Be ≤ 8 words
- Communicate the transformation, not the feature
- Work as a billboard headline with zero context

Select one primary tagline and two alternates for A/B testing.

### 3.3 Hero Copy Formula

```
HEADLINE:    [Outcome the customer gets — active verb, concrete noun]
SUBHEADLINE: [How it works + who it's for + why now — 1 sentence, ≤ 20 words]
CTA PRIMARY: [Action verb + value object] — e.g., "Start free", "See it live", "Get early access"
CTA SECONDARY: [Lower-commitment option] — e.g., "Watch 2-min demo", "Read the docs"
SOCIAL PROOF HOOK: [Number] [teams/companies/users] [verb] with [Product] — or logos strip
```

### 3.4 Metrics & Numbers

Extract or estimate credible numbers to display. Categories:
- **Performance metrics**: speed, accuracy, uptime, throughput
- **Customer metrics**: NPS, retention, expansion revenue, time-to-value
- **Scale metrics**: users, requests/day, data processed, countries
- **Efficiency metrics**: cost reduction %, time saved per user, FTE equivalent

If the product is pre-launch, use beta program numbers or benchmark-based claims (clearly labeled).

### 3.5 Feature → Benefit Translation

For each key feature, produce the benefit translation:
| Feature (what it does) | Benefit (what the user gets) | Proof point |
|---|---|---|

Never lead with features on the homepage. Lead with benefits. Features belong on the product page.

---

## Phase 4 — Site Architecture

### 4.1 Full Sitemap

Generate a complete sitemap:

```
/ (Home / Landing)
/product          → Features deep-dive + architecture diagram
/pricing          → Full tier breakdown, ROI calculator, add-ons
/implementation   → Step-by-step onboarding and setup guide
/architecture     → System architecture, data flow, security model
/customers        → Case studies & logos
/about            → Mission, team, investors
/blog             → Thought leadership
  /blog/[slug]
/resources        → Whitepapers, research, guides
  /resources/[slug]  (gated downloads)
/events           → Webinars, conferences, community
/careers          → Open roles, culture, values
/docs             → Technical documentation (link or embed)
/github           → OSS projects, contribution guide
/contact          → Sales, partnerships, press
/privacy          → Privacy policy
/terms            → Terms of service
/security         → Security posture (for B2B)
/status           → System status (link to status page)
/sitemap.xml      → Auto-generated
/robots.txt
```

### 4.2 Navigation Structure

```
PRIMARY NAV (top):
  [Logo]  Product  Customers  Pricing  Resources  Blog  [Login]  [Get Started →]

FOOTER (4-column):
  Col 1: Product links
  Col 2: Company links
  Col 3: Resources links
  Col 4: Legal + Social icons
```

---

## Phase 5 — Page-by-Page Content Generation

For each page below, generate complete content. See `references/page-blueprints.md` for detailed section specs.

### 5.1 Homepage — Generate All Sections In Order

1. **Navigation bar** — logo, nav links, CTA button
2. **Hero** — headline, subheadline, dual CTA, hero visual (describe or generate SVG/illustration spec), social proof strip (5–8 customer logos)
3. **Explainer video embed** — 60–90 second video (or animated demo) placed directly below the hero fold; include play-button overlay on a branded thumbnail; link to `/watch` or use inline YouTube/Vimeo embed. Generate the full video script using Phase 5.14.
4. **Problem section** — 3 pain points as headlines with 1-line elaborations; use icons
5. **Solution overview** — product screenshot or diagram + 3 key differentiators
6. **How it works / Implementation steps** — 3–4 step visual flow (numbered, icon-forward); link to full `/implementation` page
7. **Feature highlights** — 3–6 feature blocks (icon + headline + 2-line benefit copy)
8. **Product architecture preview** — simplified architecture diagram (SVG) showing major system components; "See full architecture →" links to `/architecture`
9. **Metrics bar** — 3–4 impressive numbers with labels (animate on scroll)
10. **Case study teaser** — 1 featured customer story with logo, quote, and outcome metric
11. **Architecture / Trust section** — SOC 2, GDPR, enterprise logos, security badge
12. **Pricing preview** — 3-tier card strip (truncated); primary tier highlighted; link to `/pricing` for full detail
13. **Testimonials** — 3–6 quotes with name, title, company, photo placeholder
14. **Integration logos** — ecosystem/compatibility strip (tools they already use)
15. **Investor logos** — if applicable; "Backed by" strip
16. **Final CTA banner** — bold headline + primary CTA + optional secondary CTA
17. **Footer** — full 4-column footer with all links and social icons

### 5.2 Product / Features Page

- Feature grid or tabbed layout
- For each feature: hero image/screenshot, headline, 2-para description, benefit callout, link to docs
- Comparison table vs. competitors (feature-by-feature)
- **Architecture section**: embed the simplified system diagram from Phase 5.15; "See full architecture →" link to `/architecture`
- CTA to `/implementation` — "Ready to see how it fits your stack?"

### 5.3 Pricing Page

Generate a complete, conversion-optimized pricing page. See `references/page-blueprints.md` § Pricing Page Deep-Dive for full specs.

- **Pricing model selection**: choose the right model for the product type (per-seat, usage-based, flat-rate, tiered usage, or hybrid) and justify the choice
- **3-tier card layout**: Starter / Pro / Enterprise (or equivalent) with annual/monthly toggle; default to annual to anchor on savings
- **Per-tier feature matrix**: full breakdown of what each tier includes — limits, capabilities, support level, SLA, integrations
- **Add-ons and overages**: explicitly spec what happens at limit boundaries and what optional add-ons exist
- **ROI calculator section**: interactive calculator showing "If you save X hours per week at $Y/hr, payback in Z weeks"
- **Upgrade path narrative**: make it obvious why customers move from Starter → Pro → Enterprise
- **Feature comparison table**: exhaustive row-by-row across all tiers
- **FAQ section** (8–10 questions)
- **Enterprise CTA strip**: custom quote, procurement support, security review, SLA negotiation
- **Trust signals**: money-back guarantee, no credit card required, cancel anytime, SOC 2 badge

### 5.4 Customers / Case Studies Page

- Logos grid (hero section)
- 3 featured case studies: problem → solution → result (with metrics)
- Testimonial carousel
- Industry filter tabs

### 5.5 About Page

- Mission statement (1 compelling paragraph, present tense)
- Founding story (3–5 paragraphs: origin, problem, why us, what's next)
- Team grid (name, title, 2-line bio, photo placeholder, LinkedIn icon)
- Investor/backer logos
- Press mentions strip

### 5.6 Blog Page

- Featured article hero
- Category filters
- Article card grid (thumbnail + category tag + title + 2-line excerpt + author + date + read time)
- Newsletter CTA sidebar/banner

### 5.7 Resources / Downloads Page

- Gated content cards (whitepaper, research report, guide)
- Each card: cover image placeholder, title, description, "Download" button → lead capture form
- Ungated resources: docs links, video tutorials, API reference

### 5.8 Events Page

- Upcoming events (webinar, conference, community meetup): date, title, description, registration CTA
- Past events with recordings/slides download

### 5.9 Careers Page

- Culture statement + values (3–5 values, each with icon + headline + 2-line description)
- Benefits grid (compensation, equity, remote policy, health, learning budget)
- Open roles list with department filter
- "Don't see your role?" invite CTA

### 5.10 Contact Page

- Split layout: form left, contact info right
- Form fields: Name, Work Email, Company, Role, Message, Intent (Sales / Press / Partnership / Support)
- Sales email, support email, address, social links
- Map embed placeholder

### 5.11 Privacy Policy

Generate a complete, GDPR + CCPA compliant privacy policy covering:
- Data collected (explicit list: name, email, usage data, cookies, IP)
- How data is used (service delivery, analytics, marketing — separately)
- Third-party processors (list: Stripe, Intercom, Segment, AWS, etc.)
- Data retention periods
- User rights (access, correction, deletion, portability, opt-out)
- Cookie policy inline
- Contact for DPO/privacy requests
- Last updated date field

### 5.12 Terms of Service

Generate complete ToS covering:
- Acceptance of terms
- License grant (SaaS subscription, non-exclusive, non-transferable)
- Acceptable use policy (explicit prohibitions)
- Payment terms and refund policy
- IP ownership (customer data stays customer's; product IP stays company's)
- Warranty disclaimer
- Limitation of liability (cap at 12 months of fees paid)
- Governing law and dispute resolution
- Termination conditions
- Changes to terms

### 5.13 Implementation Steps Page (`/implementation`)

A dedicated page showing exactly how to go from zero to value. See `references/page-blueprints.md` § Implementation Steps Page Blueprint for full specs.

Structure:
1. **Page hero** — "Up and running in [timeframe]" headline; estimated time to first value
2. **Prerequisites checklist** — what the user needs before starting (accounts, API keys, dependencies)
3. **Step-by-step guide** — numbered implementation phases with code snippets, screenshots, and expected outputs at each step
4. **Integration recipes** — for the top 5 integrations: copy-paste setup instructions
5. **Validation checkpoints** — "You know it's working when you see..." — clear success signals at each phase
6. **Troubleshooting section** — top 5 setup errors and their solutions
7. **Next steps** — links to docs, community, office hours

Generate all code snippets for the actual product. Include copy-to-clipboard UI for each snippet.

### 5.14 Explainer Video Script & Spec

Generate a complete production-ready video package. See `references/page-blueprints.md` § Explainer Video Blueprint for full specs.

Produce:
1. **60–90 second voiceover script** — structured as: Hook (0–5s) → Problem (5–20s) → Solution (20–50s) → How it works (50–75s) → CTA (75–90s)
2. **Scene-by-scene storyboard** — for each scene: screen content, voiceover line, motion direction, duration
3. **Thumbnail design spec** — branded still frame for the video preview card (1280×720px)
4. **Embed component code** — Next.js component with lazy-loading, branded play button overlay, and thumbnail
5. **Video CTA overlay** — end-card design: product URL, primary CTA button, secondary link

Place the video:
- Homepage: below the hero, above the problem section
- Product page: as the hero element replacing a static screenshot
- Resources page: as a featured item in the ungated section

### 5.15 Product Architecture Page (`/architecture`)

A dedicated technical deep-dive for engineers, architects, and security reviewers. See `references/page-blueprints.md` § Product Architecture Page Blueprint for full specs.

Produce:
1. **System architecture diagram** — SVG flowchart covering all major components, data flows, and external integrations
2. **Component inventory** — table of every service/module: name, responsibility, tech stack, scalability notes
3. **Data flow walkthrough** — step-by-step numbered narrative of a request through the system
4. **Deployment architecture** — how it deploys (cloud-native, self-hosted, hybrid); regions and availability zones
5. **Security architecture section** — auth model, encryption at rest and in transit, network isolation, secrets management
6. **Scalability and SLA** — how the system scales under load; what the limits are; failover behavior
7. **Integration architecture** — how external systems connect (webhooks, APIs, SDKs, event streams)

---

## Phase 6 — Code Generation

### 6.1 Tech Stack Selection

Default stack (production-ready, fast):
- **Framework**: Next.js 14+ (App Router) with TypeScript
- **Styling**: Tailwind CSS v3+ with the generated design tokens
- **Animations**: Framer Motion for scroll reveals and hero entrance
- **Icons**: Lucide React
- **Fonts**: Google Fonts (specify exact names from Phase 2.4)
- **Forms**: React Hook Form + Zod validation
- **Analytics**: Plausible or Vercel Analytics (privacy-first default)

If user prefers plain HTML/CSS/JS, generate vanilla files with no build step required.

### 6.2 File Structure

```
[company-name]/
├── app/
│   ├── layout.tsx                ← root layout, fonts, meta
│   ├── page.tsx                  ← homepage
│   ├── product/page.tsx
│   ├── pricing/page.tsx
│   ├── implementation/page.tsx   ← step-by-step onboarding
│   ├── architecture/page.tsx     ← system architecture deep-dive
│   ├── customers/page.tsx
│   ├── about/page.tsx
│   ├── blog/page.tsx
│   ├── blog/[slug]/page.tsx
│   ├── resources/page.tsx
│   ├── events/page.tsx
│   ├── careers/page.tsx
│   ├── contact/page.tsx
│   ├── privacy/page.tsx
│   └── terms/page.tsx
├── components/
│   ├── ui/                       ← Button, Card, Badge, Input, etc.
│   ├── layout/                   ← Navbar, Footer
│   ├── sections/                 ← Hero, Features, Metrics, Testimonials, etc.
│   ├── ExplainerVideo.tsx        ← lazy video embed with branded overlay
│   ├── ArchitectureDiagram.tsx   ← SVG system diagram component
│   ├── PricingTiers.tsx          ← tier cards + toggle + ROI calculator
│   ├── ImplementationSteps.tsx   ← numbered steps with code snippets
│   └── Logo.tsx                  ← SVG logo component
├── lib/
│   └── tokens.ts                 ← Design tokens as JS constants
├── public/
│   ├── favicon.ico
│   ├── og-image.png              ← Open Graph image spec
│   └── video-thumbnail.png       ← Explainer video thumbnail (1280×720)
├── tailwind.config.ts            ← Extend with brand tokens
└── next.config.ts
```

Generate each file with complete, working code — no placeholders, no TODOs.

### 6.3 SEO & Meta

For every page generate:
```tsx
export const metadata: Metadata = {
  title: '[Page Title] | [Company Name]',
  description: '[150-char meta description with primary keyword]',
  openGraph: { title, description, image: '/og-image.png', type: 'website' },
  twitter: { card: 'summary_large_image', ... },
  alternates: { canonical: 'https://[domain]/[path]' },
}
```

Also generate:
- `public/robots.txt`
- `app/sitemap.ts` (dynamic sitemap generator)
- Schema.org JSON-LD for Organization, Product, and FAQPage

### 6.4 Performance Requirements

All pages must score ≥ 90 on Lighthouse. Enforce:
- Images: `next/image` with explicit width/height and `loading="lazy"`
- Fonts: `next/font` with `display: swap`
- No render-blocking scripts
- CSS: only Tailwind purged classes, no unused styles

---

## Phase 7 — Launch Checklist

Produce a launch-ready checklist:

**Brand**
- [ ] Logo SVG exported in all variants (full color, white, black, favicon)
- [ ] Design tokens documented in Figma or CSS file
- [ ] Brand guidelines PDF generated

**Content**
- [ ] All pages reviewed for benefit-first copy (no feature-only sections)
- [ ] All numbers verified or clearly labeled as estimates
- [ ] Legal pages reviewed by user (not legal advice; advise user to consult counsel)
- [ ] Blog seeded with 3+ articles before launch
- [ ] Explainer video produced, uploaded to YouTube/Vimeo, and embedded on homepage + product page
- [ ] Implementation steps page tested end-to-end (all code snippets verified)
- [ ] Architecture diagrams reviewed by an engineer for technical accuracy

**Technical**
- [ ] Domain purchased and DNS configured
- [ ] SSL/TLS certificate active
- [ ] Analytics installed and verified
- [ ] Forms tested end-to-end (submissions reach inbox)
- [ ] 404 page created
- [ ] Sitemap submitted to Google Search Console
- [ ] Social meta tags validated with opengraph.xyz

**Conversion**
- [ ] Heatmap tool installed (Hotjar or Microsoft Clarity)
- [ ] A/B test configured for hero headline (2 variants minimum)
- [ ] Email capture connected to CRM or mailing list
- [ ] Exit-intent popup configured (optional)

---

## Output Format

Deliver all phases in sequence. Use this order:

1. **Discovery Summary** — ICP, competitor matrix, audience profiles
2. **Brand Book** — name recommendation, logo brief, SVG logo code, color tokens, typography
3. **Messaging Document** — positioning statement, tagline, hero copy, metrics, benefit table
4. **Sitemap** — full URL tree with page descriptions
5. **Content Document** — all page copy, section by section (including implementation steps, architecture narrative, pricing tiers, explainer video script)
6. **Codebase** — complete Next.js project files, one file per code block (including `ExplainerVideo.tsx`, `ArchitectureDiagram.tsx`, `PricingTiers.tsx`, `ImplementationSteps.tsx`)
7. **Launch Checklist** — ready-to-action markdown checklist

If the output is very long, deliver phases as separate responses and ask the user which phase to expand first.
