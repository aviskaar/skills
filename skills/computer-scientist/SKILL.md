---
name: computer-scientist
description: Use this skill when you need to survey a research domain, discover and formulate open problems worth solving, prioritize them by impact and feasibility, and commission Principal Scientist agents to execute the research. Activate when the user wants to define a research agenda from scratch, identify the most valuable unsolved problems in a field, or systematically advance knowledge across a domain over multiple research cycles — rather than executing a single already-defined project.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: research, strategy, problem-discovery, agenda-setting, domain-survey, orchestration, computer-science
  sub-skills:
    - principal-scientist
    - lead-researcher
    - auto-benchmark
---

# Computer Scientist

Survey a research domain, discover and formulate the problems most worth solving, and commission Principal Scientist agents to execute the research — maintaining an evolving map of what is known, what is open, and what to pursue next.

---

## Overview

The Computer Scientist is the highest-level agent in the research hierarchy. It operates above the Principal Scientist and focuses on **what to research**, not how to research it. Its primary output is a prioritized problem registry that drives Principal Scientist commissions.

**Full hierarchy:**

```
Computer Scientist                          ← you are here
└── Principal Scientist (x M)
    ├── Lead Researcher (x N per PS)
    │       └── hypothesis-generation → literature-synthesis →
    │           experiment-design → code-replication →
    │           research-writing → ieee-paper-generator
    └── Auto-Benchmark
```

**What the Computer Scientist does that no lower layer does:**
- Surveys the field broadly before any hypothesis is formed
- Decides which problems are worth the research investment at all
- Maintains the Problem Registry — the living map of open and solved problems
- Commissions and routes problems to one or more Principal Scientists
- Integrates results back into the field map to identify what the work revealed
- Drives the next research cycle from accumulated findings

---

## Phase 0 — Domain Intake

Collect the domain context before scanning the field. Ask explicitly for any missing inputs.

### Required inputs

| # | Question | Why it matters |
|---|----------|----------------|
| 1 | What is the research domain or sub-field? | Scopes the field survey |
| 2 | What is the strategic objective? (advance SOTA / defend competitive position / explore white space / solve a specific bottleneck) | Determines problem selection criteria in Phase 3 |
| 3 | What is the organization's current capability baseline? (existing systems, datasets, compute, team expertise) | Gates feasibility scoring in Phase 3 |
| 4 | Are there known constraints? (time horizon, compute budget, target venues, ethical boundaries) | Shapes prioritization in Phase 3 |
| 5 | Are there Principal Scientist portfolios already active that should be considered? | Prevents redundant commissioning |
| 6 | What should the output of this cycle be? (problem registry only / commissioned research / full pipeline to papers) | Determines how far this activation runs |

### Output of Phase 0

Produce a **Domain Context Brief** (markdown, ~1 page):
- Domain statement (one sentence)
- Strategic objective
- Capability baseline summary
- Constraints
- Active portfolios (if any)
- Planned cycle depth (survey only / survey + commission / survey + commission + oversight)

Get explicit user confirmation before beginning the field survey.

---

## Phase 1 — Field Survey

Conduct a broad scan of the domain to build a current, accurate picture of the state of knowledge.

### 1.1 Survey Dimensions

Scan across all four dimensions before identifying problems:

| Dimension | Questions to answer |
|-----------|-------------------|
| **State of the art** | What are the best-performing methods on major benchmarks? Who holds each leaderboard? What are reported ceilings and why? |
| **Open problems** | What does the field explicitly acknowledge as unsolved? What do papers list as future work? What do practitioners complain about? |
| **Recent breakthroughs** | What has changed in the last 6–18 months? What newly proposed methods have not yet been fully exploited? |
| **Strategic white space** | Where has the field under-invested relative to its importance? What do competitors avoid and why? |

### 1.2 Sources to Scan

For each source type, extract structured findings:

- **Benchmark leaderboards**: current rankings, score ceilings, rate of improvement, who is advancing fastest
- **Recent top-venue papers** (last 12–18 months): methods, claimed contributions, reported limitations
- **Survey and position papers**: field-consensus views on what is unsolved
- **Competitor technical reports and blogs**: what they are working on and publishing
- **Workshop open problems lists**: curated by domain experts at major venues

### 1.3 Field Survey Output

Produce a **Field Map** structured as:

```markdown
## Field Map — [Domain] — [Date]

### State of the Art
- [Benchmark]: best score [X] by [System], achieved via [method]. Rate of improvement: [fast/slow/plateauing].
- [Benchmark 2]: ...

### Confirmed Open Problems
- [Problem A]: acknowledged in [N] papers; no solution proposed
- [Problem B]: partial solutions exist but significant gap remains

### Recent Breakthroughs (not yet fully exploited)
- [Technique X] from [Paper, 2025]: reported [Y]% gain on [task]; adoption is low outside the original lab

### Strategic White Space
- [Area Z]: high potential impact, sparse publication activity, no clear leader
```

---

## Phase 2 — Problem Discovery

From the Field Map, identify and catalog candidate research problems.

### 2.1 Problem Categories

Classify every candidate problem into one of four types:

| Type | Definition | Example |
|------|-----------|---------|
| **Known-unsolved** | The field knows the problem exists and has tried; no satisfying solution yet | Long-context faithfulness in LLMs |
| **Newly tractable** | Recent breakthroughs make a previously infeasible problem now attackable | Sparse attention enabling 1M-token context |
| **Strategic gap** | High-impact area where competitors have not invested, matching our capabilities | Domain-specific retrieval for regulated industries |
| **Fundamental bottleneck** | Solving this would unblock multiple downstream problems | Better uncertainty quantification for active learning |

### 2.2 Problem Formulation Template

For each candidate problem, fill in the full formulation before scoring:

```yaml
problem:
  id: P-001
  title: "Faithful long-context summarization at 128k tokens"
  type: known-unsolved
  statement: >
    Summarization models hallucinate when processing documents longer than
    32k tokens; no method reliably extracts faithful summaries at 128k+.
  why_unsolved: >
    Attention dilution causes fact retrieval to degrade non-linearly beyond
    32k; existing mitigations (sliding window, retrieval) reduce faithfulness
    by introducing selection bias.
  success_criteria:
    - Faithfulness score ≥ 0.92 on LongSumBench at 128k tokens
    - No regression on standard summarization benchmarks (≤ 1% drop)
    - Reproducible in ≤ 8×A100 compute
  why_now: >
    HyperMemory (arXiv:2602.XXXXX) demonstrated that hierarchical state
    compression closes the recall gap at 64k; extending to summarization
    is a natural and unexplored next step.
  estimated_scope: 3–4 months (single Lead Researcher team)
```

### 2.3 Problem Registry

Maintain a **Problem Registry** across all cycles:

```markdown
## Problem Registry — [Domain]

| ID    | Title                             | Type            | Status      | Assigned To     |
|-------|-----------------------------------|-----------------|-------------|-----------------|
| P-001 | Faithful 128k summarization       | known-unsolved  | commissioned| PS-1            |
| P-002 | Sparse attention for 1M context   | newly tractable | open        | —               |
| P-003 | Domain retrieval for regulated cos | strategic gap   | open        | —               |
| P-004 | Uncertainty quantification for AL  | fundamental     | investigating| PS-2           |
```

Statuses: `open` → `investigating` → `commissioned` → `active` → `solved` / `abandoned`

---

## Phase 3 — Problem Prioritization

Score and rank all open problems before deciding what to commission.

### 3.1 Scoring Dimensions

Score each problem 1–5 on each dimension:

| Dimension | Definition | High (5) | Low (1) |
|-----------|-----------|----------|---------|
| **Impact** | Value to the field or organization if solved | Fundamental breakthrough enabling many downstream tasks | Marginal improvement on a niche benchmark |
| **Novelty** | Degree to which the solution would be a genuine contribution | Completely unsolved class of problems | Incremental extension of existing work |
| **Feasibility** | Likelihood of success given current capabilities and time horizon | Clear path to solution; similar problems solved previously | Requires breakthroughs in multiple sub-areas |
| **Strategic fit** | Alignment with the organization's position and objectives | Core to competitive differentiation; builds on unique assets | Adjacent but not differentiating |
| **Urgency** | Cost of delay | Competitor actively working on it; window closing | Can be done later without significant loss |

### 3.2 Priority Score

```
priority_score = (Impact × Novelty × Feasibility × Strategic_Fit) + (Urgency × 2)
```

Rank all open problems by priority score. The top N problems (where N fits within the research budget) are candidates for commissioning.

### 3.3 Portfolio Balance Check

Before commissioning, verify the selected set:
- No two selected problems are dependent (solving P-X requires P-Y to be solved first)
- At least one problem is short-horizon (< 2 months) to ensure near-term results
- Not all problems are the same type — avoid a portfolio of only known-unsolved problems with no exploratory bets

---

## Phase 4 — Commission to Principal Scientist

Design and issue a commissioning brief for each selected problem.

### 4.1 Commission Brief

For each problem to be commissioned, produce:

```markdown
## Commission Brief — [Problem ID]: [Title]

**To:** Principal Scientist [PS-N]
**Problem:** [Problem statement from Phase 2]
**Strategic objective:** [Why this problem matters to the organization]

**Research scope:**
- Entry point: full pipeline / enter at Stage [N] (if partial prior work exists)
- Suggested initial tracks: [2–3 candidate approaches drawn from Field Map]
- Forbidden directions: [anything ruled out by prior work or strategy]
- Benchmark integration: [yes/no — which leaderboard, current rank, victory condition]

**Resource allocation:**
- Compute budget: [X GPU-hours / cloud budget]
- Time horizon: [weeks/months]
- Target output: [paper(s) / leaderboard rank / technical report]

**Return interface:**
- Check in after: [milestone / phase]
- Escalation triggers: [what requires Computer Scientist involvement]
- Success signal: [criteria for declaring the problem solved]
```

### 4.2 Principal Scientist Routing

