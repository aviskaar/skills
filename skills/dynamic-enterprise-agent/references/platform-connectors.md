# Platform Connectors Reference

Full API and connector details per platform for dynamic enterprise agent generation.

---

## ServiceNow

**Agent Entry Points:** Flow Designer, Scripted REST, NLU Virtual Agent

### Authentication
```python
import requests

SN_INSTANCE = "https://{instance}.service-now.com"
headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
}
auth = ("{username}", "{password}")  # or OAuth2 bearer token

# OAuth2 (preferred)
token_res = requests.post(f"{SN_INSTANCE}/oauth_token.do", data={
    "grant_type": "password",
    "client_id": CLIENT_ID,
    "client_secret": CLIENT_SECRET,
    "username": USERNAME,
    "password": PASSWORD,
})
access_token = token_res.json()["access_token"]
headers["Authorization"] = f"Bearer {access_token}"
```

### Key APIs
| Operation | Endpoint | Method |
|-----------|----------|--------|
| Query records | `/api/now/table/{table}` | GET |
| Create record | `/api/now/table/{table}` | POST |
| Update record | `/api/now/table/{table}/{sys_id}` | PATCH |
| Scripted REST | `/api/{scope}/{api_name}/{version}/{resource}` | ANY |
| Attachments | `/api/now/attachment` | GET/POST |
| Import sets | `/api/now/import/{staging_table}` | POST |

### Common Tables
- `incident` — ITSM incidents
- `sc_request` / `sc_req_item` — service catalog requests
- `change_request` — change management
- `sn_customerservice_case` — customer service
- `cmdb_ci` — configuration items
- `sys_user` / `sys_user_group` — users and groups

### GlideRecord (server-side)
```javascript
var gr = new GlideRecord('incident');
gr.addQuery('state', 1);        // New
gr.addQuery('priority', '<=', 2);  // P1/P2
gr.orderByDesc('sys_created_on');
gr.setLimit(50);
gr.query();
while (gr.next()) {
    gs.log(gr.sys_id + ' — ' + gr.short_description);
}
```

### Webhook / Outbound REST
```javascript
// Call external AI agent from ServiceNow
var rm = new sn_ws.RESTMessageV2();
rm.setEndpoint('https://your-agent-host/invoke');
rm.setHttpMethod('POST');
rm.setRequestHeader('Authorization', 'Bearer ' + gs.getProperty('agent.api.key'));
rm.setRequestBody(JSON.stringify({ sys_id: current.sys_id.toString() }));
var response = rm.execute();
```

---

## Salesforce

**Agent Entry Points:** Einstein Copilot, Agentforce, Apex, Flow, MuleSoft

### Authentication
```python
from simple_salesforce import Salesforce

# Username/Password + Security Token
sf = Salesforce(username=USERNAME, password=PASSWORD, security_token=TOKEN)

# OAuth2 JWT Bearer (server-to-server)
import jwt, time, requests
claim = {"iss": CLIENT_ID, "sub": USERNAME, "aud": "https://login.salesforce.com",
         "exp": int(time.time()) + 300}
assertion = jwt.encode(claim, PRIVATE_KEY, algorithm="RS256")
res = requests.post("https://login.salesforce.com/services/oauth2/token",
    data={"grant_type": "urn:ietf:params:oauth:grant-type:jwt-bearer",
          "assertion": assertion})
access_token = res.json()["access_token"]
instance_url = res.json()["instance_url"]
```

### Key APIs
| Operation | Endpoint | Method |
|-----------|----------|--------|
| SOQL query | `/services/data/v59.0/query?q={soql}` | GET |
| Create record | `/services/data/v59.0/sobjects/{Object}/` | POST |
| Update record | `/services/data/v59.0/sobjects/{Object}/{id}` | PATCH |
| Bulk API v2 | `/services/data/v59.0/jobs/ingest` | POST |
| Platform Events | `/services/data/v59.0/sobjects/{Event__e}/` | POST |
| Streaming API | `/cometd/59.0` | CometD |

