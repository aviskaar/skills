# Agent Teams in Open Org

This document describes how to use **Claude Code Agent Teams** with Open Org skills for parallel, autonomous execution across multi-agent pipelines.

> **Status:** Agent teams are an experimental feature in Claude Code. Enable them via `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` in your environment or `settings.json`.

---

## What are Agent Teams?

Agent teams coordinate multiple Claude Code instances working together. One session acts as the **team lead**, coordinating work and synthesizing results. **Teammates** work independently in their own context windows and communicate directly with each other through a shared task list and mailbox.

This is distinct from subagents, which only report results back to the caller. Teammates can message each other, challenge findings, and claim tasks autonomously.

```
Team Lead
├── Task List (shared)
├── Teammate A  ←──messages──→  Teammate B
└── Teammate C
```

---

## Enabling Agent Teams

Add the following to your `settings.json`:

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

Or export it in your shell:

```bash
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
```

---

## Agent Teams vs. Subagents

| | Subagents | Agent Teams |
|---|---|---|
| **Context** | Own context window; results return to caller | Own context window; fully independent |
| **Communication** | Report results back to main agent only | Teammates message each other directly |
| **Coordination** | Main agent manages all work | Shared task list with self-coordination |
| **Best for** | Focused tasks where only the result matters | Complex work requiring discussion and collaboration |
| **Token cost** | Lower | Higher (each teammate is a separate instance) |

---

## Open Org Skill Hierarchies as Agent Teams

Open Org skill hierarchies map naturally onto agent team structures. Each orchestrator skill becomes the **team lead**; specialist skills become **teammates**.

Pre-built team configurations live in `.claude/teams/`. Load any team by name:

```
Create an agent team using the research-team configuration.
```

---

### Research Team (`research-team`)

```
computer-scientist (team lead)
├── principal-scientist
│   ├── lead-researcher
│   │   ├── ai-engineer
│   │   │   └── auto-website-builder
│   │   ├── hypothesis-generation
│   │   ├── literature-synthesis
│   │   ├── experiment-design
│   │   ├── code-replication
│   │   ├── research-writing
│   │   ├── ieee-paper-generator
│   │   └── research-paper-review
│   └── auto-benchmark
```

**Spawn this team:**

```
Create an agent team to run a full research cycle on [topic].
Use the computer-scientist skill as lead. Spawn teammates for
hypothesis generation, literature synthesis, and experiment design.
Require plan approval before any teammate writes output.
```

---

### Engineering Team (`engineering-team`)

```
ai-engineer (team lead)
└── auto-website-builder
```

**Spawn this team:**

```
Create an agent team to build [product] from a research brief or PRD.
Use ai-engineer as lead for architecture, backend, and AI/ML integration.
Spawn auto-website-builder for the complete web presence and frontend codebase.
Require plan approval before any teammate produces code.
```

---

### Enterprise Agent Team (`enterprise-agent-team`)

```
dynamic-enterprise-agent (team lead)
├── enterprise-signal-listener   (Phase 0 — Listen)
├── enterprise-problem-decoder   (Phase 1 — Decode)
├── enterprise-agent-builder     (Phases 2+3 — Build)
└── enterprise-agent-shipper     (Phases 4+5 — Ship)
```

**Spawn this team:**

```
Create an agent team to build an enterprise AI agent for [client problem].
Use dynamic-enterprise-agent as lead. Spawn teammates sequentially through
the Listen → Decode → Build → Ship pipeline. Target: agent deployed before
the client meeting ends.
```

---

### GTM / Sales Team (`gtm-team`)

```
pm-ai-research (team lead)
├── pm-lead
│   ├── stakeholder-intel
│   ├── competitive-research
│   ├── idea-generation
│   ├── prd-writer
│   ├── roadmap-planner
│   └── proposal-writer
├── proposal-automation
├── calendar-pipeline
└── account-intelligence
```

**Spawn this team:**

```
Create an agent team for a full product planning cycle on [product area].
Use pm-ai-research as lead. Spawn pm-lead as project orchestrator with
task-layer teammates for research, then prd-writer and roadmap-planner
for deliverables. Spawn calendar-pipeline and account-intelligence for
sales execution.
```

---

### Marketing Team (`marketing-team`)

```
cmo-marketing (team lead)
├── content-marketing
│   ├── seo-automation
│   └── whitepaper-engine
├── demand-gen
│   ├── paid-ads-manager
│   └── lead-routing
├── product-marketing
│   └── customer-intel
├── community-growth
│   └── community-builder
├── events-webinars
└── retention-marketing
```

**Spawn this team:**

```
Create an agent team for a product launch campaign.
Use cmo-marketing as lead. Spawn content-marketing, demand-gen,
and product-marketing teammates. Have them coordinate on messaging
before each produces their deliverables.
```

---

### Strategic Partnerships Team (`partnerships-team`)

```
strategic-partnerships (team lead)
├── partner-strategy
│   ├── partner-recruitment
│   └── partner-negotiation
├── partner-enablement
├── alliance-gtm
│   └── alliance-marketing
├── partner-sales-ops
└── partner-finance
```

**Spawn this team:**

```
Create an agent team to build a full partner program.
Use strategic-partnerships as lead. Spawn partner-strategy first to
define thesis and roadmap, then partner-recruitment and partner-negotiation.
Spawn partner-enablement, alliance-gtm, partner-sales-ops, and
partner-finance in parallel once strategy is set.
```

---

### Investor Relations Team (`investor-relations-team`)

```
cro-investor-relations (team lead)
├── investor-research
├── pitch-deck-builder
├── investor-outreach
├── investor-calendar
├── due-diligence-prep
└── fundraising-analytics
```

**Spawn this team:**

