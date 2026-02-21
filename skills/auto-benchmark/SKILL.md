---
name: auto-benchmark
description: Use this skill when building or operating a continuous, automated benchmarking system that tracks competitor performance, ingests the latest research, generates improvement hypotheses, runs experiments autonomously, and keeps a solution ranked #1 in its domain — with minimal manual intervention from engineers or researchers.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "2.0"
  tags: benchmarking, competitive-intelligence, automation, continuous-evaluation, ML, research-ingestion, leaderboard
---

# Auto Benchmark

A continuous, autonomous benchmarking system that monitors the competitive landscape, extracts insights from the latest research, proposes and runs improvement experiments, and keeps your solution ranked #1 — so engineers and researchers can focus on building product rather than running benchmarks manually.

## System Overview

The system operates as a closed loop that runs on a schedule (daily, weekly, or on trigger):

```
┌─────────────────────────────────────────────────────────────────┐
│                      CONTINUOUS LOOP                            │
│                                                                 │
│  [1] Monitor       [2] Ingest         [3] Hypothesize           │
│  Competitors   →   Research       →   Improvements             │
│  & Leaderboards    Papers             from Gap                  │
│       ↑                                    ↓                    │
│  [6] Report    ←   [5] Promote    ←   [4] Experiment            │
│  Stakeholders      Winners            Autonomously              │
└─────────────────────────────────────────────────────────────────┘
```

Each iteration of the loop answers one question: **"What can we do right now to move from our current rank to #1?"**

---

## Phase 1 — Competitive Landscape Setup

Do this once at system initialization; update the registry whenever new competitors emerge.

### 1.1 Define the Competitive Registry

Store a `competitive_registry.yaml` that is the system's single source of truth:

```yaml
domain: memory  # e.g., memory, retrieval, reasoning, vision

target_leaderboards:
  - name: MemoryBench
    url: https://...
    scrape_method: html_table  # or api, rss, manual
    primary_metric: accuracy
    higher_is_better: true
  - name: LongContextEval
    url: https://...
    scrape_method: api
    primary_metric: f1_score
    higher_is_better: true

competitors:
  - name: CompetitorA
    latest_score: 0.847
    source: MemoryBench
    last_updated: 2026-02-01
  - name: CompetitorB
    latest_score: 0.831
    source: MemoryBench
    last_updated: 2026-02-05

our_solution:
  name: OurSystem
  current_scores:
    MemoryBench: 0.823
    LongContextEval: 0.791
  promotion_threshold: 0.005  # minimum improvement over current score to promote
```

### 1.2 Define Victory Conditions

State explicitly what "#1" means for each leaderboard:
- **Absolute rank**: we must be the top entry by primary metric.
- **Relative gap**: our score must exceed the current #1 by at least N points to account for leaderboard update lag.
- **Sustained**: we must hold the position for at least K consecutive evaluation cycles.

### 1.3 Set the Monitoring Schedule

```yaml
schedule:
  leaderboard_scrape: "0 6 * * *"    # daily at 6am
  research_ingest:    "0 7 * * 1"    # weekly on Monday
  experiment_sweep:   "0 8 * * *"    # daily at 8am
  report_digest:      "0 9 * * 1"    # weekly digest on Monday
```

---

## Phase 2 — Competitive Monitoring

On each scheduled run, update the competitive landscape before doing anything else.

### 2.1 Scrape Leaderboards

For each leaderboard in the registry:
1. Fetch the current rankings.
2. Compare against the stored snapshot from the previous run.
3. Detect changes: new entrants, score improvements, rank shifts.
4. Update `competitive_registry.yaml` with the latest scores.

Emit a **competitive delta report** on any change:
```
[ALERT] CompetitorA improved on MemoryBench: 0.847 → 0.861 (+0.014)
[ALERT] New entrant: StartupX at 0.855 — now ranked #2, ahead of us
[STATUS] Our rank: #3 | Gap to #1: -0.038
```

### 2.2 Compute the Gap Matrix

Produce a ranked table after every scrape:

```
| Rank | System       | MemoryBench | LongContextEval | Δ to Our Score |
|------|--------------|-------------|-----------------|----------------|
| #1   | CompetitorA  | 0.861       | 0.812           | -0.038         |
| #2   | StartupX     | 0.855       | 0.798           | -0.032         |
| #3   | OurSystem    | 0.823       | 0.791           | —              |
| #4   | CompetitorB  | 0.801       | 0.764           | +0.022         |
```

The **gap to #1** on each leaderboard is the primary input to Phase 3.

### 2.3 Trigger Logic

- If our rank drops (competitor overtook us): immediately trigger Phase 4 with **urgent** priority.
- If gap to #1 widens beyond a threshold: trigger a research ingest cycle.
- If we are already #1 by the victory margin: run a maintenance sweep to defend the position.

