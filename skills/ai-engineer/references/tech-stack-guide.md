# Tech Stack Selection Guide — AI Engineer Skill

Use this reference during Stage 3 (Tech Stack Architecture) of the ai-engineer skill. Each section provides decision criteria and recommended options for a research-to-product build.

---

## Selection Principles

1. **Minimize research-engineering friction**: Prefer languages and frameworks the research team already uses (typically Python). Interoperability with PyTorch, JAX, or Hugging Face ecosystems is almost always required.
2. **Serve the model first**: Every other stack choice should be evaluated against the model serving requirements. The model is the product's core — don't let web framework preferences dictate inference architecture.
3. **Default to boring technology**: Use well-understood, widely-adopted tools. Reserve novel technologies for problems they uniquely solve.
4. **Environment parity**: Dev, staging, and production should be as similar as possible, especially for the AI/ML serving layer.

---

## Layer 1: AI/ML Model Serving

This is the most important layer. Get this right before choosing anything else.

### Decision tree

```
Is the model a large language model (LLM, >1B params)?
  ├── Yes → vLLM (open-source), TGI (Hugging Face), or managed (OpenAI, Anthropic, Vertex AI)
  └── No → Is it a transformer model?
        ├── Yes → Triton Inference Server or FastAPI + PyTorch
        └── No → Is it a classical ML model (sklearn, XGBoost)?
              ├── Yes → FastAPI + joblib/ONNX
              └── No → Custom PyTorch/JAX server via FastAPI
```

### Options

| Option | Best for | Throughput | Latency | GPU support | Notes |
|--------|----------|-----------|---------|-------------|-------|
| **vLLM** | LLM serving (7B–70B+) | Very high (paged attention) | Low | Yes | Best OSS option for LLMs |
| **TGI (Text Generation Inference)** | HF models, LLMs | High | Low | Yes | Easy HF model loading |
| **Triton Inference Server** | Any model, high throughput | Very high | Very low | Yes | Complex setup; use for production at scale |
| **FastAPI + PyTorch** | Custom research models | Medium | Medium | Yes | Fastest path for research code |
| **ONNX Runtime** | Optimized inference, non-GPU | High | Very low | Partial | Good for CPU-bound models |
| **Managed API** | Closed models, fast MVP | N/A | Low | N/A | No control over model; vendor lock-in |

### Model serving checklist

- [ ] Batch inference enabled (improves GPU utilization)
- [ ] Model loaded once at startup (not per-request)
- [ ] Health check endpoint implemented
- [ ] Graceful shutdown with in-flight request draining
- [ ] Versioned model endpoints (`/v1/predict`, `/v2/predict`)
- [ ] Request/response logging with latency tracking

---

## Layer 2: Backend API

### Recommended: FastAPI (Python)

**Use when:** Research team is Python-based, model serving is Python, or tight integration with ML libraries is needed.

```python
# Canonical FastAPI structure for research-to-product builds
app/
├── main.py              # App entry point, middleware, router registration
├── routers/
│   ├── inference.py     # AI/ML endpoints
│   ├── data.py          # CRUD endpoints
│   └── auth.py          # Auth endpoints
├── services/
│   ├── model_client.py  # Wraps model serving API
│   └── data_service.py  # Business logic
├── models/              # Pydantic schemas (request/response)
├── db/                  # SQLAlchemy models, migrations (Alembic)
└── core/
    ├── config.py        # Settings via pydantic-settings
    └── dependencies.py  # FastAPI dependency injection
```

### Alternative: Node.js/TypeScript + Express or Fastify

**Use when:** Frontend team is JS-heavy, model serving is already a separate Python service, and the backend is primarily a data/auth layer.

### Alternative: Go + Gin or Echo

**Use when:** Very high throughput requirements for the non-AI layer, and the team has Go experience.

---

## Layer 3: Database

### Primary data store

| Option | Best for | Notes |
|--------|----------|-------|
| **PostgreSQL** | Relational data, ACID compliance | Default choice; pgvector extension for embeddings |
| **MongoDB** | Flexible schema, document-heavy | Good for rapid iteration when schema is unstable |
| **SQLite** | Development and small-scale | Never use in multi-instance production |

**Recommendation:** Start with PostgreSQL. Use the pgvector extension before adding a separate vector database.

### Vector store (for embedding-based search)

| Option | Best for | Notes |
|--------|----------|-------|
| **pgvector** | Small to medium datasets (<10M vectors) | No additional infra; use if already on Postgres |
| **Pinecone** | Managed, production scale | Fast setup; managed; cost scales with usage |
| **Weaviate** | Self-hosted, multi-modal | Richer query API; more ops complexity |
| **Qdrant** | Self-hosted, high performance | Good OSS option; Rust-based, fast |
| **ChromaDB** | Development and prototyping | Not production-ready at scale |

### Cache

| Option | Use case |
|--------|----------|
| **Redis** | Session cache, rate limiting, task queue, inference result cache |
| **Memcached** | Pure key-value cache, no persistence needed |

