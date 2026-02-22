# Scaling Playbook — AI Engineer Skill

Use this reference during Stage 8 (Scaling & Production Hardening) of the ai-engineer skill. This playbook covers scaling patterns, production hardening checklists, and operational runbook templates for AI-powered full-stack applications.

---

## When to Scale — Decision Triggers

Do not scale prematurely. Trigger scaling work when:

| Signal | Action |
|--------|--------|
| P95 inference latency > 2× target | Scale model serving tier |
| Backend API P95 > 500ms | Scale backend or optimize queries |
| Queue depth growing unbounded | Scale async workers |
| GPU utilization > 80% sustained | Add GPU replicas |
| Error rate > 0.1% on inference | Investigate before scaling |
| DB connection pool exhaustion | Add read replicas or connection pooling |
| Storage growth rate > 70% of provisioned | Expand or archive |

---

## Model Serving Scaling Patterns

### Pattern 1: Horizontal replica scaling

Add more model server instances behind a load balancer. Use when:
- Model fits in a single GPU
- Requests are independent (stateless inference)

```
Load Balancer
├── Model Server Pod 1 (GPU)
├── Model Server Pod 2 (GPU)
└── Model Server Pod N (GPU)
```

**Kubernetes HPA config (example):**
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: model-server-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: model-server
  minReplicas: 1
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 60
```

### Pattern 2: Request batching

Batch multiple inference requests together before sending to the GPU. Reduces per-request cost and improves throughput at the cost of latency.

- vLLM: continuous batching is automatic
- Custom models: implement a batching queue in the model server with a configurable `max_batch_size` and `max_wait_ms`

### Pattern 3: Model quantization

Reduce model size and inference cost with quantization. Common options:
- **INT8 quantization**: ~2× memory reduction, minimal accuracy loss for most tasks
- **INT4 quantization (GGUF/GPTQ)**: ~4× reduction; accuracy impact varies — validate with research team before deploying
- **FP16/BF16**: Standard for GPU inference; use as baseline before INT8

> Always validate quantized model accuracy against the research team's evaluation suite before production deployment.

### Pattern 4: Caching inference results

For deterministic or near-deterministic inputs, cache model outputs:

```python
import hashlib, json
from redis import Redis

redis = Redis()

def cached_inference(input_data: dict, model_client, ttl_seconds=3600):
    cache_key = "inference:" + hashlib.sha256(
        json.dumps(input_data, sort_keys=True).encode()
    ).hexdigest()

    cached = redis.get(cache_key)
    if cached:
        return json.loads(cached)

    result = model_client.predict(input_data)
    redis.setex(cache_key, ttl_seconds, json.dumps(result))
    return result
```

Use only when: inputs are sufficiently deterministic, and stale results are acceptable.

### Pattern 5: Async offload for heavy inference

For requests where latency > 5s is acceptable:

```
Client → POST /jobs → Job ID returned immediately
         ↓
     Job Queue (Redis/Kafka)
         ↓
     Worker Pool → Model Server → Result stored in DB

Client → GET /jobs/{id} → Poll for result
     or
Client ← WebSocket push when result ready
```

---

## Backend API Scaling Patterns

### Stateless services

Ensure backend API pods are stateless (no local state, sessions, or files). All state must live in:
- Database (persistent state)
- Redis (session cache, distributed locks)
- Object storage (S3/GCS for files, model artifacts)

### Database scaling

| Issue | Solution |
|-------|----------|
| Read-heavy load | Add read replicas; route read queries to replicas |
| Write contention | Partition tables by time or user; consider CQRS |
| Slow queries | Add indexes; use `EXPLAIN ANALYZE`; consider materialized views |
| Connection exhaustion | Use PgBouncer (connection pooler) in front of Postgres |
| Data volume growth | Partition by time; archive old data to object storage |

### Connection pooling with PgBouncer

```ini
# pgbouncer.ini
[databases]
mydb = host=postgres-primary port=5432 dbname=mydb

[pgbouncer]
pool_mode = transaction        # Best for most web apps
max_client_conn = 1000
default_pool_size = 20
min_pool_size = 5
server_idle_timeout = 600
```

### Rate limiting

Implement at two levels:
1. **API gateway level**: Per-IP and per-user limits using nginx or cloud load balancer
2. **Application level**: Per-user inference quota using Redis token bucket

```python
import time
from redis import Redis

redis = Redis()

def check_rate_limit(user_id: str, limit: int, window_seconds: int) -> bool:
    key = f"rate_limit:{user_id}:{int(time.time() // window_seconds)}"
    current = redis.incr(key)
    if current == 1:
        redis.expire(key, window_seconds * 2)
    return current <= limit
```

---

## Resilience Patterns

### Circuit breaker for model server calls

Prevent cascading failures when the model server is degraded:

```python
from circuitbreaker import circuit

@circuit(failure_threshold=5, recovery_timeout=30, expected_exception=Exception)
def call_model_server(input_data: dict):
    return model_client.predict(input_data)
```

### Retry with exponential backoff

```python
import time, random

def with_retry(fn, max_retries=3, base_delay=0.5):
    for attempt in range(max_retries):
        try:
            return fn()
        except Exception as e:
            if attempt == max_retries - 1:
                raise
            delay = base_delay * (2 ** attempt) + random.uniform(0, 0.1)
            time.sleep(delay)
