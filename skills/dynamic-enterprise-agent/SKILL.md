---
name: dynamic-enterprise-agent
description: >
  Use this skill when anyone — a client, stakeholder, investor, team member, or executive —
  describes any business problem, workflow pain, or opportunity in real time and needs an AI
  agent built immediately during that conversation. Activate the moment someone says "we need
  something that can..." or "our team keeps having to manually..." or "what if there were a way
  to..." Orchestrates the full Listen → Decode → Build → Ship pipeline across four specialist
  skills to produce a fully specified, code-ready, deployable AI agent on-the-fly — covering
  any enterprise platform (ServiceNow, Salesforce, Workday, SAP, Snowflake, Microsoft 365/Azure/
  Teams/Dynamics, AWS, GCP, Okta, CyberArk, Palo Alto, Splunk, Epic, Veeva, Bloomberg, and more)
  and any industry (healthcare, life sciences, fintech, banking, quant, retail, manufacturing,
  federal agencies, and beyond). The agent is live before the meeting ends.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "2.0"
  tags: >
    enterprise, ai-agents, orchestrator, on-the-fly, servicenow, salesforce, workday, sap,
    snowflake, microsoft, azure, aws, iam, network-security, healthcare, lifesciences, fintech,
    banking, quant, retail, manufacturing, federal, real-time, automation, orchestration
  sub-skills:
    - enterprise-signal-listener
    - enterprise-problem-decoder
    - enterprise-agent-builder
    - enterprise-agent-shipper
---

# Dynamic Enterprise AI Agent Builder — Strategic Orchestrator

Build a fully functional, deployable AI agent in real time — while the conversation is still
happening. No post-meeting spec docs. No multi-week discovery. The agent exists before you hang up.

---

## Core Principle

**Listen → Decode → Build → Ship.**

The moment someone describes a problem, this skill orchestrates four specialist skills in sequence:
extract what is needed, map it to the right platform and industry context, generate working code
and configuration, and produce a deployment-ready agent. Every output is actionable, not a proposal.

---

## Pipeline Overview

| Phase | Skill | What Happens | Output |
|-------|-------|-------------|--------|
| **Listen** | `enterprise-signal-listener` | Extract structured signals from natural conversation without interrupting | Populated intake YAML |
| **Decode** | `enterprise-problem-decoder` | Resolve platform, apply compliance, classify agent type | Structured agent spec |
| **Build** | `enterprise-agent-builder` | Design architecture, generate production Python code + platform adapters | Blueprint + working code |
| **Ship** | `enterprise-agent-shipper` | Configure integration, generate IAM policy, produce demo + checklist | Deployment-ready package |

---

## Orchestration Instructions

### Entry Points

Based on what the user provides, enter the pipeline at the right stage:

| User provides... | Enter at |
|-----------------|----------|
| Someone describing a problem in conversation | Listen (enterprise-signal-listener) |
| A completed intake YAML | Decode (enterprise-problem-decoder) |
| A structured agent spec | Build (enterprise-agent-builder) |
| A blueprint + code | Ship (enterprise-agent-shipper) |
| "Run everything" or open-ended problem description | Listen (full pipeline) |

### Stage 1 — Listen

**Invoke**: `enterprise-signal-listener`

**Purpose**: Capture signals from the live conversation. Do not interrupt. Do not ask for
structured input. Extract platform, industry, pain trigger, actor, frequency, and desired outcome
from natural speech.

**Ask at most 2 clarifying questions.** Stop as soon as enough signal exists to decode.

**Gate**: Signal capture is complete when `spoken_problem`, `platform_hint`, and `desired_outcome`
are all populated. Proceed immediately — do not wait for a perfect intake.

**Output → Decode**: Pass the completed intake YAML to `enterprise-problem-decoder`.

---

### Stage 2 — Decode

**Invoke**: `enterprise-problem-decoder`

**Purpose**: Map intake signals to a precise agent specification. Resolve the exact platform
entry point, apply industry compliance constraints automatically, and classify the agent type
(Monitoring, Triage, Automation, Decision-Support, or Orchestrator).

**Gate**: Agent spec is complete when platform, agent type, trigger, and desired outcome are
all resolved. Flag open questions but do not block — builders resolve ambiguity.

**Output → Build**: Pass the `agent_spec` YAML to `enterprise-agent-builder`.

---

### Stage 3 — Build

**Invoke**: `enterprise-agent-builder`

**Purpose**: Design the complete agent architecture (blueprint + data flow diagram) and generate
production-ready Python code using the Anthropic Claude API, with platform-specific adaptations
for ServiceNow (JavaScript), Salesforce (Apex), and Snowflake (Snowpark) where required.

All guardrails are embedded in the generated code. No irreversible actions without human approval.
Audit trail on every tool call. Credentials via secrets manager only.

**Gate**: Build is complete when the blueprint, data flow diagram, and runnable code are produced.
The code must be functional as written — not a skeleton requiring rewrite.