### Common Objects
- `Lead`, `Contact`, `Account`, `Opportunity` — CRM core
- `Case` — service management
- `Task`, `Event` — activity
- `ContentDocument`, `ContentVersion` — files
- Custom objects: `{Name}__c`

### Apex (platform-native)
```apex
@RestResource(urlMapping='/agent/invoke/*')
global class AgentRestResource {
    @HttpPost
    global static void doPost() {
        RestRequest req = RestContext.request;
        Map<String,Object> body = (Map<String,Object>) JSON.deserializeUntyped(req.requestBody.toString());
        String recordId = (String) body.get('record_id');
        // Enqueue async callout
        System.enqueueJob(new AgentCalloutQueueable(recordId));
    }
}
```

### MuleSoft Connector
```yaml
# anypoint-connector config
salesforce:
  config:
    connection:
      authorizationUrl: "https://login.salesforce.com/services/oauth2/authorize"
      accessTokenUrl: "https://login.salesforce.com/services/oauth2/token"
      consumerKey: "${sfdc.consumer.key}"
      consumerSecret: "${sfdc.consumer.secret}"
```

---

## Workday

**Agent Entry Points:** Extend (REST), Prism Analytics, Studio

### Authentication
```python
import requests
from requests.auth import HTTPBasicAuth

WORKDAY_BASE = "https://{tenant}.workday.com/ccx/api"
TENANT = "{tenant}"

# OAuth2 Client Credentials
res = requests.post(f"https://{TENANT}.workday.com/ccx/oauth2/{TENANT}/token",
    auth=HTTPBasicAuth(CLIENT_ID, CLIENT_SECRET),
    data={"grant_type": "client_credentials"})
access_token = res.json()["access_token"]
headers = {"Authorization": f"Bearer {access_token}"}
```

### Key APIs
| Operation | Endpoint | Method |
|-----------|----------|--------|
| Worker data | `/v1/{tenant}/workers` | GET |
| Job profiles | `/v1/{tenant}/jobProfiles` | GET |
| Org hierarchy | `/v1/{tenant}/organizations` | GET |
| Business processes | `/v1/{tenant}/businessProcesses` | GET/POST |
| Prism data upload | `/v1/{tenant}/datasets` | POST |
| Extend REST | `/v1/{tenant}/{custom-resource}` | ANY |

### Workday Studio (orchestration)
```xml
<!-- Sample Studio integration for HR event trigger -->
<wd:integration xmlns:wd="urn:com.workday/bsvc">
  <wd:Integration_Service_Reference>
    <wd:ID wd:type="Integration_Service_ID">HR_Agent_Trigger</wd:ID>
  </wd:Integration_Service_Reference>
</wd:integration>
```

---

## SAP

**Agent Entry Points:** BTP AI Core, S/4HANA APIs, Build Process Automation

### Authentication
```python
import requests

# SAP BTP OAuth2
res = requests.post(f"https://{SUBACCOUNT}.authentication.{REGION}.hana.ondemand.com/oauth/token",
    auth=(CLIENT_ID, CLIENT_SECRET),
    data={"grant_type": "client_credentials"})
access_token = res.json()["access_token"]

# S/4HANA OData
ODATA_BASE = f"https://{S4_HOST}/sap/opu/odata/sap"
headers = {"Authorization": f"Bearer {access_token}", "Accept": "application/json"}
```

### Key APIs
| System | Endpoint | Capability |
|--------|----------|-----------|
| S/4HANA | `/API_PURCHASEORDER_PROCESS_SRV` | Purchase orders |
| S/4HANA | `/API_BUSINESS_PARTNER` | Vendor/customer master |
| S/4HANA | `/API_FINANCIALPLANDATA_0001` | Finance planning |
| BTP AI Core | `/v2/inference/deployments/{id}/chat/completions` | LLM inference |
| BTP Workflow | `/workflow/rest/v1/workflow-instances` | Process orchestration |
| Build PA | `/workflow-service/rest/v1/xsrf-token` | RPA triggers |

