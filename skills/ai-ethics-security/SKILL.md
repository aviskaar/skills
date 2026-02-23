---
name: ai-ethics-security
description: "Use this skill when you need AI system security architecture, agentic AI security frameworks, hallucination detection and mitigation, responsible AI implementation, AI governance programs, PII protection in AI pipelines, adversarial ML defense, model security, AI regulatory compliance (EU AI Act, NIST AI RMF), or AI-specific security training. Trigger for any AI/ML system deployment, agentic workflow design, or AI ethics review."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [ai-security, responsible-ai, hallucination, agentic-ai, ai-governance, pii, eu-ai-act, nist-ai-rmf, adversarial-ml]
  sub-skills:
    - ai-security-analyst
    - security-trainer
---

# AI Ethics & Security — VP AI Ethics & Security

## Role

VP AI Ethics & Security owns the security, safety, and ethical governance of all artificial intelligence systems deployed within or by the organization. This includes agentic AI frameworks, LLM-powered applications, ML models, and automated decision systems. The role ensures AI systems are secure, explainable, fair, and compliant with applicable regulations.

---

## Phase 1 — AI Risk Classification

**AI system risk register (mandatory for every AI deployment):**

| Risk Dimension | Assessment Questions |
|---|---|
| Autonomy level | Does the system act without human approval? What is the blast radius? |
| Data sensitivity | Does it process PII, PHI, financial, or regulated data? |
| Decision impact | Does output affect individuals' rights, employment, credit, health? |
| Adversarial exposure | Is the model accessible to untrusted users or external inputs? |
| Regulatory obligation | Does EU AI Act, GDPR, HIPAA, or sector-specific rules apply? |
| Hallucination risk | Are outputs acted upon automatically without validation? |
| Supply chain risk | Does it rely on third-party models, APIs, or training data? |

**Risk tiers:**

| Tier | Profile | Controls Required |
|---|---|---|
| Critical | Autonomous, PII/PHI, regulatory decisions | Full governance suite + human-in-the-loop mandatory |
| High | Significant automation, sensitive data | Enhanced monitoring + human review on exceptions |
| Medium | Assisted decision-making, internal use | Standard security controls + audit logging |
| Low | Internal tools, no sensitive data, no automation | Basic security review + logging |

---

## Phase 2 — AI Agentic Security Framework

**Core principles for agentic AI systems (non-negotiable):**

```
1. MINIMAL FOOTPRINT
   - Request only necessary permissions
   - Prefer reversible over irreversible actions
   - Avoid storing sensitive information beyond immediate need
   - Actions scoped to declared task boundary

2. HUMAN-IN-THE-LOOP (HITL) GATES
   - All irreversible actions require human approval before execution
   - Financial transactions > threshold: human approval
   - Data deletion/modification at scale: human approval
   - External communications sent on behalf of users: human approval
   - Privilege escalation: human approval

3. CONSTRAINED EXECUTION
   - Tool access: allowlist only (deny-by-default)
   - Network access: egress allowlist; no arbitrary internet calls
   - File system: scoped read/write paths; no access to system files
   - Environment variables / secrets: vault-injected; not accessible to model
   - Maximum action budget per session (prevent runaway agents)

4. AUDIT TRAIL
   - Every agent action logged: timestamp, action, inputs, outputs, approvals
   - Immutable audit log (append-only, tamper-evident)
   - Log retention: 365 days minimum
   - Session transcripts stored for all agentic interactions

5. SANDBOXED EXECUTION
   - Code execution in isolated containers (no host access)
   - Browser automation: headless, network-restricted
   - File operations: temporary, sandboxed, cleaned on session end
   - No persistent state modification without explicit intent declaration
```

**Agentic security architecture:**

```
User/System Prompt
       ↓
[Prompt Injection Guard]    ← Block adversarial prompt injections
       ↓
[PII Detection & Masking]   ← Strip PII before model processes
       ↓
[Context Policy Engine]     ← Enforce scope, topic, action limits
       ↓
[AI Model (LLM/Agent)]
       ↓
[Output Validation Layer]   ← Hallucination check, policy compliance
       ↓
[Action Authorization Gate] ← Human approval for irreversible actions
       ↓
[Audit Logger]              ← Immutable log of all actions
       ↓
[Tool Execution Sandbox]    ← Scoped, monitored tool use
```

---

## Phase 3 — Hallucination Detection & Mitigation

**Hallucination risk matrix:**

| Context | Risk | Mitigation |
|---|---|---|
| Medical / clinical advice | Critical | Domain expert review; source citation required; disclaimer |
| Legal / compliance guidance | Critical | Human lawyer review; model outputs marked advisory only |
| Financial calculations | High | Deterministic verification layer; human sign-off on thresholds |
| Code generation | High | SAST scan on generated code; no auto-deploy without testing |
| Factual claims / citations | Medium | RAG with verified sources; source attribution; confidence scores |
| Customer-facing responses | Medium | Human review queue for low-confidence outputs |

**Technical hallucination controls:**

```
RAG (Retrieval-Augmented Generation):
- Ground model responses in verified, up-to-date document corpus
- Every factual claim must be traceable to a retrieved source
- Source recency validation: flag claims based on documents >90 days old
- Semantic similarity threshold: reject low-similarity retrievals (<0.7)

Confidence Scoring:
- Output confidence score on every model response
- Low confidence (<0.6): human review before action
- Medium confidence (0.6–0.85): present to user with uncertainty indicator
- High confidence (>0.85): automated, with spot-check sampling (5%)

Output Validation:
- Schema validation on structured outputs (JSON, tables, code)
- Fact-checking layer for cited statistics and claims
- Contradiction detection: compare against organization knowledge base
- Hallucination classifier model (fine-tuned for domain) on critical pipelines
```

---

## Phase 4 — Responsible AI Implementation

**Responsible AI framework (aligned to NIST AI RMF):**

| Function | Requirements |
|---|---|
| GOVERN | AI governance policy; roles & responsibilities; risk tolerance defined |
| MAP | AI system inventory; risk classification; stakeholder impact mapping |
| MEASURE | Bias testing; performance benchmarks; safety evaluations; red-teaming |
| MANAGE | Incident response for AI failures; model version control; rollback capability |

**Fairness & Bias controls:**
- Pre-deployment bias audit for all AI systems impacting humans (hiring, lending, healthcare)
- Disaggregated performance metrics across demographic groups
- Regular fairness re-evaluation (quarterly minimum) as model and data drift
- Bias incident escalation: any identified bias → immediate investigation + CISO + Legal

**Explainability requirements by risk tier:**
- Critical systems: full explanation of every decision; SHAP/LIME or equivalent
- High: explanation on request; feature importance available
- Medium: summary explanation available in UI
- Low: model card documenting training approach, limitations, intended use

**Model governance:**
- Model Registry: every model version tracked (training data, hyperparameters, performance)
- Model Cards: mandatory for all production models
- Model versioning: semantic versioning with changelog
- A/B testing: security evaluation required before production promotion
- Model retirement: EOL policy; no unsupported models in production

---

## Phase 5 — PII Protection in AI Systems

**PII in AI pipeline controls:**

```
Data Ingestion:
- PII classification scan on all training data before ingest
- Anonymization/pseudonymization applied before model training
- Differential privacy applied for sensitive dataset training
- Data lineage tracked: know where every training record originates

Model Training:
- No real PII in training data without explicit consent and legal basis (GDPR Art. 6)
- Machine unlearning capability required for right-to-be-forgotten requests
- Training environment: isolated, access-controlled, audit-logged
- Model inversion / membership inference attack testing before release

Inference / Production:
- PII detection at prompt ingestion (regex + ML classifier)
- PII masking/tokenization before model sees input
- Output scanning: redact PII from model responses before delivery
- Log scrubbing: no PII in inference logs

User Data Rights:
- Data subject can request their data be excluded from training
- Opt-out respected within 30 days (GDPR) or 45 days (CCPA)
- Synthetic data generation for development/testing (no production PII in dev)
```

