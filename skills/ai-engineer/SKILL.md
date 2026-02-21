---
name: ai-engineer
description: Use this skill when a research paper or research team output needs to be transformed into a working full-stack product. Activate when the task involves bridging research findings into production software — including writing a PRD, selecting a tech stack, designing AI/ML integration, building UI and backend, and scaling the system. This skill coordinates with the research lead and researcher team throughout, acting as the engineering counterpart to the research pipeline.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: engineering, full-stack, ai, product, prd, tech-stack, ui, backend, scaling, research-to-product
  sub-skills:
    - lead-researcher
    - literature-synthesis
    - research-paper-review
---

# AI Engineer

Bridge research and production: partner with the research lead and researcher team to transform a research paper or set of research findings into a deployed, scalable full-stack application.

---

## Overview

The AI Engineer skill is the engineering counterpart to the research pipeline. Where `lead-researcher` orchestrates the science, this skill orchestrates the build. It runs alongside the research team — not after them — consulting the research lead at every critical junction and translating research outputs into product requirements, architecture decisions, working code, and production-ready services.

**Pipeline stages:**

```
1. Research Onboarding & Researcher Consultation
       ↓
2. PRD Creation
       ↓
3. Tech Stack Architecture
       ↓
4. AI/ML Integration Design          [← continuous research-team touchpoint]
       ↓
5. UI Development
       ↓
6. Backend Development
       ↓
7. Integration, Testing & QA
       ↓
8. Scaling & Production Hardening
       ↓
9. Handoff & Knowledge Transfer
```

All stages involve active collaboration with the research lead. Stages 1, 4, and 8 have explicit decision gates requiring research-lead sign-off before proceeding.

---

## Stage 1 — Research Onboarding & Researcher Consultation

**Trigger:** Always first. Do not write a single line of product spec or code before completing this stage.

### Required inputs — collect from the research lead

| # | Question | Why it matters |
|---|----------|----------------|
| 1 | What is the core research contribution? (One sentence) | Anchors the entire product definition |
| 2 | What is the paper or research artifact? (Title, link, or summary) | Feeds into literature-synthesis and research-paper-review if needed |
| 3 | Who is the intended end-user of the product? | Drives UI/UX decisions |
| 4 | What is the key model, algorithm, or method to embed in the product? | Gates AI integration design in Stage 4 |
| 5 | Are there existing baselines, datasets, or trained models available? | Determines build vs. integrate decisions |
| 6 | What are the hard constraints? (latency, cost, privacy, compliance) | Eliminates tech stack options early |
| 7 | What is the definition of a successful MVP? | Sets the scope for stages 5–7 |
| 8 | What are the compute and deployment environment constraints? | Drives cloud and infra decisions |

### Research team touchpoints to establish

- **Research Lead**: Primary decision authority on model fidelity, research correctness, and scope
- **Researcher Team**: Day-to-day collaborators on model APIs, data formats, evaluation metrics, and edge-case behavior
- **Communication cadence**: Define sync frequency (e.g., daily stand-up, async PRs, weekly review)

### Output of Stage 1

Produce a **Research-to-Product Brief** (markdown, ~1 page):
- Core research contribution (one sentence)
- Product vision (one paragraph)
- Target user and their primary job-to-be-done
- Key AI/ML component to embed
- MVP scope (what is in, what is explicitly out)
- Hard constraints list
- Research team contacts and sync cadence

**Decision gate:** Get explicit sign-off from the research lead before proceeding to Stage 2.

---

## Stage 2 — PRD Creation

**Reference:** `references/prd-template.md` for full PRD structure.

**Trigger:** After Stage 1 sign-off.

### Actions

1. **Problem Statement**: Translate the research contribution into a user-facing problem being solved. Avoid research jargon; write from the user's perspective.
2. **Goals and Success Metrics**: Define 3–5 measurable success criteria. At least one must be tied to the AI/ML component's performance (e.g., accuracy threshold, latency budget).
3. **User Stories**: Write user stories in the format `As a [user], I want to [action] so that [outcome]`. Cover the core AI-powered workflow end-to-end.
4. **Feature Set (MVP)**: List features in priority order (P0 / P1 / P2). Mark any feature that directly depends on a research output.
5. **Non-Goals**: Explicitly list what this product will NOT do in V1.
6. **Research Dependencies**: Table mapping each product feature to its research dependency (model, dataset, algorithm, metric).
7. **Acceptance Criteria**: Testable criteria for each P0 feature.

### Researcher team consultation

