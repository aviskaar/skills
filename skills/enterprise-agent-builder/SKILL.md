---
name: enterprise-agent-builder
description: >
  Use this skill when you have a structured agent specification from enterprise-problem-decoder
  and need to design the complete agent architecture and generate production-ready code. Produces
  an agent blueprint with data flow diagram, Python code using the Anthropic Claude API, and
  platform-specific adaptations for ServiceNow, Salesforce, Snowflake, and others.
  The agent exists as working, deployable code before this skill completes.
  This is Phase 2+3 (Build) of the Listen → Decode → Build → Ship methodology.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: >
    enterprise, ai-agents, architecture, code-generation, python, anthropic, claude-api,
    servicenow, salesforce, snowflake, apex, javascript, blueprint, tool-use, agentic-loop
---

# Enterprise Agent Builder — Architecture & Code Generation

Design the complete agent architecture, then generate production-ready code. No stubs that need
rebuilding. No proposals requiring follow-up. The code runs the moment the conversation ends.

---

## Input

Accepts the `agent_spec` YAML output from `enterprise-problem-decoder`. If called directly,
prompt for: agent name, type, platform, industry/compliance, trigger, and desired outcome.

---

## Phase 2 — Agent Architecture

Design the complete agent **before writing a single line of code**.

### Agent Blueprint

Produce this blueprint immediately from the agent spec:

```markdown
## Agent Blueprint — [Agent Name]

**One-liner:** [What it does in one sentence, in plain language]
**Type:** [Monitoring | Triage | Automation | Decision-Support | Orchestrator]
**Platform:** [Primary platform] via [entry point]
**Industry context:** [Domain + compliance frameworks applied]

### Trigger
- Event: [what kicks the agent off]
- Source: [which system sends the trigger]
- Frequency: [real-time / scheduled / on-demand]

### Inputs
| Input | Source | Format | Notes |
|-------|--------|--------|-------|
| [field] | [system] | [JSON/XML/text] | [enrichment needed] |

### Reasoning / Logic
1. [Step 1: what the agent detects or decides]
2. [Step 2: what it looks up or computes]
3. [Step 3: what action it takes or recommends]

### Outputs / Actions
| Action | Target System | API / Method | Condition |
|--------|--------------|-------------|-----------|
| [action] | [system] | [endpoint] | [when triggered] |

### Human-in-the-Loop Gates
- [Any step where a human must approve before the agent proceeds]
- [Any irreversible action — delete, bulk-update, financial, clinical, security policy]

### Compliance Controls
- Audit logging: [destination]
- PII/PHI handling: [de-identification rule or exemption]
- Access control: [scope-limited credential requirement]
```

### Data Flow Diagram

Always produce a text-based data flow with the blueprint:

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

Generate production-ready code. Default to Python + Anthropic Claude API. Use platform-native
languages only when the target platform requires it (Apex for Salesforce, Groovy/JS for ServiceNow).

See `../dynamic-enterprise-agent/references/agent-templates.md` for full templates per platform
and agent type.

### Core Agent Scaffold (Python / Anthropic SDK)

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

### Platform-Specific Adaptations

Generate the appropriate adaptation when the primary platform is not Python-native:

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
            rm.setRequestBody(JSON.stringify({
                event: {
                    sys_id: gr.sys_id.toString(),
                    short_description: gr.short_description.toString()
                }
            }));
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
        SObject record = Database.query(
            'SELECT Id, Name FROM ' + objectType + ' WHERE Id = :recordId'
        );
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
        session.sql(
            f"UPDATE {table} SET ai_recommendation = '{result}' WHERE id = '{row['ID']}'"
        ).collect()
```

---

## Guardrails Embedded in Every Agent

Every generated agent must include these controls. Do not omit any of them:

- **No irreversible action without human gate** — delete, bulk-update, financial transaction,
  patient record change, or security policy change always calls `request_human_approval` first.
- **Audit trail on every action** — every tool call is logged with timestamp, actor identity,
  input, and output.
- **Credential hygiene** — all secrets via environment variables or secrets manager. Zero
  hardcoded credentials in generated code.
- **Scope-limited API credentials** — generated IAM policy is read-heavy with surgical write
  scope. No admin credentials.
- **PII/PHI handling** — if industry is healthcare or life sciences, apply de-identification
  before any LLM call not within a compliant boundary.
- **Rate limiting** — all platform API calls include exponential backoff and per-minute rate limits.
- **Graceful degradation** — if the agent cannot reach a platform API, it fails safe: logs the
  failure, alerts a human, does not guess or hallucinate data.

---

## Output

Produce the blueprint, data flow diagram, and complete code:

```
BUILD COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Agent: [agent name]
Blueprint: [inline above]
Data Flow: [inline above]
Code: [Python scaffold + platform adaptation, inline above]
Guardrails: embedded ✓

Ready for: enterprise-agent-shipper
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Hand off the blueprint, code, and agent spec to `enterprise-agent-shipper`.
