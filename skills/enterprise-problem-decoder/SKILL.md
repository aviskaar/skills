---
name: enterprise-problem-decoder
description: >
  Use this skill when you have a completed intake specification from enterprise-signal-listener
  and need to map it to a structured agent specification — resolving the exact platform entry
  point, applying industry-specific compliance constraints, and classifying the agent type.
  Produces a fully structured agent spec ready for architecture and code generation.
  This is Phase 1 (Decode) of the Listen → Decode → Build → Ship methodology.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: >
    enterprise, ai-agents, problem-decoding, platform-resolution, industry-compliance,
    agent-classification, servicenow, salesforce, workday, sap, snowflake, healthcare,
    fintech, federal, manufacturing, specification
---

# Enterprise Problem Decoder — Problem Decoding & Agent Specification

Map raw intake signals to a precise, structured agent specification. Resolve the platform,
apply compliance constraints, classify the agent type, and produce a spec that `enterprise-agent-builder`
can immediately turn into architecture and code.

---

## Input

Accepts the intake YAML output from `enterprise-signal-listener`. If called directly, prompt
for: the spoken problem description, platform hint, industry hint, and desired outcome.

---

## Step 1 — Platform Resolution

Resolve the platform from the intake. If ambiguous, default to the most likely platform for
the stated industry and build for it — note alternatives at the bottom of the spec.

See `../dynamic-enterprise-agent/references/platform-connectors.md` for full API and connector
details per platform.

**Platform families and primary agent entry points:**

| Platform | Agent Entry Point | Primary Capability |
|----------|------------------|--------------------|
| **ServiceNow** | Flow Designer, Scripted REST, NLU Virtual Agent | ITSM automation, case routing, approvals |
| **Salesforce** | Einstein Copilot, Agentforce, Apex, Flow, MuleSoft | CRM automation, opportunity management, service |
| **Workday** | Extend (REST), Prism Analytics, Studio | HR automation, talent workflows, payroll |
| **SAP** | BTP AI Core, S/4HANA APIs, Build Process Automation | ERP automation, procurement, finance |
| **Snowflake** | Cortex AI, Snowpark, Tasks, Streams | Data pipelines, ML scoring, analytics agents |
| **Microsoft** | Copilot Studio, Power Automate, Azure AI, Teams bots | Collaboration, Office workflows, cloud AI |
| **AWS** | Bedrock Agents, Lambda, Step Functions, Connect | Cloud-native, serverless, contact center |
| **Azure** | AI Foundry, Logic Apps, Azure Functions, Bot Service | Cloud AI, enterprise integration |
| **GCP** | Vertex AI, Cloud Run, Apigee, Dialogflow | Cloud AI, API management, NLP |
| **Okta / Azure Entra** | Hooks, Workflows, SCIM, Graph API | IAM automation, lifecycle mgmt, access reviews |
| **CyberArk / BeyondTrust** | REST API, CPM plugins, session hooks | PAM automation, credential rotation, audit |
| **Palo Alto / Zscaler** | XSOAR, Cortex, ZIA API | Security ops, threat response, policy mgmt |
| **Splunk / QRadar** | SOAR, Adaptive Response, REST API | SIEM automation, alert triage, investigation |
| **CrowdStrike / SentinelOne** | RTR API, Workflows, SOAR integration | EDR response, hunting, containment |
| **Epic / Cerner** | FHIR R4 API, CDS Hooks, SMART on FHIR | Clinical workflows, care gap, documentation |
| **Veeva / Medidata** | Vault REST API, Rave Web Services | Clinical trial mgmt, regulatory submissions |
| **Bloomberg / FactSet** | B-PIPE, Server API, Open FactSet | Market data, analytics, quant workflows |
| **Shopify / CommerceCloud** | Admin API, Flow, Einstein Commerce | E-commerce automation, merchandising |

**Resolution rules:**
- If multiple platforms are mentioned, identify the primary (trigger source) and secondaries (integration targets).
- If no platform is identifiable, ask: "Which system does this live in today?" before proceeding.
- If the platform is ambiguous between two options, resolve to the one with a stronger match to
  the industry context and state the alternative in the spec.

---

## Step 2 — Industry Context Resolution

Apply industry-specific rules, compliance constraints, and data models automatically based on
industry signals in the intake.

See `../dynamic-enterprise-agent/references/industry-patterns.md` for the full regulatory and
domain pattern library.