Before finalizing the PRD:
- Review the "Research Dependencies" table with the researcher team — confirm each dependency is feasible and the interface (API, model artifact, data schema) is agreed upon.
- Have the research lead sign off on the "Goals and Success Metrics" section, particularly any metrics derived from research evaluation.

### Output of Stage 2

- `PRD.md` — full product requirements document
- `RESEARCH-DEPENDENCIES.md` — dependency table extracted from the PRD

---

## Stage 3 — Tech Stack Architecture

**Reference:** `references/tech-stack-guide.md` for decision frameworks and recommended stacks.

**Trigger:** After PRD is approved.

### Selection criteria

Evaluate each layer of the stack against:
- Research team's existing language/framework preferences (reduce friction for collaboration)
- Model serving requirements (GPU, memory, latency)
- Data pipeline needs (batch vs. streaming, volume)
- Hard constraints from Stage 1 (privacy, compliance, cost)
- Team's familiarity and ecosystem maturity

### Stack layers to define

| Layer | Decision | Options to consider |
|-------|----------|-------------------|
| **AI/ML serving** | Inference framework and API | FastAPI + vLLM, Triton, Hugging Face TGI, custom PyTorch server |
| **Backend** | Language and web framework | Python/FastAPI, Node/Express, Go/Gin |
| **Database** | Primary store, vector store, cache | PostgreSQL, MongoDB, Pinecone/Weaviate, Redis |
| **Frontend** | UI framework | Next.js, React + Vite, Svelte |
| **Auth** | Authentication and authorization | Clerk, Auth0, Supabase Auth, custom JWT |
| **Queue / async** | Task queue and message broker | Celery + Redis, BullMQ, RabbitMQ, Kafka |
| **Infra** | Cloud provider and compute | AWS, GCP, Azure; GPU instance type |
| **CI/CD** | Build, test, deploy pipeline | GitHub Actions, CircleCI, ArgoCD |
| **Observability** | Logging, metrics, tracing | Grafana + Prometheus + Loki, Datadog, OpenTelemetry |

### Output of Stage 3

- `ARCHITECTURE.md` — full stack diagram (text-based) + per-layer decisions with rationale
- `ADRs/` (Architecture Decision Records) — one markdown file per significant decision, especially for AI/ML serving and data storage

---

## Stage 4 — AI/ML Integration Design

**Trigger:** After architecture is confirmed. This is the highest-collaboration stage with the research team.

### Research team interface agreement

Before writing integration code, agree in writing with the researcher team on:

| Contract | Detail |
|----------|--------|
| **Model API** | Input format, output format, schema, versioning |
| **Inference endpoint** | gRPC vs. REST, authentication, rate limits |
| **Model artifact** | Location, format (ONNX, PyTorch, HF), versioning |
| **Fallback behavior** | What happens when the model returns low-confidence or errors |
| **Evaluation metrics** | How model quality is monitored in production |
| **Retraining triggers** | When and how the model is updated |

### Integration patterns — choose based on requirements

- **Synchronous inference**: User request → backend → model API → response. Use for low-latency (<500ms) single predictions.
- **Asynchronous inference**: Request queued → worker calls model → result fetched or pushed. Use for heavy inference (>1s) or batch.
- **Batch inference**: Scheduled job processes data in bulk. Use for analytics, pre-computation, or offline scoring.
- **Streaming inference**: Model outputs tokens or results incrementally. Use for LLMs, generative models, real-time dashboards.

### Implementation checklist

- [ ] Model client library or API wrapper written and unit-tested
- [ ] Input validation layer (schema enforcement before model call)
- [ ] Output parsing and normalization (research output → product data model)
- [ ] Error handling: timeout, model unavailable, malformed output
- [ ] Confidence threshold handling (reject, fallback, or flag for review)
- [ ] End-to-end integration test with mock and live model
- [ ] Latency and throughput benchmarks recorded

**Decision gate:** Present integration design to research lead. Confirm model interface contract is signed off before building dependent UI/backend layers.

### Output of Stage 4

- `AI-INTEGRATION.md` — interface contract, integration pattern, data flow diagram
- Model client module (code) with unit tests
- Integration test suite

---

## Stage 5 — UI Development

**Trigger:** After AI integration design is confirmed (parallel with Stage 6 where feasible).

### Design-first approach

1. **Information architecture**: Map user journeys from the PRD user stories. Identify screens, modals, and states.
2. **Wireframes or mockups**: Text-based wireframes are acceptable; escalate to visual tools if ambiguity exists.
3. **Component inventory**: List reusable components. Prioritize components that surface AI/ML outputs (result cards, confidence indicators, streaming text displays).
4. **Accessibility baseline**: All interactive elements keyboard-navigable; WCAG 2.1 AA color contrast minimum.