### RFC / BAPI (via PyRFC)
```python
from pyrfc import Connection

conn = Connection(ashost=SAP_HOST, sysnr='00', client='100',
                  user=USERNAME, passwd=PASSWORD)

# Call BAPI
result = conn.call('BAPI_PO_GETDETAIL', PURCHASEORDER='4500012345')
items = result['POITEM']
```

---

## Snowflake

**Agent Entry Points:** Cortex AI, Snowpark, Tasks, Streams

### Authentication
```python
from snowflake.snowpark import Session

session = Session.builder.configs({
    "account":   SNOWFLAKE_ACCOUNT,
    "user":      SNOWFLAKE_USER,
    "private_key": PRIVATE_KEY,   # key-pair auth (preferred)
    "role":      "AGENT_ROLE",
    "warehouse": "AGENT_WH",
    "database":  "ANALYTICS",
    "schema":    "AGENT",
}).create()
```

### Cortex AI Functions
```sql
-- LLM inference natively in Snowflake
SELECT SNOWFLAKE.CORTEX.COMPLETE('claude-opus-4-6',
    CONCAT('Classify this support ticket: ', TICKET_TEXT)) AS classification
FROM SUPPORT_TICKETS
WHERE PROCESSED = FALSE;

-- Sentiment analysis
SELECT SNOWFLAKE.CORTEX.SENTIMENT(REVIEW_TEXT) AS sentiment_score
FROM PRODUCT_REVIEWS;

-- Text embeddings for similarity search
SELECT SNOWFLAKE.CORTEX.EMBED_TEXT_768('e5-base-v2', DOCUMENT_TEXT) AS embedding
FROM KNOWLEDGE_BASE;
```

### Streams and Tasks (event-driven)
```sql
-- Stream captures changes
CREATE STREAM agent_trigger_stream ON TABLE source_events;

-- Task runs agent on new data
CREATE TASK run_agent_task
  WAREHOUSE = AGENT_WH
  SCHEDULE = '1 minute'
  WHEN SYSTEM$STREAM_HAS_DATA('agent_trigger_stream')
AS
  CALL agent_stored_proc();
```

### Snowpark (Python UDFs)
```python
from snowflake.snowpark.functions import udf
from snowflake.snowpark.types import StringType
import anthropic

@udf(name="classify_record", return_type=StringType(),
     input_types=[StringType()], packages=["anthropic"])
def classify_record(record_text: str) -> str:
    client = anthropic.Anthropic()
    response = client.messages.create(
        model="claude-opus-4-6", max_tokens=256,
        messages=[{"role": "user", "content": f"Classify: {record_text}"}])
    return response.content[0].text
```

---

## Microsoft 365 / Azure / Teams

**Agent Entry Points:** Copilot Studio, Power Automate, Azure AI, Teams bots

### Authentication (MSAL)
```python
import msal

app = msal.ConfidentialClientApplication(
    CLIENT_ID, authority=f"https://login.microsoftonline.com/{TENANT_ID}",
    client_credential=CLIENT_SECRET)

token = app.acquire_token_for_client(scopes=["https://graph.microsoft.com/.default"])
access_token = token["access_token"]
headers = {"Authorization": f"Bearer {access_token}"}
```

### Microsoft Graph API
| Operation | Endpoint | Method |
|-----------|----------|--------|
| Send Teams message | `/v1.0/teams/{id}/channels/{id}/messages` | POST |
| Create Teams card | `/v1.0/chats/{id}/messages` | POST |
| Read emails | `/v1.0/users/{id}/messages` | GET |
| Create calendar event | `/v1.0/users/{id}/calendar/events` | POST |
| Get SharePoint files | `/v1.0/sites/{id}/drive/items` | GET |
| Manage user | `/v1.0/users/{id}` | GET/PATCH |