```

### Graceful degradation

When the model server is unavailable, define a fallback behavior:
- Return a cached previous result (if applicable)
- Return a deterministic fallback (rule-based or heuristic)
- Return an explicit "service temporarily unavailable" response (do not silently drop or guess)

Document the fallback behavior and validate it with the research lead — degraded AI behavior must be intentional and communicated to users.

---

## Production Hardening Checklist

### Security

- [ ] All secrets stored in vault (AWS Secrets Manager, GCP Secret Manager, HashiCorp Vault)
- [ ] No secrets in environment variables committed to source control
- [ ] TLS enforced on all external endpoints
- [ ] Auth on all non-public API endpoints
- [ ] Input validation on all model inference endpoints (prevent prompt injection, oversized inputs)
- [ ] Rate limiting enforced (per-user inference quota)
- [ ] Dependency vulnerability scan in CI pipeline (`pip audit`, `npm audit`)
- [ ] Container images scanned for vulnerabilities

### Reliability

- [ ] Health check endpoints on every service (`/health`, `/ready`)
- [ ] Liveness and readiness probes configured in Kubernetes
- [ ] Pod disruption budgets set (ensure minimum replicas during rolling deploys)
- [ ] Resource requests and limits set on all pods
- [ ] Horizontal Pod Autoscaler configured for model server and backend
- [ ] Database backups automated and tested (restore drill required)
- [ ] Model artifact backups stored with versioning

### Observability

- [ ] Structured JSON logging on all services
- [ ] Distributed tracing with trace IDs propagated across services
- [ ] Key dashboards: inference latency, throughput, error rate, GPU utilization, queue depth
- [ ] Alerts configured for: latency SLO breach, error rate spike, queue depth threshold, disk space
- [ ] On-call rotation and escalation path documented
- [ ] Runbook linked from every alert

### Deployability

- [ ] Zero-downtime deployment strategy (rolling update or blue-green)
- [ ] Feature flags for new model versions and experimental features
- [ ] Model rollback procedure documented and tested
- [ ] Database migration rollback strategy for every migration
- [ ] Environment parity: dev/staging/prod use identical container images

---

## Cost Optimization

| Area | Optimization |
|------|-------------|
| **GPU compute** | Use spot/preemptible instances for batch inference (not real-time) |
| **Model serving** | Enable request batching; quantize model to reduce GPU memory |
| **Inference caching** | Cache repeat queries (if deterministic); reduces GPU calls |
| **Autoscaling** | Scale to zero or minimum replicas during off-peak hours |
| **Storage** | Archive cold data to cheaper storage tiers (S3 Glacier, GCS Nearline) |
| **Logging** | Sample verbose logs (e.g., 10% of successful requests); retain errors at 100% |
| **CDN** | Serve static frontend assets from CDN; reduces origin load |

### Cost model template

Estimate monthly cost before launch:

| Component | Unit | Quantity | Unit Cost | Monthly Cost |
|-----------|------|----------|-----------|-------------|
| GPU instance (model serving) | $/hr | [X hrs/month] | | |
| Backend compute | $/hr | [X hrs/month] | | |
| Database | $/month | | | |
| Redis / cache | $/month | | | |
| Object storage | $/GB | [X GB] | | |
| Egress / bandwidth | $/GB | [X GB] | | |
| Observability | $/month | | | |
| **Total** | | | | |

---

## Incident Runbook Template

Store the completed version as `RUNBOOK.md` in the repository root.

```markdown
# Runbook — [Product Name]

## Contacts
| Role | Name | Contact |
|------|------|---------|
| On-call Engineer | | |
| Escalation (Research Lead) | | |
| Escalation (Engineering Lead) | | |

## Dashboards
- System health: [link]
- Inference metrics: [link]
- Database: [link]

## Deployment

### Deploy new backend version
```bash
kubectl set image deployment/backend backend=[image]:[tag]
kubectl rollout status deployment/backend
```

### Deploy new model version
1. Update model version in config map or environment variable
2. Rolling restart model server pods: `kubectl rollout restart deployment/model-server`
3. Monitor inference latency and error rate for 10 minutes
4. If degraded: rollback with `kubectl rollout undo deployment/model-server`

### Rollback backend
```bash
kubectl rollout undo deployment/backend
```

## Common Incidents

### High inference latency

1. Check GPU utilization (`kubectl top pods -l app=model-server`)
2. Check queue depth (Redis queue monitor)
3. If GPU > 90%: scale out model server (`kubectl scale deployment/model-server --replicas=N`)
4. If queue growing unbounded: scale worker pool
5. Escalate to Research Lead if latency high despite scaling (may indicate model issue)

### Model server returning errors

1. Check model server logs: `kubectl logs -l app=model-server --tail=100`
2. Check if error is timeout, OOM, or model-level error
3. If OOM: restart pods; check if model version changed
4. If model-level errors: notify Research Lead immediately
5. Activate graceful degradation if error rate > 5%

### Database connection exhaustion

1. Check active connections: `SELECT count(*) FROM pg_stat_activity;`
2. Kill idle connections if > threshold
3. Check PgBouncer pool stats
4. Increase pool size if under-provisioned

## Maintenance

### Database backup verification (monthly)
1. Restore latest backup to staging environment
2. Run smoke tests against restored DB
3. Document result in incident log

### Model artifact backup (after every model update)
1. Copy model artifact to backup bucket with versioned path
2. Record version, date, and performance metrics in model registry
```

---

## Model Versioning and Rollback

Maintain a model registry (can be a simple table in the database or a file in object storage):

| Version | Date | Metrics | Artifact Path | Status |
|---------|------|---------|---------------|--------|
| v1.0 | | precision=X, recall=Y | s3://bucket/models/v1.0/ | Deprecated |
| v1.1 | | precision=X, recall=Y | s3://bucket/models/v1.1/ | Active |

**Rollback procedure:**
1. Update model version config to previous version
2. Rolling restart model server
3. Verify metrics return to baseline
4. Notify research team of rollback and reason
