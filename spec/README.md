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

### Size Guidance

| Component | Recommended Limit |
|-----------|-------------------|
| `SKILL.md` | ≤ 500 lines |
| Frontmatter description | ≤ 1024 chars |
| Inline instructions | ≤ 5000 tokens |
