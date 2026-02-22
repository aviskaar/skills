# Agent Templates Reference

Full template implementations per platform and agent type.
Each template is production-ready with stubs for platform connectors. Replace stubs with real SDK calls.

---

## Template Index

| Template ID | Agent Type | Platform | Industry |
|------------|-----------|----------|----------|
| `triage-servicenow` | Triage | ServiceNow | Any |
| `lead-followup-sfdc` | Automation | Salesforce | B2B |
| `pipeline-monitor-snowflake` | Monitoring | Snowflake | Data/Any |
| `iam-provisioning` | Automation | Okta + ServiceNow | Any |
| `alert-triage-siem` | Triage | Splunk/XSOAR | SecOps |
| `clinical-doc-assist` | Automation | Epic FHIR | Healthcare |
| `clinical-trial-monitor` | Monitoring | Veeva Vault | Life Sciences |
| `sar-automation` | Automation | Core Banking + SAP | Banking/Fintech |
| `signal-delivery-agent` | Monitoring | Bloomberg B-PIPE | Quant Finance |
| `po-approval-sap` | Triage | SAP BTP | Manufacturing |
| `incident-bridge-teams` | Orchestrator | Microsoft Teams + Azure | Any |
| `audit-response-federal` | Decision-Support | ServiceNow GovCloud | Federal |
| `order-sync-retail` | Automation | Shopify + 3PL API | Retail |
| `asset-health-monitor` | Monitoring | PI System + Azure | Energy/Utilities |

---

## `triage-servicenow` — Incident Triage Agent

**Type:** Triage | **Platform:** ServiceNow | **Industry:** Any

```python
"""
Agent: Incident Triage Agent
Platform: ServiceNow
Function: Classifies, prioritizes, and routes incoming incidents
          using LLM reasoning over incident context.
"""
import anthropic, requests, json
from datetime import datetime, timezone

MODEL = "claude-opus-4-6"
SN_BASE = "https://{instance}.service-now.com/api/now"
HEADERS = {"Authorization": "Bearer {token}", "Content-Type": "application/json"}

client = anthropic.Anthropic()

SYSTEM = """You are an IT incident triage agent for a ServiceNow ITSM environment.
Your job is to classify each incident by urgency and impact, assign the correct
assignment group, and set an appropriate priority (1-4).

Rules:
- P1: Business-critical service down, revenue impact, security breach
- P2: Major degradation, multiple users affected, SLA at risk
- P3: Single user affected, workaround exists
- P4: Minor issue, no business impact
- Never change priority downward without a note.
- Always log your reasoning in the work notes."""

tools = [
    {
        "name": "get_incident_details",
        "description": "Fetch full incident record including CI, caller, recent history.",
        "input_schema": {"type": "object",
                         "properties": {"sys_id": {"type": "string"}},
                         "required": ["sys_id"]}
    },
    {
        "name": "get_similar_incidents",
        "description": "Find recent similar incidents to detect patterns or known issues.",
        "input_schema": {"type": "object",
                         "properties": {"keywords": {"type": "string"},
                                        "limit": {"type": "integer", "default": 5}},
                         "required": ["keywords"]}
    },
    {
        "name": "update_incident",
        "description": "Update incident fields: priority, assignment_group, work_notes.",
        "input_schema": {"type": "object",
                         "properties": {
                             "sys_id": {"type": "string"},
                             "priority": {"type": "string", "enum": ["1", "2", "3", "4"]},
                             "assignment_group": {"type": "string"},
                             "work_notes": {"type": "string"}},
                         "required": ["sys_id", "priority", "assignment_group", "work_notes"]}
    }
]

def get_incident_details(sys_id: str) -> dict:
    r = requests.get(f"{SN_BASE}/table/incident/{sys_id}", headers=HEADERS,
                     params={"sysparm_display_value": "true"})
    return r.json().get("result", {})

def get_similar_incidents(keywords: str, limit: int = 5) -> list:
    r = requests.get(f"{SN_BASE}/table/incident", headers=HEADERS,
                     params={"sysparm_query": f"short_descriptionLIKE{keywords}^resolved_atONToday@javascript:gs.beginningOfLast7Days()@javascript:gs.endOfToday()",
                             "sysparm_limit": limit, "sysparm_display_value": "true"})
    return r.json().get("result", [])

def update_incident(sys_id: str, priority: str, assignment_group: str, work_notes: str) -> dict:
    payload = {"priority": priority, "assignment_group": {"name": assignment_group},
               "work_notes": f"[Agent Triage — {datetime.now(timezone.utc).isoformat()}]\n{work_notes}"}
    r = requests.patch(f"{SN_BASE}/table/incident/{sys_id}", headers=HEADERS, json=payload)
    return r.json().get("result", {})

TOOL_MAP = {"get_incident_details": get_incident_details,
            "get_similar_incidents": get_similar_incidents,
            "update_incident": update_incident}

def triage_incident(sys_id: str):
    messages = [{"role": "user",
                 "content": f"Triage this incident (sys_id={sys_id}). Fetch details, check for similar incidents, set priority and route it."}]
    while True:
        resp = client.messages.create(model=MODEL, max_tokens=2048, system=SYSTEM,
                                      tools=tools, messages=messages)
        tool_uses = [b for b in resp.content if b.type == "tool_use"]
        if resp.stop_reason == "end_turn" or not tool_uses:
            return next((b.text for b in resp.content if hasattr(b, "text")), "Done.")
        messages.append({"role": "assistant", "content": resp.content})
        results = []
        for tu in tool_uses:
            out = TOOL_MAP[tu.name](**tu.input)
            results.append({"type": "tool_result", "tool_use_id": tu.id, "content": json.dumps(out)})
        messages.append({"role": "user", "content": results})

# Entry: ServiceNow Business Rule or scheduled job calls this
if __name__ == "__main__":
    triage_incident(sys_id="{sys_id_from_trigger}")
```