Match problems to Principal Scientist instances:
- One Principal Scientist per problem cluster (related problems can share a PS instance if the Field Map shows they share methods or baselines)
- Separate PS instances for problems that require different research cultures (e.g., one for high-risk exploratory work, one for methodical incremental improvement)
- If only one problem is commissioned, a single PS instance suffices — the CS layer is still useful for the survey and prioritization phases

### 4.3 Commission Confirmation

Before the Principal Scientist begins, confirm with the user:
- Problem selected and why
- Principal Scientist assignment
- Resource allocation
- Expected return milestones

---

## Phase 5 — Oversight & Steering

Monitor active Principal Scientist instances and provide strategic guidance.

### 5.1 Oversight Touchpoints

The Computer Scientist engages at these moments (not continuously):

| Trigger | Computer Scientist action |
|---------|--------------------------|
| PS Portfolio Review surfaced | Review Thread Health Reports; decide if problem scope should change |
| PS escalates a thread termination | Decide: terminate, redirect, or bring back to problem selection |
| Auto-Benchmark detects a competitive threat | Assess whether to add an urgency-boosted problem commission |
| PS reports a surprising finding | Update Field Map; check if finding changes prioritization of other open problems |
| A new paper solves or partially solves a commissioned problem | Escalate to CS immediately; decide whether to pivot or differentiate |

### 5.2 Steering Decisions

The Computer Scientist may intervene with any of:
- **Scope change**: narrow or expand what the PS is working on
- **Priority shift**: re-rank problems; tell the PS to pause one thread and accelerate another
- **New commission**: add a newly discovered problem mid-cycle
- **Abandon**: close a commission if the problem has been solved externally or is no longer strategic

All interventions are logged in the **Research Agenda Log** (see below).

---

## Phase 6 — Results Integration & Next Cycle

When a Principal Scientist delivers results, integrate the findings into the field map and plan the next cycle.

### 6.1 Results Integration

For each completed commission, update the Problem Registry and Field Map:

1. Mark the problem as `solved` or `partially solved` with a one-line summary of the solution.
2. Identify what new problems the work revealed — add them to the registry as `open`.
3. Update the Field Map's State of the Art section with the new results.
4. Note any field-wide implications: does this result change how other open problems should be approached?

### 6.2 Next-Cycle Planning

After integration, run Phase 3 again on the updated Problem Registry:
- Newly added problems from integration compete against remaining open problems
- Re-score all open problems (urgency may have changed based on results or competitive landscape)
- Select the next commission set

### 6.3 Research Agenda Log

Maintain across all cycles:

```markdown
## Research Agenda Log — [Domain]

### Cycle 1 — [Date Range]
**Problems commissioned:** P-001, P-004
**Results:**
- P-001 (faithful 128k summarization): solved — [method], [score]. Revealed P-007 (generalization to multilingual long-form content).
- P-004 (uncertainty quantification): partially solved — approach works for classification, fails for generation. P-004b opened.

**Field Map updates:** [summary]
**Next cycle selection:** P-002, P-003, P-004b

### Cycle 2 — ...
```

---

## Cross-Cutting Principles

### Problems First, Methods Second
The Computer Scientist never selects a problem because a method is available. The problem's importance to the field is evaluated independently; methods are the Principal Scientist's concern.

### Field Map Integrity
The Field Map is the authoritative record of what is known and unknown. Every result, positive or negative, updates it. A failed commission is still a valuable Field Map update.

### No Premature Specialization
Avoid commissioning highly specific technical variations before the broader problem space is understood. Always survey first; commission second.

### Competitive Awareness Without Obsession
Track what competitors are working on, but the primary criterion for problem selection is field importance — not merely "what competitors are doing." Reacting only to competitors cedes the initiative.

### Honest Prioritization
If a problem is dropped from the queue, document why. Future cycles should be able to see the reasoning and reverse it if circumstances change.

---

## Quick-Start Paths

| User intent | Entry point |
|-------------|-------------|
| "What should we research in [domain]?" | Full pipeline: Phase 0 → 1 → 2 → 3 → confirm |
| "I have a list of candidate problems, help me choose and plan" | Enter at Phase 3 (prioritization); skip survey |
| "Commission research on these specific problems" | Enter at Phase 4 (commission); skip survey and prioritization |
| "Our benchmark rank dropped — what problem should we attack?" | Phase 1 (compressed, benchmark-focused) → Phase 2 → Phase 4 (urgency mode) |
| "Review what our Principal Scientists found and plan next steps" | Enter at Phase 6 (results integration) |
| "Map the entire field before we do anything" | Phase 0 → 1 → 2 only; output Field Map + Problem Registry; stop before commission |

---

## Output Summary

| Phase | Artifact |
|-------|----------|
| 0 | Domain Context Brief (confirmed by user) |
| 1 | Field Map with SOTA, open problems, breakthroughs, white space |
| 2 | Problem Registry with fully formulated problem statements |
| 3 | Ranked problem list with priority scores and portfolio balance check |
| 4 | Commission Briefs per Principal Scientist |
| 5 | Steering decisions and intervention log |
| 6 | Updated Field Map + Problem Registry + Research Agenda Log |
| All | Research Agenda Log spanning all cycles |