---

## Phase 3 — Research Ingestion Pipeline

Continuously pull the latest research and translate it into actionable improvement candidates.

### 3.1 Paper Sources to Monitor

Configure sources in `research_config.yaml`:

```yaml
research_sources:
  arxiv_queries:
    - "memory augmented neural networks"
    - "long context transformers 2026"
    - "retrieval augmented generation benchmark"
  venues:
    - ICLR 2026
    - NeurIPS 2025
    - ICML 2026
  competitor_blogs:
    - https://competitor-a.ai/research
  citation_tracking:
    - track papers that cite our core method
```

### 3.2 Paper Processing Protocol

For each new paper found:

1. **Relevance screen**: does it benchmark on our target leaderboard(s) or report SOTA on our domain?
2. **Technique extraction**: identify every architectural change, training trick, data strategy, or inference optimization the paper claims is responsible for improvement.
3. **Applicability assessment**: for each technique, answer:
   - Can it be applied to our architecture without a full redesign?
   - Estimated implementation effort: Low / Medium / High
   - Estimated score impact (based on paper's reported gains): Low (<1%) / Medium (1–3%) / High (>3%)
4. **Prioritize** by: (estimated impact) × (1 / effort).
5. Log to `research_log.md`:

```markdown
## [2026-02-10] Paper: "HyperMemory: Hierarchical State Spaces for Long-Context Recall"

**Source:** arXiv:2602.XXXXX
**Relevant leaderboard:** MemoryBench
**Reported gain:** +4.2% on MemoryBench vs prior SOTA
**Techniques extracted:**
- Hierarchical state compression (effort: Medium, impact: High) ← PRIORITIZED
- Cosine decay + warmup schedule (effort: Low, impact: Low)
- Synthetic data augmentation for long-range dependencies (effort: High, impact: Medium)
**Action:** Generate hypothesis for hierarchical state compression — schedule experiment.
```

### 3.3 Competitor Architecture Reverse-Engineering

When a competitor publishes a technical report or open-sources code:
- Extract every architectural and training detail.
- Diff against our current architecture.
- Flag differences as candidate experiments.

---

## Phase 4 — Improvement Hypothesis Generation

Translate the competitive gap and research findings into a ranked experiment queue.

### 4.1 Hypothesis Format

Each hypothesis must state:

```yaml
hypothesis:
  id: H-042
  title: "Hierarchical state compression reduces long-context forgetting"
  claim: "Applying hierarchical state compression to our memory module will
          improve MemoryBench accuracy from 0.823 to ≥0.850"
  source: arXiv:2602.XXXXX + gap analysis (gap to #1 = 0.038)
  target_leaderboards: [MemoryBench]
  implementation:
    change: "Replace flat KV cache with 3-level hierarchical compression"
    effort: Medium
    estimated_gain: +0.027
  priority_score: 8.1   # (estimated_gain / effort_score) × urgency_multiplier
  status: queued
```

### 4.2 Experiment Queue Management

Maintain a `experiment_queue.yaml` ranked by `priority_score`:
- **Urgent** (rank drop detected): run immediately, single seed first for a fast signal.
- **Normal**: run in scheduled daily sweep.
- **Low priority**: run only when compute budget allows.

Limit the queue to the top 10 active hypotheses. Archive superseded ones.

### 4.3 Architecture Tweak Proposals

For tweaks that don't come from papers (e.g., hyperparameter tuning):
- Use the gap size to determine search strategy:
  - Gap < 1%: targeted fine-grained search (LR, weight decay).
  - Gap 1–5%: component-level ablation (attention heads, layer depth, context window).
  - Gap > 5%: architectural change required — escalate to research team with a written brief.

---

## Phase 5 — Automated Experiment Execution

### 5.1 Directory Structure

```
experiments/
├── queue/              # pending hypotheses (YAML files)
├── active/             # currently running
├── results/
│   └── <hypothesis_id>/
│       ├── config.yaml
│       ├── metrics.json
│       ├── train.log
│       └── eval_on_leaderboard.json
├── promoted/           # configs promoted to production
└── archived/           # failed or superseded experiments
```

### 5.2 Runner Behavior

The automated runner:
1. Picks the highest-priority item from the queue.
2. Runs a **fast validation** (1 seed, subset of data) to catch implementation bugs. If it fails, move to `archived/` with failure notes. Do not waste full compute on broken configs.
3. If fast validation passes, run the **full experiment** (3+ seeds, full eval suite).
4. Write results to `results/<hypothesis_id>/metrics.json`.
5. Compare against the current production score.
6. Move to either `promoted/` or `archived/` based on Phase 5 promotion logic.
7. Start the next item in the queue.

### 5.3 Reproducibility Requirements

- All configs stored as YAML — no hardcoded values in scripts.
- Exact dependency versions pinned (`requirements.lock`).
- Fixed seeds applied to all RNG sources.
- Deterministic evaluation (disable dropout at eval, fixed batch order).

### 5.4 Failure Handling

- Failed run (crash/OOM): retry once, then archive with full error log.
- Result below baseline: archive immediately with gap analysis notes.
- Inconclusive result (mean improvement < threshold, high std): schedule an extended run with more seeds before deciding.

---

## Phase 6 — Promotion Decision

A new configuration is promoted to production only when all of the following are true:

| Criterion | Requirement |
|-----------|-------------|
| Primary metric improvement | ≥ `promotion_threshold` above current production score |
| Statistical significance | p < 0.05 on paired t-test vs production config |
| No regression on secondary metrics | Latency within 10%, memory within 15% |
| Reproducibility | Consistent across ≥ 3 seeds (std < 0.5% of mean) |
| Leaderboard projection | If promoted, would we reach or exceed #1? |

If promotion is approved:
1. Write the new config to `promoted/` with a timestamp.
2. Update `competitive_registry.yaml` → `our_solution.current_scores`.
3. Trigger a leaderboard submission if the target supports API submission.
4. Log the promotion event in `CHANGELOG.md`.

If rejected, write a clear rejection note explaining which criterion failed.

---

## Phase 7 — Continuous Monitoring and Defense

Once at #1, the system switches to **defense mode**:

- Run the full eval suite on the production config on every scheduled cycle.
- Alert immediately if our score regresses (environment drift, data drift, dependency update).
- Watch for new leaderboard entrants within 5% of our score — pre-emptively queue experiments.
- Re-enter **attack mode** the moment any competitor overtakes us.

---

## Phase 8 — Stakeholder Reporting

Produce two report types automatically:

### 8.1 Weekly Digest (for leadership / product)

```markdown
# Benchmark Digest — Week of YYYY-MM-DD

## Competitive Position
- MemoryBench: #1 ✅ (our score: 0.871 | gap to #2: +0.010)
- LongContextEval: #2 ⚠️  (our score: 0.812 | gap to #1: -0.006)

## What Changed This Week
- Promoted H-042 (hierarchical compression): +0.031 on MemoryBench
- CompetitorA improved LongContextEval to 0.818 — now ahead of us

## Next Actions (Automated)
- Experiment H-047 (synthetic data aug) queued for LongContextEval — est. gain +0.009
- Research ingest scheduled for Monday

## Experiments Run This Week
- 4 experiments completed | 3 failed fast validation | 1 promoted
```

### 8.2 Technical Log (for engineers / researchers)

Full structured log at `TECHNICAL_LOG.md`:
- Every experiment run with config, metrics, and outcome.
- Every paper ingested with extracted techniques and disposition.
- Every promotion and rejection with full rationale.
- Current experiment queue with priority scores.

Engineers should be able to review the log in under 5 minutes and understand exactly what the system did and why.

---

## Principles

- **The system runs itself.** Engineers should only intervene for High-effort architectural changes that exceed automated scope — not for routine benchmark runs.
- **Competitive rank is the north star.** Every experiment exists to close the gap to #1, not to satisfy academic curiosity.
- **Speed over perfection on urgency.** When a competitor overtakes us, run a fast 1-seed signal first. A rough answer in hours beats a perfect answer in days.
- **Never tune on the test set.** If the leaderboard uses a hidden test set, never use it for development decisions.
- **Transparency over automation comfort.** Every automated decision (promote / reject / archive) must be logged with a reason a human can audit.
- **Research is a feed, not a manual task.** Papers are inputs to a pipeline, not homework for researchers.
- **Failed experiments have value.** Log what didn't work and why — this prevents re-running the same dead ends.

---

## Quick-Start Checklist

**One-time setup:**
- [ ] `competitive_registry.yaml` populated with leaderboards and competitors
- [ ] Victory condition defined per leaderboard
- [ ] `research_config.yaml` configured with paper sources and domain queries
- [ ] Scheduler configured (cron / CI pipeline / Airflow / GitHub Actions)
- [ ] Runner script deployed and tested on one hypothesis end-to-end

**Each automated cycle (verify the system does this):**
- [ ] Leaderboards scraped and gap matrix updated
- [ ] Competitive delta report generated
- [ ] New papers screened and techniques extracted
- [ ] Experiment queue re-ranked
- [ ] Highest-priority experiment run
- [ ] Promotion decision made and logged
- [ ] Weekly digest sent to stakeholders

**Escalate to humans only when:**
- [ ] Gap to #1 > 5% and no queued hypothesis is projected to close it
- [ ] A competitor's architecture cannot be reverse-engineered from public sources
- [ ] A promoted config causes a latency or cost regression beyond automated thresholds
