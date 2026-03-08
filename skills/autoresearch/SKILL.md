---
name: autoresearch
description: Use this skill when you want to run an autonomous ML research loop that iteratively modifies training code, runs timed experiments, evaluates a single metric, and keeps only improvements — repeating indefinitely until manually stopped. Activate when the user wants to autonomously discover better model architectures, hyperparameters, or training strategies overnight or over a defined session, with full cross-platform support (CUDA / Apple Silicon MPS / CPU / Windows).
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: research, autonomous, ml-training, experiment-loop, hyperparameter-search, architecture-search, overnight, cross-platform, cuda, mps, apple-silicon
---

# AutoResearch

Autonomously run an indefinite ML research loop: modify training code, run a timed experiment, measure one metric, keep improvements, discard regressions — repeat until manually stopped. Inspired by Karpathy's autoresearch and extended with cross-platform support (CUDA / Apple Silicon MPS / CPU / Windows) and user-configurable experiment parameters.

---

## Overview

AutoResearch turns an AI agent into a tireless overnight researcher. Given a training codebase and a metric to minimize (or maximize), the agent continuously proposes code modifications, runs fixed-budget training runs, logs results, and builds a growing record of what works — without requiring human involvement between iterations.

**The core loop:**

```
┌──────────────────────────────────────────────────────────────────┐
│                     AUTONOMOUS RESEARCH LOOP                      │
│                                                                   │
│  [1] Read current     [2] Propose          [3] Apply change       │
│      codebase     →       modification →       to train.py        │
│         ↑                                          ↓              │
│  [7] Keep / discard   [5] Evaluate         [4] Commit &           │
│      & iterate    ←       metric       ←       train (T min)      │
│         ↑                                          ↓              │
│  [6] Log to           ──────────────────────────────              │
│      results.tsv                                                  │
└──────────────────────────────────────────────────────────────────┘
```

