<p align="center">
  <img src="open-org-logo.png" alt="Open Org Logo" width="200">
  <h1 align="center">Open Org</h1>
</p>

<p align="center">
  <strong>The World's First Fully Autonomous Organization - Building 1-Person Unicorns</strong>
</p>

<p align="center">
  <a href="https://github.com/aviskaar/open-org/blob/main/LICENSE">
    <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" alt="License">
  </a>
  <a href="https://github.com/aviskaar/open-org/issues">
    <img src="https://img.shields.io/github/issues/aviskaar/open-org" alt="Issues">
  </a>
  <a href="https://github.com/aviskaar/open-org/pulls">
    <img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" alt="PRs Welcome">
  </a>
  <a href="https://agentskills.io/specification">
    <img src="https://img.shields.io/badge/Spec-Agent%20Skills-orange" alt="Specification">
  </a>
</p>

---

## 🚀 Quick Start

```bash
# Step 1 — Add the open-org marketplace to Claude Code
/plugin marketplace add aviskaar/open-org

# Step 2 — Browse available skills in the Discover tab
/plugin

# Step 3 — Install only the skills you need
/plugin install lead-researcher@open-org
/plugin install ciso@open-org
/plugin install cmo-marketing@open-org
```

<img width="954" height="573" alt="image" src="https://github.com/user-attachments/assets/e7e466a8-4b6e-4f9e-91ce-ecc5105a6716" />

---

## 🌐 Vision

OpenOrg generalizes AI skills for enterprise automation, enabling fully autonomous organizations run by one person – scaling to unicorn status while prioritizing human good. By open-sourcing the skill layer, we give every builder the same leverage that once required entire departments.

---

## 🛠️ Core Features

- **🤖 Multi-AI model support** — Skills work across Claude, GPT, Gemini, and any model that accepts a system prompt.
- **🏢 Org-wide automation** — Pre-built hierarchies cover Research, Engineering, GTM, Marketing, and Operations end-to-end.
- **🔗 Composable skill stacks** — Orchestrator skills chain specialist skills, mirroring real team structures.
- **📦 Open-source extensibility** — Fork any skill, publish your own, and share across the community.
- **⚡ Agentic teams support** — Coordinate multi-agent pipelines using the [Agent Teams](AGENTS.md) model for parallel, autonomous execution.

---

## 📖 Table of Contents

