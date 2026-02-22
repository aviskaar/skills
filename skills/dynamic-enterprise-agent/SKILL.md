---
name: dynamic-enterprise-agent
description: >
  Use this skill when anyone — a client, stakeholder, investor, team member, or executive —
  describes any business problem, workflow pain, or opportunity in real time and needs an AI
  agent built immediately during that conversation. Activate the moment someone says "we need
  something that can..." or "our team keeps having to manually..." or "what if there were a way
  to..." Produces a fully specified, code-ready, deployable AI agent on-the-fly — covering any
  enterprise platform (ServiceNow, Salesforce, Workday, SAP, Snowflake, Microsoft 365/Azure/Teams/
  Dynamics, AWS, GCP, Okta, CyberArk, Palo Alto, Splunk, Epic, Veeva, Bloomberg, and more) and
  any industry (healthcare, life sciences, fintech, banking, quant, retail, manufacturing, federal
  agencies, and beyond). The agent is live before the meeting ends.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: >
    enterprise, ai-agents, on-the-fly, servicenow, salesforce, workday, sap, snowflake,
    microsoft, azure, aws, iam, network-security, healthcare, lifesciences, fintech,
    banking, quant, retail, manufacturing, federal, real-time, automation, orchestration
---

# Dynamic Enterprise AI Agent Builder

Build a fully functional, deployable AI agent in real time — while the conversation is still
happening. No post-meeting spec docs. No multi-week discovery. The agent exists before you hang up.

---

## Core Principle

**Listen → Decode → Build → Ship.**

The moment someone describes a problem, this skill extracts what is needed, maps it to the
right platform and industry context, generates working code and configuration, and produces a
deployment-ready agent. Every output is actionable, not a proposal.

---

## Phase 0 — Live Signal Capture

Do not interrupt the conversation. Capture while the person talks.

### 0.1 What to Listen For

Extract these signals from natural speech — do not require structured input:

| Signal Type | Listen for phrases like... |
|-------------|---------------------------|
| **Platform** | "in ServiceNow", "our Salesforce", "Workday tickets", "SAP transactions", "Snowflake warehouse", "Teams channel", "Azure", "AWS", "our Okta", "Splunk alerts" |
| **Industry** | "patients", "clinical trials", "trades", "claims", "SKUs", "warfighters", "compliance audit", "drug approval", "loan origination", "grid operators" |
| **Pain trigger** | "manually", "takes too long", "we keep missing", "no one knows", "we get paged at 3am", "the team wastes hours", "audit fails", "we can't see" |
| **Actor** | Who does this today? (a person, a team, a queue) |
| **Frequency** | How often does this happen? (every ticket, nightly, on-demand, real-time) |
| **Outcome wanted** | "automatically", "instantly", "alert us when", "summarize", "route to", "predict", "remediate", "generate", "approve" |

### 0.2 Rapid Intake Form (if direct input is available)

Collect only what is missing from the conversation:

```yaml
intake:
  spoken_problem: ""          # verbatim quote or paraphrase of what they said
  platform_hint: ""           # any system they mentioned
  industry_hint: ""           # any domain/vertical they mentioned
  actor: ""                   # who does this today
  trigger: ""                 # what kicks the process off
  desired_outcome: ""         # what good looks like
  urgency: demo_now | this_week | this_sprint
```

### 0.3 Clarifying Questions (ask at most 2, only if critical signals are missing)

Priority order — stop once you have enough to build:
1. "Which system does this live in today?" (if no platform detected)
2. "When this goes wrong, who feels it first?" (surfaces the actor and trigger)
3. "What would 'fixed' look like in 30 seconds?" (surfaces the outcome)

Never ask about timelines, budget, or architecture in Phase 0. Build first.

---

## Phase 1 — Problem Decoding

Map raw signals to a structured agent specification.

### 1.1 Platform Resolution

Resolve the platform from signals. If ambiguous, default to the most likely platform for the
industry and build for it, noting alternatives.

See `references/platform-connectors.md` for full API and connector details per platform.

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