---

## Layer 4: Frontend

### Recommended: Next.js (React)

**Use when:** Production application requiring SEO, SSR, and a large component ecosystem.

Key libraries for AI-powered UIs:
- `react-markdown` — render model-generated markdown safely
- `@tanstack/react-query` — async state management for API calls
- Streaming: use `EventSource` (SSE) or WebSocket hooks for streaming model output
- `recharts` or `tremor` — data visualization for model outputs and metrics

### Alternative: React + Vite

**Use when:** Pure SPA is sufficient (no SSR needed), and you want faster dev builds.

### Alternative: Svelte / SvelteKit

**Use when:** Smaller team, preference for less boilerplate, or performance-critical UI.

### Design system

- **Shadcn/ui** (Tailwind-based, headless): Recommended for new projects; fully customizable
- **Chakra UI**: Good for rapid prototyping with accessibility built in
- **Ant Design**: Enterprise-grade; strong data display components

---

## Layer 5: Auth

| Option | Best for | Notes |
|--------|----------|-------|
| **Clerk** | Fastest production auth | Managed; great DX; handles MFA, social login |
| **Auth0** | Enterprise SSO requirements | More config; SAML support |
| **Supabase Auth** | If using Supabase DB | Tight integration |
| **Custom JWT** | Full control, no vendor | Only choose if you have specific requirements |

**Recommendation:** Use Clerk for new projects unless there is a compliance reason not to use a managed auth provider.

---

## Layer 6: Async Task Queue

Use when inference latency > 2s, batch processing is needed, or jobs must survive server restarts.

| Option | Best for | Notes |
|--------|----------|-------|
| **Celery + Redis** | Python backends | Battle-tested; good monitoring with Flower |
| **Dramatiq + Redis** | Python; simpler than Celery | Less config; good for smaller teams |
| **BullMQ** | Node.js backends | TypeScript support; Redis-backed |
| **Kafka** | High-volume event streaming | Overkill for most research products; use only if event volume demands it |

---

## Layer 7: Infrastructure and Cloud

### Cloud provider

| Provider | Best for |
|----------|----------|
| **AWS** | Broadest service catalog; strong GPU instance options (g4dn, p3, p4) |
| **GCP** | Best managed GPU options (A100, TPU access); strong ML ecosystem |
| **Azure** | Enterprise/corporate requirements; good OpenAI integration |

### Compute for model serving

| Instance type | Use case |
|---------------|----------|
| AWS g4dn.xlarge (T4) | Small models, cost-sensitive inference |
| AWS p3.2xlarge (V100) | Medium models, higher throughput |
| AWS p4d.24xlarge (A100) | Large LLMs, maximum throughput |
| GCP a2-highgpu (A100) | LLMs; GCP's best GPU option |

### Containerization and orchestration

- **Docker**: All services containerized. Enforce this from day one.
- **Kubernetes (EKS/GKE/AKS)**: For production at scale. Use Helm for packaging.
- **Docker Compose**: Development only.

### CI/CD

| Option | Best for |
|--------|----------|
| **GitHub Actions** | Most teams; tight GitHub integration; free tier |
| **CircleCI** | Faster builds; better caching |
| **ArgoCD** | GitOps-style Kubernetes deployments |

---

## Layer 8: Observability

Do not skip observability. AI systems fail in non-obvious ways — you need visibility into both system health and model behavior.

### Recommended stack

| Component | Tool | What to monitor |
|-----------|------|----------------|
| Metrics | Prometheus + Grafana | Latency, throughput, error rate, GPU utilization |
| Logs | Loki + Grafana (or CloudWatch) | Request logs, model input/output (sampled), errors |
| Tracing | OpenTelemetry + Jaeger or Tempo | End-to-end request tracing across services |
| Alerting | Grafana Alerts or PagerDuty | Latency SLO breach, error rate spike, model quality degradation |

### AI-specific metrics to track

| Metric | Why |
|--------|-----|
| Inference latency (P50, P95, P99) | Core SLO |
| Model throughput (requests/sec) | Capacity planning |
| Queue depth (if async) | Backpressure signal |
| Token count per request (if LLM) | Cost tracking |
| Model version in use | Enables rollback correlation |
| Confidence score distribution | Detect model drift |
| Error rate by error type | Distinguish model vs. system errors |

---

## Architecture Decision Record (ADR) Template

Create one ADR per significant decision. Store in `ADRs/ADR-NNN-title.md`.

```markdown
# ADR-001: [Decision title]

## Status
Proposed / Accepted / Deprecated / Superseded by ADR-XXX

## Context
What is the problem or question this decision addresses?

## Decision
What was decided?

## Rationale
Why was this option chosen over the alternatives?

## Alternatives considered
- Option A: [description, why rejected]
- Option B: [description, why rejected]

## Consequences
- Positive: [list]
- Negative / trade-offs: [list]

## Date
[YYYY-MM-DD]

## Stakeholders
[Who was consulted or needs to know about this decision]
```
