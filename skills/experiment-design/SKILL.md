---
name: experiment-design
description: Use this skill when designing ML/AI experiments, evaluation protocols, or research benchmarks. Guides hypothesis specification, baseline selection, metric choice, and experimental controls to ensure results are valid and reproducible.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: experiments, evaluation, ML, reproducibility, methodology
---

# Experiment Design

Design rigorous machine learning experiments that produce credible, reproducible results.

## Design Checklist

Work through each section before writing any code.

### 1. Hypothesis
State the hypothesis as a falsifiable claim:
> "We claim that [method X] achieves [metric Y] on [dataset Z] because [mechanism]."

If the hypothesis is vague, help the user sharpen it before proceeding.

### 2. Independent and Dependent Variables
- **Independent variable:** What is being changed (e.g., architecture, loss function, data augmentation)?
- **Dependent variable:** What is being measured (e.g., accuracy, FID score, wall-clock time)?
- **Controlled variables:** List everything held constant.

### 3. Baselines
Select baselines at three levels:
- **Naive:** A trivially simple method (majority class, mean predictor)
- **Standard:** The most widely-used existing approach
- **Strong:** The current state-of-the-art on the chosen benchmark

Justify each choice. Avoid strawman baselines.

### 4. Datasets and Splits
- Name the dataset, version, and source.
- Specify train/val/test splits. Use standard splits if they exist.
- Flag any data leakage risks.
- Note dataset limitations (bias, domain coverage, size).

### 5. Metrics
- Choose metrics that align with the task objective.
- Prefer metrics with established semantics over novel ones.
- Report multiple metrics when they capture different aspects.
- Specify statistical significance: report means ± standard deviation over N seeds.

### 6. Compute Budget
State the hardware, estimated runtime, and number of seeds. This enables reproducibility and contextualizes cost.

### 7. Ablations
Design ablations that isolate each component's contribution. Each ablation should remove or replace exactly one thing.

### 8. Failure Modes
Identify at least two ways the experiment could give misleading results, and how to detect or mitigate them.

## Output Format

Produce a structured experiment plan as a markdown document with all sections above filled in. Highlight any section where the user needs to make a decision before proceeding.