---

## `lead-followup-sfdc` — Lead Follow-Up Automation Agent

**Type:** Automation | **Platform:** Salesforce | **Industry:** B2B

```python
"""
Agent: Lead Follow-Up Automation Agent
Platform: Salesforce (via simple-salesforce)
Function: Detects stale leads, drafts personalized outreach,
          creates Tasks, and logs activity — all automatically.
"""
import anthropic, json
from datetime import datetime, timezone
from simple_salesforce import Salesforce

MODEL = "claude-opus-4-6"
sf = Salesforce(username="{user}", password="{pass}", security_token="{token}")
client = anthropic.Anthropic()

SYSTEM = """You are a B2B sales automation agent. Your job is to:
1. Identify leads that have been untouched for > 3 days.
2. Research each lead's company context (industry, size, recent activity).
3. Draft a concise, personalized follow-up email (≤ 5 sentences, no generic openers).
4. Create a Salesforce Task for the owning rep with the draft and suggested send time.
Never fabricate company facts. If context is thin, draft a curiosity-gap opener."""

tools = [
    {
        "name": "get_stale_leads",
        "description": "Query Salesforce for leads not contacted in N days.",
        "input_schema": {"type": "object",
                         "properties": {"days_stale": {"type": "integer", "default": 3}},
                         "required": []}
    },
    {
        "name": "get_lead_context",
        "description": "Get full lead record plus account/company enrichment.",
        "input_schema": {"type": "object",
                         "properties": {"lead_id": {"type": "string"}},
                         "required": ["lead_id"]}
    },
    {
        "name": "create_followup_task",
        "description": "Create a Task in Salesforce with the draft email for the rep.",
        "input_schema": {"type": "object",
                         "properties": {
                             "lead_id": {"type": "string"},
                             "owner_id": {"type": "string"},
                             "subject": {"type": "string"},
                             "email_draft": {"type": "string"},
                             "due_date": {"type": "string"}},
                         "required": ["lead_id", "owner_id", "subject", "email_draft"]}
    }
]

def get_stale_leads(days_stale: int = 3) -> list:
    result = sf.query(
        f"SELECT Id, FirstName, LastName, Company, Title, Email, OwnerId, Status "
        f"FROM Lead WHERE LastActivityDate < LAST_N_DAYS:{days_stale} "
        f"AND Status NOT IN ('Converted', 'Closed') LIMIT 20")
    return result["records"]

def get_lead_context(lead_id: str) -> dict:
    lead = sf.Lead.get(lead_id)
    return {k: lead[k] for k in ["FirstName", "LastName", "Company", "Title",
                                   "Industry", "NumberOfEmployees", "LeadSource",
                                   "Description", "Email", "Website"] if lead.get(k)}

def create_followup_task(lead_id: str, owner_id: str, subject: str,
                         email_draft: str, due_date: str = None) -> dict:
    due = due_date or datetime.now(timezone.utc).strftime("%Y-%m-%d")
    task = sf.Task.create({
        "WhoId": lead_id, "OwnerId": owner_id, "Subject": subject,
        "Description": email_draft, "ActivityDate": due,
        "Status": "Not Started", "Priority": "Normal",
        "Type": "Email"
    })
    return task

TOOL_MAP = {"get_stale_leads": get_stale_leads, "get_lead_context": get_lead_context,
            "create_followup_task": create_followup_task}

def run_lead_followup():
    messages = [{"role": "user", "content":
                 "Find all stale leads, draft personalized follow-ups, and create tasks for each rep."}]
    while True:
        resp = client.messages.create(model=MODEL, max_tokens=4096, system=SYSTEM,
                                      tools=tools, messages=messages)
        tool_uses = [b for b in resp.content if b.type == "tool_use"]
        if resp.stop_reason == "end_turn" or not tool_uses:
            return next((b.text for b in resp.content if hasattr(b, "text")), "Done.")
        messages.append({"role": "assistant", "content": resp.content})
        results = []
        for tu in tool_uses:
            out = TOOL_MAP[tu.name](**tu.input)
            results.append({"type": "tool_result", "tool_use_id": tu.id, "content": json.dumps(out)})
        messages.append({"role": "user", "content": results})
```

---

## `pipeline-monitor-snowflake` — Data Pipeline Monitor

**Type:** Monitoring | **Platform:** Snowflake | **Industry:** Data/Any

