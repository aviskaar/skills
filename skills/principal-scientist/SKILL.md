---
name: principal-scientist
description: Use this skill when managing a portfolio of research projects that require multiple parallel research tracks, competing hypotheses explored simultaneously, or a combination of autonomous research and continuous benchmarking. Activate when the user needs to coordinate multiple lead-researcher agents in parallel — each pursuing a distinct track or hypothesis — while maintaining a unified strategic direction. Also use this skill when research must be paired with continuous competitive benchmarking via the auto-benchmark skill to validate gains against real leaderboards.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: research, orchestration, portfolio, multi-agent, parallel, strategy, principal, benchmarking
  sub-skills:
    - lead-researcher
    - auto-benchmark
    - hypothesis-generation
    - literature-synthesis
    - experiment-design
    - code-replication
    - research-paper-review
    - research-writing
    - ieee-paper-generator
---

# Principal Scientist

Orchestrate a portfolio of parallel research tracks, each run by an independent Lead Researcher agent, while maintaining strategic coherence, eliminating duplication, and integrating continuous benchmarking through Auto-Benchmark.

---

## Overview

The Principal Scientist is the top-level orchestrator above Lead Researcher. It does not replace Lead Researcher — it spawns and manages multiple Lead Researcher instances in parallel, each owning a complete research track, and synthesizes their outputs into a unified strategic outcome.

**Architecture:**

```
Principal Scientist
├── [Thread 1] Lead Researcher — Track A
│       └── hypothesis-generation → literature-synthesis → experiment-design → ...
├── [Thread 2] Lead Researcher — Track B
│       └── hypothesis-generation → literature-synthesis → experiment-design → ...
├── [Thread N] Lead Researcher — Track N
│       └── ...
└── [Benchmark] Auto-Benchmark (continuous, attached to any thread or standalone)
        └── competitive monitoring → research ingestion → experiment queue → promotion
```

**When to spawn multiple Lead Researchers:**
- Multiple competing hypotheses warrant parallel exploration
- Independent research problems share compute and timeline budgets
- A competitive threat requires exploring several closure strategies simultaneously
- The user wants breadth-first coverage before committing to a single direction

**When to attach Auto-Benchmark:**
- A production system exists whose competitive rank must be defended or improved
- Any Lead Researcher track produces results that should be validated against live leaderboards
- The user wants continuous progress tracking independent of the paper pipeline

---

## Phase 0 — Mission Intake

Collect the research mission before designing the portfolio. Ask explicitly for any missing inputs.

### Required inputs

| # | Question | Why it matters |
|---|----------|----------------|
| 1 | What is the overarching research mission or objective? | Sets the strategic frame for all tracks |
| 2 | Are there multiple hypotheses, problems, or directions to explore, or one to pursue in depth? | Determines number of Lead Researcher threads |
| 3 | Is there an existing production system that should be benchmarked against competitors? | Gates Auto-Benchmark integration |
| 4 | What is the total compute and time budget across all tracks? | Governs resource allocation in Phase 1 |
| 5 | What is the target output? (unified paper / per-track papers / portfolio report / leaderboard rank) | Determines synthesis strategy in Phase 5 |
| 6 | Should tracks converge (winner-takes-all) or remain independent (parallel publications)? | Sets the Phase 4 synthesis model |

### Output of Phase 0

Produce a **Research Mission Brief** (markdown, ~1 page):
- Mission statement (one sentence)
- Proposed tracks (list with one-line scope per track)
- Benchmark integration plan (yes/no, which system, which leaderboards)
- Resource allocation sketch (% of budget per track)
- Convergence strategy (winner-takes-all / parallel / synthesis)

Get explicit user confirmation before proceeding to Phase 1.

---

## Phase 1 — Portfolio Design

Design the thread structure and assign each Lead Researcher its scope.

### 1.1 Thread Registry

Create and maintain a **Thread Registry** throughout the session:

