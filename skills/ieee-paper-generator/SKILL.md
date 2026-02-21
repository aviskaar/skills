---
name: ieee-paper-generator
description: Use this skill when generating a complete, publication-ready IEEE research paper from experiment data, results, or research findings. Applies to conference papers (e.g., ICML, NeurIPS, CVPR, ICCV, EMNLP, ACL) and journal articles following IEEE Transactions formatting conventions. Covers all sections from title through references, adhering to IEEE style, structure, and citation format.
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: IEEE, research-paper, writing, academic, publication, conference, journal, formatting
---

# IEEE Research Paper Generator

Generate a complete, professional IEEE-format research paper from experiment data and findings.

---

## Before You Begin

Collect the following inputs from the user before writing any section. If any are missing, ask explicitly:

1. **Paper type**: conference (8 pages) or journal (variable; ask for target page count)
2. **Title candidate**: working title or research topic
3. **Authors and affiliations**: names, departments, institutions, cities, countries, emails
4. **Problem and motivation**: what problem is solved and why it matters
5. **Proposed method**: the core technical contribution (algorithm, architecture, framework, model)
6. **Experiment data**: datasets used, baselines compared, metrics, tables of results, ablations
7. **Key findings**: what the results show, performance gains, failure cases
8. **Related work references**: papers to cite (titles, authors, venues, years); ask for at least 15
9. **Target venue** (optional): informs tone, focus, and length norms

Do not fabricate results, numbers, citations, or author names. If data is incomplete, flag the gap and prompt the user.

---

## Paper Structure

Generate each section in order. Use IEEE Roman-numeral section numbering (I, II, III, …). Every section heading must be in ALL CAPS, centered, using the IEEE style.

---

### TITLE BLOCK

```
[FULL PAPER TITLE IN TITLE CASE — CONCISE, SPECIFIC, ≤12 WORDS PREFERRED]

Author One, Author Two, and Author Three
Department of X, University of Y, City, Country
{email1, email2, email3}@domain.edu
```

- Titles must name the method or problem specifically. Avoid vague titles like "A Novel Approach."
- For multi-institution papers, use numbered superscripts.

---

### I. ABSTRACT

Write a self-contained abstract of **150–250 words** following this five-part structure:

1. **Context** (1 sentence): Situate the problem in the broader field.
2. **Problem** (1–2 sentences): State the precise challenge addressed.
3. **Method** (2–3 sentences): Describe the proposed approach at a high level. Name the method.
4. **Results** (2–3 sentences): Report concrete quantitative results. Include dataset names and metrics.
5. **Impact** (1 sentence): State what this enables or what door it opens.

Rules:
- Do not cite references in the abstract.
- Spell out all acronyms on first use.
- Use present tense for contributions; past tense for experiments.

**Index Terms** follow the abstract as a comma-separated list of 4–8 lowercase terms enclosed in `\begin{IEEEkeywords}...\end{IEEEkeywords}`.

---

### II. INTRODUCTION

Structure as five parts:

1. **Opening motivation** (1–2 paragraphs): Ground the reader in why this problem matters. Use concrete statistics or real-world consequences where possible.
2. **Problem statement** (1 paragraph): Define the problem precisely. State what makes it hard.
3. **Limitations of prior work** (1–2 paragraphs): Summarize existing approaches and their shortcomings. Every limitation must be tied to at least one citation.
4. **Contributions** (1 paragraph + bulleted list): Begin with "In this paper, we…" then list 3–5 specific, verifiable contributions as bullets:
   - Each bullet starts with a verb: "We propose…", "We demonstrate…", "We provide…"
   - Contributions must match what the paper actually delivers.
5. **Paper organization** (1 paragraph): One sentence per remaining section.

---

### III. RELATED WORK

Group prior work into 2–5 thematic subsections. Each subsection heading uses `\subsection{}`.

For each thematic group:
- Summarize the approach shared by the group (2–3 sentences).
- Note the key limitation that differentiates this group from your work (1–2 sentences).
- Distinguish your work from the closest prior work explicitly.