### 1.2 Industry Context Resolution

Apply industry-specific rules, compliance constraints, and data models automatically.

See `references/industry-patterns.md` for full regulatory and domain pattern library.

| Industry | Key constraints auto-applied | Domain data model |
|----------|------------------------------|-------------------|
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

### 1.3 Agent Type Classification

Classify the agent into one of five types based on the decoded problem:

| Type | Trigger phrase | What it does |
|------|---------------|-------------|
| **Monitoring Agent** | "alert us when", "we get paged", "we miss" | Watches data/events, surfaces anomalies, notifies |
| **Triage Agent** | "route to", "who should handle", "we don't know who" | Classifies, prioritizes, assigns work items |
| **Automation Agent** | "manually", "takes too long", "repetitive" | Executes multi-step workflows without human input |
| **Decision-Support Agent** | "we don't know", "help us decide", "summarize" | Analyzes context, synthesizes, recommends |
| **Orchestrator Agent** | "end-to-end", "across systems", "connect" | Coordinates multiple agents, systems, and teams |

---

## Phase 2 — Agent Architecture

Design the complete agent before writing a single line of code.

### 2.1 Agent Blueprint

Produce this blueprint immediately after Phase 1:

```markdown
## Agent Blueprint — [Agent Name]

**One-liner:** [What it does in one sentence, in plain language]
**Type:** [Monitoring | Triage | Automation | Decision-Support | Orchestrator]
**Platform:** [Primary platform]
**Industry context:** [Domain + applied constraints]

### Trigger
- Event: [what kicks the agent off]
- Source: [which system sends the trigger]
- Frequency: [real-time / scheduled / on-demand]

### Inputs
| Input | Source | Format | Notes |
|-------|--------|--------|-------|
| [field] | [system] | [JSON/XML/text] | [any enrichment needed] |

### Reasoning / Logic
1. [Step 1: what the agent decides or detects]
2. [Step 2: what it looks up or computes]
3. [Step 3: what action it takes]

### Outputs / Actions
| Action | Target System | API / Method | Condition |
|--------|--------------|-------------|-----------|
| [action] | [system] | [endpoint] | [when] |

### Human-in-the-Loop Gates
- [Any step where a human must approve before the agent proceeds]

### Compliance Controls
- [Audit logging destination]
- [PII/PHI handling rule]
- [Access control constraint]
```

### 2.2 Data Flow Diagram (text)

Always produce a text-based flow with the blueprint:

```
[Trigger Source] → [Ingestion Layer] → [Agent Core (LLM Reasoning)]
                                              ↓
                              ┌───────────────┼───────────────┐
                         [Action A]      [Action B]      [Notify]
                              ↓               ↓               ↓
                        [Target Sys 1]  [Target Sys 2]  [Human/Channel]
```

---

## Phase 3 — Code Generation

Generate production-ready code. Default to Python + Anthropic Claude API unless the platform
requires a native SDK (e.g., Apex for Salesforce, Groovy for ServiceNow).

See `references/agent-templates.md` for full templates per platform and agent type.

### 3.1 Core Agent Scaffold (Python / Anthropic SDK)