```python
"""
Agent: Data Pipeline Monitor
Platform: Snowflake (Snowpark + Cortex)
Function: Detects failed/stalled Snowflake tasks and data quality
          anomalies; alerts on-call data engineer via PagerDuty/Slack.
"""
import anthropic, json, requests
from snowflake.snowpark import Session
from datetime import datetime, timezone

MODEL = "claude-opus-4-6"
client = anthropic.Anthropic()

SYSTEM = """You are a data pipeline reliability agent for a Snowflake environment.
Monitor task history and data quality metrics. When anomalies are detected:
1. Diagnose the root cause from available logs and metrics.
2. Classify severity: critical (data missing or wrong), warning (delay), info.
3. Draft a concise incident summary for the on-call engineer.
4. Trigger an alert only if severity is warning or above.
Do not alert on expected scheduled gaps (weekends, maintenance windows)."""

def get_snowpark_session() -> Session:
    return Session.builder.configs({
        "account": "{SNOWFLAKE_ACCOUNT}", "user": "{USER}",
        "private_key": "{PRIVATE_KEY}", "role": "MONITOR_ROLE",
        "warehouse": "MONITOR_WH", "database": "OPS", "schema": "PIPELINE"
    }).create()

tools = [
    {
        "name": "get_failed_tasks",
        "description": "Query TASK_HISTORY for recently failed or timed-out tasks.",
        "input_schema": {"type": "object",
                         "properties": {"hours_back": {"type": "integer", "default": 2}},
                         "required": []}
    },
    {
        "name": "get_row_count_anomalies",
        "description": "Compare today's table row counts vs. 7-day average.",
        "input_schema": {"type": "object",
                         "properties": {"schema_name": {"type": "string"}},
                         "required": ["schema_name"]}
    },
    {
        "name": "send_alert",
        "description": "Send incident alert to Slack/PagerDuty.",
        "input_schema": {"type": "object",
                         "properties": {
                             "severity": {"type": "string", "enum": ["critical", "warning", "info"]},
                             "summary": {"type": "string"},
                             "details": {"type": "string"}},
                         "required": ["severity", "summary"]}
    }
]

session = get_snowpark_session()

def get_failed_tasks(hours_back: int = 2) -> list:
    rows = session.sql(f"""
        SELECT NAME, STATE, ERROR_MESSAGE, SCHEDULED_TIME, COMPLETED_TIME
        FROM TABLE(INFORMATION_SCHEMA.TASK_HISTORY(
            SCHEDULED_TIME_RANGE_START => DATEADD('hour', -{hours_back}, CURRENT_TIMESTAMP())))
        WHERE STATE IN ('FAILED', 'SKIPPED', 'CANCELLED')
        ORDER BY SCHEDULED_TIME DESC
    """).collect()
    return [r.as_dict() for r in rows]

def get_row_count_anomalies(schema_name: str) -> list:
    rows = session.sql(f"""
        WITH daily AS (
            SELECT TABLE_NAME, ROW_COUNT, LAST_ALTERED::DATE AS snapshot_date
            FROM INFORMATION_SCHEMA.TABLES
            WHERE TABLE_SCHEMA = '{schema_name.upper()}'
        ),
        avg_counts AS (
            SELECT TABLE_NAME, AVG(ROW_COUNT) AS avg_7d
            FROM SNOWFLAKE.ACCOUNT_USAGE.TABLE_STORAGE_METRICS
            WHERE TABLE_SCHEMA = '{schema_name.upper()}'
              AND DELETED IS NULL
            GROUP BY TABLE_NAME
        )
        SELECT d.TABLE_NAME, d.ROW_COUNT, a.avg_7d,
               ROUND((d.ROW_COUNT - a.avg_7d) / NULLIF(a.avg_7d, 0) * 100, 1) AS pct_change
        FROM daily d JOIN avg_counts a USING (TABLE_NAME)
        WHERE ABS(pct_change) > 20
    """).collect()
    return [r.as_dict() for r in rows]

def send_alert(severity: str, summary: str, details: str = "") -> dict:
    # Slack webhook
    requests.post("{SLACK_WEBHOOK_URL}", json={
        "text": f"*[{severity.upper()}] Pipeline Monitor*\n{summary}\n```{details}```"})
    return {"sent": True, "severity": severity, "timestamp": datetime.now(timezone.utc).isoformat()}

TOOL_MAP = {"get_failed_tasks": get_failed_tasks,
            "get_row_count_anomalies": get_row_count_anomalies,
            "send_alert": send_alert}

def run_pipeline_monitor(schema_name: str = "ANALYTICS"):
    messages = [{"role": "user", "content":
                 f"Check for pipeline failures and data anomalies in schema {schema_name}. Alert if needed."}]
    while True:
        resp = client.messages.create(model=MODEL, max_tokens=2048, system=SYSTEM,
                                      tools=tools, messages=messages)
        tool_uses = [b for b in resp.content if b.type == "tool_use"]
        if resp.stop_reason == "end_turn" or not tool_uses:
            return next((b.text for b in resp.content if hasattr(b, "text")), "Done.")
        messages.append({"role": "assistant", "content": resp.content})
        results = []
        for tu in tool_uses:
            out = TOOL_MAP[tu.name](**tu.input)
            results.append({"type": "tool_result", "tool_use_id": tu.id, "content": json.dumps(out, default=str)})
        messages.append({"role": "user", "content": results})
```

---

## `iam-provisioning` — IAM Lifecycle Automation Agent