**Key design principles (from Karpathy's autoresearch):**
- Only one file is ever modified (`train.py` or its equivalent) — data prep and evaluation are read-only
- One metric rules everything — lower (or higher) is better, no multi-objective confusion
- Fixed time budget per experiment — ensures fair, comparable runs regardless of architecture size
- No human interruption — the agent runs indefinitely until manually stopped
- Results logged to `results.tsv` — a permanent, auditable record

---

## Phase 0 — User Configuration (Ask Before Starting)

Before touching any code, collect all required parameters. Ask explicitly for any missing values.

### Required inputs

| # | Parameter | Description | Default if omitted |
|---|-----------|-------------|-------------------|
| 1 | **Training script path** | Path to the file the agent will modify (e.g., `train.py`) | `train.py` in cwd |
| 2 | **Read-only script path** | Path to the file the agent must never modify (e.g., `prepare.py`) | `prepare.py` in cwd |
| 3 | **Time budget per experiment** | How long each training run is allowed to run | Ask — do not assume |
| 4 | **Metric to optimize** | Metric name and direction (`minimize val_bpb`, `maximize val_acc`, etc.) | Ask — do not assume |
| 5 | **Max iterations** | How many experiment cycles to run (or `unlimited` for indefinite) | `unlimited` |
| 6 | **Allowed modification scope** | What can be changed: architecture / hyperparameters / optimizer / all | `all` |
| 7 | **Branch tag** | Short identifier for the research branch (e.g., `mar8`, `exp-attention`) | Date-based (e.g., `mar8`) |
| 8 | **Results file** | Where to log results | `results.tsv` in cwd |

### User-decided parameters (do not hardcode these)

The original autoresearch fixed the training window at 5 minutes. This skill lets the user choose:

```
"How long should each training run be? (e.g., 3 minutes, 10 minutes, 30 minutes)"
```

Likewise, the user decides:
- What metric to track (val_bpb, val_loss, accuracy, F1, perplexity — anything the eval harness reports)
- Whether to minimize or maximize it
- How many iterations to attempt before stopping (or run indefinitely)
- Which parts of the code are in scope for modification

### Output of Phase 0 — Research Config

Produce and confirm a **Research Config** before proceeding:

```markdown
## AutoResearch Config

| Parameter              | Value                          |
|------------------------|-------------------------------|
| Training script        | train.py                      |
| Read-only script       | prepare.py                    |
| Time budget / run      | [USER SPECIFIED]              |
| Metric                 | [METRIC NAME] ([min/max])     |
| Max iterations         | [N or unlimited]              |
| Modification scope     | [architecture / hyper / all]  |
| Branch                 | autoresearch/[TAG]            |
| Results file           | results.tsv                   |
| Platform               | [detected — see Phase 1]      |
```

Get explicit user confirmation before starting Phase 1.

---

## Phase 1 — Platform Detection & Environment Setup

Detect the compute backend and configure the training environment accordingly.

### 1.1 Platform Detection

Run this detection sequence before touching any training code:

```python
# Pseudo-detection logic (adapt to actual runtime)
import torch

if torch.cuda.is_available():
    platform = "CUDA"
    device = "cuda"
    notes = "FlashAttention-3 may be available; use torch.compile if supported"
elif hasattr(torch.backends, 'mps') and torch.backends.mps.is_available():
    platform = "MPS (Apple Silicon)"
    device = "mps"
    notes = "Disable torch.compile; use SDPA instead of FlashAttention; lower batch size for Metal bounds; cast optimizer states explicitly"
else:
    platform = "CPU"
    device = "cpu"
    notes = "Use smaller batch sizes; expect slower iteration; torch.compile may help"
```

**Windows note:** On Windows, MPS is not available. CUDA detection is the same as Linux. CPU fallback applies for systems without a supported GPU.

### 1.2 Platform-Specific Adjustments

Apply these adjustments based on detected platform before the first run:

| Platform | Adjustments |
|----------|-------------|
| **CUDA** | Enable `torch.compile` if PyTorch >= 2.0. FlashAttention available if installed. Standard batch sizes apply. |
| **MPS (Apple Silicon)** | Disable `torch.compile` (unsupported paths). Replace FlashAttention with PyTorch native SDPA + manual sliding window causal masking. Lower device batch size (reduce by 2–4×). Explicitly cast optimizer states to float32 if Metal errors appear. |
| **CPU** | Disable `torch.compile`. Use smaller batch sizes. Gradient accumulation to maintain effective batch. Expect 5–10× slower runs — advise user to use shorter time budgets. |

Log the detected platform and applied adjustments in the research config.

### 1.3 Branch & Baseline Setup

1. Create the research branch: `git checkout -b autoresearch/<tag>` from the main branch.
2. Read all three key files for full context:
   - **README.md** — repository overview and conventions
   - **[read-only script]** — understand the data pipeline, tokenizer, and evaluation harness. Never modify.
   - **[training script]** — understand the current model, optimizer, and training loop. This is the only file to modify.
3. Run the baseline training for the configured time budget. Record:
   - Baseline metric value
   - Peak memory usage (MB)
   - Model parameter count
4. Initialize `results.tsv` with a header row and the baseline entry:

```tsv
commit	val_bpb	mem_gb	status	description
baseline	[BASELINE_VALUE]	[MEM]	keep	Baseline — no modifications
```

---

## Phase 2 — Autonomous Experiment Loop

This loop runs indefinitely (or until the configured max iterations). **Do NOT pause to ask the human between iterations.** Work continuously.

### 2.1 Iteration Start

At the beginning of each iteration:
1. Check current git status — confirm working tree is clean.
2. Read the current `train.py` (or equivalent) in full.
3. Review the `results.tsv` to understand what has been tried and what worked.
4. Identify the best-performing configuration so far (lowest/highest metric based on direction).

### 2.2 Hypothesis Generation

Propose one focused modification per iteration. Good candidates include:

**Architecture changes:**
- Layer count (depth)
- Embedding dimension and attention heads
- Sequence length / context window
- Attention pattern (full / sliding window / mixed)
- Activation functions (ReLU, ReLU², SiLU, GELU)
- MLP expansion ratio
- Value residual / per-layer embeddings

**Optimizer changes:**
- Learning rate and schedule (warmup steps, cooldown shape)
- Weight decay schedule
- Optimizer type (AdamW, Muon, Lion, SGD variants)
- Gradient clipping
- Per-parameter learning rate multipliers

**Training dynamics:**
- Batch size and gradient accumulation
- Mixed precision (fp16, bf16)
- Dropout / stochastic depth
- Data ordering or curriculum

**Hypothesis discipline:**
- One change at a time — never bundle multiple independent modifications
- If the last N iterations all failed, try a significantly different direction
- If a change improved the metric, explore nearby variations before moving to a different dimension
- Prefer changes that are simple and interpretable over complex ones with equal effect

### 2.3 Apply, Commit, and Run

1. Apply the proposed change to the training script.
2. Commit with a descriptive message (e.g., `exp: try ReLU² activation instead of GELU`).
3. Run training for exactly the configured time budget. Redirect output to a log file.
4. Extract the metric value from training output using grep or equivalent.

```bash
# Example — adapt to actual metric name and log format
uv run train.py 2>&1 | tee run.log
VAL_BPB=$(grep "val_bpb:" run.log | tail -1 | awk '{print $2}')
```

### 2.4 Evaluate and Decide

Compare the extracted metric to the current best:

| Outcome | Action |
|---------|--------|
| **Improved** (metric better by any amount) | Keep the commit. Update current best. Mark `keep` in results. |
| **No change or regression** | Discard: `git reset --hard HEAD~1`. Mark `discard` in results. |
| **Crash / error** | Discard. Log the failure reason. Mark `crash` in results. Do not retry the same change. |
| **Memory OOM** | If on MPS: reduce device batch size by 2×, retry once. If still OOM: discard. If on CUDA: reduce batch or enable gradient checkpointing, retry once. |

**Simplicity principle (from Karpathy's autoresearch):** If two configurations achieve the same metric, prefer the one with fewer lines of code. A deletion that maintains performance is better than an addition.

### 2.5 Log Results

After every run (kept or discarded), append to `results.tsv`:

```
<7-char-commit>	<metric-value>	<mem_gb>	<keep|discard|crash>	<one-line description>
```

Example:
```tsv
a3f12bc	0.9821	43.2	keep	ReLU² activation: -0.0158 improvement
d9e44a1	1.0023	44.1	discard	Deeper MLP: regression
c0011f2	—	—	crash	OOM: doubled batch size without accumulation fix
```

### 2.6 Progress Reporting

Every 10 iterations (or when manually queried), emit a progress report:

```markdown
## AutoResearch Progress — Iteration [N]

**Best so far:** [METRIC_VALUE] (iteration [K], commit [HASH])
**vs. Baseline:** [DELTA] ([+/-]%)
**Iterations:** [N completed] / [max or unlimited]
**Time elapsed:** [HH:MM]

**Recent results (last 5):**
| Iter | Commit | Metric | Status | Change |
|------|--------|--------|--------|--------|
| N    | abc1234| 0.9821 | keep   | ReLU² activation |
| N-1  | def5678| 1.0023 | discard| Deeper MLP |
| ...  |        |        |        |        |

**Current direction:** [what the agent is exploring next]
```

---

## Phase 3 — Stopping and Reporting

The loop stops when:
- The user manually stops the agent
- The configured max iterations is reached
- The user's configured stop condition is met (if provided)

### 3.1 Final Summary

When stopped, produce a **Research Summary** document (`autoresearch-summary.md`):

```markdown
# AutoResearch Summary

**Research session:** autoresearch/<tag>
**Platform:** [CUDA / MPS / CPU]
**Date:** [date range]
**Total iterations:** [N]
**Time budget / run:** [T minutes]

## Results

| Baseline metric | Best metric | Improvement | Best commit |
|-----------------|-------------|-------------|-------------|
| [BASELINE]      | [BEST]      | [DELTA]     | [HASH]      |

## Top Improvements (kept commits)

| Rank | Commit | Metric | Description |
|------|--------|--------|-------------|
| 1    | abc123 | 0.9612 | [description] |
| 2    | def456 | 0.9744 | [description] |
| ...  |        |        |              |

## What Didn't Work

| Category | Description | Outcome |
|----------|-------------|---------|
| [category] | [description] | [why it failed] |

## Recommended Next Steps

- [3–5 actionable recommendations based on the session findings]
```

### 3.2 Merge Recommendation

After summarizing:
1. Show the user the list of kept commits and the final metric value.
2. Ask whether to merge the best-performing branch into main, or keep as-is.
3. If merging: squash or rebase per the user's preference. Never force-push main.

---

## Cross-Platform Compatibility Matrix

| Feature | CUDA (Linux/Windows) | MPS (macOS) | CPU (any OS) |
|---------|---------------------|-------------|--------------|
| `torch.compile` | ✅ Enabled | ❌ Disabled | ✅ Optional |
| FlashAttention | ✅ If installed | ❌ Use SDPA | ❌ Use SDPA |
| Sliding window attn | ✅ via FA or SDPA | ✅ SDPA + manual mask | ✅ SDPA + manual mask |
| Mixed precision (bf16) | ✅ | ✅ (M2+) | ❌ Use fp32 |
| `torch.compile` modes | `reduce-overhead` | Disabled | `reduce-overhead` |
| Batch size guidance | Full config | Reduce 2–4× | Reduce 4–8× |
| Optimizer state casting | Not needed | fp32 explicit cast | Not needed |

---

## Allowed Modifications Reference

The agent may only modify the training script (`train.py` or equivalent). It must never modify:
- The data preparation script (`prepare.py` or equivalent)
- The evaluation harness
- The tokenizer or vocabulary files
- Package dependency files

The agent must never install new packages mid-session (all dependencies must already be available).

---

## Integration with Research Team

AutoResearch is designed to plug directly into the research pipeline as a specialized experiment execution layer:

- **Receives from `lead-researcher`**: A hypothesis about a training approach to explore (e.g., "try hierarchical attention with reduced context window").
- **Receives from `experiment-design`**: A structured experiment plan specifying what to vary, what to hold fixed, and what metric to optimize.
- **Delivers to `principal-scientist`**: A `results.tsv` and `autoresearch-summary.md` with the best configuration found and all supporting evidence.
- **Delivers to `research-writing`**: A structured table of experiments suitable for the methodology and results sections of a paper.

When operating within the research team, the research config (Phase 0) is pre-populated by the `lead-researcher` or `experiment-design` teammates rather than entered manually by the user.

---

## Quick-Start Paths

| User intent | Entry point |
|-------------|-------------|
| "Run autoresearch overnight on my training script" | Phase 0 (full config) → Phase 1 → Phase 2 loop |
| "I have a hypothesis — test it and keep going" | Phase 0 (pass hypothesis as first iteration direction) → loop |
| "Run this for exactly 20 iterations and report" | Phase 0 (max_iterations=20) → loop → Phase 3 |
| "Continue a previous session" | Phase 1.3 (skip branch creation, re-read existing results.tsv) → Phase 2 |
| "Analyze what happened in last night's session" | Phase 3 only — summarize existing results.tsv |

---

## Output Summary

| Phase | Artifact |
|-------|----------|
| 0 | Research Config (confirmed by user) |
| 1 | Platform detection log, baseline entry in `results.tsv` |
| 2 | Growing `results.tsv` + per-iteration progress reports |
| 3 | `autoresearch-summary.md` with ranked improvements and recommendations |