### AI-specific UI patterns

- **Streaming output**: Use server-sent events (SSE) or WebSockets; show incremental rendering for generative outputs.
- **Confidence visualization**: Display uncertainty with appropriate UI cues (e.g., progress bars, badges, tooltips) — validate display thresholds with research lead.
- **Loading states**: Async inference requires explicit loading, progress, and timeout states.
- **Error states**: Distinguish model errors from system errors in user-facing copy.
- **Feedback loops**: Add thumbs-up/down or correction UI if the research team needs user feedback for model improvement.

### Implementation checklist

- [ ] Component library or design system selected
- [ ] Core screens implemented (from PRD P0 features)
- [ ] AI output components built and tested with mock data
- [ ] Responsive design (mobile and desktop breakpoints)
- [ ] Error and empty states implemented
- [ ] Basic accessibility audit passed
- [ ] Frontend connected to backend API (from Stage 6)

### Output of Stage 5

- Working frontend application (repository or module)
- Component documentation
- Screenshot or recorded walkthrough of core user journey

---

## Stage 6 — Backend Development

**Trigger:** After PRD and architecture confirmed (parallel with Stage 5 where feasible).

### API design

1. Define REST or GraphQL endpoints for each PRD feature.
2. Document each endpoint: method, path, request schema, response schema, error codes.
3. Write an OpenAPI / Swagger spec before implementation.

### Core backend modules

| Module | Responsibility |
|--------|----------------|
| **Auth** | User identity, session management, role-based access |
| **Model gateway** | Wraps the AI integration client; handles routing, retries, rate limits |
| **Data layer** | CRUD operations, ORM/query builder, migrations |
| **Job queue** | Async task management for heavy inference or batch jobs |
| **Webhooks / events** | Notify frontend or external systems of async results |
| **Admin API** | Internal endpoints for monitoring, model management, feature flags |

### Implementation checklist

- [ ] OpenAPI spec written and reviewed
- [ ] Auth endpoints implemented and tested
- [ ] Model gateway module wraps AI integration client
- [ ] CRUD endpoints for core data entities
- [ ] Async job queue wired up (if applicable)
- [ ] Unit tests for all business logic
- [ ] Integration tests for API endpoints
- [ ] Environment-based config (no hardcoded secrets)
- [ ] Database migrations versioned

### Output of Stage 6

- Backend service (repository or module)
- OpenAPI spec
- Database schema with migration scripts
- Test suite (unit + integration)

---

## Stage 7 — Integration, Testing & QA

**Trigger:** After Stages 5 and 6 are functionally complete.

### Test levels

| Level | Scope | Tools |
|-------|-------|-------|
| **Unit** | Individual functions and modules | pytest, Jest, Vitest |
| **Integration** | Service-to-service, DB, model API | pytest, Supertest |
| **End-to-end** | Full user journey through UI | Playwright, Cypress |
| **AI/ML quality** | Model output correctness in product context | Custom eval suite (consult research team) |
| **Load** | Throughput and latency under expected peak load | k6, Locust |
| **Security** | OWASP Top 10 basics, auth boundary checks | Manual + automated scan |

### Research team QA collaboration

- **AI output correctness review**: Have the researcher team review a sample of real inference outputs from the integrated system. Surface discrepancies between paper-reported behavior and production behavior.
- **Edge case inventory**: Ask the researcher team for known edge cases, out-of-distribution inputs, and failure modes the model exhibits. Write test cases for each.

### Definition of done for Stage 7

- [ ] All P0 features pass acceptance criteria from PRD
- [ ] AI/ML output quality validated by research team on production-like data
- [ ] No critical or high security issues outstanding
- [ ] Load test shows system meets latency and throughput targets under peak load
- [ ] End-to-end test suite covers all core user journeys

### Output of Stage 7

- QA report (test results, coverage, open issues)
- Edge case test suite (co-authored with research team)
- Load test results and identified bottlenecks

---

## Stage 8 — Scaling & Production Hardening

**Reference:** `references/scaling-playbook.md` for patterns and runbooks.

**Trigger:** After Stage 7 QA pass.

### Scaling dimensions to address

| Dimension | Target | Approach |
|-----------|--------|----------|
| **Inference throughput** | Requests/sec under peak | Model batching, GPU auto-scaling, request queuing |
| **Backend throughput** | API requests/sec | Horizontal pod autoscaling, connection pooling |
| **Data volume** | Storage growth rate | Partitioning, archival strategy, index optimization |
| **Latency** | P95 and P99 targets from PRD | CDN for static assets, caching layer, async offload |
| **Availability** | Uptime SLA | Multi-AZ or multi-region deployment, health checks, circuit breakers |
| **Cost** | Cost per inference / cost per user | Spot instances, request batching, model quantization |

