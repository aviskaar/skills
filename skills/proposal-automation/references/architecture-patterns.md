# Enterprise Architecture Patterns by Industry

Reference guide for Phase 3 — Architecture Design. Select the appropriate base pattern for the customer's industry, then adapt using the technology stack decisions in SKILL.md Phase 3.3.

---

## Pattern Library

### Pattern A — Data Platform & Analytics (Cross-Industry)

**When to use**: Customer wants to unify siloed data, enable self-serve analytics, build a data lake, or power BI dashboards.

```
Source Systems (ERP, CRM, SaaS APIs, IoT, Files)
        │
        ▼
┌─────────────────────────────────────┐
│  Ingestion Layer                    │
│  Batch: Airbyte / AWS Glue / ADF    │
│  Stream: Kafka / Kinesis / Pub/Sub  │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│  Data Lake (Raw Zone)               │
│  S3 / ADLS Gen2 / GCS              │
│  Format: Parquet, Delta, Iceberg    │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│  Transform & Curate                 │
│  dbt / Spark / Databricks           │
│  Zones: Bronze → Silver → Gold      │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│  Serving Layer                      │
│  DWH: Snowflake / BigQuery / Redshift│
│  Semantic: dbt metrics / Cube.dev   │
│  BI: Tableau / Power BI / Looker    │
└─────────────────────────────────────┘
```

**Key decisions**: Medallion architecture vs Kappa vs Lambda. Real-time vs batch latency SLA.

---

### Pattern B — Microservices Platform (SaaS / Digital Products)

**When to use**: Customer is building or modernizing an application that needs to scale independently, release frequently, and support multiple client types.

```
Client Apps (Web, Mobile, 3rd-party)
        │
        ▼
┌─────────────────────────────────────┐
│  API Gateway + Auth                 │
│  Kong / AWS API GW / Azure APIM     │
│  JWT / OAuth2 / mTLS                │
└──────────────┬──────────────────────┘
               │
    ┌──────────┼──────────┐
    ▼          ▼          ▼
Service A   Service B   Service C
(Bounded Contexts — Domain-Driven Design)
    │          │          │
    └──────────┼──────────┘
               ▼
┌─────────────────────────────────────┐
│  Event Bus                          │
│  Kafka / AWS EventBridge / NATS     │
└──────────────┬──────────────────────┘
               ▼
┌─────────────────────────────────────┐
│  Data Stores (per service)          │
│  PostgreSQL / DynamoDB / Redis      │
│  MongoDB / Elasticsearch            │
└─────────────────────────────────────┘
```

**Key decisions**: Domain boundaries (DDD), synchronous vs async communication, saga vs 2PC for distributed transactions.

---

### Pattern C — AI/ML Platform

**When to use**: Customer wants predictive analytics, generative AI, LLM-powered features, or automated decision-making embedded in their workflows.

```
Data Sources → Feature Store → Model Training
                    │                │
                    ▼                ▼
              Feature Pipeline   MLflow / Model Registry
                    │                │
                    └──────┬─────────┘
                           ▼
                   Model Serving Layer
                   (SageMaker / Vertex AI / BentoML)
                           │
              ┌────────────┼────────────┐
              ▼            ▼            ▼
         Real-time     Batch         GenAI
         Inference    Scoring     (LLM APIs /
         (REST API)  (Scheduled)   RAG / Agents)
              │            │            │
              └────────────┼────────────┘
                           ▼
                   Application Layer
                   (Embed predictions into workflows)
```

**Key decisions**: Build vs buy model, fine-tuning vs RAG vs prompt engineering, online vs offline inference, MLOps maturity.

**GenAI / RAG Sub-Pattern**:
```
Documents / Knowledge Base
        │
        ▼
Chunking + Embedding (OpenAI / Cohere / local)
        │
        ▼
Vector Store (Pinecone / Weaviate / pgvector)
        │
   ┌────┴────┐
   │  Retrieval│◄── User Query
   └────┬────┘
        ▼
   LLM + Prompt (Claude / GPT-4 / Llama)
        │
        ▼
   Response (grounded in retrieved context)
```

---

### Pattern D — System Integration / ESB (Enterprise Legacy Modernization)

**When to use**: Customer has legacy systems (mainframe, SAP, Oracle EBS, Salesforce) that need to be connected without a full rip-and-replace.

```
Legacy Systems (Mainframe, SAP, Oracle)
        │
        ▼
┌─────────────────────────────────────┐
│  Integration Platform               │
│  MuleSoft / Azure Logic Apps / Boomi │
│  IBM App Connect / AWS Step Fns     │
└──────────────┬──────────────────────┘
               │
    ┌──────────┼──────────┐
    ▼          ▼          ▼
CRM         ERP         External
(Salesforce)(SAP S/4)  (Partner APIs)
```