```python
"""
Agent: {agent_name}
Platform: {platform}
Industry: {industry}
Generated: on-the-fly during conversation
"""
import anthropic
import json
from datetime import datetime

# ── Configuration ──────────────────────────────────────────────
AGENT_NAME = "{agent_name}"
PLATFORM   = "{platform}"
INDUSTRY   = "{industry}"
MODEL      = "claude-opus-4-6"

client = anthropic.Anthropic()  # uses ANTHROPIC_API_KEY from env

SYSTEM_PROMPT = """
You are {agent_name}, an AI agent operating within {platform} for a {industry} organization.

Your role: {agent_one_liner}

Rules:
- Always cite the data source for every finding.
- Never take irreversible actions without explicit confirmation.
- Apply {compliance_framework} controls to all data handling.
- When uncertain, surface the ambiguity to a human rather than guess.
- Log every action with timestamp, actor, and outcome.
"""

# ── Tool Definitions ────────────────────────────────────────────
tools = [
    {
        "name": "fetch_context",
        "description": "Retrieve relevant records from {platform} to inform reasoning.",
        "input_schema": {
            "type": "object",
            "properties": {
                "query": {"type": "string", "description": "What to look up"},
                "record_type": {"type": "string", "description": "Entity type (e.g. incident, case, patient)"},
                "filters": {"type": "object", "description": "Key-value filters"}
            },
            "required": ["query", "record_type"]
        }
    },
    {
        "name": "take_action",
        "description": "Execute an action in {platform} (create, update, assign, notify).",
        "input_schema": {
            "type": "object",
            "properties": {
                "action_type": {"type": "string", "enum": ["create", "update", "assign", "notify", "escalate"]},
                "target": {"type": "string", "description": "Record ID or destination"},
                "payload": {"type": "object", "description": "Fields and values to apply"}
            },
            "required": ["action_type", "target", "payload"]
        }
    },
    {
        "name": "request_human_approval",
        "description": "Pause and request a human decision before proceeding.",
        "input_schema": {
            "type": "object",
            "properties": {
                "context": {"type": "string", "description": "What the human needs to decide"},
                "options": {"type": "array", "items": {"type": "string"}},
                "urgency": {"type": "string", "enum": ["low", "medium", "high", "critical"]}
            },
            "required": ["context", "urgency"]
        }
    }
]

# ── Platform Connector (replace with real SDK calls) ────────────
def fetch_context(query: str, record_type: str, filters: dict = None) -> dict:
    """Stub: replace with actual {platform} API call."""
    # e.g. ServiceNow: requests.get(f"{SN_INSTANCE}/api/now/table/{record_type}", params=filters)
    # e.g. Salesforce: sf.query(f"SELECT ... FROM {record_type} WHERE ...")
    # e.g. Snowflake:  cursor.execute(f"SELECT ... FROM {record_type} WHERE ...")
    return {"records": [], "total": 0, "query": query}

def take_action(action_type: str, target: str, payload: dict) -> dict:
    """Stub: replace with actual {platform} write API call."""
    print(f"[ACTION] {action_type.upper()} → {target}: {json.dumps(payload, indent=2)}")
    return {"status": "success", "action": action_type, "target": target, "timestamp": datetime.utcnow().isoformat()}

def request_human_approval(context: str, urgency: str, options: list = None) -> dict:
    """Stub: replace with Teams/Slack/PagerDuty/ServiceNow approval notification."""
    print(f"[HUMAN GATE] {urgency.upper()}: {context}")
    return {"status": "pending", "approval_id": "appr_001", "channel": "teams"}

# ── Tool Dispatch ────────────────────────────────────────────────
TOOL_MAP = {
    "fetch_context": fetch_context,
    "take_action": take_action,
    "request_human_approval": request_human_approval,
}

def dispatch_tool(tool_name: str, tool_input: dict) -> str:
    fn = TOOL_MAP.get(tool_name)
    if not fn:
        return json.dumps({"error": f"Unknown tool: {tool_name}"})
    result = fn(**tool_input)
    return json.dumps(result)

# ── Agent Loop ───────────────────────────────────────────────────
def run_agent(event: dict) -> str:
    """Main agent entry point. `event` is the trigger payload."""
    print(f"\n[{AGENT_NAME}] Triggered at {datetime.utcnow().isoformat()}")
    print(f"  Event: {json.dumps(event, indent=2)}\n")

    messages = [
        {"role": "user", "content": f"Process this event and take the appropriate action:\n\n{json.dumps(event, indent=2)}"}
    ]

    # Agentic loop
    while True:
        response = client.messages.create(
            model=MODEL,
            max_tokens=4096,
            system=SYSTEM_PROMPT,
            tools=tools,
            messages=messages,
        )

        # Collect any tool uses
        tool_uses = [b for b in response.content if b.type == "tool_use"]

        if response.stop_reason == "end_turn" or not tool_uses:
            # Extract final text
            final = next((b.text for b in response.content if hasattr(b, "text")), "Agent completed.")
            print(f"[{AGENT_NAME}] Done: {final}")
            return final

        # Execute tools and feed results back
        messages.append({"role": "assistant", "content": response.content})
        tool_results = []
        for tu in tool_uses:
            print(f"  → Tool: {tu.name}({json.dumps(tu.input)})")
            result = dispatch_tool(tu.name, tu.input)
            tool_results.append({
                "type": "tool_result",
                "tool_use_id": tu.id,
                "content": result,
            })
        messages.append({"role": "user", "content": tool_results})


# ── Entry (Lambda / Cloud Function / ServiceNow Scripted REST) ──
if __name__ == "__main__":
    # Replace with your real trigger payload
    sample_event = {
        "trigger_type": "{trigger_type}",
        "source_system": "{platform}",
        "payload": {}
    }
    run_agent(sample_event)
```

