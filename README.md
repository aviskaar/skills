# Aviskaar AI Research Skills

Public repository for AI Research Skills — reusable instruction sets that extend AI agent capabilities for research workflows.

> **Skills** are folders of instructions, scripts, and resources that an AI agent loads dynamically to improve performance on specialized research tasks.

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

| Skill | Description |
|-------|-------------|
| [research-paper-review](skills/research-paper-review/) | Structured critique and analysis of AI/ML research papers |
| [literature-synthesis](skills/literature-synthesis/) | Synthesize findings across a body of research into coherent summaries |
| [experiment-design](skills/experiment-design/) | Design rigorous ML experiments with proper baselines and evaluation |
| [research-writing](skills/research-writing/) | Draft and refine research papers, abstracts, and sections |
| [code-replication](skills/code-replication/) | Reproduce results from papers with documented methodology |
| [hypothesis-generation](skills/hypothesis-generation/) | Generate, refine, and stress-test novel research hypotheses |
| [auto-benchmark](skills/auto-benchmark/) | Continuous competitive benchmarking system that monitors leaderboards, ingests research papers, auto-runs improvement experiments, and keeps a solution ranked #1 with minimal human involvement |

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

We welcome contributions from the research community.

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
│   ├── research-paper-review/
│   ├── literature-synthesis/
│   ├── experiment-design/
│   ├── research-writing/
│   ├── code-replication/
│   ├── hypothesis-generation/
│   └── auto-benchmark/
├── template/                 # Starter template for new skills
│   └── SKILL.md
├── spec/                     # Pointer to the Agent Skills Specification
└── README.md
```

---

## License

Skills in this repository are released under the [Apache 2.0 License](LICENSE) unless otherwise noted in the individual skill's frontmatter.

---

*Aviskaar — Advancing AI Research through open, composable tooling.*