Rules:
- Do not write a flat list of papers. Synthesize.
- Acknowledge concurrent and closely related work honestly.
- Cite all baselines and datasets used in the experiments.

---

### IV. METHODOLOGY

This is the technical core. Organize with subsections matching your method's components.

#### Required subsections (adapt names to the work):

**A. Problem Formulation**
- Define all variables and notation in a table or inline.
- State the objective function or task formally.
- Example: "Let $\mathcal{D} = \{(x_i, y_i)\}_{i=1}^N$ denote the training set…"

**B. Proposed Method**
- Describe the architecture, algorithm, or framework in full.
- Include a system diagram or algorithm pseudocode block where appropriate.
- For algorithms, use the `algorithm` + `algorithmic` environment with numbered lines.
- For models, describe each component and how outputs flow between them.

**C. Training Objective / Loss Function**
- State each loss term as a numbered equation: $(1), (2), \ldots$
- Explain the role of each term.
- State any hyperparameters introduced and their sensitivity.

**D. Theoretical Analysis** *(include if applicable)*
- State and prove or sketch key propositions, lemmas, or complexity bounds.
- Label theorems and proofs with `\begin{theorem}...\end{theorem}`.

**E. Complexity Analysis**
- Report time and space complexity.
- Compare against the strongest baseline.

---

### V. EXPERIMENTAL SETUP

**A. Datasets**

For each dataset:
- Name, version/split, and source citation.
- Size: number of training/validation/test samples.
- Preprocessing steps applied.
- Any known limitations or biases relevant to conclusions.

**B. Baselines**

List all comparison methods. For each:
- Method name and citation.
- Why it was chosen as a comparison point.
- How it was run (official code, reimplementation, results from paper).

**C. Evaluation Metrics**

- Name each metric and provide its formula or definition.
- Justify metric choice relative to the task objective.
- State how statistical significance is assessed (e.g., mean ± std over N seeds, paired t-test).

**D. Implementation Details**

Report in a `\begin{table}` or inline:
- Hardware (GPU model, count, memory)
- Framework and version (e.g., PyTorch 2.1)
- Optimizer, learning rate, scheduler, batch size, number of epochs
- Any data augmentation or regularization

This section must contain enough detail for reproducibility.

---

### VI. RESULTS AND DISCUSSION

**A. Main Results**

- Present results in a `\begin{table*}` spanning both columns.
- Table format: rows = methods, columns = datasets × metrics. Bold the best result per column.
- Caption begins with "TABLE I" and includes a concise description.
- Narrate the table: explain what the numbers mean, not just that "our method is best."
- Quantify improvements: "Our method outperforms the strongest baseline by 3.2 points in F1 on…"

**B. Ablation Study**

- Present a table isolating each component's contribution.
- Each row removes or replaces exactly one component.
- Discuss what each ablation reveals about the method's design.

**C. Analysis and Discussion**

Include at least two of the following, as appropriate:

- **Qualitative examples**: figures with captions comparing outputs of your method vs. baselines.
- **Error analysis**: categorize failure cases; explain why they occur.
- **Sensitivity analysis**: plot performance vs. a key hyperparameter.
- **Generalization**: results on an out-of-distribution or held-out test condition.
- **Efficiency**: training time, inference time, or memory comparison.

**D. Limitations**

Dedicate 1–2 paragraphs to honest limitations:
- Conditions under which the method fails or degrades.
- Assumptions that may not hold in deployment.
- Do not bury limitations or frame them as future work only.

---

### VII. CONCLUSION

Write 2–3 paragraphs:

1. **Summary**: Restate the problem, the approach, and the main results in fresh language (do not copy the abstract verbatim).
2. **Takeaways**: What should a reader conclude about when and why to use this method?
3. **Future work**: 2–3 concrete directions, each one sentence.

Do not introduce new results or claims in the conclusion.

---

### ACKNOWLEDGMENTS *(optional)*

Standard single paragraph. Do not include in anonymous submissions. Acknowledge funding sources (grant numbers), compute credits, and individuals who contributed but are not authors.

---

### REFERENCES

Format all references in **IEEE citation style** — numbered in order of appearance `[1]`, `[2]`, etc.