**Type:** Automation | **Platform:** Okta + ServiceNow | **Industry:** Any

```python
"""
Agent: IAM Lifecycle Automation Agent
Platform: Okta + ServiceNow
Function: Detects new hire service catalog requests in ServiceNow,
          provisions Okta account + group memberships, and updates the ticket.
"""
import anthropic, requests, json
from datetime import datetime, timezone

MODEL = "claude-opus-4-6"
client = anthropic.Anthropic()

OKTA_BASE = "https://{okta_domain}/api/v1"
OKTA_HEADERS = {"Authorization": "SSWS {OKTA_API_TOKEN}", "Content-Type": "application/json"}
SN_BASE = "https://{instance}.service-now.com/api/now"
SN_HEADERS = {"Authorization": "Bearer {SN_TOKEN}", "Content-Type": "application/json"}

SYSTEM = """You are an IAM provisioning agent. When a new hire request arrives:
1. Extract the new employee's details and their role/department.
2. Determine the correct Okta groups based on role and department.
3. Create the Okta user account with appropriate profile.
4. Assign the correct groups (and no others — least privilege).
5. Update the ServiceNow ticket with the provisioning summary.
6. Never assign admin or privileged groups without explicit approval in the request."""

tools = [
    {
        "name": "get_pending_provisioning_requests",
        "description": "Get open new hire RITM records from ServiceNow.",
        "input_schema": {"type": "object", "properties": {}, "required": []}
    },
    {
        "name": "lookup_role_groups",
        "description": "Look up the standard Okta group assignments for a given role and department.",
        "input_schema": {"type": "object",
                         "properties": {"role": {"type": "string"}, "department": {"type": "string"}},
                         "required": ["role", "department"]}
    },
    {
        "name": "create_okta_user",
        "description": "Create a new Okta user and activate their account.",
        "input_schema": {"type": "object",
                         "properties": {
                             "first_name": {"type": "string"}, "last_name": {"type": "string"},
                             "email": {"type": "string"}, "login": {"type": "string"},
                             "department": {"type": "string"}, "title": {"type": "string"}},
                         "required": ["first_name", "last_name", "email", "login"]}
    },
    {
        "name": "assign_okta_groups",
        "description": "Assign a list of group IDs to an Okta user.",
        "input_schema": {"type": "object",
                         "properties": {"user_id": {"type": "string"},
                                        "group_ids": {"type": "array", "items": {"type": "string"}}},
                         "required": ["user_id", "group_ids"]}
    },
    {
        "name": "close_servicenow_ticket",
        "description": "Update and close the ServiceNow RITM with provisioning summary.",
        "input_schema": {"type": "object",
                         "properties": {"ritm_sys_id": {"type": "string"},
                                        "summary": {"type": "string"}},
                         "required": ["ritm_sys_id", "summary"]}
    }
]

# Role-to-group mapping (replace with your CMDB/HR system lookup)
ROLE_GROUP_MAP = {
    ("engineer", "engineering"):       ["00g_engineers", "00g_github_users", "00g_aws_read"],
    ("analyst", "finance"):            ["00g_finance", "00g_snowflake_analysts"],
    ("manager", "sales"):              ["00g_sales", "00g_salesforce_std", "00g_expensify"],
}

def get_pending_provisioning_requests() -> list:
    r = requests.get(f"{SN_BASE}/table/sc_req_item", headers=SN_HEADERS,
                     params={"sysparm_query": "cat_item.name=New Employee Onboarding^state=1",
                             "sysparm_limit": 10, "sysparm_display_value": "true"})
    return r.json().get("result", [])

def lookup_role_groups(role: str, department: str) -> list:
    key = (role.lower(), department.lower())
    return ROLE_GROUP_MAP.get(key, ["00g_default_users"])

def create_okta_user(first_name: str, last_name: str, email: str, login: str,
                     department: str = "", title: str = "") -> dict:
    payload = {"profile": {"firstName": first_name, "lastName": last_name,
                           "email": email, "login": login,
                           "department": department, "title": title},
               "activate": True}
    r = requests.post(f"{OKTA_BASE}/users", headers=OKTA_HEADERS, json=payload)
    return r.json()

def assign_okta_groups(user_id: str, group_ids: list) -> list:
    results = []
    for gid in group_ids:
        r = requests.put(f"{OKTA_BASE}/groups/{gid}/users/{user_id}", headers=OKTA_HEADERS)
        results.append({"group_id": gid, "status": r.status_code})
    return results

def close_servicenow_ticket(ritm_sys_id: str, summary: str) -> dict:
    payload = {"state": "3", "close_notes": summary,  # state 3 = Closed Complete
               "work_notes": f"[IAM Agent — {datetime.now(timezone.utc).isoformat()}]\n{summary}"}
    r = requests.patch(f"{SN_BASE}/table/sc_req_item/{ritm_sys_id}", headers=SN_HEADERS, json=payload)
    return r.json().get("result", {})

TOOL_MAP = {"get_pending_provisioning_requests": get_pending_provisioning_requests,
            "lookup_role_groups": lookup_role_groups, "create_okta_user": create_okta_user,
            "assign_okta_groups": assign_okta_groups, "close_servicenow_ticket": close_servicenow_ticket}

def run_iam_provisioning():
    messages = [{"role": "user", "content":
                 "Process all pending new hire provisioning requests. Create accounts and assign groups."}]
    while True:
        resp = client.messages.create(model=MODEL, max_tokens=4096, system=SYSTEM,
                                      tools=tools, messages=messages)
        tool_uses = [b for b in resp.content if b.type == "tool_use"]
        if resp.stop_reason == "end_turn" or not tool_uses:
            return next((b.text for b in resp.content if hasattr(b, "text")), "Done.")
        messages.append({"role": "assistant", "content": resp.content})
        results = []
        for tu in tool_uses:
            out = TOOL_MAP[tu.name](**tu.input)
            results.append({"type": "tool_result", "tool_use_id": tu.id, "content": json.dumps(out)})
        messages.append({"role": "user", "content": results})
```