**Output → Ship**: Pass the blueprint, code, and agent spec to `enterprise-agent-shipper`.

---

### Stage 4 — Ship

**Invoke**: `enterprise-agent-shipper`

**Purpose**: Produce the full deployment package: environment variable configuration, secrets
manager integration, deployment target selection, least-privilege IAM policy, a live demo script,
and a ship checklist. The agent is deployment-ready when this stage completes.

**Gate**: Ship is complete when the demo script and ship checklist are produced and all open
items on the checklist are documented (not necessarily resolved — but known).

**Output**: Deployable agent package. Hand to the client or engineering team with the checklist.

---

## Quick-Build Matrix

Match any problem heard in conversation to a pre-configured starting point. Feed the row into
`enterprise-signal-listener` or skip directly to `enterprise-problem-decoder`:

| Heard this... | Agent type | Platform | Industry | Template entry |
|---------------|-----------|----------|----------|----------------|
| "Incidents keep getting misrouted" | Triage | ServiceNow | Any | `templates/triage-servicenow` |
| "Salesforce leads sit untouched for days" | Automation | Salesforce | B2B | `templates/lead-followup-sfdc` |
| "We can't tell which Snowflake jobs are failing" | Monitoring | Snowflake | Data/Any | `templates/pipeline-monitor-snowflake` |
| "New employees wait weeks for access" | Automation | Okta + ServiceNow | Any | `templates/iam-provisioning` |
| "Security alerts are noise — no one triages them" | Triage | Splunk/XSOAR | SecOps | `templates/alert-triage-siem` |
| "Clinical notes take nurses 45 min to document" | Automation | Epic FHIR | Healthcare | `templates/clinical-doc-assist` |
| "Our trial site status is always stale" | Monitoring | Veeva Vault | Life Sciences | `templates/clinical-trial-monitor` |
| "We get fined for late SAR filings" | Automation | Core Banking + SAP | Banking/Fintech | `templates/sar-automation` |
| "Quant signals aren't reaching traders fast enough" | Monitoring | Bloomberg B-PIPE | Quant Finance | `templates/signal-delivery-agent` |
| "POs sit unreviewed for weeks in SAP" | Triage | SAP BTP | Manufacturing | `templates/po-approval-sap` |
| "Teams messages about outages get lost" | Orchestrator | Microsoft Teams + Azure | Any | `templates/incident-bridge-teams` |
| "Federal audit requests take 3 weeks to fulfill" | Decision-Support | ServiceNow GovCloud | Federal | `templates/audit-response-federal` |
| "Shopify orders aren't syncing to our WMS" | Automation | Shopify + 3PL API | Retail | `templates/order-sync-retail` |
| "We don't know when grid assets are about to fail" | Monitoring | PI System + Azure | Energy/Utilities | `templates/asset-health-monitor` |

See `references/agent-templates.md` for full template implementations.

---

## Non-Negotiable Guardrails

These apply to every agent produced by this pipeline. They are embedded by `enterprise-agent-builder`
and verified by `enterprise-agent-shipper`. Never remove them.

- **No irreversible action without human gate** — delete, bulk-update, financial transaction,
  patient record change, or security policy change always requires `request_human_approval` first.
- **Audit trail on every action** — every tool call logged with timestamp, actor identity, input,
  and output.
- **Credential hygiene** — all secrets via environment variables or secrets manager. Zero
  hardcoded credentials.
- **Scope-limited API credentials** — read-heavy with surgical write scope. No admin credentials.
- **PII/PHI handling** — if healthcare or life sciences, de-identify before any LLM call not
  within a compliant boundary.
- **Rate limiting** — exponential backoff and per-minute rate limits on all platform API calls.
- **Graceful degradation** — if platform API is unreachable, fail safe: log and alert a human.
  Never guess or hallucinate data.

### Regulated-Industry Overrides

| Framework | Override |
|-----------|---------|
| HIPAA | No PHI in logs; encrypted at rest; BAA required for LLM API vendor |
| 21 CFR Part 11 | Electronic signatures on all agent approvals; immutable audit trail; validated system docs required |
| FedRAMP / IL4+ | LLM API must be FedRAMP-authorized (Azure Government, AWS GovCloud); no commercial endpoint egress |
| PCI-DSS | Cardholder data never passed to LLM; tokenize or mask before any AI call |
| SOX | Financial agent actions require dual approval; change management controls apply to deployments |

---

## Pipeline Output Summary

| Stage | Skill | Artifact | Delivered |
|-------|-------|----------|-----------|
| Listen | enterprise-signal-listener | Signal capture log + intake YAML | During conversation |
| Decode | enterprise-problem-decoder | Platform + industry mapping + agent spec | During conversation |
| Build | enterprise-agent-builder | Agent blueprint + data flow + working code | Before call ends |
| Ship | enterprise-agent-shipper | Integration config + IAM policy + demo + checklist | Before call ends |
| All | — | Deployable agent package | Ready to run |