- [Quick Start](#-quick-start)
- [Vision](#-vision)
- [Core Features](#️-core-features)
- [What are Skills?](#-what-are-skills)
- [Available Skills](#-available-skills)
  - [Research Skills](#research-skills)
  - [Engineering Skills](#engineering-skills)
  - [Enterprise / Operations Skills](#enterprise--operations-skills)
  - [GTM / Sales Skills](#gtm--sales-skills)
  - [Marketing Skills](#marketing-skills)
  - [Strategic Partnerships & Alliances Skills](#strategic-partnerships--alliances-skills)
  - [Investor Relations & Fundraising Skills](#investor-relations--fundraising-skills)
  - [Finance & Operations Skills](#finance--operations-skills)
  - [Security & Compliance Skills](#security--compliance-skills)
- [Using Skills](#-using-skills)
  - [Claude Code — Plugin Marketplace](#claude-code--plugin-marketplace)
- [Creating a Skill](#-creating-a-skill)
- [Contributing](#-contributing)
- [Roadmap](#-roadmap)
- [Repository Structure](#-repository-structure)
- [License](#-license)

---

**Skills** are portable packages of instructions, scripts, and resources that an AI agent loads dynamically to achieve deep, domain-specific expertise. Each skill follows the [Agent Skills Specification](https://agentskills.io/specification), making them composable, version-controlled, and shareable.

---

## 🛠 What are Skills?

A skill lives in its own directory with a `SKILL.md` file at the root. This structure allows agents to understand both the high-level intent and the low-level execution details required for specialized tasks.

```text
my-skill/
├── SKILL.md          # Required: instructions + metadata frontmatter
├── scripts/          # Optional: executable helpers
├── references/       # Optional: additional docs loaded on-demand
└── assets/           # Optional: static resources, templates, data
```

---

## 🏗 Available Skills

### Research Skills
Orchestration for AI/ML research — from ideation and literature review to publication-ready papers.

#### Orchestration Hierarchy
```mermaid
graph TD
    CS[computer-scientist] --> PS[principal-scientist]
    PS --> LR[lead-researcher]
    PS --> AB[auto-benchmark]
    LR --> AE[ai-engineer]
    LR --> HG[hypothesis-generation]
    LR --> LS[literature-synthesis]
    LR --> ED[experiment-design]
    LR --> CR[code-replication]
    LR --> RW[research-writing]
    LR --> IPG[ieee-paper-generator]
    AE --> AWB[auto-website-builder]
```

| Skill | Layer | Description |
|-------|-------|-------------|
| [computer-scientist](skills/computer-scientist/) | Strategic | Survey research domains and formulate high-impact open problems. |
| [principal-scientist](skills/principal-scientist/) | Portfolio | Manage parallel research tracks and synthesize multi-track findings. |
| [lead-researcher](skills/lead-researcher/) | Project | End-to-end research orchestrator from hypothesis to publication. |
| [ai-engineer](skills/ai-engineer/) | Engineering | Transform research papers into production-ready product architectures. |
| [auto-benchmark](skills/auto-benchmark/) | Continuous | Continuous competitive benchmarking loop to defend #1 rankings. |
| [hypothesis-generation](skills/hypothesis-generation/) | Task | Generate and stress-test novel research hypotheses. |
| [literature-synthesis](skills/literature-synthesis/) | Task | Synthesize findings across a large body of research papers. |
| [ieee-paper-generator](skills/ieee-paper-generator/) | Task | Generate publication-ready IEEE conference and journal papers. |

### Engineering Skills
Transforming research into products with high-converting web presence.

#### Engineering Hierarchy
```mermaid
graph TD
    AE[ai-engineer] --> AWB[auto-website-builder]
```

| Skill | Layer | Description |
|-------|-------|-------------|
| [ai-engineer](skills/ai-engineer/) | Lead | Owns the full engineering pipeline, PRD, and tech stack design. |
| [auto-website-builder](skills/auto-website-builder/) | Task | Produces investor-grade websites and complete Next.js codebases. |

### Enterprise / Operations Skills
Real-time agent construction for enterprise platforms.

| Skill | Description |
|-------|-------------|
| [dynamic-enterprise-agent](skills/dynamic-enterprise-agent/) | Build deployable AI agents on-the-fly for ServiceNow, Salesforce, AWS, and more. |

### GTM / Sales Skills
Product intelligence, pre-sales automation, and autonomous prospecting.

#### Product Intelligence Hierarchy
```mermaid
graph TD
    PAR[pm-ai-research] --> PL[pm-lead]
    PL --> SI[stakeholder-intel]
    PL --> CR[competitive-research]
    PL --> IG[idea-generation]
    PL --> PW[prd-writer]
    PL --> RP[roadmap-planner]
    PL --> PRW[proposal-writer]
```

| Skill | Category | Description |
|-------|----------|-------------|
| [pm-ai-research](skills/pm-ai-research/) | Product | Portfolio-level PM intelligence and signal aggregation. |
| [pm-lead](skills/pm-lead/) | Product | End-to-end product discovery for specific product areas. |
| [proposal-automation](skills/proposal-automation/) | Pre-Sales | Transforms customer briefs into complete commercial packages and POCs. |
| [calendar-pipeline](skills/calendar-pipeline/) | Sales | Autonomous engine for C-suite prospecting and meeting generation. |
| [account-intelligence](skills/account-intelligence/) | Sales Intelligence | Produces executive-grade Account Intelligence Reports (.docx) for enterprise pursuit meetings across any industry vertical. |

### Marketing Skills
Automating the full marketing department — from brand and content through demand generation and retention.

#### Marketing Team Hierarchy
```mermaid
graph TD
    CMO[cmo-marketing] --> CM[content-marketing]
    CMO --> DG[demand-gen]
    CMO --> PM[product-marketing]
    CMO --> CG[community-growth]
    CMO --> EV[events-webinars]
    CMO --> RM[retention-marketing]
    
    CM --> SEO[seo-automation]
    CM --> WE[whitepaper-engine]
    
    DG --> PAM[paid-ads-manager]
    DG --> LR[lead-routing]
    
    PM --> CI[customer-intel]
    CI -.-> CP[calendar-pipeline]
    
    CG --> CB[community-builder]
```

| Skill | Layer | Description |
|-------|-------|-------------|
| [cmo-marketing](skills/cmo-marketing/) | Strategic | CMO orchestrator running strategy, budget, and cross-functional campaigns. |
| [content-marketing](skills/content-marketing/) | Orchestrator | VP Content: plans editorial calendar and multi-platform distribution. |
| [demand-gen](skills/demand-gen/) | Orchestrator | VP Demand Gen: orchestrates pipeline creation, paid ads, and lead routing. |
| [product-marketing](skills/product-marketing/) | Orchestrator | VP Product Marketing: positioning, messaging, and sales enablement. |
| [community-growth](skills/community-growth/) | Orchestrator | VP Community & Ecosystem: strategy across GitHub, Discord, and Slack. |
| [retention-marketing](skills/retention-marketing/) | VP | VP Lifecycle & Retention: maximize LTV through onboarding and NPS. |

### Strategic Partnerships & Alliances Skills
Full-stack partnership program — from strategy and Big 4 recruitment through negotiation, enablement, joint GTM, alliance marketing, sales operations, and partner finance.

#### Partnership Hierarchy
```mermaid
graph TD
    SP[strategic-partnerships] --> PS[partner-strategy]
    SP --> PR[partner-recruitment]
    SP --> PN[partner-negotiation]
    SP --> PE[partner-enablement]
    SP --> AG[alliance-gtm]
    SP --> AM[alliance-marketing]
    SP --> SO[partner-sales-ops]
    SP --> PF[partner-finance]

    AG --> CP[calendar-pipeline]
    AG --> PA[proposal-automation]

    AM --> WE[whitepaper-engine]
    AM --> EV[events-webinars]
    AM --> PM[product-marketing]

    SO --> CP2[calendar-pipeline]
    SO --> LR[lead-routing]
```

| Skill | Role | Description |
|-------|------|-------------|
| [strategic-partnerships](skills/strategic-partnerships/) | CPO / VP Strategic Alliances | Top-level orchestrator: partner portfolio, alliances strategy, board reporting, full program governance. |
| [partner-strategy](skills/partner-strategy/) | VP Partnership Strategy | Partnership thesis, market mapping, partner tier framework, build-vs-partner decisions, OKRs, multi-year roadmap. |
| [partner-recruitment](skills/partner-recruitment/) | Director, Partner Development | Identify and pitch Big 4, GSIs, boutique consultancies, and ISVs; executive outreach, business case construction, qualification gate. |
| [partner-negotiation](skills/partner-negotiation/) | Director, Alliance Negotiations | LOI, MOU, co-sell, reseller, implementation, and JV agreements; commercial term structuring, legal provisions, negotiation playbook. |
| [partner-enablement](skills/partner-enablement/) | Director, Partner Enablement | 30/60/90-day onboarding, certification programs (Foundation → Expert), sales kit production, battle cards, QBRs, partner portal. |
| [alliance-gtm](skills/alliance-gtm/) | VP, Alliance GTM | Joint account planning, co-sell motion, implementation partnership framework, JV GTM, upsell and expansion within partner accounts. |
| [alliance-marketing](skills/alliance-marketing/) | Director, Alliance Marketing | Co-authored thought leadership, joint events, co-branding, company positioning via ecosystem, press strategy, partner awards. |
| [partner-sales-ops](skills/partner-sales-ops/) | Director, Partner Sales Operations | Deal registration system, AE/SE/AM calendar coordination, partner pipeline tracking, CRM hygiene, attribution, weekly reporting. |
| [partner-finance](skills/partner-finance/) | Director, Partner Finance & Pricing | Referral fees, reseller margins, MDF program, revenue recognition, partner program P&L, pricing alignment, Finance team coordination. |

### Investor Relations & Fundraising Skills
Fully automated fundraising — from investor discovery and pitch deck production through outreach campaigns, calendar packing, due diligence preparation, and round analytics.

#### Investor Relations Hierarchy
```mermaid
graph TD
    CRO[cro-investor-relations] --> IR[investor-research]
    CRO --> PD[pitch-deck-builder]
    CRO --> IO[investor-outreach]
    CRO --> IC[investor-calendar]
    CRO --> DD[due-diligence-prep]
    CRO --> FA[fundraising-analytics]
```

| Skill | Layer | Description |
|-------|-------|-------------|
| [cro-investor-relations](skills/cro-investor-relations/) | Strategic Orchestrator | Top-level fundraising orchestrator: raise strategy, investor relations, board reporting, sub-skill coordination from research to close. |
| [investor-research](skills/investor-research/) | Intelligence | Discover, profile, score, and prioritize investors — VCs, angels, HNIs, family offices, CVCs — with intel briefs and warm intro mapping. |
| [pitch-deck-builder](skills/pitch-deck-builder/) | Production | Build investor-grade pitch decks: problem, TAM/SAM/SOM, solution, architecture, traction, case studies, IP/patents, competition, team, and ask. |
| [investor-outreach](skills/investor-outreach/) | Outreach Engine | Automated personalized multi-channel outreach — cold email, LinkedIn, warm intros — for angels, VCs (Sequoia, a16z, Greylock, Bain Capital), HNIs, and family offices. |
| [investor-calendar](skills/investor-calendar/) | Calendar Engine | Pack the founder's calendar with investor meetings — scheduling, pre-meeting briefs, day-of prep, post-meeting follow-up, and round momentum management. |
| [due-diligence-prep](skills/due-diligence-prep/) | DD Engine | Build and organize the investor data room — financials, legal, cap table, technical architecture, customer references, and full DD Q&A preparation. |
| [fundraising-analytics](skills/fundraising-analytics/) | Intelligence | Track conversion funnel, measure outreach effectiveness, forecast round close, analyze investor sentiment, and produce board-ready fundraising reports. |

### Finance & Operations Skills
Fully autonomous finance department — from financial strategy and revenue operations through payroll, AP, tax compliance, and partner program finance.

#### Finance Team Hierarchy
```mermaid
graph TD
    CFO[cfo-finance] --> RO[revenue-operations]
    CFO --> AP[accounts-payable]
    CFO --> PC[payroll-compensation]
    CFO --> TC[tax-compliance]

    RO --> IM[invoice-management]
    RO --> CT[commission-tracker]

    AP --> POM[purchase-order-management]
    AP --> EM[expense-management]

    PC --> SM[salary-management]
```

| Skill | Layer | Description |
|-------|-------|-------------|
| [cfo-finance](skills/cfo-finance/) | Strategic | CFO orchestrator: financial strategy, investor reporting, revenue ops, AP, payroll, and tax compliance. |
| [revenue-operations](skills/revenue-operations/) | Orchestrator | VP Revenue Ops: customer invoicing, recurring billing, revenue recognition, and commission payout. |
| [invoice-management](skills/invoice-management/) | Task | AR: invoice generation, tracking, collections, and aging reports. |
| [commission-tracker](skills/commission-tracker/) | Task | Sales Comp: calculate, track, and process commission payouts, accelerators, SPIFFs, and clawbacks. |
| [accounts-payable](skills/accounts-payable/) | Orchestrator | VP AP: vendor invoice processing, PO management, and employee expense reimbursements. |
| [purchase-order-management](skills/purchase-order-management/) | Task | PO creation, three-way matching, vendor onboarding, and procurement controls. |
| [expense-management](skills/expense-management/) | Task | Employee expense reports, policy enforcement, and reimbursement workflows. |
| [payroll-compensation](skills/payroll-compensation/) | Orchestrator | VP Payroll: payroll processing, benefits administration, and compensation planning. |
| [salary-management](skills/salary-management/) | Task | Salary bands, compensation changes, equity grants, and total compensation statements. |
| [tax-compliance](skills/tax-compliance/) | Task | Corporate tax, sales tax, VAT, transfer pricing, and R&D tax credits. |

### Security & Compliance Skills
Fully autonomous enterprise security organization — from risk governance and compliance through SOC operations, AppSec, infrastructure security, and AI ethics.

#### Security Team Hierarchy
```mermaid
graph TD
    CISO[ciso] --> CG[compliance-governance]
    CISO --> SO[security-operations]
    CISO --> AS[application-security]
    CISO --> IS[infrastructure-security]
    CISO --> AES[ai-ethics-security]
    CISO --> ST[security-trainer]

    CG --> CA[compliance-auditor]
    CG --> IC[industry-compliance]

    SO --> TH[threat-hunter]
    SO --> IR[incident-responder]
    SO --> SRE[sre-operations]

    AS --> PT[penetration-tester]

    IS --> IAM[iam-specialist]
    IS --> NDS[network-data-security]

    AES --> ASA[ai-security-analyst]
```

| Skill | Layer | Description |
|-------|-------|-------------|
| [ciso](skills/ciso/) | Strategic | CISO orchestrator: enterprise security strategy, risk governance, and board-level reporting. |
| [compliance-governance](skills/compliance-governance/) | Orchestrator | VP Compliance: SOC 2, ISO 27001, HIPAA, GDPR, EU AI Act, and industry-specific frameworks. |
| [compliance-auditor](skills/compliance-auditor/) | Task | Audit evidence collection, control testing, SOC 2 readiness, and GRC platform management. |
| [industry-compliance](skills/industry-compliance/) | Task | Vertical-specific compliance: HIPAA, PCI-DSS, SOX, FedRAMP, and financial services. |
| [security-operations](skills/security-operations/) | Orchestrator | VP SOC: threat monitoring, incident detection, and SRE reliability. |
| [threat-hunter](skills/threat-hunter/) | Task | Proactive threat hunting, anomaly detection, and IOC intelligence. |
| [incident-responder](skills/incident-responder/) | Task | Incident containment, eradication, recovery, and post-incident reporting. |
| [sre-operations](skills/sre-operations/) | Task | Platform reliability, SLO compliance, incident runbooks, and operational security controls. |
| [application-security](skills/application-security/) | Orchestrator | VP AppSec: secure SDLC, SAST/DAST toolchains, vulnerability management, and bug bounty. |
| [penetration-tester](skills/penetration-tester/) | Task | Authorized penetration tests, red team exercises, and vulnerability assessments. |
| [infrastructure-security](skills/infrastructure-security/) | Orchestrator | VP Infra Security: cloud security posture, network architecture, encryption, and IAM governance. |
| [iam-specialist](skills/iam-specialist/) | Task | RBAC, least-privilege, privileged access management, and SSO/MFA architecture. |
| [network-data-security](skills/network-data-security/) | Task | Network segmentation, DLP controls, encryption policies, and data classification. |
| [ai-ethics-security](skills/ai-ethics-security/) | Orchestrator | VP AI Security & Ethics: AI system security, responsible AI governance, and EU AI Act compliance. |
| [ai-security-analyst](skills/ai-security-analyst/) | Task | AI threat modeling, prompt injection testing, LLM security hardening, and adversarial assessments. |
| [security-trainer](skills/security-trainer/) | Task | Security awareness training, phishing simulations, and role-based compliance education. |

---

## 🚀 Using Skills

### Claude Code — Plugin Marketplace

This repository is a Claude Code plugin marketplace. Add it once and selectively install only the skills you need — no need to install everything.

**Step 1: Add the marketplace**

Add a GitHub repository that contains a `.claude-plugin/marketplace.json` file using the `owner/repo` format — where `owner` is the GitHub username or organization and `repo` is the repository name. For example, `aviskaar/open-org` refers to the `open-org` repository owned by `aviskaar`:

```bash
/plugin marketplace add aviskaar/open-org
```

This registers the catalog with Claude Code so you can browse what's available. No plugins are installed yet.

**Step 2: Browse and install individual skills**

Run `/plugin` to open the plugin manager and go to the **Discover** tab to browse all available skills. You can install only the ones relevant to your work:

```bash
# Install a single skill
/plugin install lead-researcher@open-org

# Or install a few specific skills
/plugin install ciso@open-org
/plugin install cfo-finance@open-org
/plugin install cmo-marketing@open-org
```

**You don't have to install all skills** — the marketplace is just a catalog. Pick only what you need.

**Installation scopes**

When prompted, choose a scope:
- **User scope** (default): install for yourself across all projects
- **Project scope**: install for your whole team (adds to `.claude/settings.json`)
- **Local scope**: install for yourself in this repository only

**Managing installed skills**

```bash
# List installed plugins
/plugin

# Disable a skill without uninstalling
/plugin disable lead-researcher@open-org

# Uninstall a skill
/plugin uninstall lead-researcher@open-org
```

### Claude.ai
Upload any `SKILL.md` file into a **Claude.ai Project** to activate it for your conversation.

### API Usage
Inject skill instructions into the `system_prompt` or use the dedicated Skills API (where available).

---

## ✍️ Creating a Skill

Start from the [template](template/SKILL.md). A valid skill requires YAML frontmatter:

```markdown
---
name: my-skill
description: "Use this skill when..."
metadata:
  author: your-name
  version: "1.0"
---

# Instructions
Detailed behavioral instructions go here.
```

**Best Practices:**
- **Trigger-focused:** Write descriptions as activation conditions.
- **Modular:** Keep `SKILL.md` under 500 lines; use `references/` for data.
- **Tooling:** Explicitly define `allowed-tools` if the skill requires environment access.

---

## 🤝 Contributing

We welcome contributions from the community! Skills live in the [/skills](skills/) directory — browse existing ones for inspiration.

**Steps to contribute:**
1. Fork the repo and create your branch: `skill/your-skill-name`.
2. Adhere to the [Agent Skills Specification](https://agentskills.io/specification).
3. Ensure no hardcoded credentials or proprietary data are included.
4. Open a Pull Request with a clear description of the use cases and problem being solved.

**Adding agent team workflows?** See [AGENTS.md](AGENTS.md) for how to document multi-agent coordination patterns.

---

## 📂 Repository Structure

```text
.
├── skills/                   # Individual skill packages
│   ├── hypothesis-generation/    # Research — task
│   ├── lead-researcher/          # Research — project orchestrator
│   ├── ai-engineer/              # Engineering — orchestrator
│   ├── cmo-marketing/            # Marketing — strategic orchestrator
│   └── ...
├── template/                 # Starter template for new skills
└── spec/                     # Agent Skills Specification reference
```

---

## 📈 Roadmap

| Milestone | Description | Status |
|-----------|-------------|--------|
| **v0.5 — Skill Library** | Publish 20+ production-ready skills across all org functions | ✅ In progress |
| **v1.0 — Autonomy Benchmarks** | Define and publish benchmarks for single-person org automation (research, GTM, engineering) | 🔜 Planned |
| **v1.5 — Agent Teams Integration** | First-class multi-agent orchestration with the [Agent Teams](AGENTS.md) model baked into every skill hierarchy | 🔜 Planned |
| **v2.0 — Enterprise Runtime** | Hosted skill execution, usage analytics, and SSO/RBAC for enterprise deployments | 🔜 Planned |
| **v3.0 — Unicorn Playbook** | End-to-end autonomous org template: one founder, full AI team, verified unicorn-track metrics | 🔜 Planned |

Have a feature request? [Open an issue](https://github.com/aviskaar/open-org/issues) or start a discussion.

---

## 📄 License

Unless otherwise specified in a skill's frontmatter, all content is licensed under the [Apache 2.0 License](LICENSE).

---

<p align="center">
  <i>Aviskaar — Advancing AI through open, composable tooling.</i>
</p>