### 3.2 Platform-Specific Adaptations

**ServiceNow (Scripted REST + GlideRecord):**
```javascript
// ServiceNow server-side script
var AgentRunner = Class.create();
AgentRunner.prototype = {
    initialize: function() {},
    process: function(request, response) {
        var payload = JSON.parse(request.body.dataString);
        var gr = new GlideRecord('incident');
        gr.addQuery('state', 1); // New incidents
        gr.query();
        while (gr.next()) {
            // Call Claude API via REST Message
            var rm = new sn_ws.RESTMessageV2('Claude_Agent', 'POST');
            rm.setRequestBody(JSON.stringify({event: {sys_id: gr.sys_id.toString(), short_description: gr.short_description.toString()}}));
            rm.execute();
        }
    },
    type: 'AgentRunner'
};
```

**Salesforce (Apex):**
```apex
public class DynamicAgentCallout {
    @future(callout=true)
    public static void runAgent(String recordId, String objectType) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Claude_API/v1/messages');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        // Build payload from SObject record
        SObject record = Database.query('SELECT Id, Name FROM ' + objectType + ' WHERE Id = :recordId');
        req.setBody(JSON.serialize(new Map<String,Object>{'event' => record}));
        Http http = new Http();
        HttpResponse res = http.send(req);
        // Process response and update record
    }
}
```

**Snowflake (Snowpark + Cortex):**
```python
from snowflake.snowpark import Session
from snowflake.cortex import Complete

def run_snowflake_agent(session: Session, table: str, filter_clause: str):
    df = session.table(table).filter(filter_clause)
    for row in df.collect():
        prompt = f"Analyze this record and recommend action: {dict(row)}"
        result = Complete("claude-opus-4-6", prompt)
        # Write result back to Snowflake
        session.sql(f"UPDATE {table} SET ai_recommendation = '{result}' WHERE id = '{row['ID']}'").collect()
```

---

## Phase 4 — Integration Configuration

### 4.1 Environment Variables and Secrets

```bash
# Always use secrets manager — never hardcode
export ANTHROPIC_API_KEY="$(vault read -field=value secret/anthropic/api_key)"
export PLATFORM_API_URL="https://{instance}.service-now.com"     # or equivalent
export PLATFORM_CLIENT_ID="$(vault read -field=value secret/{platform}/client_id)"
export PLATFORM_CLIENT_SECRET="$(vault read -field=value secret/{platform}/client_secret)"
export AUDIT_LOG_DESTINATION="splunk://audit-index"              # or S3/CloudWatch/etc
```

### 4.2 Deployment Targets

| Trigger mechanism | Deployment target | Runtime |
|------------------|------------------|---------|
| ServiceNow Flow | ServiceNow MID Server / Scripted REST | JS / Rhino |
| Salesforce event | Apex Future / Platform Event | Apex |
| Cron / schedule | AWS Lambda, Azure Function, Cloud Run | Python |
| Webhook / API call | API Gateway + Lambda, Azure API Mgmt | Python |
| Streaming event | Kafka consumer, EventBridge, Pub/Sub | Python |
| Teams / Slack message | Bot Framework, Socket Mode | Python |
| SIEM alert | XSOAR/SOAR playbook, Splunk Adaptive Response | Python |

