---
name: auto-benchmark
description: Use this skill when asked to benchmark, evaluate, or compare ML/AI experiments automatically. Guides end-to-end benchmark orchestration — defining metrics, running experiments across configurations, collecting results, and producing a structured comparison report with statistical analysis.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: benchmarking, evaluation, experiments, automation, ML, statistics
---

# Auto Benchmark

Automatically orchestrate, run, and report benchmarks across multiple experiment configurations.

## When to Use

Activate this skill when the user wants to:
- Compare multiple models, hyperparameters, or algorithmic variants on a shared evaluation suite
- Automate the full loop of experiment execution → metric collection → result aggregation
- Produce a reproducible benchmark report from a set of experiment configs

---

## Phase 1 — Benchmark Specification

Before running anything, lock down the scope:

### 1.1 Define the Evaluation Suite
- List every dataset or task included in the benchmark.
- Specify the exact split (test set, held-out fold, etc.) — never tune on the test set.
- Record dataset versions and checksums where possible.

### 1.2 Define Primary and Secondary Metrics
- **Primary metric**: the single metric used to rank configurations (e.g., accuracy, F1, BLEU, FID).
- **Secondary metrics**: reported for completeness (latency, memory, fairness metrics).
- Specify aggregation across tasks: macro-average, micro-average, or per-task.

### 1.3 Define the Configuration Space
List all configurations (models, hyperparameter settings, ablations) to benchmark as a structured table or YAML block:

```yaml
configurations:
  - name: baseline
    model: resnet50
    lr: 0.01
    epochs: 100
  - name: variant_a
    model: resnet50
    lr: 0.001
    epochs: 100
  - name: variant_b
    model: vit_small
    lr: 0.001
    epochs: 100
```

### 1.4 Set the Compute Budget
State: hardware (GPU type, count), wall-clock budget, and number of random seeds per configuration.

---

## Phase 2 — Environment and Reproducibility Setup

- Pin all dependency versions (`pip freeze > requirements.txt` or `conda env export`).
- Set and document a global random seed. Apply it to: Python `random`, `numpy`, `torch`/`tf`, and data loaders.
- Use a deterministic run flag where available (e.g., `torch.use_deterministic_algorithms(True)`).
- Store all configs as files (YAML/JSON), not hardcoded in scripts.

---

## Phase 3 — Automated Experiment Execution

### 3.1 Runner Script

Write or generate a runner that:
1. Iterates over every configuration in the spec.
2. Launches each run with the configured seed(s).
3. Captures stdout/stderr and writes to per-run log files.
4. Saves raw outputs (model checkpoints, predictions) to a structured results directory:

```
results/
└── <run_id>/
    ├── config.yaml       # exact config used
    ├── metrics.json      # all metrics for this run
    ├── train.log         # full training log
    └── predictions.pkl   # optional: raw outputs for reanalysis
```

### 3.2 Failure Handling
- Detect and log failed runs without stopping the full sweep.
- Re-run failed configurations up to 2 times before marking as failed.
- Report a summary of failed runs at the end.

### 3.3 Progress Tracking
- Print a progress summary after each run: `[3/12] variant_b seed=42 — primary_metric=0.847`.
- Estimate remaining time based on elapsed time per run.

---

## Phase 4 — Metric Collection and Aggregation

After all runs complete:

1. Parse `metrics.json` for each run.
2. Group runs by configuration name.
3. Compute across seeds:
   - **Mean** and **standard deviation** for each metric.
   - **Min** and **max** (to surface instability).
4. Rank configurations by mean primary metric.

Produce an aggregated results table:

```
| Configuration | Primary Metric (mean ± std) | Secondary Metric | Seeds |
|---------------|----------------------------|-----------------|-------|
| baseline      | 0.823 ± 0.004              | 142ms           | 3     |
| variant_a     | 0.851 ± 0.002              | 138ms           | 3     |
| variant_b     | 0.867 ± 0.006              | 201ms           | 3     |
```

---

## Phase 5 — Statistical Analysis

Do not rely on point estimates alone:

- **Significance test**: run a paired t-test or Wilcoxon signed-rank test between the best configuration and the baseline. Report p-value.
- **Effect size**: compute Cohen's d or equivalent. Flag whether the improvement is practically meaningful.
- **Confidence intervals**: report 95% CI for the primary metric of each configuration.

Flag any configuration where std > 1% of the mean as **high variance** — worth investigating further.

---

## Phase 6 — Benchmark Report

Produce a `BENCHMARK_REPORT.md` containing:

```markdown
# Benchmark Report

**Date:** YYYY-MM-DD
**Task:** <task description>
**Dataset:** <name, version, split>
**Primary Metric:** <metric name>
**Seeds per config:** N
**Hardware:** <GPU type, count>

## Summary

<1–3 sentence narrative of the key finding>

## Results Table

<aggregated results table from Phase 4>

## Statistical Analysis

<significance test results and effect sizes>

## Configuration Details

<full YAML for each configuration>

## Failure Log

<list of any failed runs with error summaries>

## Reproduction Instructions

<step-by-step commands to reproduce the full benchmark from scratch>
```

---

## Principles

- **Never cherry-pick seeds.** Report all seeds run, including ones with poor results.
- **Never tune on the test set.** If a configuration looks bad, investigate on validation data only.
- **Separate concerns.** Keep evaluation code independent from training code.
- **Preserve raw outputs.** Save enough artifacts to recompute any metric without rerunning.
- **Make failures visible.** A failed or high-variance run is a signal, not a problem to hide.

---

## Quick-Start Checklist

- [ ] Benchmark spec defined (datasets, metrics, configs)
- [ ] Environment pinned and seeds set
- [ ] Runner script written and tested on one config
- [ ] Full sweep complete with no silent failures
- [ ] Results aggregated with mean ± std
- [ ] Statistical significance checked
- [ ] `BENCHMARK_REPORT.md` produced and reviewed
