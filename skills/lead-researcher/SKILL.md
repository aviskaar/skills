---
name: lead-researcher
description: Use this skill when conducting a complete, end-to-end research project — from initial idea through hypothesis generation, literature review, experiment design, execution, optional replication or paper review, and final research writing. Orchestrates all available research sub-skills (hypothesis-generation, literature-synthesis, experiment-design, code-replication, research-paper-review, research-writing, ieee-paper-generator) into a single, coherent pipeline. Activate when the user wants to pursue a new research idea, replicate or extend a paper's results, or produce a publication-ready manuscript.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: research, orchestration, pipeline, end-to-end, hypothesis, literature, experiment, writing, lead
  sub-skills:
    - hypothesis-generation
    - literature-synthesis
    - experiment-design
    - code-replication
    - research-paper-review
    - research-writing
    - ieee-paper-generator
---

# Lead Researcher

Orchestrate a complete research project from initial idea to publication-ready output, invoking the right sub-skills at each stage.

---

## Overview

The Lead Researcher skill is the top-level conductor of the research pipeline. It does not replace the sub-skills — it routes to them at the appropriate moment, manages context across stages, and ensures continuity and coherence throughout the full research lifecycle.

**Pipeline stages:**

```
1. Intake & Scoping
       ↓
2. Hypothesis Generation        [→ hypothesis-generation]
       ↓
3. Literature Synthesis         [→ literature-synthesis]
       ↓
4. (Optional) Paper Review      [→ research-paper-review]
       ↓
5. Experiment Design            [→ experiment-design]
       ↓
6. (Optional) Code Replication  [→ code-replication]
       ↓
7. Research Writing             [→ research-writing / ieee-paper-generator]
       ↓
8. Final Review & Handoff
```

Stages 4 and 6 are conditional: invoke them when the user has a specific paper to critique or wants to replicate baseline results before proposing improvements.

---

## Stage 1 — Intake & Scoping

Before activating any sub-skill, collect the following information. If any item is missing, ask the user explicitly before proceeding.

### Required inputs
| # | Question | Why it matters |
|---|----------|----------------|
| 1 | What is the research topic or problem? | Scopes every subsequent stage |
| 2 | Do you have a starting hypothesis, or should one be generated? | Determines whether to begin at Stage 2 |
| 3 | Do you have a set of papers to review / synthesize, or should the agent identify them? | Scopes Stage 3 and 4 |
| 4 | Is there a specific paper whose results you want to replicate or extend? | Gates Stage 6 |
| 5 | What is the target output format? (internal report / conference paper / journal article / IEEE format) | Determines which writing sub-skill to activate in Stage 7 |
| 6 | What are the compute and time constraints? | Informs experiment design in Stage 5 |

### Output of Stage 1
Produce a **Research Brief** (markdown, ~1 page) summarizing:
- Research question (one sentence)
- Intended contribution (2–3 bullets)
- Planned pipeline path (which stages apply)
- Key constraints (compute, time, data access)

Get explicit user confirmation of the Research Brief before proceeding to Stage 2.

---

## Stage 2 — Hypothesis Generation

**Sub-skill:** `hypothesis-generation`

**Trigger:** Always (unless the user supplies a finalized hypothesis).

**Input from Stage 1:** Research question, known literature, surprising observation or gap.

**Actions:**
1. Frame the problem using the sub-skill's Problem Framing step.
2. Generate 3–5 candidate hypotheses with mechanisms, falsifiability checks, and minimal experiment descriptions.
3. Stress-test each candidate for confounds, scope, and prior coverage.
4. Produce a ranked table and recommend the top hypothesis.
5. Refine the top hypothesis into a paper-ready claim.

**Carry forward:** The refined hypothesis statement and the ranked hypothesis table.

---

## Stage 3 — Literature Synthesis

**Sub-skill:** `literature-synthesis`

**Trigger:** Always.

**Input from Stage 2:** Refined hypothesis, key concepts and keywords, any papers the user provided.