### Production hardening checklist

- [ ] Model serving: GPU auto-scaling configured, warm pool set
- [ ] Backend: horizontal autoscaling with CPU/memory thresholds
- [ ] Database: read replicas, connection pooling, slow query monitoring
- [ ] Caching: Redis or CDN layer for expensive or repeated computations
- [ ] Rate limiting: per-user and per-API-key limits enforced
- [ ] Secrets management: all secrets in vault (AWS Secrets Manager, GCP Secret Manager, Vault)
- [ ] Observability: logging, metrics, distributed tracing in place; dashboards and alerts configured
- [ ] Incident runbook: on-call rotation, escalation path, model rollback procedure
- [ ] Disaster recovery: backup and restore tested for database and model artifacts

**Decision gate:** Present scaling plan and hardening checklist to research lead. Confirm model rollback and retraining integration points before going live.

### Output of Stage 8

- `RUNBOOK.md` — operational runbook (deploy, scale, roll back, incident response)
- Infrastructure-as-code (Terraform, Pulumi, or Helm charts)
- Observability dashboards and alert definitions
- Cost model (estimated cost at target traffic volumes)

---

## Stage 9 — Handoff & Knowledge Transfer

**Trigger:** After Stage 8 production readiness is confirmed.

### Deliverables

1. **Engineering handoff document**: System overview, repository structure, local dev setup, deployment guide, key architectural decisions and their rationale.
2. **Research integration guide**: How the AI/ML component is integrated, interface contracts, how to update or swap the model, evaluation pipeline.
3. **Operations guide**: How to monitor, scale, and debug the system in production.
4. **Open items register**: All known technical debt, deferred features, and future scaling concerns, with owners and priority.
5. **Demo and walkthrough**: Record or conduct a live walkthrough covering the full user journey, AI integration, and ops dashboard.

---

## Cross-Stage Principles

### Research lead consultation protocol

At every stage, any decision that affects:
- Model fidelity or correctness
- Evaluation metrics or thresholds
- The research paper's core claims as expressed in the product

…must be surfaced to the research lead before being implemented. Do not silently override research constraints with engineering pragmatism.

### Living Engineering Log

Maintain an `ENGINEERING-LOG.md` alongside the Research Log. After each stage:
```
## Stage N — [Name] — [Date]
Status: complete / in-progress / blocked
Key decisions: [list with rationale]
Research team touchpoints: [summary of what was discussed and agreed]
Open items: [list]
```

### Escalation protocol

Escalate to the research lead immediately when:
- The model's production behavior diverges significantly from the paper's reported results.
- A scaling constraint (latency, cost, memory) forces a compromise on model quality.
- A user privacy or compliance constraint conflicts with the research team's data requirements.
- A research dependency is not deliverable in time for the engineering milestone.

### No shortcuts on AI correctness

Engineering velocity does not justify silently degrading the AI/ML component's fidelity. If a deadline forces a trade-off, surface it explicitly to the research lead and document the decision.

---

## Quick-Start Paths

| User intent | Entry point | Notes |
|-------------|-------------|-------|
| "We have a paper, build the product" | Stage 1 → full pipeline | Run research-paper-review in parallel with Stage 1 |
| "PRD exists, build it" | Stage 3 → full pipeline | Confirm research dependencies table exists before starting |
| "Stack is chosen, build AI integration + app" | Stage 4 → 5 → 6 → 7 → 8 | Verify interface contract with research team before Stage 4 |
| "MVP built, make it production-ready" | Stage 7 → 8 → 9 | Run QA first to identify gaps before hardening |
| "Scale an existing deployment" | Stage 8 directly | Use scaling-playbook reference |

---

## Output Summary

| Stage | Artifact |
|-------|----------|
| 1 | Research-to-Product Brief (approved by research lead) |
| 2 | PRD.md, RESEARCH-DEPENDENCIES.md |
| 3 | ARCHITECTURE.md, ADRs/ |
| 4 | AI-INTEGRATION.md, model client module, integration tests |
| 5 | Frontend application, component docs |
| 6 | Backend service, OpenAPI spec, DB migrations, test suite |
| 7 | QA report, edge case test suite, load test results |
| 8 | RUNBOOK.md, IaC, observability config, cost model |
| 9 | Engineering handoff doc, research integration guide, open items register |
| All | ENGINEERING-LOG.md with stage-by-stage entries |