---

## Phase 6 — Adversarial ML Defense

**Attack vectors and defenses:**

| Attack | Description | Defense |
|---|---|---|
| Prompt Injection | Malicious input hijacks agent instructions | Instruction hierarchy; input sanitization; output monitoring |
| Jailbreaking | Bypass safety guardrails | Constitutional AI; RLHF; hardened system prompts; classifier |
| Model Extraction | Steal model via queries | Rate limiting; query monitoring; output watermarking |
| Data Poisoning | Corrupt training data | Data provenance; anomaly detection; data integrity checks |
| Adversarial Examples | Craft inputs to fool model | Adversarial training; input preprocessing; ensemble defenses |
| Membership Inference | Determine if record was in training | Differential privacy; output perturbation; access controls |
| Model Inversion | Reconstruct training data from model | Output discretization; differential privacy; access controls |
| Supply Chain | Compromise model weights or APIs | Model signing; hash verification; provenance tracking |

---

## Phase 7 — AI Regulatory Compliance

**EU AI Act compliance actions:**

```
Prohibited AI (never deploy):
✗ Social scoring by governments
✗ Real-time biometric surveillance in public spaces (with narrow exceptions)
✗ Subliminal manipulation causing harm
✗ Exploitation of vulnerabilities of specific groups

High-Risk AI (full compliance required):
→ Conformity assessment before deployment
→ Technical documentation (EU AI Act Annex IV)
→ Risk management system (continuous)
→ Data governance (training, validation, testing data quality)
→ Transparency & logging requirements
→ Human oversight mechanisms
→ Accuracy, robustness, cybersecurity requirements
→ Registration in EU AI Act database

GPAI (General Purpose AI Models):
→ Technical documentation
→ Copyright compliance policy
→ Publish summary of training data
→ For systemic risk models: adversarial testing; incident reporting; cybersecurity measures
```

**NIST AI RMF alignment mapping:**

| Phase | NIST AI RMF | Implementation |
|---|---|---|
| Design | Map risks | Threat modeling for AI; bias assessment |
| Build | Measure | Performance, fairness, robustness testing |
| Deploy | Manage | Monitoring, incident response, rollback |
| Operate | Govern | Policy, training, oversight, reporting |

---

## Phase 8 — AI Security Monitoring & Dashboards

**AI Agent Security Dashboard (real-time):**

```
AI SECURITY POSTURE
══════════════════════════════════════════════════════
Active AI Systems:          [N deployed]
Systems at Critical Risk:   [N]   Target: 0
Hallucination Rate:         [X%]  Target: <2%
Prompt Injection Attempts:  [N/day]
PII Exposure Incidents:     [N]   Target: 0
HITL Override Rate:         [X%]  (agent bypassed; investigate if >5%)
Model Drift Alerts:         [N]
Bias Flags (30 days):       [N]
AI Compliance Status:       [Frameworks: X/Y compliant]
Agentic Action Budget Usage:[X%]  Alert if >80%
Avg Confidence Score:       [X]   Alert if <0.75 average
══════════════════════════════════════════════════════
```

---

## Non-Negotiable AI Security Rules

1. **No AI system in production without security review** — risk classification and controls documented
2. **No irreversible agentic action without human approval** — absolute; no exceptions
3. **PII never enters model training without anonymization and legal basis** — zero tolerance
4. **Hallucination controls mandatory for critical decisions** — validation layer always between model and action
5. **Audit log every AI action** — immutable, 365-day retention, accessible for forensics
6. **No model deployed without model card** — lineage, limitations, and intended use documented
7. **AI incident response plan tested annually** — tabletop exercise for AI failure scenarios
8. **EU AI Act prohibited use cases: zero deployment** — legal and CISO sign-off required to even evaluate
