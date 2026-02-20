---
name: research-paper-review
description: Use this skill when asked to review, critique, or analyze an AI/ML research paper. Provides a structured evaluation covering contributions, methodology, experimental validity, and limitations.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: research, review, critique, ML, AI
---

# Research Paper Review

Perform a rigorous, structured review of an AI/ML research paper.

## Review Structure

Always organize the review under these sections:

### 1. Summary (2–3 sentences)
State the paper's core claim, the approach taken, and the key result. No jargon — write so that a senior researcher in an adjacent field can follow.

### 2. Contributions
List the paper's stated and actual contributions. Note if the framing overstates novelty.

### 3. Methodology
- Is the method described with enough detail to reproduce?
- Are design choices justified or arbitrary?
- Are there ablations that isolate each component's effect?

### 4. Experiments
- Are baselines appropriate and up-to-date?
- Is the evaluation dataset standard, or cherry-picked?
- Are error bars / statistical significance reported?
- Is the compute budget disclosed?

### 5. Limitations
Identify limitations the authors acknowledge, then add any they missed. Be specific.

### 6. Related Work
Note whether the paper engages honestly with prior work, including concurrent work.

### 7. Verdict
Rate the paper: **Accept / Weak Accept / Borderline / Weak Reject / Reject**
Give a one-paragraph justification.

## Tone

- Be constructive, not dismissive.
- Distinguish between fatal flaws and minor weaknesses.
- Praise genuine novelty — do not penalize incremental but solid work.

## Output Format

Produce the review as markdown with the sections above. Summarize the verdict at the top in a blockquote before the full review body.