**Actions:**
1. Identify the scope: map the hypothesis to 2–4 relevant research threads.
2. Organize papers by methodology, chronology, and findings.
3. Write the structured synthesis: Background, Key Themes, Points of Consensus, Open Debates, Open Problems, Synthesis Conclusion.
4. Flag papers that directly test or contradict the hypothesis from Stage 2.
5. Identify the gap the hypothesis fills and confirm it is not already addressed.

**Carry forward:** Literature synthesis document, gap statement, and a curated reference list.

---

## Stage 4 — Paper Review (Conditional)

**Sub-skill:** `research-paper-review`

**Trigger:** When the user provides a specific paper to critique, or when a closely related paper poses a risk of scooping the hypothesis.

**Input from Stage 3:** Candidate paper, gap statement from literature synthesis.

**Actions:**
1. Apply the full structured review: Summary, Contributions, Methodology, Experiments, Limitations, Related Work, Verdict.
2. Specifically assess: Does this paper already address the hypothesis? If yes, escalate to the user immediately.
3. Identify weaknesses, open problems, and extension opportunities that the hypothesis from Stage 2 could address.

**Decision gate:** After the review, confirm with the user whether to:
- Proceed with the original hypothesis (it is sufficiently differentiated)
- Refine the hypothesis to differentiate further (loop back to Stage 2)
- Pivot to extending/replicating the reviewed paper (activate Stage 6)

**Carry forward:** Review report, identified differentiation points, updated hypothesis if revised.

---

## Stage 5 — Experiment Design

**Sub-skill:** `experiment-design`

**Trigger:** Always (after hypothesis is confirmed).

**Input from Stages 2–4:** Finalized hypothesis, literature-derived baselines, compute constraints.

**Actions:**
1. State the hypothesis as a falsifiable claim in the format required by the sub-skill.
2. Define independent and dependent variables; list controlled variables.
3. Select baselines at three levels (naive / standard / strong) using the literature synthesis to justify choices.
4. Specify datasets and splits; flag any data leakage or bias risks.
5. Choose metrics; specify statistical significance protocol (seeds, confidence intervals).
6. State compute budget and hardware assumptions.
7. Design a minimal ablation set that isolates each component's contribution.
8. Identify at least two failure modes and mitigations.

**Carry forward:** Structured experiment plan (markdown), baseline list with citations, ablation schedule.

---

## Stage 6 — Code Replication (Conditional)

**Sub-skill:** `code-replication`

**Trigger:** When the user wants to:
- Validate that a baseline from Stage 5 performs as reported before comparing against it, OR
- Extend a prior paper's method (requires reproducing it first), OR
- Demonstrate reproducibility as a research contribution in itself.

**Input from Stages 3–5:** Target paper, experiment plan, compute constraints.

**Actions:**
1. Paper Audit: extract all hyperparameters, identify ambiguities, locate official code.
2. Environment Setup: record exact package versions, fix random seeds.
3. Minimal Reproduction: run smallest experiment to confirm pipeline integrity.
4. Full Replication: run main experiment with reported settings; record all results.
5. Gap Analysis: compare reproduced results to paper's reported numbers; categorize gaps.
6. Produce `REPLICATION.md` with full documentation.

**Decision gate:** After gap analysis:
- **Reproduced / Close**: proceed to Stage 7 with confidence.
- **Discrepancy / Failed**: surface the finding to the user; decide whether to investigate further, use the discrepancy as a research finding, or adjust the experiment plan.

**Carry forward:** Replication report, gap analysis table, confirmed baseline numbers.

---

## Stage 7 — Research Writing

**Sub-skill:** `research-writing` (for drafts, sections, and iterative editing) or `ieee-paper-generator` (for a complete, publication-ready IEEE paper).

**Trigger:** Always (after experiment results are available or summarized by the user).

**Input from all prior stages:** Research Brief, hypothesis, literature synthesis, experiment plan, replication report (if applicable), experiment results.

### 7a — Section-by-Section Drafting (`research-writing`)

Use when producing an internal report, a preprint, or individual sections (abstract, introduction, related work, etc.):

