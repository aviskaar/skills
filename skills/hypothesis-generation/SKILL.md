---
name: hypothesis-generation
description: Use this skill when generating, refining, or stress-testing research hypotheses for AI/ML problems. Produces well-formed, falsifiable hypotheses grounded in existing literature and mechanistic reasoning.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: hypothesis, research, ideation, theory, ML
---

# Hypothesis Generation

Generate and rigorously evaluate novel research hypotheses.

## Process

### Step 1 — Problem Framing
Clarify the research context:
- What phenomenon is being investigated?
- What is already known? (Ask the user to provide key papers or summarize the state of the field.)
- What surprising or unexplained observation prompted this inquiry?

### Step 2 — Generate Candidate Hypotheses
Produce 3–5 distinct hypotheses. For each:
- State it as a precise, falsifiable claim.
- Identify the underlying mechanism or assumption.
- Describe a minimal experiment that would confirm or refute it.

Use diverse generation strategies:
- **Analogy**: Does a known mechanism from a related domain apply here?
- **Inversion**: What if the conventional assumption is reversed?
- **Scaling**: Does the behavior hold at different data/model scales?
- **Ablation-driven**: What specific component, if removed, would eliminate the effect?

### Step 3 — Stress-Test Each Hypothesis
For each candidate, answer:
1. **Falsifiability**: Can this be proven false? If not, revise it.
2. **Prior literature**: Does any existing work already test this?
3. **Confounds**: What alternative explanations could produce the same observation?
4. **Scope**: Under what conditions does this hypothesis break down?
5. **Cost to test**: Estimate compute and data requirements.

### Step 4 — Prioritize
Rank hypotheses by:
- **Impact** (if true, how much does it matter?)
- **Testability** (how quickly and cheaply can it be tested?)
- **Novelty** (how differentiated from existing work?)

Recommend the top hypothesis with a justification.

### Step 5 — Refine
Take the top hypothesis and sharpen it into a paper-ready claim:
> "We hypothesize that [specific mechanism] causes [observed phenomenon] in [specific setting], and that this can be demonstrated by [experiment]."

## Output Format

Produce a markdown document with all five steps. Number each hypothesis. Use a comparison table in Step 4.