---

## `alert-triage-siem` — SIEM Alert Triage Agent

**Type:** Triage | **Platform:** Splunk/XSOAR | **Industry:** SecOps

```python
"""
Agent: SIEM Alert Triage Agent
Platform: Splunk + XSOAR
Function: Ingests high-volume SIEM alerts, filters noise,
          enriches true positives, and creates XSOAR incidents.
"""
import anthropic, json, requests
import splunklib.client as splunk_client
import splunklib.results as splunk_results

MODEL = "claude-opus-4-6"
client = anthropic.Anthropic()

SYSTEM = """You are a tier-1 SOC analyst agent. For each SIEM alert:
1. Retrieve the alert details and raw events.
2. Enrich the source IP/user with threat intel and asset context.
3. Determine if this is a true positive, false positive, or needs escalation.
4. For true positives: create an XSOAR incident with severity and initial findings.
5. For false positives: close with documented reason.
6. For unknowns: escalate to a tier-2 analyst with your analysis.

Do not create duplicate incidents for the same source within 1 hour.
Always document your reasoning."""

tools = [
    {
        "name": "get_splunk_alerts",
        "description": "Fetch recent notable events from Splunk Enterprise Security.",
        "input_schema": {"type": "object",
                         "properties": {"minutes_back": {"type": "integer", "default": 15}},
                         "required": []}
    },
    {
        "name": "enrich_indicator",
        "description": "Enrich an IP, domain, or user with threat intel and asset data.",
        "input_schema": {"type": "object",
                         "properties": {
                             "indicator": {"type": "string"},
                             "indicator_type": {"type": "string",
                                                "enum": ["ip", "domain", "user", "hash"]}},
                         "required": ["indicator", "indicator_type"]}
    },
    {
        "name": "create_xsoar_incident",
        "description": "Create a new incident in Cortex XSOAR.",
        "input_schema": {"type": "object",
                         "properties": {
                             "name": {"type": "string"},
                             "severity": {"type": "integer", "description": "1=Info 2=Low 3=Med 4=High 5=Critical"},
                             "details": {"type": "string"},
                             "labels": {"type": "array", "items": {"type": "object"}}},
                         "required": ["name", "severity", "details"]}
    },
    {
        "name": "close_alert",
        "description": "Close a Splunk notable event as false positive.",
        "input_schema": {"type": "object",
                         "properties": {
                             "event_id": {"type": "string"},
                             "reason": {"type": "string"}},
                         "required": ["event_id", "reason"]}
    }
]

svc = splunk_client.connect(host="{SPLUNK_HOST}", port=8089,
                             username="{USER}", password="{PASS}")

def get_splunk_alerts(minutes_back: int = 15) -> list:
    job = svc.jobs.create(
        f'search `notable` earliest=-{minutes_back}m | fields event_id, src_ip, src_user, '
        f'rule_name, urgency, count | sort -urgency | head 20',
        exec_mode="blocking")
    return [dict(r) for r in splunk_results.JSONResultsReader(job.results(output_mode="json"))
            if isinstance(r, dict)]

def enrich_indicator(indicator: str, indicator_type: str) -> dict:
    # Stub: replace with VirusTotal, Recorded Future, CrowdStrike Intel, etc.
    return {"indicator": indicator, "type": indicator_type,
            "reputation": "unknown", "tags": [], "asset_info": {}}

def create_xsoar_incident(name: str, severity: int, details: str, labels: list = None) -> dict:
    r = requests.post("{XSOAR_URL}/incident", headers={"Authorization": "{XSOAR_KEY}"},
                      json={"name": name, "severity": severity, "details": details,
                            "labels": labels or [], "type": "Security Alert"})
    return r.json()

def close_alert(event_id: str, reason: str) -> dict:
    # Update Splunk notable event status to closed
    svc.post("receivers/simple", **{"source": "agent", "sourcetype": "alert_closure",
                                     "event": json.dumps({"event_id": event_id,
                                                          "status": "closed", "reason": reason})})
    return {"closed": True, "event_id": event_id}

TOOL_MAP = {"get_splunk_alerts": get_splunk_alerts, "enrich_indicator": enrich_indicator,
            "create_xsoar_incident": create_xsoar_incident, "close_alert": close_alert}

def run_alert_triage():
    messages = [{"role": "user", "content":
                 "Fetch and triage all recent SIEM alerts. Create incidents for true positives, close false positives."}]
    while True:
        resp = client.messages.create(model=MODEL, max_tokens=4096, system=SYSTEM,
                                      tools=tools, messages=messages)
        tool_uses = [b for b in resp.content if b.type == "tool_use"]
        if resp.stop_reason == "end_turn" or not tool_uses:
            return next((b.text for b in resp.content if hasattr(b, "text")), "Done.")
        messages.append({"role": "assistant", "content": resp.content})
        results = []
        for tu in tool_uses:
            out = TOOL_MAP[tu.name](**tu.input)
            results.append({"type": "tool_result", "tool_use_id": tu.id, "content": json.dumps(out)})
        messages.append({"role": "user", "content": results})
```