### Adaptive Card (Teams approval)
```json
{
  "type": "AdaptiveCard",
  "version": "1.4",
  "body": [
    {"type": "TextBlock", "text": "Agent requires approval", "weight": "bolder"},
    {"type": "TextBlock", "text": "${context}", "wrap": true}
  ],
  "actions": [
    {"type": "Action.Http", "title": "Approve", "method": "POST",
     "url": "${approval_webhook}", "body": "{\"decision\":\"approve\"}"},
    {"type": "Action.Http", "title": "Reject", "method": "POST",
     "url": "${approval_webhook}", "body": "{\"decision\":\"reject\"}"}
  ]
}
```

### Azure AI Foundry
```python
from azure.ai.inference import ChatCompletionsClient
from azure.core.credentials import AzureKeyCredential

client = ChatCompletionsClient(
    endpoint=f"https://{AI_FOUNDRY_RESOURCE}.services.ai.azure.com/models",
    credential=AzureKeyCredential(API_KEY))

response = client.complete(model="claude-opus-4-6",
    messages=[{"role": "user", "content": event_payload}])
```

---

## AWS

**Agent Entry Points:** Bedrock Agents, Lambda, Step Functions, Connect

### Authentication
```python
import boto3

# IAM role-based (preferred in Lambda/ECS)
bedrock = boto3.client("bedrock-runtime", region_name="us-east-1")
lambda_client = boto3.client("lambda")
sfn = boto3.client("stepfunctions")
```

### Bedrock Agents
```python
# Invoke Bedrock Agent
bedrock_agent = boto3.client("bedrock-agent-runtime")
response = bedrock_agent.invoke_agent(
    agentId=AGENT_ID,
    agentAliasId=ALIAS_ID,
    sessionId=SESSION_ID,
    inputText=event_text)

# Invoke Claude via Bedrock
response = bedrock.invoke_model(
    modelId="anthropic.claude-opus-4-6-20250514-v1:0",
    body=json.dumps({"messages": [{"role": "user", "content": prompt}],
                     "max_tokens": 4096, "anthropic_version": "bedrock-2023-05-31"}))
```

### Lambda handler pattern
```python
def lambda_handler(event, context):
    """Standard Lambda entry point for agent triggers."""
    source = event.get("source", "unknown")
    if source == "aws.events":          # EventBridge scheduled
        records = fetch_pending_records()
    elif "Records" in event:            # SQS / SNS / S3
        records = [json.loads(r["body"]) for r in event["Records"]]
    else:                               # Direct invoke / API Gateway
        records = [event]

    results = [run_agent(r) for r in records]
    return {"statusCode": 200, "body": json.dumps(results)}
```

### Step Functions (orchestrator)
```json
{
  "Comment": "Enterprise agent orchestration",
  "StartAt": "FetchContext",
  "States": {
    "FetchContext": {"Type": "Task", "Resource": "arn:aws:lambda:::function:fetch-context",
                     "Next": "ReasonAndAct"},
    "ReasonAndAct": {"Type": "Task", "Resource": "arn:aws:lambda:::function:agent-core",
                     "Next": "HumanApproval?"},
    "HumanApproval?": {"Type": "Choice", "Choices": [
        {"Variable": "$.requires_approval", "BooleanEquals": true, "Next": "WaitForApproval"}],
      "Default": "TakeAction"},
    "WaitForApproval": {"Type": "Task", "Resource": "arn:aws:states:::sqs:sendMessage.waitForTaskToken",
                        "Next": "TakeAction"},
    "TakeAction": {"Type": "Task", "Resource": "arn:aws:lambda:::function:take-action", "End": true}
  }
}
```

---

## Okta / Azure Entra ID

**Agent Entry Points:** Hooks, Workflows, SCIM, Graph API