```
## Thread Registry

| ID  | Track Name              | Lead Researcher Scope               | Status    | Priority |
|-----|-------------------------|-------------------------------------|-----------|----------|
| T-1 | Hierarchical Attention  | Hypothesis: attention compression   | active    | high     |
| T-2 | Sparse Retrieval        | Hypothesis: sparse KV selection     | active    | medium   |
| T-3 | Synthetic Data Aug      | Hypothesis: data diversity improves | queued    | low      |
| BM  | Auto-Benchmark          | Competitive monitoring + defense    | running   | —        |
```

### 1.2 Scope Definition per Thread

For each thread, define before spawning the Lead Researcher:
- **Research question**: one sentence
- **Entry point**: which Lead Researcher stage to start from (full pipeline / mid-pipeline entry)
- **Boundary**: what this thread should NOT investigate (avoids overlap with other threads)
- **Budget**: compute and time allocation
- **Convergence gate**: the stage at which this thread's output will be compared to others

### 1.3 Deduplication Check

Before spawning, scan all thread scopes for overlap:
- Flag any two threads whose hypotheses or methods are within 80% semantic overlap
- Either merge them into one thread or explicitly differentiate their scope
- No two threads should reach experiment design pursuing the same method variant

---

## Phase 2 — Parallel Execution

Spawn and monitor all Lead Researcher threads.

### 2.1 Spawning Lead Researchers

Each Lead Researcher thread is an independent invocation of the `lead-researcher` skill with:
- The scoped Research Brief from Phase 1 as input
- Clear stage boundaries (which stages to run before returning a checkpoint)
- Awareness of other threads (to avoid citing the same literature gaps as unique)

Operate threads as sub-agents: each runs autonomously within its scope and surfaces outputs at defined checkpoints.

### 2.2 Parallel Stage Synchronization

Synchronize threads at these checkpoints before any single thread advances past a gate:

| Checkpoint | Trigger | Action |
|------------|---------|--------|
| Post-Stage 1 (Research Brief) | All threads complete Stage 1 | Cross-review briefs; eliminate overlap; reallocate budget |
| Post-Stage 3 (Literature Synthesis) | All threads complete Stage 3 | Deduplicate gap statements; identify shared baselines |
| Post-Stage 5 (Experiment Design) | All threads complete Stage 5 | Compare ablation plans; merge shared infrastructure |
| Post-Stage 7 (Draft) | All threads complete Stage 7 | Select tracks for unified output or promote independently |

At each checkpoint, the Principal Scientist reviews outputs from all threads before any thread advances.

### 2.3 Thread Health Monitoring

After each checkpoint, assess each thread:

```
## Thread Health — [Checkpoint Name]

T-1: ✅ On track — hypothesis differentiated, gap confirmed
T-2: ⚠️  Overlap with T-1 detected at Stage 3 — recommend scope adjustment
T-3: ❌ Blocked — hypothesis already addressed by 2026 SOTA paper
BM:  ✅ Running — current rank #2, gap to #1: -0.012
```

**Thread actions:**
- **Accelerate**: increase budget allocation; prioritize in scheduling
- **Continue**: proceed normally
- **Scope-adjust**: narrow or redirect the thread's hypothesis before next stage
- **Pause**: hold at current stage until another thread's findings clarify direction
- **Terminate**: stop the thread; archive its output; reallocate budget

---

## Phase 3 — Auto-Benchmark Integration

Attach the `auto-benchmark` skill when competitive rank matters alongside research output.

### 3.1 When to Activate Auto-Benchmark

Activate independently from Lead Researcher threads when:
- A production system is deployed and must maintain or improve competitive rank
- Any Lead Researcher thread reaches Stage 5 with a testable hypothesis that can be run against a live leaderboard
- The user requests continuous competitive monitoring regardless of research pipeline status

### 3.2 Auto-Benchmark ↔ Lead Researcher Interface

These two systems share information in both directions:

**Lead Researcher → Auto-Benchmark:**
- When a Lead Researcher thread completes Stage 5 (Experiment Design), surface the validated hypothesis as a candidate for Auto-Benchmark's experiment queue
- Provide: hypothesis YAML, estimated gain, effort score, target leaderboard
- Auto-Benchmark will prioritize it using its own scoring and run it in its autonomous loop

**Auto-Benchmark → Lead Researcher:**
- When Auto-Benchmark detects a gap to #1 that exceeds 5% (requiring architectural change), escalate to the Principal Scientist
- Principal Scientist may spawn a new Lead Researcher thread to investigate the gap
- Gap analysis and competitive delta reports from Auto-Benchmark inform hypothesis generation in new threads (use as Stage 1 input)

### 3.3 Benchmark-Driven Research Sprint

When a competitor overtakes the production system (Auto-Benchmark Phase 2 alert):

1. Principal Scientist immediately convenes an urgent portfolio review.
2. Spawn 2–3 Lead Researcher threads focused exclusively on closing the gap (skip Stages 1–2 if hypothesis is already in the registry; enter at Stage 3 or 5).
3. Assign Auto-Benchmark to run fast 1-seed validations of any promising thread output.
4. First thread to produce a validated improvement above the promotion threshold wins; others pause.

---

## Phase 4 — Cross-Thread Synthesis

After threads reach the convergence gate defined in Phase 1, synthesize their outputs.

### 4.1 Convergence Modes

**Winner-Takes-All:**
- Compare all threads on experiment results (primary metric, statistical significance)
- Select the best-performing track as the primary research contribution
- Incorporate secondary insights from losing tracks into the Related Work or Discussion sections
- Terminate all other threads; consolidate the winner's Lead Researcher through Stage 8

**Parallel Publications:**
- Each thread produces an independent manuscript
- Principal Scientist ensures no two manuscripts make overlapping novelty claims
- Flag any result from one thread that supersedes or contradicts another; resolve before submission

**Synthesis Paper:**
- Combine findings from all threads into a single unified paper
- The Principal Scientist coordinates the Research Writing stage across threads
- Contributions section explicitly attributes which thread produced each result
- Run a consistency check: all threads must agree on shared baselines, metrics, and dataset splits

### 4.2 Synthesis Checklist

Before producing the final output, verify across all contributing threads:
- [ ] No two threads make the same novelty claim
- [ ] All threads use identical baselines and dataset splits for fair comparison
- [ ] Contradictory results between threads are acknowledged and explained, not hidden
- [ ] All threads cite each other's contributions where relevant
- [ ] Auto-Benchmark results are reconciled with paper-reported numbers (no discrepancy > 1%)

---

## Phase 5 — Portfolio Review & Direction

At each synchronization checkpoint (Phase 2.2), conduct a formal portfolio review.

### 5.1 Portfolio Status Report

Produce after every checkpoint:

```markdown
## Portfolio Review — [Date] — [Checkpoint]

### Mission: [One sentence]

### Thread Status
| Thread | Stage | Status    | Key Finding So Far          | Recommended Action |
|--------|-------|-----------|-----------------------------|--------------------|
| T-1    | 5     | on-track  | Gap confirmed, plan solid   | Accelerate         |
| T-2    | 3     | scope-adj | Overlap with T-1 at Stage 3 | Redirect to T-2b   |
| T-3    | 1     | paused    | Waiting on T-1 lit results  | Resume after T-1   |
| BM     | —     | running   | Rank #2, gap = -0.012       | Feed T-1 gap data  |

### Resource Reallocation
- T-1 promoted to 60% of compute budget (was 40%)
- T-3 delayed until T-1 Stage 5 output available

### Open Decisions for User
1. Should T-2 pivot to "sparse retrieval with learned gates" (T-2b) or be terminated?
2. Auto-Benchmark is projecting rank #1 if T-1 hypothesis validates — confirm leaderboard submission?
```

### 5.2 Escalation to User

Always escalate to the user (do not auto-decide) when:
- A thread termination would eliminate the only path to the research mission
- Two threads produce contradictory results that cannot be resolved analytically
- Auto-Benchmark detects a competitor publishing the same hypothesis before any thread reaches Stage 7
- Total budget consumed exceeds 80% with no thread past Stage 5