---

## `clinical-doc-assist` — Clinical Documentation Assistant

**Type:** Automation | **Platform:** Epic FHIR | **Industry:** Healthcare

```python
"""
Agent: Clinical Documentation Assistant
Platform: Epic FHIR R4 (via CDS Hooks)
Function: Assists clinicians in documenting encounter notes
          by surfacing relevant patient context and suggesting note sections.

HIPAA NOTE: All PHI remains within the compliant FHIR boundary.
            LLM receives de-identified or aggregate summaries only.
"""
import anthropic, requests, json, re
from datetime import datetime, timezone

MODEL = "claude-opus-4-6"
client = anthropic.Anthropic()

FHIR_BASE = "https://{epic_instance}/api/FHIR/R4"
FHIR_HEADERS = {"Authorization": "Bearer {SMART_ACCESS_TOKEN}", "Accept": "application/fhir+json"}

# De-identification patterns (see industry-patterns.md for full list)
PHI_RE = re.compile(r'\b(\d{3}-\d{2}-\d{4}|\bMRN\s*\d+|0[1-9]/[0-3]\d/\d{4})\b')

def deidentify(text: str) -> str:
    return PHI_RE.sub("[REDACTED]", text)

SYSTEM = """You are a clinical documentation assistant. Given de-identified patient context:
1. Identify documentation gaps (missing HPI elements, ROS, assessment gaps).
2. Suggest structured note sections based on visit type and chief complaint.
3. Propose appropriate ICD-10 codes based on documented conditions.
4. Flag any medication-condition interactions worth documenting.
Output structured suggestions — do not generate free-text that could be copied without clinician review."""

tools = [
    {
        "name": "get_patient_summary",
        "description": "Retrieve de-identified patient context: active conditions, meds, recent vitals.",
        "input_schema": {"type": "object",
                         "properties": {"patient_id": {"type": "string"},
                                        "encounter_id": {"type": "string"}},
                         "required": ["patient_id"]}
    },
    {
        "name": "suggest_icd10_codes",
        "description": "Suggest ICD-10-CM codes from documented condition descriptions.",
        "input_schema": {"type": "object",
                         "properties": {"conditions": {"type": "array", "items": {"type": "string"}}},
                         "required": ["conditions"]}
    },
    {
        "name": "post_documentation_suggestions",
        "description": "Post structured suggestions back to the EHR for clinician review.",
        "input_schema": {"type": "object",
                         "properties": {
                             "encounter_id": {"type": "string"},
                             "suggestions": {"type": "array",
                                             "items": {"type": "object",
                                                       "properties": {"section": {"type": "string"},
                                                                      "suggestion": {"type": "string"},
                                                                      "rationale": {"type": "string"}}}}},
                         "required": ["encounter_id", "suggestions"]}
    }
]

def get_patient_summary(patient_id: str, encounter_id: str = None) -> dict:
    conditions = requests.get(f"{FHIR_BASE}/Condition",
        headers=FHIR_HEADERS, params={"patient": patient_id, "clinical-status": "active"}).json()
    medications = requests.get(f"{FHIR_BASE}/MedicationRequest",
        headers=FHIR_HEADERS, params={"patient": patient_id, "status": "active"}).json()
    vitals = requests.get(f"{FHIR_BASE}/Observation",
        headers=FHIR_HEADERS, params={"patient": patient_id, "category": "vital-signs",
                                       "_sort": "-date", "_count": 5}).json()
    # De-identify before returning
    summary = {
        "conditions": [deidentify(str(e.get("resource", {}).get("code", {}).get("text", "")))
                       for e in conditions.get("entry", [])],
        "medications": [deidentify(str(e.get("resource", {}).get("medicationCodeableConcept", {}).get("text", "")))
                        for e in medications.get("entry", [])],
        "recent_vitals": [deidentify(str(e.get("resource", {}).get("code", {}).get("text", "")))
                          for e in vitals.get("entry", [])]
    }
    return summary

def suggest_icd10_codes(conditions: list) -> list:
    # Stub: replace with NLM UMLS API or local ICD-10 lookup
    return [{"condition": c, "suggested_codes": ["Z00.00"]} for c in conditions]

def post_documentation_suggestions(encounter_id: str, suggestions: list) -> dict:
    # Write back to EHR as CDS cards or note suggestions (Epic-specific API)
    # This is a stub — replace with Epic's specific documentation API
    print(f"[DOC ASSIST] Encounter {encounter_id}: {len(suggestions)} suggestions posted")
    return {"encounter_id": encounter_id, "suggestions_posted": len(suggestions),
            "timestamp": datetime.now(timezone.utc).isoformat()}

TOOL_MAP = {"get_patient_summary": get_patient_summary,
            "suggest_icd10_codes": suggest_icd10_codes,
            "post_documentation_suggestions": post_documentation_suggestions}

def run_doc_assist(patient_id: str, encounter_id: str):
    messages = [{"role": "user",
                 "content": f"Assist documentation for encounter {encounter_id}. Patient: {patient_id}."}]
    while True:
        resp = client.messages.create(model=MODEL, max_tokens=2048, system=SYSTEM,
                                      tools=tools, messages=messages)
        tool_uses = [b for b in resp.content if b.type == "tool_use"]
        if resp.stop_reason == "end_turn" or not tool_uses:
            return next((b.text for b in resp.content if hasattr(b, "text")), "Done.")
        messages.append({"role": "assistant", "content": resp.content})
        results = []
        for tu in tool_uses:
            out = TOOL_MAP[tu.name](**tu.input)
            results.append({"type": "tool_result", "tool_use_id": tu.id, "content": json.dumps(out)})
        messages.append({"role": "user", "content": results})
```