**Key decisions**: API-led connectivity vs ESB, real-time vs batch sync, data canonicalization model, error handling and retry strategy.

---

### Pattern E — IoT / Edge + Cloud (Manufacturing, Logistics, Healthcare Devices)

**When to use**: Customer has physical devices, sensors, or edge infrastructure generating data that needs to flow into cloud for processing and action.

```
Physical World
(Sensors, Machines, Devices)
        │
        ▼
Edge Compute (Greengrass / Azure IoT Edge)
        │
        ▼ (MQTT / AMQP / HTTP)
IoT Ingestion (AWS IoT Core / Azure IoT Hub)
        │
        ▼
Stream Processing (Kinesis / Event Hub)
        │
   ┌────┴────────────────┐
   ▼                     ▼
Real-time Actions    Time-Series DB
(Alerts, Control)   (InfluxDB / Timestream)
                         │
                         ▼
                   Analytics & Dashboards
```

---

### Pattern F — Multi-Tenant SaaS Platform

**When to use**: Building a product to be sold to multiple enterprise customers, requiring isolation, custom branding, and per-tenant billing.

**Isolation models** (choose based on compliance requirements):

| Model | Isolation | Cost | Compliance |
|---|---|---|---|
| Silo (per-tenant infra) | Full | High | Best (HIPAA, FedRAMP) |
| Pool (shared infra, tenant ID) | Logical | Low | Good for most |
| Bridge (shared app, isolated DB) | DB-level | Medium | Good (SOC 2) |

**Additional concerns**: Tenant onboarding automation, feature flags per tier, usage metering, dunning/billing integration.

---

## Cross-Cutting Concerns (Apply to All Patterns)

### Observability Stack (Standard)
```
Application Instrumentation (OpenTelemetry SDK)
        │
        ▼
  ┌─────┬──────┬────────┐
  │Logs │Metrics│Traces  │
  ▼     ▼      ▼
CloudWatch / Datadog / Grafana Stack
        │
        ▼
Alerting → PagerDuty / OpsGenie
```

### CI/CD Pipeline (Standard)
```
Developer Push → PR Review → Automated Tests
                                    │
                          ┌─────────┼──────────┐
                          ▼         ▼          ▼
                     Unit Tests  Integration  Security
                                  Tests       Scan (SAST/DAST)
                                    │
                                    ▼
                             Deploy to Staging
                                    │
                             Smoke Tests Pass?
                                    │ YES
                                    ▼
                             Deploy to Production
                             (Blue/Green or Canary)
```

### Security Baseline (Always Include)
- **Identity**: Okta / Azure AD / AWS IAM Identity Center (SSO + MFA mandatory)
- **Secrets**: HashiCorp Vault / AWS Secrets Manager / Azure Key Vault
- **Network**: VPC + private subnets + NAT + WAF + DDoS (CloudFront / Shield)
- **Data**: Encryption at rest (AES-256) + in transit (TLS 1.2+)
- **Audit**: CloudTrail / Azure Monitor / GCP Audit Logs → SIEM
- **Vulnerability**: Snyk / Dependabot for dependency scanning; Trivy for container images
- **Pen Test**: Recommend annual external pen test; quarterly internal scan

---

## Compliance Mapping

| Regulation | Key Controls | Common Patterns |
|---|---|---|
| **HIPAA** | PHI encryption, audit logs, BAA with vendors, minimum necessary | Pattern E (IoT), Pattern F (SaaS) with Silo isolation |
| **SOC 2 Type II** | CC6 (logical access), CC7 (monitoring), CC8 (change mgmt) | All patterns; requires evidence collection tooling |
| **GDPR** | Data residency (EU), right to erasure, DPA agreements | Pattern A (data lake must support PII tagging + deletion) |
| **PCI-DSS** | Network segmentation, no cardholder data in logs, quarterly scans | Pattern B (payment service isolated in its own VPC) |
| **FedRAMP** | ATO process, FIPS 140-2, US-only cloud regions | Pattern F Silo model; GovCloud regions only |

---

## Architecture Decision Record (ADR) Template

For each major architectural decision, document:

```markdown
## ADR-[NNN]: [Decision Title]

**Date**: [YYYY-MM-DD]
**Status**: Proposed / Accepted / Deprecated

**Context**
[Why this decision needs to be made]

**Decision**
[What was decided]

**Rationale**
[Why this option was chosen over alternatives]

**Alternatives Considered**
- Option A: [pros/cons]
- Option B: [pros/cons]

**Consequences**
- Positive: [benefits]
- Negative: [trade-offs accepted]
- Risks: [risks introduced]
```