### Authentication
```python
import requests

# Okta API token
okta_headers = {"Authorization": f"SSWS {OKTA_API_TOKEN}",
                "Content-Type": "application/json"}
OKTA_BASE = f"https://{OKTA_DOMAIN}/api/v1"

# Azure Entra (via MSAL — same as MS Graph above)
```

### Key Okta APIs
| Operation | Endpoint | Method |
|-----------|----------|--------|
| List users | `/users` | GET |
| Get user | `/users/{id}` | GET |
| Activate user | `/users/{id}/lifecycle/activate` | POST |
| Suspend user | `/users/{id}/lifecycle/suspend` | POST |
| Assign app | `/apps/{appId}/users` | POST |
| Group membership | `/groups/{id}/users` | GET/POST/DELETE |
| List factors | `/users/{id}/factors` | GET |

### Okta Event Hook (inbound trigger)
```python
@app.route("/okta/hook", methods=["POST"])
def okta_event_hook():
    # Validate Okta signature
    events = request.json.get("data", {}).get("events", [])
    for event in events:
        event_type = event.get("eventType")
        if event_type == "user.lifecycle.create":
            actor = event["actor"]["displayName"]
            target = event["target"][0]["displayName"]
            run_agent({"event": event_type, "actor": actor, "target": target})
    return jsonify({"success": True})
```

---

## CyberArk / BeyondTrust

**Agent Entry Points:** REST API, CPM plugins, session hooks

### CyberArk PAM REST API
```python
import requests

PVWA_BASE = f"https://{PVWA_HOST}/PasswordVault/api"

# Authenticate
auth_res = requests.post(f"{PVWA_BASE}/auth/CyberArk/Logon",
    json={"username": USERNAME, "password": PASSWORD})
session_token = auth_res.json()

headers = {"Authorization": session_token}

# Retrieve account credentials (for agent use only — logged)
account = requests.get(f"{PVWA_BASE}/Accounts?search={SYSTEM_NAME}", headers=headers).json()
account_id = account["value"][0]["id"]
credential = requests.post(f"{PVWA_BASE}/Accounts/{account_id}/GetPassword",
    headers=headers, json={"reason": "Agent automated rotation"}).json()
```

### Key APIs
| Operation | Endpoint |
|-----------|----------|
| List accounts | `GET /Accounts` |
| Get password | `POST /Accounts/{id}/GetPassword` |
| Rotate credential | `POST /Accounts/{id}/ChangeCredentialsImmediately` |
| Get sessions | `GET /LiveSessions` |
| Terminate session | `POST /LiveSessions/{id}/Terminate` |

---

## Palo Alto / Zscaler (SIEM/SOAR)

**Agent Entry Points:** XSOAR, Cortex, ZIA API

### Cortex XSOAR REST API
```python
import demisto_client

client = demisto_client.configure(
    base_url=XSOAR_URL, api_key=XSOAR_API_KEY, verify_ssl=False)

# Create incident
incident = client.create_incident(
    name="Agent-detected anomaly",
    type="Network Anomaly",
    severity=2,
    details=json.dumps(event_context))

# Run playbook
client.execute_command("RunPlaybook",
    args={"id": incident.id, "playbook": "Investigate Network Anomaly"})
```

### Zscaler ZIA API
```python
headers = {"Content-Type": "application/json"}
session = requests.post(f"https://{ZIA_BASE_URL}/api/v1/authenticatedSession",
    json={"apiKey": api_key, "username": username, "password": password,
          "timestamp": str(int(time.time() * 1000))},
    headers=headers)

# Block URL category
requests.post(f"https://{ZIA_BASE_URL}/api/v1/urlCategories",
    headers={**headers, "Cookie": session.headers["Set-Cookie"]},
    json={"customCategory": True, "urls": [malicious_url], "id": "CUSTOM_01"})
```

---

## Splunk / QRadar