---

## `incident-bridge-teams` — Incident Bridge Orchestrator

**Type:** Orchestrator | **Platform:** Microsoft Teams + Azure | **Industry:** Any

```python
"""
Agent: Incident Bridge Orchestrator
Platform: Microsoft Teams (Bot Framework) + Azure Monitor
Function: Detects Azure Monitor alerts, creates a Teams incident channel,
          pulls relevant diagnostics, coordinates responders, and drives resolution.
"""
import anthropic, requests, json, msal
from datetime import datetime, timezone

MODEL = "claude-opus-4-6"
client = anthropic.Anthropic()

TENANT_ID = "{TENANT_ID}"
CLIENT_ID = "{CLIENT_ID}"
CLIENT_SECRET = "{CLIENT_SECRET}"
TEAMS_TEAM_ID = "{INCIDENT_TEAM_ID}"
BOT_APP_ID = "{BOT_APP_ID}"
BOT_SECRET = "{BOT_SECRET}"

def get_graph_token() -> str:
    app = msal.ConfidentialClientApplication(CLIENT_ID,
        authority=f"https://login.microsoftonline.com/{TENANT_ID}",
        client_credential=CLIENT_SECRET)
    return app.acquire_token_for_client(["https://graph.microsoft.com/.default"])["access_token"]

GRAPH_BASE = "https://graph.microsoft.com/v1.0"

SYSTEM = """You are an incident response orchestrator. When an alert fires:
1. Create a dedicated Teams channel for the incident.
2. Pull diagnostics: recent errors, affected services, timeline.
3. Post a structured incident brief to the channel.
4. Identify and @mention the on-call responders.
5. Post suggested remediation steps based on the alert type.
6. Update the incident channel as new data arrives.
Never close an incident without human confirmation."""

tools = [
    {
        "name": "get_azure_alert",
        "description": "Retrieve Azure Monitor alert details.",
        "input_schema": {"type": "object",
                         "properties": {"alert_id": {"type": "string"}},
                         "required": ["alert_id"]}
    },
    {
        "name": "create_teams_channel",
        "description": "Create a new incident channel in the incident Teams team.",
        "input_schema": {"type": "object",
                         "properties": {"incident_name": {"type": "string"}},
                         "required": ["incident_name"]}
    },
    {
        "name": "post_teams_message",
        "description": "Post a message (plain text or adaptive card) to a Teams channel.",
        "input_schema": {"type": "object",
                         "properties": {
                             "channel_id": {"type": "string"},
                             "message": {"type": "string"},
                             "card": {"type": "object", "description": "Optional Adaptive Card JSON"}},
                         "required": ["channel_id", "message"]}
    },
    {
        "name": "get_on_call_responders",
        "description": "Look up who is on-call for a given service from PagerDuty/on-call schedule.",
        "input_schema": {"type": "object",
                         "properties": {"service": {"type": "string"}},
                         "required": ["service"]}
    },
    {
        "name": "get_azure_diagnostics",
        "description": "Query Azure Log Analytics for recent errors related to the affected resource.",
        "input_schema": {"type": "object",
                         "properties": {"resource_id": {"type": "string"},
                                        "minutes_back": {"type": "integer", "default": 30}},
                         "required": ["resource_id"]}
    }
]

token = get_graph_token()
graph_headers = {"Authorization": f"Bearer {token}", "Content-Type": "application/json"}

def get_azure_alert(alert_id: str) -> dict:
    r = requests.get(
        f"https://management.azure.com{alert_id}?api-version=2022-06-15",
        headers={"Authorization": f"Bearer {token}"})
    return r.json()

def create_teams_channel(incident_name: str) -> dict:
    ts = datetime.now(timezone.utc).strftime("%Y%m%d-%H%M")
    channel_name = f"INC-{ts}-{incident_name[:30]}"
    r = requests.post(f"{GRAPH_BASE}/teams/{TEAMS_TEAM_ID}/channels",
        headers=graph_headers,
        json={"displayName": channel_name, "membershipType": "standard"})
    return r.json()

def post_teams_message(channel_id: str, message: str, card: dict = None) -> dict:
    body = {"content": message, "contentType": "text"}
    if card:
        body = {"contentType": "html",
                "content": f'<attachment id="1"></attachment>'}
    payload = {"body": body}
    if card:
        payload["attachments"] = [{"id": "1", "contentType": "application/vnd.microsoft.card.adaptive",
                                   "content": json.dumps(card)}]
    r = requests.post(f"{GRAPH_BASE}/teams/{TEAMS_TEAM_ID}/channels/{channel_id}/messages",
                      headers=graph_headers, json=payload)
    return r.json()

def get_on_call_responders(service: str) -> list:
    # Stub: replace with PagerDuty API /oncalls
    return [{"name": "On-Call Engineer", "email": "oncall@company.com", "teams_id": "{TEAMS_USER_ID}"}]

def get_azure_diagnostics(resource_id: str, minutes_back: int = 30) -> dict:
    # Stub: replace with Azure Log Analytics query API
    return {"query": f"errors in last {minutes_back}m for {resource_id}", "results": []}

TOOL_MAP = {"get_azure_alert": get_azure_alert, "create_teams_channel": create_teams_channel,
            "post_teams_message": post_teams_message, "get_on_call_responders": get_on_call_responders,
            "get_azure_diagnostics": get_azure_diagnostics}

def run_incident_bridge(alert_id: str):
    messages = [{"role": "user",
                 "content": f"An Azure Monitor alert has fired: {alert_id}. "
                             f"Create an incident channel, pull diagnostics, brief the team."}]
    while True:
        resp = client.messages.create(model=MODEL, max_tokens=4096, system=SYSTEM,
                                      tools=tools, messages=messages)
        tool_uses = [b for b in resp.content if b.type == "tool_use"]
        if resp.stop_reason == "end_turn" or not tool_uses:
            return next((b.text for b in resp.content if hasattr(b, "text")), "Done.")
        messages.append({"role": "assistant", "content": resp.content})
        results = []
        for tu in tool_uses:
            out = TOOL_MAP[tu.name](**tu.input)
            results.append({"type": "tool_result", "tool_use_id": tu.id, "content": json.dumps(out)})
        messages.append({"role": "user", "content": results})
```

