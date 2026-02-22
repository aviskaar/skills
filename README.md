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

### GTM / Sales Skills

Skills for go-to-market and revenue workflows — autonomous prospecting, outreach, and pipeline generation.

| Skill | Description |
|-------|-------------|
| [calendar-pipeline](skills/calendar-pipeline/) | Autonomous revenue engine that identifies VP/Director/C-suite targets, builds prospect intel, crafts hyper-personalized outreach, runs multi-touch sequences, and fills the calendar with high-value meetings daily |

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
│   ├── hypothesis-generation/    # Research
│   ├── literature-synthesis/     # Research
│   ├── experiment-design/        # Research
│   ├── code-replication/         # Research
│   ├── research-paper-review/    # Research
│   ├── research-writing/         # Research
│   ├── ieee-paper-generator/     # Research
│   ├── auto-benchmark/           # Research — continuous benchmarking
│   ├── lead-researcher/          # Research — project orchestrator
│   ├── principal-scientist/      # Research — portfolio orchestrator
│   ├── computer-scientist/       # Research — strategic agenda-setter
│   ├── ai-engineer/              # Engineering — orchestrates full research-to-product build
│   ├── auto-website-builder/     # Engineering — web presence, brand, UI (sub-skill of ai-engineer)
│   └── calendar-pipeline/        # GTM / Sales
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
