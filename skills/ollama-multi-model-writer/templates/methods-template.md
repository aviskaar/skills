# Methods Section Prompt Template — deepseek-r1

Write a Methodology section for a research paper covering all applicable subsections below.

---

### A. Problem Formulation
- Define all variables and notation in a table or inline.
- State the objective function or learning task formally.
- Specify inputs, outputs, and constraints.
- Example: "Let D = {(x_i, y_i)}_{i=1}^N denote the training set where..."

### B. Proposed Approach
- Describe the core algorithm, architecture, or framework step by step.
- If an algorithm, present numbered pseudocode steps.
- If a model or pipeline, explain how data flows through each component.
- Explain the design rationale for each key component — why this choice over alternatives.

### C. Training Objective (if applicable)
- State each loss term as a numbered equation: (1), (2), ...
- Explain the role of each term in plain language.
- List any hyperparameters introduced and their expected sensitivity.

### D. Complexity Analysis
- Report time complexity (training and/or inference).
- Report space complexity.
- Compare against the strongest baseline.

---

Rules:
- Use numbered equations for all formal mathematical statements.
- Define all symbols immediately when introduced.
- Be precise enough that an expert could reproduce the method from this section alone.
- Write [PLACEHOLDER: description] for any detail not yet decided or known.
- Do not fabricate numbers or performance claims — those belong in the Results section.

---

Research context to use:
