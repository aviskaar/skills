# Aviskaar AI Skills

Public repository for AI Skills — reusable instruction sets that extend AI agent capabilities for research workflows and go-to-market operations.

> **Skills** are folders of instructions, scripts, and resources that an AI agent loads dynamically to improve performance on specialized tasks.

## What are Skills?

A skill is a lightweight, portable package that gives an AI agent deep, domain-specific expertise. Each skill lives in its own folder with a `SKILL.md` file at the root:

```
my-skill/
└── SKILL.md          # Required: instructions + metadata frontmatter
    scripts/          # Optional: executable helpers
    references/       # Optional: additional docs loaded on-demand
    assets/           # Optional: static resources, templates, data
```

Skills follow the open [Agent Skills Specification](https://agentskills.io/specification). They are composable, version-controlled, and shareable across teams.

---

## Available Skills

### Research Skills

Skills for AI/ML research workflows — from ideation and literature review through experimentation, replication, and publication.

#### Orchestration Hierarchy

Research skills are organized in a hierarchy from highest-level strategy to task-level execution. Each layer commands the layers below it.

```
computer-scientist          Survey a domain, discover & prioritize open problems,
│                           commission Principal Scientists to attack them
│
└── principal-scientist     Manage a portfolio of parallel research tracks;
    │                       spawn multiple Lead Researchers & integrate Auto-Benchmark
    │
    ├── lead-researcher     Run one complete research project end-to-end,
    │   │                   coordinating all sub-skills in sequence
    │   │                   ↕ (collaborates with)
    │   │
    │   │   ai-engineer     Engineering lead: PRD, tech stack, AI integration,
    │   │   │               backend, scaling — works alongside the research team
    │   │   │               and delegates the entire web/UI layer to:
    │   │   │
    │   │   └── auto-website-builder   Complete website, brand, all pages,
    │   │                              design system, and Next.js codebase
    │   │
    │   ├── hypothesis-generation      Generate & stress-test candidate hypotheses
    │   ├── literature-synthesis       Synthesize findings across a body of papers
    │   ├── experiment-design          Design rigorous ML experiments
    │   ├── code-replication           Reproduce & validate baseline results
    │   ├── research-paper-review      Structured critique of specific papers
    │   ├── research-writing           Draft sections, abstracts, rebuttals
    │   └── ieee-paper-generator       Generate full publication-ready IEEE papers
    │
    └── auto-benchmark      Continuous competitive benchmarking loop;
                            monitors leaderboards, runs improvement experiments,
                            defends rank #1
```

#### Skill Reference

| Skill | Layer | Description |
|-------|-------|-------------|
| [computer-scientist](skills/computer-scientist/) | Strategic | Survey a research domain, discover and formulate open problems worth solving, prioritize by impact and feasibility, and commission Principal Scientist agents to execute the research |
| [principal-scientist](skills/principal-scientist/) | Portfolio | Portfolio orchestrator that spawns and manages multiple Lead Researcher agents in parallel across competing hypotheses or independent research tracks, integrates Auto-Benchmark for continuous competitive validation, and synthesizes findings into a unified strategic output |
| [lead-researcher](skills/lead-researcher/) | Project | End-to-end research orchestrator that conducts a full project — hypothesis generation, literature synthesis, experiment design, optional code replication and paper review, through to publication-ready research writing — by coordinating all research sub-skills in sequence |
| [ai-engineer](skills/ai-engineer/) | Engineering | Engineering lead that orchestrates a research paper into a production-ready product — writing the PRD, designing the tech stack, directing AI/ML integration, running backend development, scaling the system, and delegating all web presence and UI work to `auto-website-builder` |
| [auto-benchmark](skills/auto-benchmark/) | Continuous | Continuous competitive benchmarking system that monitors leaderboards, ingests research papers, auto-runs improvement experiments, and keeps a solution ranked #1 |
| [hypothesis-generation](skills/hypothesis-generation/) | Task | Generate, refine, and stress-test novel research hypotheses grounded in existing literature |
| [literature-synthesis](skills/literature-synthesis/) | Task | Synthesize findings across a body of research into coherent summaries |
| [experiment-design](skills/experiment-design/) | Task | Design rigorous ML experiments with proper baselines and evaluation protocols |
| [code-replication](skills/code-replication/) | Task | Reproduce results from papers with documented methodology and discrepancy tracking |
| [research-paper-review](skills/research-paper-review/) | Task | Structured critique and analysis of AI/ML research papers |
| [research-writing](skills/research-writing/) | Task | Draft and refine research papers, abstracts, related work, and rebuttals |
| [ieee-paper-generator](skills/ieee-paper-generator/) | Task | Generate complete, publication-ready IEEE conference and journal papers from experiment results |

### Engineering Skills

Skills for transforming research outputs into production software — from requirements and architecture through a fully deployed, scaled product with a high-converting web presence.

#### Engineering Hierarchy

```
ai-engineer         Engineering lead: consults the research team, owns PRD, tech stack,
│                   AI/ML integration, backend, QA, scaling, and handoff
│
└── auto-website-builder    Full web presence: brand identity, all site pages,
                            design system, SVG logo, pricing, and Next.js codebase
```

| Skill | Layer | Description |
|-------|-------|-------------|
| [ai-engineer](skills/ai-engineer/) | Engineering Lead | Orchestrates the full engineering pipeline from a research paper to a deployed product. Consults the research lead at every critical junction and delegates all web presence and UI work to `auto-website-builder` |
| [auto-website-builder](skills/auto-website-builder/) | Engineering Task | Produces a complete, investor-grade website and brand identity — naming, logo, all pages, design tokens, pricing strategy, and a production-ready Next.js codebase. Invoked and briefed by `ai-engineer` at Stage 5 |

### Enterprise / Operations Skills

Skills for building and deploying AI agents across enterprise platforms and industries — in real time, during the conversation.

| Skill | Description |
|-------|-------------|
| [dynamic-enterprise-agent](skills/dynamic-enterprise-agent/) | Build a fully specified, code-ready, deployable AI agent on-the-fly from a spoken or written business problem. Covers any enterprise platform (ServiceNow, Salesforce, Workday, SAP, Snowflake, Microsoft 365/Azure, AWS, GCP, Okta, CyberArk, Splunk, Epic, Veeva, Bloomberg, and more) and any industry (healthcare, life sciences, fintech, banking, retail, manufacturing, federal, and beyond). The agent is live before the meeting ends |

### GTM / Sales Skills

Skills for go-to-market and revenue workflows — from product intelligence and discovery through pre-sales proposals, prospecting, and pipeline generation.

#### Product Intelligence Hierarchy

Product intelligence skills are organized in a hierarchy from portfolio-level strategy down to task-level execution. Each layer orchestrates the layers below it.

```
pm-ai-research          Portfolio PM intelligence platform: manages multiple product areas
│                       simultaneously, runs cross-portfolio signal aggregation, commissions
│                       pm-lead cycles per area, synthesizes portfolio roadmaps, and produces
│                       proposals at scale — the always-on research partner for the PM team
│
└── pm-lead             End-to-end product discovery and planning orchestrator for a single
    │                   product area — runs the complete cycle from stakeholder intel through
    │                   competitive research, ideation, PRD writing, roadmap, and proposals
    │
    ├── stakeholder-intel      Gather, structure, and synthesize signals from sales, customers,
    │                          marketing, engineering, executives, and investors into a unified
    │                          intelligence brief with Act Now / Investigate / Monitor tiers
    │
    ├── competitive-research   Deep competitive intelligence — landscape mapping, feature
    │                          matrix, positioning analysis, pricing intelligence, momentum
    │                          scoring, and white-space opportunity identification
    │
    ├── idea-generation        Research-backed product ideation across H1/H2/H3 horizons
    │                          using Gap Attack, Analogous Markets, First Principles, Inversion,
    │                          Trend Intersection, Blue Ocean, Jobs to Be Done, and SCAMPER
    │
    ├── prd-writer             Translate research, stakeholder signals, and ideas into complete,
    │                          testable PRDs — user stories, acceptance criteria, functional and
    │                          non-functional requirements, success metrics, and risk register
    │
    ├── roadmap-planner        Build prioritized roadmaps with RICE / Opportunity / Strategic
    │                          Stack Rank scoring, capacity mapping, trade-off documentation,
    │                          and three audience-specific narratives (Engineering, Executive, GTM)
    │
    └── proposal-writer        Write internal proposals (resource requests, strategy bets,
                               cross-functional alignment) and external customer-facing proposals
                               (strategic accounts, beta programs, partnerships, co-development)
```

#### Product Intelligence Skill Reference

| Skill | Layer | Description |
|-------|-------|-------------|
| [pm-ai-research](skills/pm-ai-research/) | Portfolio | Portfolio PM intelligence platform that manages multiple product areas simultaneously, runs continuous competitive and market monitoring, commissions and oversees `pm-lead` planning cycles, synthesizes cross-portfolio roadmaps, and produces a Proposal Catalog at scale |
| [pm-lead](skills/pm-lead/) | Project | End-to-end product discovery and planning orchestrator that runs a complete cycle for a single product area — from stakeholder intelligence and competitive research through ideation, PRD writing, roadmap planning, and proposals — coordinating all PM sub-skills in sequence |
| [stakeholder-intel](skills/stakeholder-intel/) | Task | Gather, structure, and synthesize stakeholder signals from sales, customers, sales engineers, marketing, engineering, executives, and investors into an actionable intelligence brief with prioritized Act Now / Investigate / Monitor tiers |
| [competitive-research](skills/competitive-research/) | Task | Deep competitive intelligence covering landscape mapping, feature and capability matrices, positioning analysis, pricing intelligence, momentum and trajectory scoring, and white-space opportunity identification |
| [idea-generation](skills/idea-generation/) | Task | Research-backed product ideation engine that generates ideas across H1/H2/H3 horizons using seven structured modes (Gap Attack, Analogous Markets, First Principles, Inversion, Trend Intersection, Blue Ocean, Jobs to Be Done) and SCAMPER provocations |
| [prd-writer](skills/prd-writer/) | Task | Translate research findings, stakeholder signals, competitive context, and product ideas into complete, unambiguous PRDs — with user stories, acceptance criteria, functional and non-functional requirements, success metrics, and risk register |
| [roadmap-planner](skills/roadmap-planner/) | Task | Build prioritized product roadmaps using RICE, Opportunity, or Strategic Stack Rank scoring with capacity mapping, trade-off documentation, and three audience-specific narratives: Engineering, Executive, and Customer/GTM |
| [proposal-writer](skills/proposal-writer/) | Task | Write structured, evidence-backed proposals for two audiences: internal (resource requests, strategy pivots, executive alignment) and customer-facing (strategic accounts, beta programs, partnerships, co-development agreements) |

#### Pre-Sales Skills

Skills for transforming customer briefs and RFPs into boardroom-ready commercial packages — complete with working POC code, competitive analysis, architecture, cost models, and statements of work.

| Skill | Description |
|-------|-------------|
| [proposal-automation](skills/proposal-automation/) | End-to-end pre-sales and proposal lifecycle for Client Partners, Account Managers, Solutions Engineers, and Solutions Architects. Transforms a raw customer problem statement into a complete commercial package: problem analysis, use case discovery, competitive benchmarking, enterprise architecture design, fully functional POC/MVP build (no placeholders — real working code), proposal document, team and resourcing plan, US and offshore cost model with blended rates, and a legally structured Statement of Work |

#### Sales Pipeline Skills

Skills for autonomous prospecting, outreach, and pipeline generation.

| Skill | Description |
|-------|-------------|
| [calendar-pipeline](skills/calendar-pipeline/) | Autonomous revenue engine that identifies VP/Director/C-suite targets, builds prospect intel, crafts hyper-personalized outreach, runs multi-touch sequences, and fills the calendar with high-value meetings daily |

---

### Marketing Skills

Skills for automating the full marketing department — from brand and content through demand generation, paid media, community, events, customer intelligence, and retention. Organized as a complete marketing team hierarchy from CMO strategy down to task-level execution.

#### Marketing Team Hierarchy

```
cmo-marketing               Chief Marketing Officer — portfolio strategy, budget allocation,
│                           board reporting, psychological marketing tactics, and cross-
│                           functional campaign orchestration across all marketing functions
│
├── content-marketing       VP Content: editorial calendar, SEO-optimized articles, blog
│   │                       posts, press releases, LinkedIn/Medium publishing, newsletter,
│   │                       multi-platform content distribution, and repurposing cascade
│   │
│   ├── seo-automation      Technical SEO audits, keyword research engine, on-page
│   │                       optimization, link building, SERP monitoring, Core Web Vitals,
│   │                       and automated content pipeline to keep pages in top positions
│   │
│   └── whitepaper-engine   Cross-functional whitepaper production — topic selection,
│                           stakeholder interviews (Engineering, Sales, Product, C-level),
│                           writing, design briefing, gated landing page, and distribution
│                           to investors, enterprise buyers, and analysts
│
├── demand-gen              VP Demand Generation: pipeline orchestration, MQL/SQL lifecycle,
│   │                       multi-channel lead gen, nurture sequences, attribution, and
│   │                       full-funnel reporting — commissions paid-ads-manager and
│   │                       lead-routing for automated pipeline creation
│   │
│   ├── paid-ads-manager    Multi-platform ad management across Meta, LinkedIn, Twitter/X,
│   │                       Instagram, and Google — creative testing, A/B optimization,
│   │                       audience refinement (title, industry, geography, age), automatic
│   │                       ad set management, and ROAS maximization
│   │
│   └── lead-routing        Lead capture from all sources (webinars, events, ads, content,
│                           community), enrichment, fit + engagement scoring, territory-
│                           based CRM routing, personalized follow-up sequences, and
│                           automated calendar filling for the sales team
│
├── product-marketing       VP Product Marketing: positioning architecture, messaging house,
│   │                       persona-specific narratives, GTM launch playbooks, competitive
│   │                       battle cards, psychological tactics for investors / industry
│   │                       leaders / enterprise buyers / end users, analyst relations,
│   │                       and complete sales enablement packages
│   │
│   └── customer-intel      Account intelligence engine — technology stack mapping, vendor
│                           relationship profiling, leadership org chart construction,
│                           contact discovery, hiring signal analysis, buying trigger
│                           identification, and sales intelligence briefs for every
│                           target account; feeds directly into calendar-pipeline
│
├── community-growth        VP Community & Ecosystem: community strategy across GitHub,
│   │                       Discord, Slack, Reddit, LinkedIn Groups, and developer forums;
│   │                       GitHub star campaigns, ambassador programs, community-sourced
│   │                       pipeline generation, and developer relations programs
│   │
│   └── community-builder   Day-to-day community operations — onboarding new members,
│                           weekly content and engagement calendar, moderation, ambassador
│                           network management, pipeline signal detection, and weekly
│                           community health reporting across all platforms
│
├── events-webinars         VP Events & Field Marketing: full events program including
│                           weekly webinars, technology workshops, solution workshops,
│                           executive roundtables, user conferences, global speaking
│                           engagements, and conference activations — with complete
│                           lead capture, post-event routing, and pipeline reporting
│
└── retention-marketing     VP Lifecycle & Retention: customer onboarding automation,
                            stickiness tactics, churn prediction and prevention, NPS
                            program, expansion/upsell campaigns, win-back sequences,
                            and community integration to maximize customer lifetime value
```

#### Marketing Skill Reference

| Skill | Layer | Description |
|-------|-------|-------------|
| [cmo-marketing](skills/cmo-marketing/) | Strategic | Chief Marketing Officer orchestrator — runs the full marketing department: strategy, budget allocation, psychological marketing tactics, campaign commissioning, board reporting, and continuous intelligence loop across all marketing functions |
| [content-marketing](skills/content-marketing/) | VP / Orchestrator | VP Content: plans and executes the editorial calendar, produces SEO-optimized articles, press releases, LinkedIn and Medium posts, and manages multi-platform distribution — orchestrates `seo-automation` and `whitepaper-engine` |
| [seo-automation](skills/seo-automation/) | Task | Autonomous SEO engine: technical audits, keyword research, on-page optimization, link building, SERP monitoring, Core Web Vitals, and a continuously updated content pipeline that keeps the website in top search positions |
| [whitepaper-engine](skills/whitepaper-engine/) | Task | Cross-functional whitepaper production: topic selection, contributor interviews across Engineering/Sales/Product/C-level, research synthesis, writing, design briefing, gated landing page, and distribution to investors, enterprise buyers, and analysts |
| [demand-gen](skills/demand-gen/) | VP / Orchestrator | VP Demand Generation: orchestrates the full pipeline creation engine — MQL/SQL lifecycle, multi-channel programs, nurture sequences, budget allocation, and revenue attribution — commissioning `paid-ads-manager` and `lead-routing` |
| [paid-ads-manager](skills/paid-ads-manager/) | Task | Multi-platform performance marketing: designs, launches, and continuously optimizes paid campaigns across Meta, LinkedIn, Twitter/X, and Google — creative testing, A/B framework, audience refinement, and ROAS maximization |
| [lead-routing](skills/lead-routing/) | Task | Autonomous lead processing: captures leads from all sources, enriches with firmographic/behavioral data, scores for fit and intent, routes to the right rep by territory, triggers personalized follow-up, and automatically fills the sales calendar |
| [product-marketing](skills/product-marketing/) | VP / Orchestrator | VP Product Marketing: positioning architecture, persona messaging, psychological tactics for investors/leaders/enterprise/end users, GTM launch playbooks, competitive battle cards, analyst relations, and sales enablement — commissions `customer-intel` |
| [customer-intel](skills/customer-intel/) | Task | Account intelligence engine: technology stack mapping, vendor profiling, org chart and leadership hierarchy construction, contact discovery, hiring signal analysis, and sales intelligence briefs to give the sales team an unfair advantage |
| [community-growth](skills/community-growth/) | VP / Orchestrator | VP Community & Ecosystem: community strategy across GitHub, Discord, Slack, Reddit, and LinkedIn Groups; GitHub star campaigns, ambassador programs, developer relations, and community-sourced pipeline — orchestrates `community-builder` |
| [community-builder](skills/community-builder/) | Task | Community operations and daily engagement: member onboarding, weekly content calendar, platform moderation, ambassador management, pipeline signal detection, and weekly health reporting across all community platforms |
| [events-webinars](skills/events-webinars/) | VP | VP Events & Field Marketing: plans and executes webinars, technology workshops, solution workshops, executive roundtables, user conferences, and global speaking programs — with full lead capture, post-event routing, and pipeline reporting |
| [retention-marketing](skills/retention-marketing/) | VP | VP Lifecycle & Retention: onboarding automation, stickiness tactics, churn prediction/prevention, NPS program, upsell/expansion campaigns, win-back sequences, and community integration to maximize customer lifetime value and NRR |

---

## Using Skills

### Claude Code

Install a skill from this repository directly into your project:

```bash
# Install a specific skill
/plugin install aviskaar/skills#research-paper-review

# Or reference it in your .claude/settings.json
```

### Claude.ai

Upload any `SKILL.md` file in a Claude.ai Project to activate the skill for that project's conversations.

### Claude API

Pass skill instructions via the system prompt or use the Skills API to attach a pre-built skill deployment to your API calls.

---

## Creating a Skill

Start from the [template](template/SKILL.md):

```markdown
---
name: my-skill
description: What the skill does and when the agent should use it.
metadata:
  author: aviskaar
  version: "1.0"
---

# Instructions

Write your skill instructions here.
```

**Frontmatter fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Lowercase letters, numbers, hyphens (1–64 chars) |
| `description` | Yes | When and why the agent should activate this skill (1–1024 chars) |
| `license` | No | SPDX license identifier (e.g. `Apache-2.0`) |
| `compatibility` | No | Environment or tool requirements |
| `metadata` | No | Arbitrary key-value pairs (author, version, tags, etc.) |
| `allowed-tools` | No | Pre-approved tools the skill may invoke |

**Best practices:**
- Keep `SKILL.md` under 500 lines; move dense reference material to `references/`
- Write the description as a trigger condition: *"Use this skill when…"*
- Use `scripts/` for reusable automation; document inputs and outputs inline
- Test your skill with at least three realistic scenarios before publishing

---

## Contributing

We welcome contributions from the research and GTM communities.

1. Fork this repository
2. Create a new branch: `git checkout -b skill/your-skill-name`
3. Add your skill under `skills/your-skill-name/SKILL.md`
4. Open a pull request with a brief description of what the skill does and example use cases

Please follow the [Agent Skills Specification](https://agentskills.io/specification) and keep instructions concise, composable, and free of hardcoded credentials or proprietary data.

---

## Repository Structure

```
aviskaar/skills/
├── skills/                   # Individual skill packages
│   ├── hypothesis-generation/    # Research — task
│   ├── literature-synthesis/     # Research — task
│   ├── experiment-design/        # Research — task
│   ├── code-replication/         # Research — task
│   ├── research-paper-review/    # Research — task
│   ├── research-writing/         # Research — task
│   ├── ieee-paper-generator/     # Research — task
│   ├── auto-benchmark/           # Research — continuous benchmarking
│   ├── lead-researcher/          # Research — project orchestrator
│   ├── principal-scientist/      # Research — portfolio orchestrator
│   ├── computer-scientist/       # Research — strategic agenda-setter
│   ├── ai-engineer/              # Engineering — orchestrates full research-to-product build
│   ├── auto-website-builder/     # Engineering — web presence, brand, UI (sub-skill of ai-engineer)
│   ├── dynamic-enterprise-agent/ # Enterprise / Operations — real-time agent builder
│   ├── pm-ai-research/           # GTM / Product Intelligence — portfolio orchestrator
│   ├── pm-lead/                  # GTM / Product Intelligence — project orchestrator
│   ├── stakeholder-intel/        # GTM / Product Intelligence — task
│   ├── competitive-research/     # GTM / Product Intelligence — task
│   ├── idea-generation/          # GTM / Product Intelligence — task
│   ├── prd-writer/               # GTM / Product Intelligence — task
│   ├── roadmap-planner/          # GTM / Product Intelligence — task
│   ├── proposal-writer/          # GTM / Product Intelligence — task
│   ├── proposal-automation/      # GTM / Pre-Sales — end-to-end proposal + POC build
│   ├── calendar-pipeline/        # GTM / Sales Pipeline — autonomous prospecting
│   ├── cmo-marketing/            # Marketing — CMO strategic orchestrator
│   ├── content-marketing/        # Marketing — VP Content & editorial (orchestrator)
│   ├── seo-automation/           # Marketing — Technical SEO & organic growth engine
│   ├── whitepaper-engine/        # Marketing — Cross-functional whitepaper production
│   ├── demand-gen/               # Marketing — VP Demand Generation (orchestrator)
│   ├── paid-ads-manager/         # Marketing — Multi-platform paid ads & ROAS optimization
│   ├── lead-routing/             # Marketing — Lead processing, scoring & calendar filling
│   ├── product-marketing/        # Marketing — VP Product Marketing (orchestrator)
│   ├── customer-intel/           # Marketing — Account intelligence & sales intel engine
│   ├── community-growth/         # Marketing — VP Community & ecosystem (orchestrator)
│   ├── community-builder/        # Marketing — Community operations & daily engagement
│   ├── events-webinars/          # Marketing — VP Events & field marketing
│   └── retention-marketing/      # Marketing — VP Lifecycle, retention & expansion
├── template/                 # Starter template for new skills
│   └── SKILL.md
├── spec/                     # Pointer to the Agent Skills Specification
└── README.md
```

---

## License

Skills in this repository are released under the [Apache 2.0 License](LICENSE) unless otherwise noted in the individual skill's frontmatter.

---

*Aviskaar — Advancing AI through open, composable tooling.*
