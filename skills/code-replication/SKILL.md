---
name: code-replication
description: Use this skill when tasked with replicating results from a research paper. Guides systematic reproduction of experiments, documentation of discrepancies, and validation of claims.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: replication, reproducibility, experiments, code, validation
---

# Code Replication

Reproduce results from a research paper with methodical documentation.

## Replication Protocol

### Phase 1 — Paper Audit
Before writing any code:
- Extract every hyperparameter mentioned in the paper and appendix.
- Note any details that are ambiguous or missing.
- Check for an official codebase (GitHub, project page, supplementary materials).
- Identify the exact dataset split, preprocessing steps, and evaluation protocol.

Document findings in a `replication-notes.md` file.

### Phase 2 — Environment Setup
- Record exact package versions (use `pip freeze` or `conda env export`).
- Prefer the same framework the paper used when possible.
- Use a fixed random seed for all experiments. Document it.
- Isolate the environment (virtualenv, conda, or container).

### Phase 3 — Minimal Reproduction
Start with the smallest possible experiment:
- Use the smallest dataset subset that exercises the full pipeline.
- Confirm the training loop runs without errors before full-scale training.
- Check intermediate outputs (loss curves, gradient norms) against any figures in the paper.

### Phase 4 — Full Replication
- Run the main experiment with the paper's reported settings.
- Record all results in a structured log (seed, config, metric, timestamp).
- Run at least 3 seeds; report mean ± std.

### Phase 5 — Gap Analysis
Compare your results against the paper:

| Metric | Paper | Reproduced | Δ |
|--------|-------|------------|---|
| ...    | ...   | ...        | ...|

Categorize any gap:
- **Reproduced**: within noise (< 0.5% relative difference)
- **Close**: explainable by known ambiguities
- **Discrepancy**: notable gap — document likely causes
- **Failed**: results do not match — flag for investigation

### Phase 6 — Documentation
Produce a `REPLICATION.md` with:
- Paper citation
- Environment details
- Deviations from the paper (with justification)
- Results table
- Conclusion: successfully reproduced / partially reproduced / failed

## Principles

- Never alter evaluation code to match paper numbers — fix the model, not the metric.
- Document every ambiguity you encountered and how you resolved it.
- A failed replication is a valid and valuable research outcome.
