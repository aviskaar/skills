# Agent Skills Specification

Skills in this repository follow the open **Agent Skills Specification**.

Full specification: [agentskills.io/specification](https://agentskills.io/specification)

## Quick Reference

### Minimum Skill Structure

```
skill-name/
└── SKILL.md
```

### SKILL.md Frontmatter

```yaml
---
name: skill-name          # Required: lowercase, hyphens, 1-64 chars
description: ...          # Required: when/why to use this skill, 1-1024 chars
license: Apache-2.0       # Optional
metadata:                 # Optional
  author: aviskaar
  version: "1.0"
---
```

### Optional Directories

| Directory | Purpose |
|-----------|---------|
| `scripts/` | Executable code (Python, Bash, JS) |
| `references/` | Supplementary docs loaded on-demand |
| `assets/` | Static files — templates, datasets, examples |
| `templates/` | Hermes-compatible templates, forms, configs |
| `agents/` | Platform-specific companion files (see below) |

### Size Guidance

| Component | Recommended Limit |
|-----------|-------------------|
| `SKILL.md` | ≤ 500 lines |
| Frontmatter description | ≤ 1024 chars |
| Inline instructions | ≤ 5000 tokens |

### Cross-Platform Compatibility

Skills in Open Org support three agent platforms:

#### Agent Skills Spec (Claude Code)
- Discovery: `.claude/skills/` or `skills/` via `.claude-plugin/marketplace.json`
- Required: `SKILL.md` with `name` + `description` frontmatter

#### OpenAI Codex
- Discovery: `.agents/skills/` (symlink to `skills/` for shared use)
- Companion file: `agents/openai.yaml` in each skill directory
- Supports: `interface` (display_name, default_prompt), `policy` (allow_implicit_invocation), `dependencies` (MCP servers)

#### Nous Research Hermes
- Discovery: `~/.hermes/skills/category/skill-name/`
- Extended frontmatter: `platforms`, `required_environment_variables`, `requires_tools`, `fallback_for_toolsets`
- Supports `templates/` directory for forms and configs

#### Compatibility Matrix

| Feature | Claude Code | Codex | Hermes |
|---------|-------------|-------|--------|
| `SKILL.md` + frontmatter | Required | Required | Required |
| `agents/openai.yaml` | - | Optional | - |
| `scripts/` | Yes | Yes | Yes |
| `references/` | Yes | Yes | - |
| `assets/` | Yes | Yes | - |
| `templates/` | - | - | Yes |
| `required_environment_variables` | - | - | Yes |
| `requires_tools` | - | - | Yes |