---

## Phase 6 — Final Output

After synthesis, deliver the final portfolio output.

### 6.1 Output by Convergence Mode

| Mode | Final Artifact |
|------|----------------|
| Winner-takes-all | Single manuscript from winning thread + archived summaries of others |
| Parallel publications | N independent manuscripts, each with cross-references |
| Synthesis paper | One unified manuscript + per-thread contribution appendix |
| Benchmark-only | Auto-Benchmark promotion log + technical report on implemented gains |

### 6.2 Principal Scientist Handoff Summary

Always produce a **Portfolio Handoff Summary** regardless of convergence mode:

```markdown
## Portfolio Handoff Summary

**Mission:** [One sentence]
**Outcome:** [Achieved / Partially achieved / Pivoted — explain]

**Threads run:** N total | M completed | K terminated | J paused
**Benchmark status:** Rank [#N] on [leaderboard] | Gap to #1: [value]

**Key findings:**
- T-1: [One-line result]
- T-2: [One-line result]

**Final output(s):** [Link / description of each manuscript or report]

**Open items before submission:**
1. [Item]
2. [Item]

**Lessons for next portfolio cycle:**
- [What worked across threads]
- [What caused thread termination / scope adjustment]
```

---

## Cross-Cutting Principles

### Thread Independence
Each Lead Researcher thread must be able to produce a valid output independently. No thread should depend on another thread's Stage 5+ output to complete its own Stage 5. Dependencies are only allowed at synthesis (Phase 4).

### Shared Infrastructure, Separate Claims
Threads may share code, datasets, and compute setup. They must not share novelty claims. The Principal Scientist is the only agent that decides if two claims are in conflict.

### Budget Discipline
Total compute across all threads must not exceed the budget set in Phase 0. If a thread requires more than its allocation, the Principal Scientist must either reduce other threads' allocations or pause the requesting thread — never silently over-spend.

### No Fabrication
Inherited from Lead Researcher: no fake data, invented citations, fabricated results, or placeholder content intended for final output at any stage.

### Research Log Aggregation
Each Lead Researcher maintains its own Research Log. The Principal Scientist maintains a **Portfolio Log** that aggregates checkpoints, decisions, thread health, and resource changes. The Portfolio Log is the audit trail for the full portfolio.

---

## Quick-Start Paths

| User intent | Configuration |
|-------------|---------------|
| "Explore N competing hypotheses in parallel" | N Lead Researcher threads (winner-takes-all); no Auto-Benchmark unless production system exists |
| "We need to hold #1 on the leaderboard while doing research" | 1–2 Lead Researcher threads + Auto-Benchmark in defense mode; threads feed experiment queue |
| "A competitor just beat us — find and close the gap fast" | Benchmark-driven sprint (Phase 3.3): 2–3 urgent threads, Auto-Benchmark for fast validation |
| "Run two independent research projects under one portfolio" | 2 Lead Researcher threads (parallel publications); no convergence gate |
| "Explore broadly, then commit to the best path" | 3 Lead Researcher threads to Stage 3 only; review; promote one thread to full pipeline |
| "I have results from two parallel experiments, write both papers" | Enter at Phase 4 (synthesis); both threads start at Stage 7 |

---

## Output Summary

| Phase | Artifact |
|-------|----------|
| 0 | Research Mission Brief (confirmed by user) |
| 1 | Thread Registry with scopes and budget allocation |
| 2 | Per-checkpoint Thread Health Report |
| 3 | Auto-Benchmark integration plan; benchmark-driven sprint plan (if triggered) |
| 4 | Cross-thread synthesis (unified or parallel manuscripts) |
| 5 | Portfolio Review Reports at each checkpoint |
| 6 | Final output(s) + Portfolio Handoff Summary |
| All | Portfolio Log with all decisions, thread status changes, and resource reallocations |
