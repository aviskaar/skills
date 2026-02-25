# .docx Generation Script — Node.js Template

This file provides the complete scaffold for generating the Account Intelligence Report as a formatted `.docx` file using the `docx` npm package (v8.x).

**Instructions for use:**
1. Copy the script below into a new file: `generate-report.js`
2. Populate the `data` object at the top with all research findings
3. Anywhere a value is estimated or inferred, append the inline assumption text using the `assumption()` helper (see Section 2)
4. Run: `npm install docx && node generate-report.js`

---

## COMPLETE GENERATION SCRIPT

```javascript
// ============================================================
// Account Intelligence Report Generator
// Requires: npm install docx
// Usage: node generate-report.js
// ============================================================

const {
  Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
  WidthType, BorderStyle, AlignmentType, ShadingType, VerticalAlign,
  Header, PageBreak, convertInchesToTwip, UnderlineType, TableLayoutType
} = require('docx');
const fs = require('fs');
const path = require('path');

// ============================================================
// COLOR CONSTANTS
// ============================================================
const NAVY   = "1B2A4A";
const BLUE   = "2E5FA3";
const TEAL   = "2E8B7A";
const WHITE  = "FFFFFF";
const LIGHT  = "5BA3C9";
const MUTED  = "AACCEE";
const ORANGE = "CC6600";
const ALT    = "EEF3FA";
const BLACK  = "000000";

// ============================================================
// RESEARCH DATA — POPULATE FROM PHASE 1 RESEARCH
// All {{PLACEHOLDERS}} must be replaced with actual data.
// Estimated values must use the assumption() helper inline.
// ============================================================
const data = {
  company: {
    name:            "{{COMPANY_FULL_LEGAL_NAME}}",
    ticker:          "{{TICKER_OR_PRIVATE_OR_FEDERAL}}",
    descriptor:      "{{ONE_LINE_COMPANY_DESCRIPTOR}}",
    hq:              "{{CITY_STATE_COUNTRY}}",
    revenue:         "{{$X.XB or $XXM — FY20XX}}",
    employees:       "{{COUNT or RANGE}}",
    fiscalYearEnd:   "{{MONTH e.g. December}}",
    coreProducts:    "{{BRIEF DESCRIPTION}}",
    keyMarkets:      "{{MARKETS OR SEGMENTS}}",
    strategicMoment: "{{ONE SENTENCE: WHERE IS THIS COMPANY RIGHT NOW}}"
  },
  pursuer: {
    firm:        "{{YOUR_FIRM_NAME}}",
    preparedBy:  "{{PREPARED_BY}}",
    preparedFor: "{{PREPARED_FOR}}"
  },
  executiveSummary: "{{3-4 SENTENCE SYNTHESIS: WHY THIS ACCOUNT, WHY NOW, BEST ENTRY POINT}}",
  leadership: {
    ceo: {
      name:             "{{CEO_NAME}}",
      title:            "{{CEO_TITLE}}",
      since:            "{{MONTH YEAR}}",
      background:       "{{PRIOR ROLE AT PRIOR CO → PRIOR ROLE AT PRIOR CO}}",
      isPrimary:        false,
      isNew:            false
    },
    cSuite: [
      {
        name:       "{{CIO/CTO_NAME}}",
        title:      "{{CIO/CTO EXACT TITLE}}",
        since:      "{{MONTH YEAR}}",
        background: "{{PRIOR ROLES}}",
        isPrimary:  true,
        isNew:      true,   // true if joined < 18 months ago
        whyMatters: "{{WHY THIS PERSON MATTERS TO THIS PURSUIT}}"
      },
      {
        name:       "{{CFO_NAME}}",
        title:      "Chief Financial Officer",
        since:      "{{MONTH YEAR}}",
        background: "{{PRIOR ROLES}}",
        isPrimary:  false,
        isNew:      false,
        whyMatters: "{{WHY THEY MATTER}}"
      }
      // Add additional C-suite members as needed
    ],
    vps: [
      {
        name:       "{{VP1_NAME}}",
        title:      "{{VP1_TITLE}}",
        since:      "{{MONTH YEAR}}",
        background: "{{PRIOR ROLES}}",
        isPrimary:  false,
        isNew:      false,
        whyMatters: "{{WHY THEY MATTER}}"
      }
      // Add additional VPs as needed
    ],
    analyticalNote: "{{PARAGRAPH: ASSESS LEADERSHIP STABILITY AND WHAT IT MEANS FOR VENDOR DECISIONS}}"
  },
  strategicPriorities: [
    {
      title:      "{{PRIORITY 1 TITLE}}",
      commitment: "{{WHAT LEADERSHIP PUBLICLY COMMITTED TO — DIRECT QUOTE OR CLOSE PARAPHRASE}}",
      source:     "{{SOURCE: CEO, Q4 FY2025 Earnings Call, Jan 29 2025}}",
      need:       "{{SPECIFIC TECHNOLOGY OR CONSULTING NEED THIS CREATES}}",
      owner:      "{{NAME, TITLE}}"
    },
    {
      title:      "{{PRIORITY 2 TITLE}}",
      commitment: "{{COMMITMENT}}",
      source:     "{{SOURCE}}",
      need:       "{{NEED}}",
      owner:      "{{OWNER}}"
    },
    {
      title:      "{{PRIORITY 3 TITLE}}",
      commitment: "{{COMMITMENT}}",
      source:     "{{SOURCE}}",
      need:       "{{NEED}}",
      owner:      "{{OWNER}}"
    }
  ],
  techLandscape: {
    incumbentDescription: "{{DESCRIBE CONFIRMED INCUMBENT PARTNERS — OR NOTE 'No confirmed managed services relationship identified'}}",
    spending: [
      { category: "ERP / Core Systems",     estimate: "${{X}}M",  basis: "{{BASIS}}",       signal: "{{SIGNAL}}",     opportunity: "{{OPPORTUNITY}}" },
      { category: "Cloud Infrastructure",   estimate: "${{X}}M",  basis: "{{BASIS}}",       signal: "{{SIGNAL}}",     opportunity: "{{OPPORTUNITY}}" },
      { category: "Application Development",estimate: "${{X}}M",  basis: "{{BASIS}}",       signal: "{{SIGNAL}}",     opportunity: "{{OPPORTUNITY}}" },
      { category: "Data & Analytics",       estimate: "${{X}}M",  basis: "{{BASIS}}",       signal: "{{SIGNAL}}",     opportunity: "{{OPPORTUNITY}}" },
      { category: "CRM / GTM Systems",      estimate: "${{X}}M",  basis: "{{BASIS}}",       signal: "{{SIGNAL}}",     opportunity: "{{OPPORTUNITY}}" },
      { category: "Workforce / HCM",        estimate: "${{X}}M",  basis: "{{BASIS}}",       signal: "{{SIGNAL}}",     opportunity: "{{OPPORTUNITY}}" },
      { category: "Total IT Spend (Est.)",  estimate: "${{X}}M",  basis: "{{X}}% of revenue — industry benchmark for this vertical", signal: "—", opportunity: "—" }
    ]
  },
  jobPostings: [
    { title: "{{ROLE TITLE}}", location: "{{CITY or REMOTE}}", salary: "{{$X–$Y or Not Listed}}", signal: "{{WHAT IT SIGNALS}}" },
    { title: "{{ROLE TITLE}}", location: "{{LOCATION}}",       salary: "{{SALARY}}",               signal: "{{SIGNAL}}" },
    { title: "{{ROLE TITLE}}", location: "{{LOCATION}}",       salary: "{{SALARY}}",               signal: "{{SIGNAL}}" }
  ],
  jobSynthesis: "{{PARAGRAPH: WHAT DO THESE POSTINGS COLLECTIVELY TELL YOU ABOUT ACTIVE PROGRAMS}}",
  techStack: {
    confirmed: [
      { platform: "{{PLATFORM NAME}}", source: "{{SOURCE: press release / job posting / vendor case study, DATE}}" },
      { platform: "{{PLATFORM NAME}}", source: "{{SOURCE}}" }
    ],
    inferred: [
      { platform: "{{PLATFORM NAME}}", basis: "{{BASIS: e.g., industry standard for this vertical; no contrary signal found}}" },
      { platform: "{{PLATFORM NAME}}", basis: "{{BASIS}}" }
    ]
  },
  opportunities: [
    { label: "{{OPPORTUNITY TITLE}}", tier: "1", timeline: "0–6 months", value: "${{X}}M", valueBasis: "{{BASIS}}", champion: "{{NAME, TITLE}}" },
    { label: "{{OPPORTUNITY TITLE}}", tier: "1", timeline: "0–6 months", value: "${{X}}M", valueBasis: "{{BASIS}}", champion: "{{NAME, TITLE}}" },
    { label: "{{OPPORTUNITY TITLE}}", tier: "2", timeline: "6–18 months", value: "${{X}}M", valueBasis: "{{BASIS}}", champion: "{{NAME, TITLE}}" },
    { label: "{{OPPORTUNITY TITLE}}", tier: "3", timeline: "18+ months", value: "${{X}}M", valueBasis: "{{BASIS}}", champion: "{{NAME, TITLE}}" }
  ],
  credentials: [
    { credential: "{{AWARD OR CREDENTIAL}}", soWhat: "{{2-3 SENTENCES: WHY THIS MATTERS FOR THIS SPECIFIC ACCOUNT}}" },
    { credential: "{{CREDENTIAL}}",          soWhat: "{{SO WHAT}}" },
    { credential: "{{CREDENTIAL}}",          soWhat: "{{SO WHAT}}" }
  ],
  credentialsProvided: true,   // set false to trigger placeholder section
  vision: "{{PARAGRAPH: WHAT YOUR FIRM WANTS TO BE FOR THIS COMPANY — SPECIFIC, NOT GENERIC}}",
  caseStudies: [
    { study: "{{CASE STUDY TITLE}}", relevance: "{{WHY IT MAPS TO A CONFIRMED PRIORITY HERE}}", talkingPoints: "{{BULLET 1}} | {{BULLET 2}} | {{BULLET 3}}" },
    { study: "{{CASE STUDY 2}}",     relevance: "{{RELEVANCE}}",                                 talkingPoints: "{{POINTS}}" },
    { study: "{{CASE STUDY 3}}",     relevance: "{{RELEVANCE}}",                                 talkingPoints: "{{POINTS}}" },
    { study: "{{CASE STUDY 4}}",     relevance: "{{RELEVANCE}}",                                 talkingPoints: "{{POINTS}}" }
  ],
  proposals: [
    {
      title:     "{{SPECIFIC ENGAGEMENT TITLE — NOT 'ADVISORY SERVICES'}}",
      champion:  "{{NAME, TITLE}}",
      argument:  "{{3-5 SENTENCES: THE ACTUAL PITCH — SPECIFIC PROBLEM, WHAT YOU'D DO, WHY DIFFERENTIATED, WHAT THE OUTCOME IS}}",
      price:     "${{X}}M–${{Y}}M",
      priceBasis:"comparable engagement scope in this vertical"
    },
    { title: "{{PROPOSAL 2}}", champion: "{{CHAMPION}}", argument: "{{ARGUMENT}}", price: "${{X}}M", priceBasis: "{{BASIS}}" },
    { title: "{{PROPOSAL 3}}", champion: "{{CHAMPION}}", argument: "{{ARGUMENT}}", price: "${{X}}M", priceBasis: "{{BASIS}}" },
    { title: "{{PROPOSAL 4}}", champion: "{{CHAMPION}}", argument: "{{ARGUMENT}}", price: "${{X}}M", priceBasis: "{{BASIS}}" }
  ],
  outreach: {
    firstContact:  "{{FULL NAME, EXACT TITLE — AND THE SPECIFIC REASON THEY ARE THE RIGHT FIRST DOOR}}",
    hook:          "{{ONE SENTENCE SPECIFIC HOOK: JOB POSTING / QUOTE / NEWS EVENT}}",
    emailSubject:  "{{SPECIFIC SUBJECT LINE}}",
    emailOpening:  "{{3 SENTENCES — SPECIFIC TO THIS PERSON AT THIS COMPANY, NO GENERIC INTROS}}",
    bestTiming:    "{{SPECIFIC DATE WINDOW AND THE REASON}}",
    pitfall1:      "{{SPECIFIC PITFALL 1}}",
    pitfall2:      "{{SPECIFIC PITFALL 2}}"
  }
};

// ============================================================
// HELPER FUNCTIONS
// ============================================================

// Inline assumption flag — orange italic
function assumption(basis) {
  return new TextRun({
    text: ` [ASSUMPTION — ${basis}]`,
    color: ORANGE,
    italics: true,
    size: 20,
    font: "Arial"
  });
}

// No-border spec (reused often)
const noBorder = {
  top:    { style: BorderStyle.NONE, size: 0, color: "auto" },
  bottom: { style: BorderStyle.NONE, size: 0, color: "auto" },
  left:   { style: BorderStyle.NONE, size: 0, color: "auto" },
  right:  { style: BorderStyle.NONE, size: 0, color: "auto" }
};

// Full-width navy section header bar
function sectionHeader(title) {
  return new Table({
    width: { size: 100, type: WidthType.PERCENTAGE },
    layout: TableLayoutType.FIXED,
    rows: [new TableRow({
      children: [new TableCell({
        shading: { fill: NAVY, type: ShadingType.CLEAR, color: "auto" },
        borders: noBorder,
        children: [new Paragraph({
          children: [new TextRun({ text: title, color: WHITE, bold: true, size: 28, font: "Arial" })],
          spacing: { before: 100, after: 100 },
          indent: { left: 120 }
        })]
      })]
    })]
  });
}

// Thin spacer between elements
function spacer(pts = 8) {
  return new Paragraph({ spacing: { after: pts * 20 } });
}

// Body paragraph (11pt Arial)
function body(textRuns) {
  return new Paragraph({
    children: Array.isArray(textRuns) ? textRuns : [new TextRun({ text: textRuns, font: "Arial", size: 22 })],
    spacing: { after: 120 },
    style: "Normal"
  });
}

// Subsection header (12pt BLUE bold)
function subsection(text) {
  return new Paragraph({
    children: [new TextRun({ text, color: BLUE, bold: true, size: 24, font: "Arial" })],
    spacing: { before: 160, after: 80 }
  });
}

// Standard data table with navy header row and alternating rows
function dataTable(headers, rows, colWidths) {
  const headerRow = new TableRow({
    tableHeader: true,
    children: headers.map((h, i) => new TableCell({
      shading: { fill: NAVY, type: ShadingType.CLEAR, color: "auto" },
      borders: noBorder,
      width: colWidths ? { size: colWidths[i], type: WidthType.PERCENTAGE } : undefined,
      children: [new Paragraph({
        children: [new TextRun({ text: h, color: WHITE, bold: true, size: 22, font: "Arial" })],
        spacing: { before: 60, after: 60 },
        indent: { left: 80 }
      })]
    }))
  });

  const dataRows = rows.map((row, rowIdx) =>
    new TableRow({
      children: row.map((cell, colIdx) => new TableCell({
        shading: rowIdx % 2 === 1 ? { fill: ALT, type: ShadingType.CLEAR, color: "auto" } : undefined,
        borders: {
          top:    { style: BorderStyle.SINGLE, size: 1, color: "DDDDDD" },
          bottom: { style: BorderStyle.SINGLE, size: 1, color: "DDDDDD" },
          left:   { style: BorderStyle.NONE },
          right:  { style: BorderStyle.NONE }
        },
        width: colWidths ? { size: colWidths[colIdx], type: WidthType.PERCENTAGE } : undefined,
        children: Array.isArray(cell)
          ? [new Paragraph({ children: cell, spacing: { before: 60, after: 60 }, indent: { left: 80 } })]
          : [new Paragraph({
              children: [new TextRun({ text: String(cell), size: 22, font: "Arial" })],
              spacing: { before: 60, after: 60 },
              indent: { left: 80 }
            })]
      }))
    })
  );

  return new Table({
    width: { size: 100, type: WidthType.PERCENTAGE },
    layout: TableLayoutType.FIXED,
    rows: [headerRow, ...dataRows]
  });
}

// Org chart box (single cell)
function orgBox(name, title, since, isPrimary, isNew, bgColor) {
  const label = `${isPrimary ? "★ " : ""}${name}${isNew ? " ⚡" : ""}`;
  return new TableCell({
    shading: { fill: bgColor, type: ShadingType.CLEAR, color: "auto" },
    borders: {
      top:    { style: BorderStyle.SINGLE, size: 4, color: WHITE },
      bottom: { style: BorderStyle.SINGLE, size: 4, color: WHITE },
      left:   { style: BorderStyle.SINGLE, size: 4, color: WHITE },
      right:  { style: BorderStyle.SINGLE, size: 4, color: WHITE }
    },
    verticalAlign: VerticalAlign.CENTER,
    children: [
      new Paragraph({
        children: [new TextRun({ text: label, color: WHITE, bold: true, size: 22, font: "Arial" })],
        alignment: AlignmentType.CENTER,
        spacing: { before: 80, after: 20 }
      }),
      new Paragraph({
        children: [new TextRun({ text: title, color: WHITE, size: 18, font: "Arial" })],
        alignment: AlignmentType.CENTER,
        spacing: { after: 20 }
      }),
      new Paragraph({
        children: [new TextRun({ text: `Since ${since}`, color: MUTED, size: 16, font: "Arial" })],
        alignment: AlignmentType.CENTER,
        spacing: { after: 80 }
      })
    ]
  });
}

// Navy callout box (used for vision statement)
function navyBox(paragraphText) {
  return new Table({
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [new TableRow({
      children: [new TableCell({
        shading: { fill: NAVY, type: ShadingType.CLEAR, color: "auto" },
        borders: noBorder,
        children: [new Paragraph({
          children: [new TextRun({ text: paragraphText, color: WHITE, size: 22, font: "Arial", italics: true })],
          spacing: { before: 140, after: 140 },
          indent: { left: 180, right: 180 }
        })]
      })]
    })]
  });
}

// ============================================================
// PAGE HEADER (page 2 onward)
// ============================================================
const pageHeader = new Header({
  children: [
    new Table({
      width: { size: 100, type: WidthType.PERCENTAGE },
      borders: {
        top:    { style: BorderStyle.NONE },
        left:   { style: BorderStyle.NONE },
        right:  { style: BorderStyle.NONE },
        insideH:{ style: BorderStyle.NONE },
        insideV:{ style: BorderStyle.NONE },
        bottom: { style: BorderStyle.SINGLE, size: 6, color: BLUE }
      },
      rows: [new TableRow({
        children: [
          new TableCell({
            borders: noBorder,
            children: [new Paragraph({
              children: [new TextRun({ text: data.pursuer.firm, color: NAVY, bold: true, size: 18, font: "Arial" })],
              alignment: AlignmentType.LEFT
            })]
          }),
          new TableCell({
            borders: noBorder,
            children: [new Paragraph({
              children: [new TextRun({ text: `Account Intelligence Report — ${data.company.name}`, color: NAVY, size: 18, font: "Arial" })],
              alignment: AlignmentType.RIGHT
            })]
          })
        ]
      })]
    })
  ]
});

// ============================================================
// COVER PAGE
// ============================================================
const coverPage = new Table({
  width: { size: 100, type: WidthType.PERCENTAGE },
  rows: [new TableRow({
    children: [new TableCell({
      shading: { fill: NAVY, type: ShadingType.CLEAR, color: "auto" },
      borders: noBorder,
      children: [
        spacer(20),
        new Paragraph({
          children: [new TextRun({ text: "CONFIDENTIAL — FOR INTERNAL USE ONLY", color: MUTED, size: 16, font: "Arial" })],
          alignment: AlignmentType.CENTER,
          spacing: { after: 160 }
        }),
        new Paragraph({
          children: [new TextRun({ text: "Account Intelligence Report", color: WHITE, bold: true, size: 128, font: "Arial" })],
          alignment: AlignmentType.CENTER,
          spacing: { after: 180 }
        }),
        new Paragraph({
          children: [new TextRun({ text: `${data.company.name} (${data.company.ticker})`, color: LIGHT, bold: true, size: 72, font: "Arial" })],
          alignment: AlignmentType.CENTER,
          spacing: { after: 100 }
        }),
        new Paragraph({
          children: [new TextRun({ text: data.company.descriptor, color: MUTED, size: 44, font: "Arial" })],
          alignment: AlignmentType.CENTER,
          spacing: { after: 280 }
        }),
        new Paragraph({
          children: [new TextRun({ text: "─".repeat(72), color: LIGHT, size: 16 })],
          alignment: AlignmentType.CENTER,
          spacing: { after: 220 }
        }),
        new Paragraph({
          children: [
            new TextRun({ text: "Prepared By:    ", color: MUTED, size: 20, font: "Arial" }),
            new TextRun({ text: data.pursuer.preparedBy, color: WHITE, size: 20, font: "Arial" }),
            new TextRun({ text: "          Prepared For:    ", color: MUTED, size: 20, font: "Arial" }),
            new TextRun({ text: data.pursuer.preparedFor, color: WHITE, size: 20, font: "Arial" })
          ],
          alignment: AlignmentType.CENTER,
          spacing: { after: 80 }
        }),
        new Paragraph({
          children: [
            new TextRun({ text: "Account:    ", color: MUTED, size: 20, font: "Arial" }),
            new TextRun({ text: data.company.name, color: WHITE, size: 20, font: "Arial" }),
            new TextRun({ text: "     Revenue:    ", color: MUTED, size: 20, font: "Arial" }),
            new TextRun({ text: data.company.revenue, color: WHITE, size: 20, font: "Arial" }),
            new TextRun({ text: "     Employees:    ", color: MUTED, size: 20, font: "Arial" }),
            new TextRun({ text: data.company.employees, color: WHITE, size: 20, font: "Arial" })
          ],
          alignment: AlignmentType.CENTER,
          spacing: { after: 80 }
        }),
        new Paragraph({
          children: [
            new TextRun({ text: "Pursuing Firm:    ", color: MUTED, size: 20, font: "Arial" }),
            new TextRun({ text: data.pursuer.firm, color: WHITE, size: 20, font: "Arial" }),
            new TextRun({ text: "     Date:    ", color: MUTED, size: 20, font: "Arial" }),
            new TextRun({ text: new Date().toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' }), color: WHITE, size: 20, font: "Arial" })
          ],
          alignment: AlignmentType.CENTER,
          spacing: { after: 400 }
        }),
        new Paragraph({
          children: [new TextRun({
            text: "All assumptions and estimates are flagged [ASSUMPTION] inline. Revenue and spend figures are based on public signals and industry benchmarks — not confirmed financial data. For internal use only.",
            color: MUTED, italics: true, size: 16, font: "Arial"
          })],
          alignment: AlignmentType.CENTER,
          spacing: { before: 100, after: 80 }
        }),
        spacer(20)
      ]
    })]
  })]
});

// ============================================================
// SECTION 1 — EXECUTIVE SUMMARY
// ============================================================
const section1 = [
  sectionHeader("Section 1 — Executive Summary"),
  spacer(6),
  body(data.executiveSummary)
];

// ============================================================
// SECTION 2 — COMPANY SNAPSHOT
// ============================================================
const section2 = [
  spacer(10),
  sectionHeader("Section 2 — Company Snapshot"),
  spacer(6),
  dataTable(
    ["Field", "Value"],
    [
      ["Headquarters",      data.company.hq],
      ["Revenue",           data.company.revenue],
      ["Employees",         data.company.employees],
      ["Fiscal Year End",   data.company.fiscalYearEnd],
      ["Exchange / Ticker", data.company.ticker],
      ["Core Products",     data.company.coreProducts],
      ["Key Markets",       data.company.keyMarkets],
      ["Strategic Moment",  data.company.strategicMoment]
    ],
    [25, 75]
  )
];

// ============================================================
// SECTION 3 — LEADERSHIP HIERARCHY
// ============================================================

// Build CEO row
const ceoRow = new TableRow({
  children: [orgBox(
    data.leadership.ceo.name,
    data.leadership.ceo.title,
    data.leadership.ceo.since,
    data.leadership.ceo.isPrimary,
    data.leadership.ceo.isNew,
    NAVY
  )]
});

// Build C-Suite row (side by side boxes)
const cSuiteRow = new TableRow({
  children: data.leadership.cSuite.map(exec =>
    orgBox(exec.name, exec.title, exec.since, exec.isPrimary, exec.isNew, BLUE)
  )
});

// Build VP row
const vpRow = new TableRow({
  children: data.leadership.vps.map(vp =>
    orgBox(vp.name, vp.title, vp.since, vp.isPrimary, vp.isNew, TEAL)
  )
});

const orgChart = new Table({
  width: { size: 100, type: WidthType.PERCENTAGE },
  layout: TableLayoutType.FIXED,
  rows: [ceoRow, cSuiteRow, vpRow]
});

// Leadership detail table
const leadershipTableRows = [
  ...data.leadership.cSuite.map(exec => [
    `${exec.isPrimary ? "★ " : ""}${exec.isNew ? "⚡ " : ""}${exec.name}\n${exec.title}`,
    exec.background,
    `Since ${exec.since}`,
    exec.whyMatters
  ]),
  ...data.leadership.vps.map(vp => [
    `${vp.isPrimary ? "★ " : ""}${vp.isNew ? "⚡ " : ""}${vp.name}\n${vp.title}`,
    vp.background,
    `Since ${vp.since}`,
    vp.whyMatters
  ])
];

const section3 = [
  spacer(10),
  sectionHeader("Section 3 — Leadership Hierarchy"),
  spacer(6),
  subsection("Organizational Chart"),
  spacer(4),
  orgChart,
  spacer(4),
  body("★ = Primary pursuit contact     ⚡ New = Joined within 18 months"),
  spacer(10),
  subsection("Leadership Detail"),
  spacer(4),
  dataTable(
    ["Name / Title", "Background", "Tenure", "Why They Matter to This Pursuit"],
    leadershipTableRows,
    [22, 28, 15, 35]
  ),
  spacer(10),
  subsection("Leadership Analytical Note"),
  body(data.leadership.analyticalNote)
];

// ============================================================
// SECTION 4 — STRATEGIC PRIORITIES
// ============================================================
const section4Content = [
  spacer(10),
  sectionHeader("Section 4 — Strategic Priorities")
];
data.strategicPriorities.forEach((p, i) => {
  section4Content.push(spacer(8));
  section4Content.push(subsection(`Priority ${i + 1}: ${p.title}`));
  section4Content.push(body([
    new TextRun({ text: "Public Commitment: ", bold: true, size: 22, font: "Arial" }),
    new TextRun({ text: `"${p.commitment}"`, size: 22, font: "Arial", italics: true }),
    new TextRun({ text: ` — ${p.source}`, size: 20, font: "Arial", color: "555555" })
  ]));
  section4Content.push(body([
    new TextRun({ text: "Technology / Consulting Need: ", bold: true, size: 22, font: "Arial" }),
    new TextRun({ text: p.need, size: 22, font: "Arial" })
  ]));
  section4Content.push(body([
    new TextRun({ text: "Executive Owner: ", bold: true, size: 22, font: "Arial" }),
    new TextRun({ text: p.owner, size: 22, font: "Arial" })
  ]));
});
const section4 = section4Content;

// ============================================================
// SECTION 5 — TECHNOLOGY LANDSCAPE AND SPENDING SIGNALS
// ============================================================
const section5 = [
  spacer(10),
  sectionHeader("Section 5 — Technology Landscape and Spending Signals"),
  spacer(6),
  subsection("Incumbent Partners"),
  body(data.techLandscape.incumbentDescription),
  spacer(8),
  subsection("Technology Spending Estimates"),
  spacer(4),
  dataTable(
    ["Category", "Est. Annual Spend", "Key Signal", `${data.pursuer.firm} Opportunity`],
    data.techLandscape.spending.map(row => [
      row.category,
      [new TextRun({ text: row.estimate, size: 22, font: "Arial" }), assumption(row.basis)],
      row.signal,
      row.opportunity
    ]),
    [22, 18, 30, 30]
  )
];

// ============================================================
// SECTION 6 — JOB POSTING INTELLIGENCE
// ============================================================
const section6 = [
  spacer(10),
  sectionHeader("Section 6 — Job Posting Intelligence"),
  spacer(6),
  dataTable(
    ["Role Title", "Location", "Salary Range", "What It Signals"],
    data.jobPostings.map(jp => [jp.title, jp.location, jp.salary, jp.signal]),
    [30, 15, 15, 40]
  ),
  spacer(8),
  subsection("Synthesis"),
  body(data.jobSynthesis)
];

// ============================================================
// SECTION 7 — TECHNOLOGY STACK
// ============================================================
const stackRows = [];
const maxLen = Math.max(data.techStack.confirmed.length, data.techStack.inferred.length);
for (let i = 0; i < maxLen; i++) {
  const conf = data.techStack.confirmed[i];
  const inf  = data.techStack.inferred[i];
  stackRows.push([
    conf ? [new TextRun({ text: conf.platform, bold: true, size: 22, font: "Arial" }), new TextRun({ text: `\n${conf.source}`, size: 18, font: "Arial", color: "555555" })] : [""],
    inf  ? [new TextRun({ text: inf.platform, size: 22, font: "Arial" }), assumption(inf.basis)] : [""]
  ]);
}

const section7 = [
  spacer(10),
  sectionHeader("Section 7 — Technology Stack"),
  spacer(6),
  dataTable(
    ["Confirmed (Source Cited)", "Likely / Inferred [ASSUMPTION — basis]"],
    stackRows,
    [50, 50]
  )
];

// ============================================================
// SECTION 8 — OPPORTUNITY MAP
// ============================================================
const tierColors = { "1": "C8E6C9", "2": "FFF9C4", "3": "F3E5F5" };
const section8 = [
  spacer(10),
  sectionHeader("Section 8 — Opportunity Map"),
  spacer(6),
  dataTable(
    ["Opportunity", "Tier", "Timeline", "Est. Value", "Named Champion"],
    data.opportunities.map(opp => [
      opp.label,
      `Tier ${opp.tier}`,
      opp.timeline,
      [new TextRun({ text: opp.value, size: 22, font: "Arial" }), assumption(opp.valueBasis)],
      opp.champion
    ]),
    [30, 8, 12, 18, 32]
  ),
  spacer(6),
  body("Tier 1 = Active, fundable, champion identified, near-term trigger.   Tier 2 = Needs relationship development.   Tier 3 = Strategic, requires future event.")
];

// ============================================================
// SECTION 9 — CREDENTIALS
// ============================================================
const credentialContent = data.credentialsProvided
  ? dataTable(
      ["Credential / Recognition", `What It Means in a Conversation with ${data.company.name}`],
      data.credentials.map(c => [c.credential, c.soWhat]),
      [35, 65]
    )
  : body("[YOUR FIRM] credentials section — insert relevant recognitions, analyst rankings, platform partnership tiers, and referenceable case studies in this vertical before using this document in a pursuit conversation.");

const section9 = [
  spacer(10),
  sectionHeader(`Section 9 — ${data.pursuer.firm} at a Glance: Why We Win`),
  spacer(6),
  credentialContent
];

// ============================================================
// SECTION 10 — STRATEGY AND VISION
// ============================================================
const section10 = [
  spacer(10),
  sectionHeader(`Section 10 — ${data.pursuer.firm} Strategy and Vision for ${data.company.name}`),
  spacer(6),
  subsection("10.1 — Vision Statement"),
  spacer(4),
  navyBox(data.vision),
  spacer(10),
  subsection("10.2 — Case Studies to Showcase"),
  spacer(4),
  dataTable(
    ["Case Study", `Relevance to ${data.company.name}`, "Talking Points"],
    data.caseStudies.map(cs => [cs.study, cs.relevance, cs.talkingPoints.replace(/\|/g, "\n• ")]),
    [25, 35, 40]
  ),
  spacer(10),
  subsection("10.3 — Proposals to Build Before First Meeting"),
  spacer(4),
  dataTable(
    ["Proposal Title", "Target Champion", "Core Argument"],
    data.proposals.map(p => [
      p.title,
      p.champion,
      [
        new TextRun({ text: p.argument, size: 22, font: "Arial" }),
        new TextRun({ text: `\nIndicative range: ${p.price} `, size: 20, font: "Arial" }),
        assumption(p.priceBasis)
      ]
    ]),
    [22, 20, 58]
  )
];

// ============================================================
// SECTION 11 — OUTREACH STRATEGY
// ============================================================
const section11 = [
  spacer(10),
  sectionHeader("Section 11 — Recommended Outreach Strategy"),
  spacer(6),
  subsection("11.1 — Who to Contact First"),
  body(data.outreach.firstContact),
  spacer(6),
  subsection("11.2 — What to Lead With"),
  body(data.outreach.hook),
  spacer(6),
  subsection("11.3 — Draft Email Opening"),
  body([new TextRun({ text: `Subject: ${data.outreach.emailSubject}`, bold: true, size: 22, font: "Arial" })]),
  body(data.outreach.emailOpening),
  spacer(6),
  subsection("11.4 — Best Timing"),
  body(data.outreach.bestTiming),
  spacer(6),
  subsection("11.5 — What NOT to Do"),
  body(`1. ${data.outreach.pitfall1}`),
  body(`2. ${data.outreach.pitfall2}`)
];

// ============================================================
// ASSEMBLE AND SAVE DOCUMENT
// ============================================================
const doc = new Document({
  styles: {
    default: {
      document: {
        run: { font: "Arial", size: 22 }
      }
    }
  },
  sections: [
    // Section A: Cover page — no header, minimal margins
    {
      properties: {
        page: {
          margin: {
            top:    convertInchesToTwip(0.3),
            bottom: convertInchesToTwip(0.3),
            left:   convertInchesToTwip(0.3),
            right:  convertInchesToTwip(0.3)
          }
        }
      },
      children: [coverPage]
    },
    // Section B: Main report — standard margins, header from page 2
    {
      properties: {
        page: {
          margin: {
            top:    convertInchesToTwip(1.0),
            bottom: convertInchesToTwip(1.0),
            left:   convertInchesToTwip(1.0),
            right:  convertInchesToTwip(1.0)
          }
        }
      },
      headers: {
        default: pageHeader
      },
      children: [
        ...section1,
        ...section2,
        ...section3,
        ...section4,
        ...section5,
        ...section6,
        ...section7,
        ...section8,
        ...section9,
        ...section10,
        ...section11,
        spacer(20)
      ]
    }
  ]
});

// Output path
const outputDir  = "/mnt/user-data/outputs";
const outputFile = path.join(
  outputDir,
  `${data.company.name.replace(/[^a-z0-9]/gi, '_')}_Account_Intelligence_${data.pursuer.firm.replace(/[^a-z0-9]/gi, '_')}.docx`
);

if (!fs.existsSync(outputDir)) fs.mkdirSync(outputDir, { recursive: true });

Packer.toBuffer(doc).then(buffer => {
  fs.writeFileSync(outputFile, buffer);
  console.log(`\n✓ Report saved to: ${outputFile}\n`);
}).catch(err => {
  console.error("Error generating report:", err);
  process.exit(1);
});
```

---

## CUSTOMIZATION NOTES

### Adding More C-Suite Members

Add additional objects to `data.leadership.cSuite`. The org chart and table both iterate over the array.

### Handling Private Companies

Set `data.company.ticker = "PRIVATE"`. All spend estimates and revenue figures will need a basis — apply `assumption()` to each. Remove Section 2 "Exchange / Ticker" row if it creates confusion.

### Handling Federal Agencies

Set `data.company.ticker = "FEDERAL"`. Replace `revenue` with `budget` (e.g., "FY2026 IT Budget: $XXM"). In Section 5, replace "Annual Spend" column with "Contract Award Value" and source each from SAM.gov.

### Adding More Sections or Subsections

Follow the `subsection()` + `dataTable()` or `body()` pattern. All elements are plain arrays — append to the relevant section array.

### Fixing Rendering Issues

- If text overflows table cells: reduce font size from 22 to 20 in that cell, or reduce text length
- If the cover page navy background doesn't fill: increase the `spacer()` values inside the cover cell
- If column widths don't add to 100: recalculate `colWidths` array to sum to exactly 100

### Testing Without Full Data

Run the script with placeholder strings in place to verify formatting before populating all research findings. The `[ASSUMPTION]` flags will appear in orange italic regardless of placeholder content.