| Industry | Compliance auto-applied | Domain data model |
|----------|------------------------|-------------------|
| **Healthcare** | HIPAA, HL7/FHIR, CDS Hooks, de-identification | Patient, Encounter, Observation, CarePlan |
| **Life Sciences** | 21 CFR Part 11, GxP, audit trail, e-signature | Protocol, Subject, CRF, Adverse Event |
| **Fintech / Banking** | PCI-DSS, SOX, FFIEC, GDPR, model risk | Transaction, Account, Customer, Position |
| **Quantitative Finance** | Low-latency, FIX protocol, risk limits, VaR | Instrument, Order, Portfolio, Signal |
| **Insurance** | NAIC, state regulations, claims workflow | Policy, Claim, Adjudication, Reserve |
| **Retail / E-Commerce** | PCI, inventory sync, omnichannel | Product, Order, Inventory, Customer360 |
| **Manufacturing** | OEE, ISO, IEC 62443, safety interlocks | Asset, WorkOrder, BOM, Quality Record |
| **Federal / Defense** | FedRAMP, FISMA, CMMC, IL4/IL5, Zero Trust | Mission, Asset, Personnel, Incident |
| **Energy / Utilities** | NERC CIP, ICS/SCADA, OT/IT convergence | Grid, Asset, Event, Outage |
| **Legal / Compliance** | Privilege, retention, e-discovery | Matter, Contract, Obligation, Risk |

**If no industry is identified:** Apply baseline guardrails (audit logging, no irreversible
actions without approval, credential hygiene) and proceed. Flag `industry: [unspecified]` in
the spec.

---

## Step 3 — Agent Type Classification

Classify the agent into exactly one of five types based on the decoded problem. When in doubt,
choose the type that matches the primary pain trigger, not the secondary outcome.

| Type | Primary trigger phrase | What it does |
|------|----------------------|-------------|
| **Monitoring Agent** | "alert us when", "we get paged", "we miss", "no visibility into" | Watches data or events, surfaces anomalies, notifies the right person |
| **Triage Agent** | "route to", "who should handle", "we don't know who", "everything goes to the same queue" | Classifies, prioritizes, and assigns work items to the right owner |
| **Automation Agent** | "manually", "takes too long", "repetitive", "someone has to do this every" | Executes multi-step workflows end-to-end without requiring human input |
| **Decision-Support Agent** | "we don't know", "help us decide", "summarize for us", "we need to understand" | Analyzes context, synthesizes signals, and surfaces recommendations |
| **Orchestrator Agent** | "end-to-end", "across systems", "connect", "the whole process", "multiple teams" | Coordinates multiple agents, systems, approvals, and handoffs |

---

## Step 4 — Structured Agent Specification

Produce this specification immediately after Steps 1–3:

```yaml
agent_spec:
  name: ""                    # proposed agent name (descriptive, platform-prefixed)
  one_liner: ""               # what it does in one sentence, in plain language
  type: ""                    # Monitoring | Triage | Automation | Decision-Support | Orchestrator
  platform:
    primary: ""               # resolved platform
    entry_point: ""           # specific API or integration point
    secondary: []             # any additional systems it touches
  industry:
    domain: ""                # resolved industry
    compliance: []            # list of frameworks auto-applied
    data_model: []            # relevant entities (Patient, Transaction, Incident, etc.)
  trigger:
    event: ""                 # what kicks the agent off
    source: ""                # which system sends the trigger
    frequency: ""             # real-time | scheduled (cron) | on-demand | event-driven
  actor_today: ""             # who does this manually today
  desired_outcome: ""         # what "done" looks like
  pain_intensity: ""          # low | medium | high | critical
  urgency: ""                 # demo_now | this_week | this_sprint | next_quarter
  alternatives_considered:    # if platform was ambiguous
    - platform: ""
      reason_not_chosen: ""
  open_questions: []          # any ambiguities that the builder should flag
```

---

## Output

Produce the structured agent spec and a decoding summary:

```
DECODE COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Agent: [agent name]
Type:  [agent type]
Platform: [primary platform] → [entry point]
Industry: [domain] | Compliance: [frameworks]
Trigger: [event] from [source system] ([frequency])

Agent Spec:
[populated agent_spec YAML]

Ready for: enterprise-agent-builder
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Hand off the completed `agent_spec` YAML to `enterprise-agent-builder`.
