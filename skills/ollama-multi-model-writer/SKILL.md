---
name: ollama-multi-model-writer
description: Use this skill when writing or drafting research paper sections using local Ollama models on GPU. Routes each section to the optimal local model — DeepSeek-R1 for methods, results, and scientific reasoning; Phi-4-reasoning for abstract, introduction, and conclusions; GLM-4.7-Flash for full drafts and cross-section synthesis. Activate when the user wants a fully local, offline paper-writing workflow without cloud APIs.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: ollama, local-llm, research-paper, multi-model, deepseek, phi4, glm, writing, gpu
  models:
    - deepseek-r1:7b
    - phi4-reasoning
    - glm4:9b-chat-q4_K_M
---

# Ollama Multi-Model Research Writer

Route each research paper section to the locally-running Ollama model best suited for that task, then synthesize outputs into a unified manuscript — all on your local GPU, no cloud APIs required.

---

## Model Roles

| Model | Tag | Primary Role | Best Sections |
|-------|-----|-------------|---------------|
| **DeepSeek-R1** | `deepseek-r1:7b` | Scientific reasoning & data analysis | Methods, Results, Experiment Design, Ablations |
| **Phi-4-reasoning** | `phi4-reasoning` | PhD-level structured writing | Abstract, Introduction, Conclusions, Related Work |
| **GLM-4.7-Flash** | `glm4:9b-chat-q4_K_M` | Fluent drafting & synthesis | Full-section drafts, cross-section polish, consistency pass |

---

## Prerequisites

Before starting, verify Ollama and the required models are available:

```bash
# Check Ollama is running
ollama list

# Pull any missing models
ollama pull deepseek-r1:7b
ollama pull phi4-reasoning
ollama pull glm4:9b-chat-q4_K_M
```

If Ollama is not installed or a model is missing, surface the error to the user and halt. Do not proceed with a partial model set.

---

## Section Routing Table

| Paper Section | Primary Model | Backup Model |
|--------------|---------------|--------------|
| Abstract | `phi4-reasoning` | `glm4:9b-chat-q4_K_M` |
| Introduction | `phi4-reasoning` | `glm4:9b-chat-q4_K_M` |
| Related Work | `phi4-reasoning` | `glm4:9b-chat-q4_K_M` |
| Methodology | `deepseek-r1:7b` | `glm4:9b-chat-q4_K_M` |
| Experimental Setup | `deepseek-r1:7b` | `glm4:9b-chat-q4_K_M` |
| Results & Discussion | `deepseek-r1:7b` | `glm4:9b-chat-q4_K_M` |
| Ablation Study | `deepseek-r1:7b` | `glm4:9b-chat-q4_K_M` |
| Conclusion | `phi4-reasoning` | `glm4:9b-chat-q4_K_M` |
| Full-paper synthesis | `glm4:9b-chat-q4_K_M` | — |

Use the backup model if the primary model is not pulled or fails to respond.

---

## Workflow

### Phase 1 — Reasoning Pass (DeepSeek-R1)

Run DeepSeek-R1 on the technical core of the paper. Save output as `{reasoning_output}`.

```bash
# Step 1a: Extract key claims and structure from the research idea
./scripts/ollama-runner.sh deepseek-r1:7b \
  "Analyze this research idea. Extract: (1) the core technical claim, (2) the key methodological steps, (3) what experiments would validate it, (4) what metrics matter. Be precise and scientific. Research idea: {user_idea}"

# Step 1b: Draft the Methods section
./scripts/ollama-runner.sh deepseek-r1:7b \
  "Write a detailed Methodology section for a research paper. Include: problem formulation with formal notation, the proposed approach step-by-step, the training objective or loss function if applicable, and complexity analysis. Use [PLACEHOLDER] for any unknown details. Context: {reasoning_output}"

# Step 1c: Draft Results section (if experiment data is provided)
./scripts/ollama-runner.sh deepseek-r1:7b \
  "Write a Results and Discussion section. Present and interpret the following experiment results honestly. Quantify improvements with exact numbers. Identify failure cases. Results data: {results_data}"
```

---

### Phase 2 — Structure Pass (Phi-4-reasoning)

Run Phi-4-reasoning to build the academic skeleton. Save output as `{structured_output}`.

```bash
# Step 2a: Write the Abstract
./scripts/ollama-runner.sh phi4-reasoning \
  "Write a 200-word abstract using exactly this 5-part structure: (1) Motivation — why this problem matters, (2) Problem — the precise challenge, (3) Approach — the key method named explicitly, (4) Results — concrete findings with numbers or [RESULT NEEDED], (5) Significance — what this enables. No citations. Spell out all acronyms. Context: {reasoning_output}"

# Step 2b: Write the Introduction
./scripts/ollama-runner.sh phi4-reasoning \
  "Write an Introduction section with: (1) a concrete opening hook, (2) precise problem statement, (3) limitations of prior work with citations, (4) a bulleted list of 3-5 verifiable contributions each starting with a verb (We propose, We demonstrate, We show), (5) one-sentence paper outline. Context: {reasoning_output}"

# Step 2c: Write the Conclusion
./scripts/ollama-runner.sh phi4-reasoning \
  "Write a Conclusion section with: (1) a summary of the problem and approach in fresh language (do not repeat the abstract), (2) key takeaways for practitioners, (3) 2-3 concrete future work directions each one sentence. Do not introduce new claims or results. Context: {reasoning_output} {results_output}"
```