Templates by source type:

**Journal article:**
```
[N] A. Author, B. Author, and C. Author, "Title of article," *Journal Name*, vol. X, no. Y, pp. ZZZ–ZZZ, Mon. YYYY. doi: 10.XXXX/XXXXX.
```

**Conference paper:**
```
[N] A. Author and B. Author, "Title of paper," in *Proc. Conf. Name (ABBR)*, City, Country, YYYY, pp. ZZZ–ZZZ.
```

**arXiv preprint:**
```
[N] A. Author, "Title," *arXiv preprint arXiv:XXXX.XXXXX*, YYYY.
```

**Book:**
```
[N] A. Author, *Title of Book*, Xth ed. City, Country: Publisher, YYYY.
```

Rules:
- List references in citation order, not alphabetical.
- Do not cite sources not referenced in the body.
- Every baseline, dataset, and related-work paper must be cited.
- Aim for 20–40 references for a conference paper; 30–60 for a journal article.

---

## Figures and Tables

### Figures
- Every figure must be referenced in the text before it appears: "As shown in Fig. 1, …"
- Caption format: `Fig. 1. Description of figure content in one or two sentences.`
- Captions go **below** figures.
- Figures must have sufficient resolution (300 DPI minimum for print).

### Tables
- Caption format: `TABLE I \\ Description of table.` (caption goes **above** the table)
- Use `\begin{table}` for single-column and `\begin{table*}` for two-column spanning tables.
- Align numerical columns on the decimal point.
- Bold the best result per column using `\textbf{}`.

### Equations
- Number all equations that are referenced in the text: `\begin{equation}...\end{equation}`
- Reference as "Eq. (1)" or simply "(1)."
- Define all variables immediately after introduction.

---

## Writing Style Rules

- **Tense**: Present tense for the proposed method and general claims; past tense for experimental observations.
- **Voice**: Prefer active voice. Use "We propose…" not "A method is proposed…"
- **Precision**: Every claim must be (a) proven in the paper or (b) supported by a citation.
- **Hedging**: Replace vague hedges ("somewhat," "rather," "quite") with quantified statements.
- **Acronyms**: Define on first use in the abstract and again on first use in the body.
- **Sentence length**: Flag and restructure sentences exceeding 40 words.
- **Person**: Use "we" even for single-author papers, following IEEE convention.
- **Numbers**: Spell out numbers one through nine; use numerals for 10 and above, and always for measurements (e.g., "3 layers," "5 epochs").

---

## Quality Checklist

Before finalizing the paper, verify every item:

### Completeness
- [ ] All nine sections (Abstract through References) are present
- [ ] Author block includes affiliations and emails
- [ ] Index terms are listed
- [ ] Every table and figure is referenced in the body text
- [ ] All equations are numbered and defined

### Technical Rigor
- [ ] Hypothesis is falsifiable and tested by the experiments
- [ ] Every baseline has a citation and a justification for inclusion
- [ ] Metrics are defined and appropriate to the task
- [ ] Ablation isolates each component individually
- [ ] Limitations are stated honestly and directly

### IEEE Style Compliance
- [ ] Section headings use Roman numerals and ALL CAPS
- [ ] References follow IEEE numbered format
- [ ] Table captions are above tables; figure captions are below figures
- [ ] Equations are numbered in order of appearance
- [ ] Acronyms are defined on first use in abstract and body

### Writing Quality
- [ ] Abstract is 150–250 words with all five parts
- [ ] Introduction contributions list uses verifiable, specific claims
- [ ] Related work is organized thematically, not as a flat list
- [ ] Main results table has bold best-results and a descriptive caption
- [ ] Conclusion does not introduce new claims

---

## Output Format

Produce the full paper as a single, continuous Markdown document using LaTeX notation for math and structure cues. Delimit each major section with a horizontal rule and labeled heading. After the full draft:

1. Provide a **Word count estimate** per section.
2. Flag any **data gaps** — sections where user input is needed to complete the content.
3. List **recommended next steps**: additional experiments, missing citations, figures to create.