1. **Abstract**: Follow the five-part structure (Motivation, Problem, Approach, Results, Significance). Keep to 150–250 words.
2. **Introduction**: Hook → Problem → Gap → Contributions (bulleted, verifiable) → Paper outline.
3. **Related Work**: Organized thematically using the literature synthesis from Stage 3.
4. **Methodology**: Draw from the experiment plan and replication notes.
5. **Results**: Present data from experiments; narrate tables — do not just report "our method is best."
6. **Conclusion**: Summary, takeaways, future work. No new claims.
7. **Editing pass**: Apply all style rules (active voice, precise quantifiers, acronym expansion, sentence length).

### 7b — Full IEEE Paper (`ieee-paper-generator`)

Use when the target output is a submission to an IEEE conference or journal:

1. Collect any missing inputs (authors, affiliations, target venue, page count).
2. Generate all sections in IEEE Roman-numeral order with correct heading style.
3. Apply the IEEE Quality Checklist before presenting the draft.
4. Flag any data gaps that require user input (results tables, figures, missing citations).
5. Provide word count per section and recommended next steps.

**Carry forward:** Draft manuscript and list of outstanding gaps.

---

## Stage 8 — Final Review & Handoff

**Trigger:** After Stage 7 produces a complete draft.

**Actions:**
1. **Internal consistency check**: Ensure the hypothesis from Stage 2, the experimental setup from Stage 5, and the claims in the manuscript all align. Flag any contradiction.
2. **Literature coverage check**: Confirm all baselines, datasets, and key related work identified in Stage 3 are cited in the manuscript.
3. **Reproducibility audit**: Verify that enough detail is present (datasets, splits, hyperparameters, seeds, hardware) for an independent replication.
4. **Open items list**: Produce a prioritized list of what remains — missing experiments, figures to create, citations to verify, reviewer-anticipated objections.
5. **Handoff summary**: One-page markdown document covering:
   - Research question and final hypothesis
   - Key results (top-line numbers)
   - Status of each pipeline stage
   - Outstanding items before submission

---

## Cross-Stage Principles

### Context Continuity
Maintain a running **Research Log** across all stages. After completing each stage, append a brief summary entry:
```
## Stage N — [Name] — [Date]
Status: complete / in-progress / blocked
Key output: [1–2 sentence summary]
Decisions made: [list]
Open questions: [list]
```

### Decision Gates
At the end of Stages 1, 4, and 6, pause and surface a clear decision to the user before proceeding. Do not auto-advance through a gate if the outcome is ambiguous.

### Escalation Protocol
Escalate immediately (do not silently continue) when:
- The hypothesis is found to already exist in the literature (Stage 3 or 4).
- Replication fails with a large gap that is not explainable (Stage 6).
- Experiment results contradict the hypothesis in a way that invalidates the paper's contribution (Stage 7).

### No Fabrication
At no stage generate fake data, invented citations, fabricated results, or placeholder author names intended to be left in a final document. All numbers in the manuscript must come from actual experiments or cited sources.

---

## Quick-Start Paths

Use these shortcuts when the user's intent is clear:

| User intent | Entry point | Skipped stages |
|-------------|-------------|----------------|
| "I have an idea, help me turn it into a paper" | Stage 1 → full pipeline | None |
| "Review this paper and help me extend it" | Stage 4 → 2 → 3 → 5 → 7 | Stage 6 unless user wants replication |
| "Replicate this paper and beat it" | Stage 4 → 6 → 2 → 5 → 7 | — |
| "I have results, write the paper" | Stage 7 directly | Stages 2–6 (reference prior work if available) |
| "Design experiments for this hypothesis" | Stage 3 → 5 | Stages 2 (hypothesis given), 4, 6, 7 |

---

## Output Summary

| Stage | Artifact |
|-------|----------|
| 1 | Research Brief (markdown, confirmed by user) |
| 2 | Hypothesis document with ranked table and refined claim |
| 3 | Literature synthesis with gap statement and reference list |
| 4 | Paper review report with differentiation analysis (if activated) |
| 5 | Experiment plan (markdown) |
| 6 | `REPLICATION.md` with gap analysis table (if activated) |
| 7 | Draft manuscript (section-by-section or full IEEE format) |
| 8 | Handoff summary and open items list |
| All | Research Log with stage-by-stage entries |