```
Create an agent team for a fundraising round.
Use cro-investor-relations as lead. Spawn investor-research first, then
pitch-deck-builder and investor-outreach in parallel. Spawn investor-calendar
for meeting management, due-diligence-prep once interest is confirmed,
and fundraising-analytics throughout for pipeline visibility.
```

---

### Finance Team (`finance-team`)

```
cfo-finance (team lead)
├── revenue-operations
│   ├── invoice-management
│   └── commission-tracker
├── accounts-payable
│   ├── purchase-order-management
│   └── expense-management
├── payroll-compensation
│   └── salary-management
└── tax-compliance
```

**Spawn this team:**

```
Create an agent team for a full financial close cycle.
Use cfo-finance as lead. Spawn revenue-operations, accounts-payable,
and payroll-compensation as orchestrators in parallel — each coordinating
their task-layer teammates. Spawn tax-compliance for specialized reporting.
```

---

### Security Team (`security-team`)

```
ciso (team lead)
├── compliance-governance
│   ├── compliance-auditor
│   └── industry-compliance
├── security-operations
│   ├── threat-hunter
│   ├── incident-responder
│   └── sre-operations
├── application-security
│   └── penetration-tester
├── infrastructure-security
│   ├── iam-specialist
│   └── network-data-security
├── ai-ethics-security
│   └── ai-security-analyst
└── security-trainer
```

**Spawn this team:**

```
Create an agent team for an enterprise security program review.
Use ciso as lead. Spawn compliance-governance, security-operations,
application-security, infrastructure-security, and ai-ethics-security
as VP orchestrators in parallel — each coordinating their task-layer
teammates. Spawn security-trainer for org-wide enablement.
```

---

## Starting an Agent Team

Tell Claude to create a team in natural language:

```
I need to ship the authentication module. Create an agent team:
- One teammate owns the backend (JWT + session logic)
- One teammate owns the frontend (login forms + token storage)
- One teammate writes integration tests
Require plan approval before any teammate writes code.
```

Claude creates the team, spawns teammates, manages the task list, and synthesizes results.

---

## Controlling the Team

### Talk to teammates directly

- **In-process mode**: press `Shift+Down` to cycle through teammates, then type to send a message.
- **Split-pane mode**: click into a teammate's pane. Requires `tmux` or iTerm2.

### Display modes

Set in `settings.json`:

```json
{
  "teammateMode": "in-process"
}
```

Or pass as a flag:

```bash
claude --teammate-mode in-process
```

### Require plan approval

```
Spawn a security-reviewer teammate. Require plan approval before
they make any recommendations.
```

The lead reviews, approves or rejects with feedback, and the teammate iterates.

### Assign tasks explicitly

```
Assign the 'API integration' task to the backend teammate.
```

Or let teammates self-claim from the shared task list.

### Shut down and clean up

```
Ask the researcher teammate to shut down.
Clean up the team.
```

Always clean up through the lead. Teammates should not run cleanup.

---

## Best Practices for Open Org Workflows

### Give teammates the right skill context

Teammates load `CLAUDE.md`, MCP servers, and skills automatically, but not the lead's conversation history. Include skill-specific context in the spawn prompt:

```
Spawn a lead-researcher teammate with this context:
"You are running the lead-researcher skill. The research topic is
[X]. Use hypothesis-generation and literature-synthesis sub-skills.
Produce a structured findings doc at research/findings.md."
```

### Break work by skill boundary

Avoid two teammates editing the same file. Assign work so each teammate owns a distinct deliverable — one per skill layer:

- **Good**: content-marketing owns `blog-draft.md`, demand-gen owns `ad-copy.md`
- **Bad**: two teammates editing `campaign-brief.md` simultaneously

### Use hooks to enforce quality gates

The `TeammateIdle` hook runs when a teammate goes idle. Use it to enforce standards:

```json
{
  "hooks": {
    "TeammateIdle": "scripts/validate-skill-output.sh"
  }
}
```

Exit with code `2` to send feedback and keep the teammate working.

The `TaskCompleted` hook runs when a task is being marked complete. Exit with code `2` to block completion and send feedback.

### Size tasks to skill granularity

Match task size to the skill layer:
- **Strategic skills** (computer-scientist, cmo-marketing): one task = one research direction or campaign
- **Orchestrator skills** (lead-researcher, content-marketing): one task = one deliverable area
- **Task skills** (hypothesis-generation, seo-automation): one task = one concrete output

---

## Architecture Reference

| Component | Role |
|-----------|------|
| **Team lead** | Main Claude Code session; creates team, spawns teammates, coordinates work |
| **Teammates** | Separate Claude Code instances; work on assigned tasks |
| **Task list** | Shared list of work items teammates claim and complete |
| **Mailbox** | Messaging system for direct agent-to-agent communication |

**Storage locations:**

- Team config: `~/.claude/teams/{team-name}/config.json`
- Task list: `~/.claude/tasks/{team-name}/`

---

## Known Limitations

- `/resume` and `/rewind` do not restore in-process teammates after session restart.
- Task status can lag — check manually if a task appears stuck.
- Teammates cannot spawn sub-teams (no nested teams).
- One team per lead session; clean up before starting a new team.
- Split-pane mode requires `tmux` or iTerm2 (not supported in VS Code terminal or Windows Terminal).

---

## Further Reading

- [Claude Code Agent Teams docs](https://code.claude.com/docs/en/agent-teams)
- [Claude Code Subagents](https://code.claude.com/docs/en/sub-agents)
- [Claude Code Hooks](https://code.claude.com/docs/en/hooks)
- [Agent Skills Specification](https://agentskills.io/specification)
- [Open Org Skills directory](skills/)
