# Brand System Reference

This reference is loaded on-demand during Phase 2 of the auto-website-builder skill.

---

## Industry Color Palettes

Use these as starting points. Always adapt to the specific product's personality and verify contrast ratios.

### SaaS / Productivity / Collaboration
- **Primary**: Electric blue (#2563EB) or Indigo (#4F46E5)
- **Accent**: Violet (#7C3AED) or Cyan (#0891B2)
- **Neutral**: Slate grays (#0F172A → #F8FAFC)
- **Mood**: Clean, confident, trustworthy, modern
- **References**: Linear, Notion, Figma, Loom

### DevTools / Infrastructure / API
- **Primary**: Near-black with electric accent (#0EA5E9 or #10B981)
- **Accent**: Neon green (#22C55E) or bright orange (#F97316)
- **Background**: True dark (#09090B or #0D1117)
- **Neutral**: Zinc grays
- **Mood**: Precise, fast, developer-native, no-BS
- **References**: Vercel, PlanetScale, Railway, Turso

### FinTech / Payments / Banking
- **Primary**: Deep navy (#1E3A5F) or midnight blue (#0F1F3D)
- **Accent**: Gold (#D4AF37) or emerald (#059669)
- **Neutral**: Cool grays with high contrast
- **Mood**: Trustworthy, regulated, secure, institutional
- **References**: Stripe, Brex, Mercury, Ramp

### HealthTech / MedTech / Wellness
- **Primary**: Calm teal (#0D9488) or soft blue (#3B82F6)
- **Accent**: Warm coral (#F97316) or mint (#34D399)
- **Background**: Warm off-white (#FAFAF9)
- **Neutral**: Stone grays
- **Mood**: Caring, clinical-grade trust, approachable, human
- **References**: Devoted Health, Headspace, Calm, Ro

### Cybersecurity / Zero Trust / Compliance
- **Primary**: Deep red (#DC2626) or dark navy (#1E293B)
- **Accent**: Electric lime (#84CC16) or bright cyan (#06B6D4)
- **Background**: Very dark (#0A0A0A or #0F172A)
- **Neutral**: Cool grays with blue undertones
- **Mood**: Vigilant, technical, uncompromising, urgent
- **References**: CrowdStrike, Wiz, Lacework, Snyk

### AI / Machine Learning / Data
- **Primary**: Deep purple (#7C3AED) or vibrant blue (#2563EB)
- **Accent**: Magenta (#D946EF) or amber (#F59E0B)
- **Background**: Near-black or midnight navy
- **Neutral**: Slate with purple undertones
- **Mood**: Intelligent, futuristic, powerful, precise
- **References**: Anthropic, OpenAI, Cohere, Weights & Biases

### E-commerce / Retail / Consumer
- **Primary**: Brand-specific (conduct color psychology analysis for target demographic)
- **Accent**: High-contrast for CTA buttons (orange #F97316 converts well universally)
- **Background**: White or warm off-white (#FFFBF5)
- **Neutral**: Warm grays
- **Mood**: Aspirational, approachable, conversion-optimized
- **References**: Shopify, Allbirds, Away, Warby Parker

### CleanTech / Sustainability / Climate
- **Primary**: Forest green (#15803D) or deep teal (#0F766E)
- **Accent**: Sky blue (#38BDF8) or warm sand (#D97706)
- **Background**: Off-white with warm undertone (#FAFAF5)
- **Neutral**: Stone grays
- **Mood**: Purposeful, scientific, optimistic, credible
- **References**: Stripe Climate, Watershed, Pachama

### EdTech / Learning / Training
- **Primary**: Bright blue (#2563EB) or warm purple (#7C3AED)
- **Accent**: Yellow (#FBBF24) or orange (#F97316)
- **Background**: White or very light blue (#F0F9FF)
- **Neutral**: Cool grays
- **Mood**: Engaging, accessible, growth-oriented, energetic
- **References**: Coursera, Duolingo, Loom, Figma Learn

### Enterprise B2B / ERP / Workflow
- **Primary**: Corporate blue (#1D4ED8) or professional charcoal (#374151)
- **Accent**: Orange (#EA580C) or teal (#0D9488)
- **Background**: White, light gray (#F9FAFB)
- **Neutral**: Gray-900 down to Gray-50
- **Mood**: Reliable, established, scalable, ROI-focused
- **References**: Salesforce, ServiceNow, SAP, Workday (but more modern)

---

## Logo Design Principles

### Tier 1 Logo Characteristics (Unicorn-grade)
1. **Reduction**: Works at 16×16 favicon size. If it doesn't, it's too complex.
2. **Metaphor depth**: The icon encodes meaning — it represents the transformation, not the literal product.
3. **Geometry**: Built on a grid. Use circles, squares, triangles as base primitives.
4. **Negative space**: The best logos use it. The FedEx arrow. The Amazon smile. Encode a second meaning.
5. **No gradients in the mark**: The icon must work in single color (for embroidery, engraving, one-color print).
6. **Wordmark pairing**: Icon and text have optical alignment, not mathematical center alignment.
7. **Unique enough**: Avoid clichés — no generic lightbulbs, speech bubbles, or ascending bar charts.

### SVG Logo Template

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 48" fill="none">
  <!-- Icon mark: 40×40, positioned left -->
  <!-- Replace with actual icon path -->
  <g transform="translate(4, 4)">
    <rect width="40" height="40" rx="10" fill="[PRIMARY_COLOR]"/>
    <!-- Inner icon shape in white -->
    <path d="[ICON_PATH]" fill="white"/>
  </g>
  <!-- Wordmark: starts at x=52 -->
  <text
    x="52" y="31"
    font-family="Inter, system-ui, sans-serif"
    font-size="22"
    font-weight="600"
    letter-spacing="-0.5"
    fill="[NEUTRAL_900]"
  >[COMPANY NAME]</text>
</svg>
```

### Icon Concept Archetypes by Product Type

| Product Type | Icon Concept | Visual Approach |
|---|---|---|
| Data/Analytics | Constellation, flow, signal | Connected nodes, sparkline embedded in shape |
| Security | Shield that's also a lock or key | Geometric shield with hidden element |
| Speed/Performance | Arrow, acceleration, vector | Dynamic diagonal, implied motion |
| Collaboration | Intersection, orbit, network | Overlapping circles (but NOT Venn — do something unexpected) |
| AI/Intelligence | Neural synapse, spark, lens | Abstract neural path, optical lens flare |
| Storage/Memory | Layered planes, stack, cube | Isometric layers suggesting depth |
| Communication | Wave, signal, frequency | Clean sine or geometric wave form |
| Developer tool | Terminal, bracket, cursor | > or { or cursor as creative anchor |
| Finance | Balance, flow, growth | Abstract scale or ascending flow |
| Health | Pulse, breath, cycle | Heartbeat line in unexpected geometric form |

---

## Typography Pairings by Brand Personality

### Modern Tech / SaaS
- Headings: **Inter** or **Geist** (700)
- Body: **Inter** (400)
- Mono: **Geist Mono** or **JetBrains Mono**

### Premium / Enterprise
- Headings: **Sora** or **Manrope** (700)
- Body: **Manrope** (400) or **DM Sans**
- Mono: **IBM Plex Mono**

### Bold / Consumer / High Energy
- Headings: **Bricolage Grotesque** or **Clash Display** (700–800)
- Body: **Satoshi** or **DM Sans**

### Scientific / Academic / Data
- Headings: **Space Grotesk** or **Archivo** (600)
- Body: **Source Sans 3** (400)
- Mono: **Fira Code**

### Warm / Human / Wellness
- Headings: **Plus Jakarta Sans** (700)
- Body: **Plus Jakarta Sans** (400)
- Accent: **Lora** (serif) for pull quotes

---

## Naming Frameworks

### COINED Framework
- **C**atchy — sticks in memory after one hear
- **O**riginal — not already used in your vertical
- **I**ntuitive — the meaning is inferable or quickly learned
- **N**amespaceable — @company, company.com, /company all available
- **E**asy to spell — after hearing it spoken once
- **D**omain-ready — .com available or reasonably priced

### Name Generation Strategies

**Strategy 1 — Portmanteau**: Combine two relevant words, truncate and blend
- Examples: Spotify (spot + identify), Instagram (instant + telegram), Pinterest (pin + interest)

**Strategy 2 — Metaphor**: Name after a concept that embodies the transformation
- Examples: Stripe (payment as clean lines), Figma (figure, but plural/active), Linear (straight-line execution)

**Strategy 3 — Invented word**: Create a word with phonaesthetics — sounds fast, reliable, or futuristic
- Examples: Xero, Twilio, Asana, Gusto

**Strategy 4 — Proper noun**: Use a name, place, or object with unexpected relevance
- Examples: Amazon (biggest river → biggest store), Oracle (source of wisdom), Jira (from Gojira/Godzilla — a bug tracker)

**Strategy 5 — Descriptive but compressed**: Take the core value and make it a word
- Examples: Zoom (speed of video), Loom (weave a story through video), Notion (a powerful idea)

### Naming Anti-Patterns (Avoid)
- Generic suffixes: -ify, -ly, -ful, -hub, -io (overused)
- Tech clichés: Synergy, Nexus, Core, Apex, Vertex, Quantum, Catalyst
- Misspellings that look like typos: Fliickr, Tumblr (era-specific, dated)
- Impossible to pronounce without seeing it written
- Names that translate badly in major global markets