---

## Common Patterns Across All Templates

### Agentic Loop (standard)
```python
def run_agent(prompt: str, system: str, tools: list, tool_map: dict,
              model: str = "claude-opus-4-6", max_tokens: int = 4096) -> str:
    client = anthropic.Anthropic()
    messages = [{"role": "user", "content": prompt}]
    while True:
        resp = client.messages.create(model=model, max_tokens=max_tokens,
                                      system=system, tools=tools, messages=messages)
        tool_uses = [b for b in resp.content if b.type == "tool_use"]
        if resp.stop_reason == "end_turn" or not tool_uses:
            return next((b.text for b in resp.content if hasattr(b, "text")), "Completed.")
        messages.append({"role": "assistant", "content": resp.content})
        results = []
        for tu in tool_uses:
            fn = tool_map.get(tu.name)
            output = fn(**tu.input) if fn else {"error": f"Unknown tool: {tu.name}"}
            results.append({"type": "tool_result", "tool_use_id": tu.id,
                            "content": json.dumps(output, default=str)})
        messages.append({"role": "user", "content": results})
```

### Retry with Exponential Backoff (all API calls)
```python
import time, functools

def with_retry(max_attempts: int = 4, base_delay: float = 2.0):
    def decorator(fn):
        @functools.wraps(fn)
        def wrapper(*args, **kwargs):
            for attempt in range(max_attempts):
                try:
                    return fn(*args, **kwargs)
                except Exception as e:
                    if attempt == max_attempts - 1:
                        raise
                    delay = base_delay * (2 ** attempt)
                    print(f"[RETRY] {fn.__name__} attempt {attempt+1} failed: {e}. Retrying in {delay}s.")
                    time.sleep(delay)
        return wrapper
    return decorator

# Usage: @with_retry(max_attempts=4, base_delay=2.0)
```

### Structured Audit Log (all templates)
```python
import hashlib, json
from datetime import datetime, timezone

def audit_log(agent_id: str, action: str, inputs: dict, output: dict,
              success: bool, actor: str = "system") -> dict:
    entry = {
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "agent_id": agent_id, "action": action,
        "actor": actor, "inputs": inputs, "output": output, "success": success,
    }
    entry["checksum"] = hashlib.sha256(json.dumps(entry, sort_keys=True).encode()).hexdigest()
    # Write to your audit destination: Splunk, CloudWatch, Snowflake, immutable DB
    print(f"[AUDIT] {json.dumps(entry)}")
    return entry
```

### Human Approval Gate (mandatory for irreversible actions)
```python
def request_approval(action: str, payload: dict, channel: str = "teams") -> dict:
    """Pause execution and request human approval before proceeding.
    Returns approval decision. Agent must check before taking irreversible action."""
    approval_id = f"appr_{datetime.now(timezone.utc).strftime('%Y%m%d%H%M%S')}"
    # Send to Teams/Slack/PagerDuty/ServiceNow
    notify_human(channel, action, payload, approval_id)
    # Poll for response (or use callback/webhook pattern)
    decision = poll_for_approval(approval_id, timeout_seconds=3600)
    return {"approval_id": approval_id, "decision": decision,
            "timestamp": datetime.now(timezone.utc).isoformat()}
```