---

### Phase 3 — Synthesis & Polish Pass (GLM-4.7-Flash)

Run GLM-4.7-Flash to unify all sections into a coherent manuscript. Save output as `{synthesis_output}`.

```bash
# Step 3a: Synthesize all sections into one draft
./scripts/ollama-runner.sh glm4:9b-chat-q4_K_M \
  "You are editing a research paper. Unify these independently-written sections into a single coherent manuscript. Ensure: consistent terminology throughout, the abstract matches the conclusion, all contributions in the introduction appear in the results, no repetition between sections. Sections: REASONING: {reasoning_output} STRUCTURED: {structured_output}"

# Step 3b: Cross-section consistency check
./scripts/ollama-runner.sh glm4:9b-chat-q4_K_M \
  "Review this research paper draft and flag: (1) terminology inconsistencies, (2) claims in the introduction not supported by the results, (3) abstract statements not matching the paper content, (4) any [PLACEHOLDER] or [RESULT NEEDED] tags. List each issue with the section name and line. Draft: {synthesis_output}"
```

---

## Running a Single Section

When the user asks for one section only, skip the full pipeline:

```bash
# Abstract only
./scripts/ollama-runner.sh phi4-reasoning \
  "$(cat templates/abstract-template.md)" \
  "Research context: {user_input}"

# Methods only
./scripts/ollama-runner.sh deepseek-r1:7b \
  "$(cat templates/methods-template.md)" \
  "Research context: {user_input}"

# Any section — quick draft
./scripts/ollama-runner.sh glm4:9b-chat-q4_K_M \
  "Draft the {section_name} section for a research paper. Academic tone, precise language. Research context: {user_input}"
```

---

## Integration with the Lead Researcher Pipeline

When operating inside the `lead-researcher` pipeline as **Stage 7c**:

**Trigger**: User says they want a local/GPU workflow, or Ollama is confirmed available.

**Inputs received from prior stages:**

| Input | Source Stage |
|-------|-------------|
| Research Brief | Stage 1 |
| Finalized hypothesis | Stage 2 |
| Literature synthesis & gap statement | Stage 3 |
| Experiment plan | Stage 5 |
| Results summary | User-provided or Stage 6 |

**Actions:**
1. Confirm Ollama is running and all three models are available.
2. Run Phase 1 (DeepSeek-R1) with the hypothesis + experiment plan as context.
3. Run Phase 2 (Phi-4-reasoning) with the reasoning output.
4. Run Phase 3 (GLM-4.7-Flash) to synthesize all phases.
5. Write the manuscript to `paper-{topic}-draft.md`.
6. Report draft location and all `[PLACEHOLDER]` / `[RESULT NEEDED]` tags back to `lead-researcher`.

Optionally hand off to `ieee-paper-generator` for IEEE formatting after the draft is complete.

---

## Output Format

Save the manuscript as `paper-{topic}-draft.md` using this structure:

```markdown
# [Paper Title]

## Abstract
[150-250 words, 5-part structure — generated by phi4-reasoning]

## 1. Introduction
[Generated by phi4-reasoning]

## 2. Related Work
[Generated by phi4-reasoning]

## 3. Methodology
[Generated by deepseek-r1]

## 4. Experimental Setup
[Generated by deepseek-r1]

## 5. Results and Discussion
[Generated by deepseek-r1]

## 6. Conclusion
[Generated by phi4-reasoning]

## References
[Numbered in order of appearance — user must supply actual citations]

---
## Model Attribution
| Section | Model Used |
|---------|-----------|
| Abstract | phi4-reasoning |
| Introduction | phi4-reasoning |
| Methodology | deepseek-r1:7b |
| Results | deepseek-r1:7b |
| Conclusion | phi4-reasoning |
| Synthesis pass | glm4:9b-chat-q4_K_M |

## Data Gaps
[List all [PLACEHOLDER] and [RESULT NEEDED] tags with section references]

## Cross-Validation Flags
[List any inconsistencies detected in the Phase 3 consistency check]
```

---

## No Fabrication Policy

- Never invent experimental results, benchmark scores, or ablation numbers.
- Never generate fake citations, paper titles, or author names.
- Mark all missing data with `[RESULT NEEDED: description]`.
- Mark all unknown details with `[PLACEHOLDER: description]`.
- All quantitative claims in the paper must come from the user's actual experiments.
