---
name: enterprise-signal-listener
description: >
  Use this skill when someone — a client, stakeholder, investor, team member, or executive —
  is describing a business problem, workflow pain, or opportunity in natural conversation and
  you need to extract structured signal without interrupting them. Activate the moment someone
  says "we need something that can..." or "our team keeps having to manually..." or "what if
  there were a way to..." Produces a completed intake specification ready for problem decoding.
  This is Phase 0 (Listen) of the Listen → Decode → Build → Ship methodology.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: >
    enterprise, ai-agents, signal-capture, intake, listening, real-time, conversation,
    discovery, servicenow, salesforce, workday, sap, snowflake, microsoft, aws, azure
---

# Enterprise Signal Listener — Live Signal Capture

Extract everything needed to build an enterprise AI agent from natural conversation — without
interrupting the person talking. Capture while they speak. Ask nothing unless a critical signal
is missing.

---

## Core Behavior

Do not ask the person to fill out a form. Do not pause the conversation to confirm understanding.
Listen, extract, and produce a completed intake specification. Ask at most two clarifying
questions, and only when a critical signal cannot be inferred.

---

## What to Listen For

Extract these signals from natural speech. They will rarely be stated explicitly — infer them
from context:

| Signal Type | Listen for phrases like... |
|-------------|---------------------------|
| **Platform** | "in ServiceNow", "our Salesforce", "Workday tickets", "SAP transactions", "Snowflake warehouse", "Teams channel", "Azure pipeline", "our AWS account", "Okta provisioning", "Splunk alerts", "CrowdStrike detections", "Epic orders", "Veeva submissions", "Bloomberg feed" |
| **Industry** | "patients", "clinical trials", "adverse events", "trades", "positions", "claims", "underwriting", "SKUs", "warfighters", "compliance audit", "drug approval", "loan origination", "grid operators", "grid assets", "procurement", "purchase orders" |
| **Pain trigger** | "manually", "takes too long", "we keep missing", "no one knows when", "we get paged at 3am", "the team wastes hours on", "audit keeps failing", "we can't see", "there's no visibility into", "someone has to", "it falls through the cracks" |
| **Actor** | Who does this today? (a person, a named team, a queue, a shift) |
| **Frequency** | How often does this happen? ("every ticket", "nightly", "on-demand", "real-time", "every quarter", "whenever a new hire joins") |
| **Outcome wanted** | "automatically", "instantly notify", "alert us when", "summarize for us", "route it to", "predict when", "remediate it", "generate the report", "approve without a human", "escalate if" |

---

## Rapid Intake Form

Populate this from conversation signals. Mark fields `[inferred]` if derived from context,
`[missing]` if not detectable:

```yaml
intake:
  spoken_problem: ""        # verbatim quote or close paraphrase of what they said
  platform_hint: ""         # any system(s) they mentioned — be specific (e.g. "ServiceNow ITSM")
  industry_hint: ""         # domain or vertical (e.g. "healthcare — hospital network")
  actor: ""                 # who does this today (person, team, queue)
  trigger: ""               # what kicks the process off (event, schedule, threshold, request)
  desired_outcome: ""       # what "fixed" or "done" looks like in their words
  pain_intensity: ""        # low | medium | high | critical (infer from language: "3am", "audit fails" = critical)
  urgency: ""               # demo_now | this_week | this_sprint | next_quarter
  compliance_flags: []      # any regulatory or compliance terms heard (HIPAA, FedRAMP, SOX, PCI, GxP, etc.)
  secondary_systems: []     # any additional platforms or integrations mentioned
```

---

## Clarifying Questions

Ask **at most 2** questions. Only ask if a critical signal is missing after careful listening.
Stop as soon as you have enough to hand off to problem decoding.

**Priority order — ask the first unanswered question from this list:**

1. "Which system does this live in today?" — ask only if no platform was detectable from the conversation
2. "When this goes wrong, who feels it first?" — surfaces the actor and trigger simultaneously
3. "What would 'fixed' look like in 30 seconds?" — surfaces the desired outcome

**Never ask about:**
- Timelines, budgets, or project schedules
- Technical architecture or infrastructure preferences
- Whether they've tried other solutions
- Org structure or reporting lines

Build from what you have. Ambiguity is resolved in the Decode phase, not here.

---

## Signal Quality Assessment

Before handing off, rate the intake:

| Field | Status | Action if missing |
|-------|--------|------------------|
| `spoken_problem` | Required | Paraphrase what was described |
| `platform_hint` | Required | Ask clarifying question #1 |
| `industry_hint` | Preferred | Infer from domain vocabulary; flag as `[inferred]` |
| `actor` | Preferred | Ask clarifying question #2 |
| `trigger` | Preferred | Infer from frequency and pain language |
| `desired_outcome` | Required | Ask clarifying question #3 |
| `pain_intensity` | Auto-inferred | Always derivable from language |
| `urgency` | Preferred | Default to `this_week` if not stated |

If `spoken_problem`, `platform_hint`, and `desired_outcome` are all populated — even with
inferred values — the intake is complete and ready for decoding.

---

## Output

Produce the completed intake YAML and a one-sentence summary:

```
SIGNAL CAPTURE COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Summary: [One sentence describing the problem heard, the platform, and the desired outcome]

Intake:
[populated intake YAML]

Signal quality: [Complete | Partial — missing: field1, field2]
Ready for: enterprise-problem-decoder
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Hand off the completed intake YAML to `enterprise-problem-decoder`.