**Agent Entry Points:** SOAR, Adaptive Response, REST API

### Splunk REST API
```python
import splunklib.client as splunk_client
import splunklib.results as results

service = splunk_client.connect(
    host=SPLUNK_HOST, port=8089, username=USERNAME, password=PASSWORD,
    autologin=True)

# Run search
job = service.jobs.create(
    f'search index=main sourcetype=security earliest=-1h | stats count by src_ip | where count > 100',
    exec_mode="blocking")

for result in results.JSONResultsReader(job.results(output_mode="json")):
    run_agent({"type": "splunk_alert", "data": dict(result)})
```

### Splunk SOAR (Phantom) Action
```python
def on_start(container):
    phantom.act("run query", parameters=[{"query": "select * from events"}],
                assets=["splunk"], callback=analyze_results)

def analyze_results(action, success, container, results, handle):
    for r in results[0]["action_results"]:
        phantom.act("create ticket", parameters=[{"description": str(r)}],
                    assets=["servicenow"])
```

---

## Epic / Cerner (Clinical)

**Agent Entry Points:** FHIR R4 API, CDS Hooks, SMART on FHIR

### SMART on FHIR Authentication
```python
import requests

# SMART backend services (system-to-system)
import jwt, time, uuid

claim = {
    "iss": CLIENT_ID, "sub": CLIENT_ID,
    "aud": f"https://{EPIC_BASE}/oauth2/token",
    "jti": str(uuid.uuid4()),
    "exp": int(time.time()) + 300
}
assertion = jwt.encode(claim, PRIVATE_KEY, algorithm="RS384")

token_res = requests.post(f"https://{EPIC_BASE}/oauth2/token", data={
    "grant_type": "client_credentials",
    "client_assertion_type": "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
    "client_assertion": assertion,
    "scope": "system/Patient.read system/Observation.read"
})
access_token = token_res.json()["access_token"]
```

### FHIR R4 Key Resources
| Resource | Endpoint | Use |
|----------|----------|-----|
| Patient | `/Patient/{id}` | Demographics |
| Encounter | `/Encounter?patient={id}` | Visits |
| Observation | `/Observation?patient={id}&category=vital-signs` | Vitals/labs |
| MedicationRequest | `/MedicationRequest?patient={id}` | Orders |
| Condition | `/Condition?patient={id}` | Diagnoses |
| DiagnosticReport | `/DiagnosticReport?patient={id}` | Lab/imaging reports |
| AllergyIntolerance | `/AllergyIntolerance?patient={id}` | Allergies |
| CarePlan | `/CarePlan?patient={id}` | Care plans |

### CDS Hooks
```python
@app.route("/cds-hooks/patient-view", methods=["POST"])
def patient_view_hook():
    hook_data = request.json
    patient_id = hook_data["context"]["patientId"]
    fhir_token = hook_data["fhirAuthorization"]["access_token"]
    # Run agent with patient context — PII stays within FHIR boundary
    recommendation = run_clinical_agent(patient_id, fhir_token)
    return jsonify({
        "cards": [{"summary": recommendation["summary"],
                   "indicator": "info",
                   "source": {"label": "AI Clinical Support"}}]
    })
```

---

## Veeva / Medidata (Life Sciences)

**Agent Entry Points:** Vault REST API, Rave Web Services

### Veeva Vault REST API
```python
import requests

# Authenticate
auth = requests.post(f"https://{VAULT_DNS}/api/v24.1/auth",
    data={"username": USERNAME, "password": PASSWORD})
session_id = auth.json()["sessionId"]
headers = {"Authorization": session_id, "Content-Type": "application/json"}

# Query documents
docs = requests.get(f"https://{VAULT_DNS}/api/v24.1/query",
    headers=headers, params={"q": "SELECT id, name__v, status__v FROM documents"})

# Trigger workflow action
requests.post(f"https://{VAULT_DNS}/api/v24.1/objects/documents/{doc_id}/lifecycle_actions/submit_for_review",
    headers=headers)
```

### Medidata Rave Web Services
```python
import requests

rave_base = f"https://{RAVE_URL}/RaveWebServices"
headers = {"Authorization": f"Basic {base64_credentials}"}

# Get subjects
subjects = requests.get(f"{rave_base}/datasets/regular.json?dataset=Subjects",
    headers=headers).json()

# Post data point
requests.post(f"{rave_base}/studies/{STUDY_OID}/sites/{SITE_OID}/subjects/{SUBJECT_KEY}/forms",
    headers={**headers, "Content-Type": "application/json"},
    json={"FormOID": "AE", "DataPoints": [{"FieldOID": "AETERM", "Value": adverse_event_term}]})
```

---

## Bloomberg / FactSet (Quant Finance)

**Agent Entry Points:** B-PIPE, Server API, Open FactSet

### Bloomberg B-PIPE (blpapi)
```python
import blpapi

session = blpapi.Session()
session.start()
session.openService("//blp/refdata")
ref_data_service = session.getService("//blp/refdata")

# Real-time subscription
subscription_list = blpapi.SubscriptionList()
subscription_list.add("AAPL US Equity", ["LAST_PRICE", "BID", "ASK"],
                       interval=0.5, correlationId=blpapi.CorrelationId(1))
session.subscribe(subscription_list)
```

### FactSet API
```python
from fds.sdk.FactSetPrices import ApiClient, Configuration, PricesApi

config = Configuration(username=FACTSET_USER, password=FACTSET_API_KEY)
with ApiClient(config) as client:
    api = PricesApi(client)
    response = api.get_security_prices(
        ids=["AAPL-US"], start_date="2024-01-01", end_date="2024-12-31",
        frequency="D", currency="USD")
```

---

## Shopify / Salesforce Commerce Cloud (Retail)

### Shopify Admin API
```python
import shopify

shopify.Session.setup(api_key=API_KEY, secret=API_SECRET)
session = shopify.Session(SHOP_URL, API_VERSION, ACCESS_TOKEN)
shopify.ShopifyResource.activate_session(session)

# Query orders
orders = shopify.Order.find(status="open", limit=50)
for order in orders:
    if float(order.total_price) > 1000:
        run_agent({"type": "high_value_order", "order_id": order.id, "total": order.total_price})
```

### Shopify Webhooks
```python
@app.route("/webhook/orders/create", methods=["POST"])
def order_created():
    # Verify HMAC
    data = request.get_json()
    run_agent({"event": "order.created", "order": data})
    return "", 200
```

---

## Connector Quick-Reference

| Platform | SDK / Library | Auth Method | Rate Limit |
|----------|--------------|-------------|------------|
| ServiceNow | `requests` + REST | OAuth2 / Basic | 10K req/hr |
| Salesforce | `simple-salesforce` | OAuth2 JWT | 100K req/24hr |
| Workday | `requests` | OAuth2 CC | Per-tenant |
| SAP | `pyrfc`, `requests` | OAuth2 / Basic | Per-system |
| Snowflake | `snowflake-snowpark-python` | Key-pair / OAuth | Warehouse limits |
| Microsoft | `msal`, `msgraph-sdk` | MSAL OAuth2 | 10K req/10min |
| AWS | `boto3` | IAM Role / AKSK | Service-specific |
| Okta | `okta-sdk-python` | API Token / OAuth2 | 10K req/min |
| CyberArk | `requests` | Session Token | Per-PVWA |
| Splunk | `splunk-sdk` | Token / Basic | 50 concurrent |
| Epic | `requests` | SMART JWT | Per-endpoint |
| Veeva | `requests` | Session ID | 1K req/5min |
| Bloomberg | `blpapi` | Service Agreement | Market hours |
| Shopify | `ShopifyAPI` | OAuth2 / Token | 40 req/app/sec |
