# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Open Org** is a Claude Code plugin marketplace publishing 70+ portable AI skills for enterprise automation. Each skill is a directory with a `SKILL.md` file (YAML frontmatter + Markdown instructions) following the [Agent Skills Specification](https://agentskills.io/specification). Skills are organized into hierarchies: Research, Engineering, GTM/Sales, Marketing, Partnerships, Investor Relations, Finance, and Security.

## Repository Structure

```
skills/                      # 70+ skill packages, each in its own directory
  └── <skill-name>/
       └── SKILL.md         # Required: instructions + metadata frontmatter
       └── scripts/         # Optional: executable helpers
       └── references/      # Optional: supplementary docs
       └── assets/          # Optional: static resources
template/
  └── SKILL.md              # Starter template for new skills
  └── agents/openai.yaml       # Codex companion config template
spec/
  └── README.md             # Agent Skills Specification quick reference
.claude/
  └── settings.json         # Agent teams enabled, TeammateIdle & TaskCompleted hooks
  └── hooks/                # Bash hooks for quality gates
.github/workflows/
  └── claude.yml            # Auto-responds to @claude mentions on issues/PRs
  └── claude-code-review.yml  # Auto-reviews PRs via Claude Code action
.claude-plugin/
  └── marketplace.json      # Plugin catalog (pluginRoot: ./skills, 70+ entries)
```

## Adding a New Skill

1. Copy `template/SKILL.md` into `skills/<skill-name>/SKILL.md`
2. Fill in YAML frontmatter: `name`, `description` (trigger condition), `license`, `metadata`
3. Keep `SKILL.md` under 500 lines; put reference data in `references/`
4. Add an entry to `.claude-plugin/marketplace.json` with name, source, description, version, keywords, category
5. Branch naming convention: `skill/your-skill-name`

## Agent Teams Configuration

Agent teams are enabled via `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` in `.claude/settings.json`. The settings file also configures `TeammateIdle` and `TaskCompleted` hooks that run bash scripts for quality gate enforcement. See `AGENTS.md` for pre-built team hierarchies (research, engineering, marketing, security, etc.) and how to spawn them.

## GitHub CI/CD

- **claude.yml**: Triggers when `@claude` is mentioned on issues, PR comments, or PR reviews. Uses `anthropics/claude-code-action@v1`.
- **claude-code-review.yml**: Auto-reviews PRs on open/sync/ready_for_review/reopened events.

Both require `CLAUDE_CODE_OAUTH_TOKEN` secret.

## Key Conventions

- **Skill naming**: lowercase, hyphens, 1-64 chars
- **Frontmatter description**: 1-1024 chars, written as a trigger condition ("Use this skill when...")
- **License**: Apache 2.0 by default, overridable per-skill via frontmatter
- **No hardcoded credentials** in any skill files

## Multi-Format Skill Support

Skills are compatible with three agent platforms:
- **Claude Code**: Base Agent Skills Spec, `SKILL.md` with YAML frontmatter
- **OpenAI Codex**: Add `agents/openai.yaml` for interface/policy/dependencies config. Symlink `.agents/skills` → `skills/` for discovery.
- **Nous Research Hermes**: Extended frontmatter fields (`platforms`, `required_environment_variables`, `requires_tools`, `fallback_for_toolsets`). Uses `templates/` directory.

See `spec/README.md` for the full compatibility matrix and format specifications.
