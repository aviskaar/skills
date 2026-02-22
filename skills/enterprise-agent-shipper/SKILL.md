---
name: enterprise-agent-shipper
description: >
  Use this skill when you have a completed agent blueprint and code from enterprise-agent-builder
  and need to produce the full deployment package: environment configuration, secrets management,
  deployment target selection, least-privilege IAM policy, a live demo script, and a ship
  checklist. The agent is deployment-ready before this skill completes.
  This is Phase 4+5 (Ship) of the Listen → Decode → Build → Ship methodology.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: >
    enterprise, ai-agents, deployment, integration, iam, secrets, lambda, cloud-functions,
    demo, ship-checklist, servicenow, salesforce, devops, aws, azure, gcp, production
---

# Enterprise Agent Shipper — Integration Configuration & Live Demo

Configure everything needed to deploy the agent right now. Produce the environment config,
IAM policy, deployment target, live demo script, and ship checklist. The agent goes live
before the meeting ends.

---

## Input

Accepts the agent blueprint, generated code, and `agent_spec` YAML from `enterprise-agent-builder`.
If called directly, prompt for: platform, deployment target, notification channel, and agent name.

---

## Phase 4 — Integration Configuration

### Environment Variables and Secrets

Always use a secrets manager. Never hardcode credentials in generated configuration.

```bash
# Always retrieve from secrets manager — never hardcode
export ANTHROPIC_API_KEY="$(vault read -field=value secret/anthropic/api_key)"
export PLATFORM_API_URL="https://{instance}.service-now.com"     # or platform equivalent
export PLATFORM_CLIENT_ID="$(vault read -field=value secret/{platform}/client_id)"
export PLATFORM_CLIENT_SECRET="$(vault read -field=value secret/{platform}/client_secret)"
export AUDIT_LOG_DESTINATION="splunk://audit-index"              # or S3/CloudWatch/Datadog
```

**Secrets manager options by deployment target:**

| Deployment target | Recommended secrets store |
|------------------|--------------------------|
| AWS Lambda | AWS Secrets Manager or Parameter Store |
| Azure Function | Azure Key Vault |
| GCP Cloud Run | Google Secret Manager |
| ServiceNow MID Server | ServiceNow Credential Store |
| Kubernetes | Kubernetes Secrets + external-secrets operator |
| On-premise | HashiCorp Vault |

### Deployment Target Selection

Match the trigger mechanism to the correct deployment target:

| Trigger mechanism | Deployment target | Runtime |
|------------------|------------------|---------|
| ServiceNow Flow / Scripted REST | ServiceNow MID Server | JS / Rhino |
| Salesforce Platform Event / Apex trigger | Apex Future / Platform Event | Apex |
| Cron / scheduled job | AWS Lambda, Azure Function, Cloud Run | Python |
| Webhook / inbound API call | API Gateway + Lambda, Azure API Management | Python |
| Streaming event (Kafka, Kinesis) | Kafka consumer, EventBridge, Pub/Sub | Python |
| Teams / Slack message | Bot Framework, Socket Mode | Python |
| SIEM alert (Splunk, QRadar) | XSOAR/SOAR playbook, Splunk Adaptive Response | Python |
| Database change / CDC | Debezium + Lambda, Azure Event Hub | Python |
| IoT / OT event | AWS IoT Core, Azure IoT Hub, OSIsoft PI | Python |

### Minimum IAM Permissions

Generate the least-privilege IAM policy for the resolved platform:

```yaml
# Principle of least privilege — scoped to this agent only
iam_policy:
  agent: "{agent_name}"
  platform: "{platform}"
  read:
    - {platform}.records.read        # read trigger source records
    - {platform}.attachments.read    # read supporting context and files
  write:
    - {platform}.records.update      # update records the agent is responsible for
    - {platform}.notifications.send  # send alerts and approval requests
  deny:
    - {platform}.admin.*             # never admin-scope credentials
    - {platform}.delete.*            # never delete without an explicit, separate flag
    - {platform}.export.*            # never bulk export
```

**Regulated-industry overrides — apply automatically when detected:**

| Framework | Additional IAM constraint |
|-----------|--------------------------|
| HIPAA | Credentials must be within a HIPAA-covered entity boundary; BAA required for LLM vendor |
| 21 CFR Part 11 | All write actions must produce immutable audit entries; e-signature required for approvals |
| FedRAMP / IL4+ | LLM API must be FedRAMP-authorized (Azure Government, AWS GovCloud); no commercial endpoint egress |
| PCI-DSS | Cardholder data masked or tokenized before any LLM call; no raw PAN in logs |
| SOX | Financial agent actions require dual approval; agent deployments subject to change management |

---

## Phase 5 — Live Demo Package

Produce this in under 60 seconds when someone asks "can you show me?" or when urgency is `demo_now`.

### Instant Demo Script

```
AGENT DEMO: {agent_name}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

SCENARIO: [One sentence describing a realistic, concrete event]

TRIGGER: A {trigger_type} arrives in {source_system}

AGENT RESPONSE (live):
  1. Receives event → extracts: [{key_fields_from_payload}]
  2. Calls fetch_context → finds: [{what_was_retrieved}]
  3. Reasons: [{what_the_llm_decides_and_why}]
  4. Takes action: [{action_taken}] on {target_system}
  5. Logs to audit trail: [{audit_entry_content}]
  [6. Requests human approval: [{approval_context}] — only if a gate was triggered]

WITHOUT THIS AGENT:  [{what_a_human_does_today}] — takes {time_today}
WITH THIS AGENT:     Done in {time_with_agent} — human notified only if exception

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Ship Checklist

```
SHIP CHECKLIST — {agent_name}
Platform: {platform} | Deployment: {deployment_target}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

SECRETS & CREDENTIALS
[ ] ANTHROPIC_API_KEY stored in {secrets_manager} — not in code or config files
[ ] Platform client ID and secret stored in {secrets_manager}
[ ] Secrets manager access policy scoped to this agent's service identity only

PLATFORM CONNECTORS
[ ] fetch_context() connected to real {platform} read endpoint
[ ] take_action() connected to real {platform} write endpoint
[ ] request_human_approval() connected to {notification_channel} (Teams/Slack/PagerDuty)

COMPLIANCE
[ ] Audit log destination configured: {audit_log_destination}
[ ] PII/PHI handling rule implemented per {compliance_framework}
[ ] IAM policy scoped to minimum permissions (no admin, no delete)

TESTING
[ ] Test run executed against a single non-production event
[ ] Human-in-the-loop gate tested and approval notification received
[ ] fetch_context() timeout and retry behavior confirmed
[ ] Graceful degradation tested: agent fails safe when platform API is unreachable

DEPLOYMENT
[ ] Rate limit / exponential backoff logic in all platform API calls
[ ] Agent deployed to {deployment_target}
[ ] Trigger connected and verified (first real event received)
[ ] Monitoring / alerting configured for agent failures

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
AGENT IS LIVE WHEN ALL BOXES ARE CHECKED
```

---

## Output

Produce the integration config, IAM policy, demo script, and ship checklist:

```
SHIP PACKAGE COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Agent: [agent name]
Deployment target: [target]
Secrets: [secrets manager]
IAM policy: [inline above]
Demo script: [inline above]
Ship checklist: [inline above]

Status: READY TO DEPLOY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

The agent is deployment-ready. Work the ship checklist top to bottom to go live.