### 4.3 Minimum IAM Permissions

```yaml
# Principle of least privilege — generated per platform
iam_policy:
  read:
    - {platform}.records.read        # read trigger source
    - {platform}.attachments.read    # read supporting context
  write:
    - {platform}.records.update      # update handled records only
    - {platform}.notifications.send  # send alerts/approvals
  deny:
    - {platform}.admin.*             # never admin scope
    - {platform}.delete.*            # never delete without explicit flag
```

---

## Phase 5 — Live Demo Package

Produce this in under 60 seconds when someone asks "can you show me?":

### 5.1 Instant Demo Script

```
AGENT DEMO: {agent_name}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

SCENARIO: [One sentence describing a realistic event]

TRIGGER: A {trigger_type} arrives in {source_system}

AGENT RESPONSE (live):
  1. Receives event → extracts: [{key_fields}]
  2. Calls fetch_context → finds: [{context_found}]
  3. Reasons: [{what_the_llm_decides}]
  4. Takes action: [{action_taken}] on {target_system}
  5. Logs to audit trail: [{audit_entry}]

WITHOUT THIS AGENT:  [{what_a_human_does_today}] — takes {time_today}
WITH THIS AGENT:     Done in {time_with_agent} — human notified if exception

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 5.2 Deployment Checklist (ship today)

```
SHIP CHECKLIST — {agent_name}
[ ] ANTHROPIC_API_KEY set in secrets manager
[ ] Platform API credentials stored (not hardcoded)
[ ] fetch_context() connected to real {platform} endpoint
[ ] take_action() connected to real {platform} write endpoint
[ ] request_human_approval() connected to {notification_channel}
[ ] Audit log destination configured
[ ] Test run against a single non-production event
[ ] Human-in-the-loop gate tested
[ ] Rate limit / retry logic added for API calls
[ ] Deployed to {deployment_target}
```

---

## Quick-Build Matrix

Match any problem to a pre-configured starting point:

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

## Guardrails

Every generated agent automatically includes these controls. Never remove them.

### Non-negotiable safety rules
- **No irreversible action without human gate** — delete, bulk-update, financial transaction, patient record change, or security policy change always requires `request_human_approval` first.
- **Audit trail on every action** — every tool call is logged with timestamp, actor identity, input, and output.
- **Credential hygiene** — all secrets via environment variables or secrets manager. Zero hardcoded credentials in generated code.
- **Scope-limited API credentials** — generated IAM policy is read-heavy with surgical write scope. No admin credentials.
- **PII/PHI handling** — if industry is healthcare or life sciences, apply de-identification before any LLM call that is not within a compliant boundary.
- **Rate limiting** — all platform API calls include exponential backoff and per-minute rate limits.
- **Graceful degradation** — if the agent cannot reach a platform API, it fails safe: it does not guess or hallucinate data; it logs the failure and alerts a human.

### Regulated-industry overrides
- **HIPAA**: no PHI in logs; encrypted at rest; access-controlled; Business Associate Agreement required for LLM API vendor.
- **21 CFR Part 11**: electronic signatures on all agent-executed approvals; audit trail is immutable; validated system documentation required.
- **FedRAMP / IL4+**: LLM API must be FedRAMP-authorized or run in a sovereign boundary (Azure Government, AWS GovCloud); no data egress to commercial endpoints.
- **PCI-DSS**: cardholder data never passed directly to LLM; tokenize or mask before any AI call.
- **SOX**: financial agent actions require dual approval; change management controls apply to agent deployments.

---

## Output Summary

| Phase | Artifact | Delivered |
|-------|----------|-----------|
| 0 | Signal capture log | During conversation |
| 1 | Platform + industry mapping | During conversation |
| 2 | Agent blueprint + data flow | Before call ends |
| 3 | Working Python code + platform adapter | Before call ends |
| 4 | Integration config + IAM policy | Before call ends |
| 5 | Demo script + ship checklist | Before call ends |
| All | Deployable agent package | Ready to run |
