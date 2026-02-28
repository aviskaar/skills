# .docx Generation Script — Node.js Template

This file provides the complete scaffold for generating the Account Intelligence Report as a formatted `.docx` file using the `docx` npm package (v8.x), with high-definition embedded charts via `chartjs-node-canvas`.

**Instructions for use:**
1. Copy the script below into a new file: `generate-report.js`
2. Populate the `data` object at the top with all research findings
3. Anywhere a value is estimated or inferred, append the inline assumption text using the `assumption()` helper (see Section 2)
4. Run: `npm install docx chartjs-node-canvas chart.js canvas && node generate-report.js`

**Chart dependencies:** The script generates four high-definition PNG charts embedded directly in the .docx:
- Spending Allocation doughnut chart (Section 5)
- Opportunity Timeline bar chart (Section 8)
- AI Readiness Radar chart (Section 12)
- IP Strength Snapshot horizontal bar chart (Section 13)

---

## COMPLETE GENERATION SCRIPT

```javascript
// ============================================================
// Account Intelligence Report Generator
// Requires: npm install docx chartjs-node-canvas chart.js canvas
// Usage: node generate-report.js
// ============================================================

const {
  Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell,
  WidthType, BorderStyle, AlignmentType, ShadingType, VerticalAlign,
  Header, PageBreak, convertInchesToTwip, UnderlineType, TableLayoutType,
  ImageRun
} = require('docx');
const fs = require('fs');
const path = require('path');
const { ChartJSNodeCanvas } = require('chartjs-node-canvas');

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
const GOLD   = "FFF8DC";   // Pioneering Bets callout background
const GOLDBORDER = "B8860B"; // Pioneering Bets border accent
const PURPLE = "6B4FA0";   // AI governance / research accent
const GREEN  = "2E7D32";   // AI readiness strong (4–5)
const RED    = "C62828";   // AI readiness weak (1–2)
const AMBER  = "E65100";   // AI readiness mid (3)
const LIGHTGOLD = "FFF3CD"; // IP section row alt

// Chart colors (hex without #, for chartjs)
const CHART_COLORS = {
  navy:   '#1B2A4A',
  blue:   '#2E5FA3',
  teal:   '#2E8B7A',
  light:  '#5BA3C9',
  orange: '#CC6600',
  alt:    '#EEF3FA',
  purple: '#6B4FA0',
  green:  '#2E7D32',
  amber:  '#E65100'
};

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
  },

  // ---- AI AGENTIC VISION (Section 12) ----
  aiVision: {
    // AI Readiness scores — each dimension scored 1–5 from Dimension 8 research
    readinessScores: [
      { dimension: "Data Maturity",         score: 0, evidence: "{{SPECIFIC SIGNAL FROM RESEARCH}}", implication: "{{WHAT THIS MEANS FOR AI BUILDOUT}}" },
      { dimension: "Infrastructure Readiness", score: 0, evidence: "{{SIGNAL}}", implication: "{{IMPLICATION}}" },
      { dimension: "AI / ML Talent",        score: 0, evidence: "{{SIGNAL}}", implication: "{{IMPLICATION}}" },
      { dimension: "AI Governance",         score: 0, evidence: "{{SIGNAL}}", implication: "{{IMPLICATION}}" },
      { dimension: "Agentic Readiness",     score: 0, evidence: "{{SIGNAL}}", implication: "{{IMPLICATION}}" }
    ],
    // Agentic use cases — tied to confirmed strategic priorities
    useCases: [
      {
        name:           "{{SPECIFIC USE CASE — NOT 'AI AUTOMATION'}}",
        function:       "{{BUSINESS FUNCTION: Finance / Ops / HR / Supply Chain / etc.}}",
        strategicLink:  "{{Links to Priority X from Section 4}}",
        impact:         "{{High / Medium / Low}}",
        complexity:     "{{High / Medium / Low}}",
        tier:           "1",   // 1 = Deploy Now, 2 = Build This Year, 3 = Innovate Long-Term
        valueEstimate:  "${{X}}M",
        valueBasis:     "{{BASIS FOR ESTIMATE}}"
      },
      {
        name: "{{USE CASE 2}}", function: "{{FUNCTION}}", strategicLink: "{{LINK}}",
        impact: "{{H/M/L}}", complexity: "{{H/M/L}}", tier: "1",
        valueEstimate: "${{X}}M", valueBasis: "{{BASIS}}"
      },
      {
        name: "{{USE CASE 3}}", function: "{{FUNCTION}}", strategicLink: "{{LINK}}",
        impact: "{{H/M/L}}", complexity: "{{H/M/L}}", tier: "2",
        valueEstimate: "${{X}}M", valueBasis: "{{BASIS}}"
      },
      {
        name: "{{USE CASE 4}}", function: "{{FUNCTION}}", strategicLink: "{{LINK}}",
        impact: "{{H/M/L}}", complexity: "{{H/M/L}}", tier: "2",
        valueEstimate: "${{X}}M", valueBasis: "{{BASIS}}"
      },
      {
        name: "{{USE CASE 5}}", function: "{{FUNCTION}}", strategicLink: "{{LINK}}",
        impact: "{{H/M/L}}", complexity: "{{H/M/L}}", tier: "3",
        valueEstimate: "${{X}}M", valueBasis: "{{BASIS}}"
      }
    ],
    deliveryModel:    "{{PARAGRAPH: HOW YOUR FIRM DELIVERS — SPECIFIC PLATFORMS, ACCELERATORS, SEQUENCING, GOVERNANCE}}",
    platformAnchors:  "{{SPECIFIC AI PLATFORMS FROM COMPANY'S CONFIRMED TECH STACK THAT ANCHOR THE SOLUTION}}",
    investmentTable: [
      { area: "{{INVESTMENT AREA 1}}", investment: "${{X}}M", valueBasis: "{{BASIS}}", valueCapture: "${{Y}}M", payback: "{{X months}}" },
      { area: "{{INVESTMENT AREA 2}}", investment: "${{X}}M", valueBasis: "{{BASIS}}", valueCapture: "${{Y}}M", payback: "{{X months}}" },
      { area: "{{INVESTMENT AREA 3}}", investment: "${{X}}M", valueBasis: "{{BASIS}}", valueCapture: "${{Y}}M", payback: "{{X months}}" }
    ],
    cfoNarrative:     "{{3-4 SENTENCES: HOW YOUR FIRM WOULD PRESENT THE AI BUSINESS CASE TO THE CFO — SPECIFIC TO THIS COMPANY'S COST PRESSURES OR GROWTH MANDATE}}"
  },

  // ---- IP & RESEARCH OPPORTUNITIES (Section 13) ----
  ipResearch: {
    // IP landscape across three categories
    ipLandscape: [
      {
        category:    "Patent Portfolio",
        currentState: "{{ACTIVE PATENTS / FILING ACTIVITY / DOMAINS — sourced or flagged}}",
        strength:    "{{High / Medium / Low}}",
        gap:         "{{WHERE COVERAGE IS THIN OR NOVEL IP COULD BE FILED}}"
      },
      {
        category:    "Proprietary Data Assets",
        currentState: "{{WHAT UNIQUE DATA THE COMPANY GENERATES OR HOLDS}}",
        strength:    "{{High / Medium / Low}}",
        gap:         "{{HOW IT COULD BE MONETIZED OR PROTECTED}}"
      },
      {
        category:    "Proprietary Processes / Algorithms",
        currentState: "{{KNOWN TRADE SECRETS, PROPRIETARY MODELS, UNIQUE WORKFLOWS}}",
        strength:    "{{High / Medium / Low}}",
        gap:         "{{WHAT COULD BE FORMALIZED, PROTECTED, OR BUILT ON}}"
      }
    ],
    // Research & innovation opportunities
    researchOpportunities: [
      {
        area:         "{{RESEARCH AREA 1 — SPECIFIC}}",
        rationale:    "{{WHY THIS MATTERS FOR THIS COMPANY NOW}}",
        output:       "{{PATENT / MODEL / PLATFORM / PUBLISHED RESEARCH}}",
        firmRole:     "{{Lead / Co-develop / Advisory}}",
        timeline:     "{{X months}}"
      },
      {
        area: "{{RESEARCH AREA 2}}", rationale: "{{RATIONALE}}",
        output: "{{OUTPUT}}", firmRole: "{{ROLE}}", timeline: "{{X months}}"
      },
      {
        area: "{{RESEARCH AREA 3}}", rationale: "{{RATIONALE}}",
        output: "{{OUTPUT}}", firmRole: "{{ROLE}}", timeline: "{{X months}}"
      },
      {
        area: "{{RESEARCH AREA 4}}", rationale: "{{RATIONALE}}",
        output: "{{OUTPUT}}", firmRole: "{{ROLE}}", timeline: "{{X months}}"
      }
    ],
    // Co-innovation model
    coInnovation: {
      fundingModel:      "{{HOW COSTS, IP OWNERSHIP, AND COMMERCIALIZATION RIGHTS WOULD BE SPLIT}}",
      governance:        "{{WHO OWNS DECISIONS — NAMED ROLES AT BOTH ORGANIZATIONS}}",
      ipFramework:       "{{WHAT EACH PARTY BRINGS IN, WHAT GETS CREATED JOINTLY, HOW NEW IP IS REGISTERED}}",
      milestones:        "{{6-MONTH, 12-MONTH, 24-MONTH OUTCOMES}}",
      modelNarrative:    "{{3-4 SENTENCES: WHY THIS MODEL FITS THIS COMPANY'S CULTURE AND RISK TOLERANCE}}"
    },
    // Pioneering Bets — 2–3 industry-defining innovation opportunities
    pioneeringBets: [
      {
        title:           "{{PIONEERING BET 1 TITLE}}",
        thesis:          "{{WHAT MAKES THIS COMPANY UNIQUELY POSITIONED — SPECIFIC DATA ASSET + DOMAIN DEPTH + STRATEGIC MOMENT}}",
        innovation:      "{{WHAT NOVEL AI CAPABILITY, PRODUCT, OR PROCESS COULD BE BUILT}}",
        moat:            "{{WHY COMPETITORS COULD NOT EASILY REPLICATE THIS}}",
        firmContribution:"{{WHAT YOUR FIRM BRINGS — SPECIFIC IP, PLATFORM, OR EXPERTISE}}",
        risk:            "{{WHAT COULD PREVENT THIS — TECHNOLOGY / ORGANIZATIONAL / REGULATORY}}"
      },
      {
        title: "{{PIONEERING BET 2 TITLE}}",
        thesis: "{{THESIS}}", innovation: "{{INNOVATION}}",
        moat: "{{MOAT}}", firmContribution: "{{FIRM CONTRIBUTION}}", risk: "{{RISK}}"
      }
    ]
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
// CHART GENERATION HELPERS (chartjs-node-canvas)
// ============================================================

// Generates a chart as a PNG Buffer
async function generateChart(type, chartData, options, width = 550, height = 380) {
  const canvas = new ChartJSNodeCanvas({
    width, height,
    backgroundColour: '#FFFFFF',
    chartCallback: (ChartJS) => {
      ChartJS.defaults.font.family = 'Arial';
      ChartJS.defaults.color = '#1B2A4A';
    }
  });
  return canvas.renderToBuffer({ type, data: chartData, options });
}

// Embeds a chart buffer as an ImageRun in a centered Paragraph
function chartImage(buffer, widthPx = 490, heightPx = 340) {
  return new Paragraph({
    children: [
      new ImageRun({
        data: buffer,
        transformation: { width: widthPx, height: heightPx }
      })
    ],
    alignment: AlignmentType.CENTER,
    spacing: { before: 100, after: 120 }
  });
}

// Spending Allocation doughnut chart (Section 5)
async function buildSpendingChart(spendingData) {
  const labels = spendingData
    .filter(r => r.category !== 'Total IT Spend (Est.)')
    .map(r => r.category);
  const values = spendingData
    .filter(r => r.category !== 'Total IT Spend (Est.)')
    .map(r => parseFloat(r.estimate.replace(/[^0-9.]/g, '')) || 10);
  const colors = [
    CHART_COLORS.navy, CHART_COLORS.blue, CHART_COLORS.teal,
    CHART_COLORS.light, CHART_COLORS.purple, CHART_COLORS.amber
  ];
  return generateChart('doughnut', {
    labels,
    datasets: [{
      data: values,
      backgroundColor: colors.slice(0, labels.length),
      borderColor: '#FFFFFF',
      borderWidth: 3,
      hoverOffset: 8
    }]
  }, {
    plugins: {
      title: {
        display: true,
        text: 'Estimated IT Spend Allocation',
        font: { size: 14, weight: 'bold' },
        color: '#1B2A4A',
        padding: { bottom: 12 }
      },
      legend: {
        position: 'right',
        labels: { font: { size: 11 }, color: '#1B2A4A', padding: 12, boxWidth: 16 }
      }
    },
    cutout: '58%'
  }, 550, 320);
}

// Opportunity Timeline horizontal bar chart (Section 8)
async function buildOpportunityChart(opportunities) {
  const tier1 = opportunities.filter(o => o.tier === '1');
  const tier2 = opportunities.filter(o => o.tier === '2');
  const tier3 = opportunities.filter(o => o.tier === '3');
  const allOpps = [...tier1, ...tier2, ...tier3];
  const labels = allOpps.map(o => o.label.length > 32 ? o.label.substring(0, 32) + '…' : o.label);
  const starts = allOpps.map(o => parseInt(o.tier) === 1 ? 0 : parseInt(o.tier) === 2 ? 6 : 18);
  const durations = allOpps.map(o => parseInt(o.tier) === 1 ? 6 : parseInt(o.tier) === 2 ? 12 : 12);
  const bgColors = allOpps.map(o =>
    o.tier === '1' ? CHART_COLORS.teal : o.tier === '2' ? CHART_COLORS.blue : CHART_COLORS.navy
  );
  return generateChart('bar', {
    labels,
    datasets: [
      { data: starts, backgroundColor: 'transparent', borderColor: 'transparent', barPercentage: 0.6 },
      { data: durations, backgroundColor: bgColors, borderRadius: 4, barPercentage: 0.6,
        label: 'Opportunity Window (months)' }
    ]
  }, {
    indexAxis: 'y',
    plugins: {
      title: {
        display: true,
        text: 'Opportunity Timeline (months from now)',
        font: { size: 13, weight: 'bold' },
        color: '#1B2A4A',
        padding: { bottom: 10 }
      },
      legend: { display: false },
      tooltip: {
        callbacks: {
          label: (ctx) => ctx.datasetIndex === 1 ? ` ${ctx.raw} months` : ''
        }
      }
    },
    scales: {
      x: {
        stacked: true,
        max: 32,
        ticks: { callback: v => `M${v}`, color: '#1B2A4A', font: { size: 10 } },
        grid: { color: '#EEF3FA' }
      },
      y: { stacked: true, ticks: { color: '#1B2A4A', font: { size: 10 } }, grid: { display: false } }
    }
  }, 600, Math.max(280, allOpps.length * 44 + 80));
}

// AI Readiness Radar chart (Section 12)
async function buildAIRadarChart(readinessScores) {
  const labels = readinessScores.map(r => r.dimension);
  const scores = readinessScores.map(r => r.score);
  return generateChart('radar', {
    labels,
    datasets: [{
      label: 'AI Readiness Score',
      data: scores,
      backgroundColor: 'rgba(27, 42, 74, 0.35)',
      borderColor: '#2E5FA3',
      borderWidth: 2.5,
      pointBackgroundColor: '#2E5FA3',
      pointBorderColor: '#FFFFFF',
      pointRadius: 5,
      pointHoverRadius: 7
    }]
  }, {
    scales: {
      r: {
        min: 0,
        max: 5,
        ticks: {
          stepSize: 1,
          display: true,
          font: { size: 10 },
          color: '#AACCEE',
          backdropColor: 'transparent'
        },
        pointLabels: { font: { size: 11, weight: 'bold' }, color: '#1B2A4A' },
        grid: { color: '#AACCEE' },
        angleLines: { color: '#AACCEE' }
      }
    },
    plugins: {
      title: {
        display: true,
        text: 'AI Readiness Assessment',
        font: { size: 14, weight: 'bold' },
        color: '#1B2A4A',
        padding: { bottom: 10 }
      },
      legend: { display: false }
    }
  }, 460, 400);
}

// IP Strength Snapshot horizontal bar chart (Section 13)
async function buildIPChart(ipLandscape) {
  const labels = ipLandscape.map(ip => ip.category);
  const strengthMap = { 'High': 5, 'Medium': 3, 'Low': 1 };
  const values = ipLandscape.map(ip => strengthMap[ip.strength] || 2);
  const colors = ipLandscape.map(ip =>
    ip.strength === 'High' ? CHART_COLORS.teal :
    ip.strength === 'Medium' ? CHART_COLORS.blue :
    CHART_COLORS.orange
  );
  return generateChart('bar', {
    labels,
    datasets: [{
      label: 'IP Strength',
      data: values,
      backgroundColor: colors,
      borderRadius: 5,
      barPercentage: 0.55
    }]
  }, {
    indexAxis: 'y',
    plugins: {
      title: {
        display: true,
        text: 'IP Strength by Category',
        font: { size: 13, weight: 'bold' },
        color: '#1B2A4A',
        padding: { bottom: 10 }
      },
      legend: { display: false }
    },
    scales: {
      x: {
        min: 0,
        max: 5,
        ticks: {
          callback: v => ['', 'Low', '', 'Med', '', 'High'][v] || '',
          color: '#1B2A4A',
          font: { size: 11 }
        },
        grid: { color: '#EEF3FA' }
      },
      y: { ticks: { color: '#1B2A4A', font: { size: 12, weight: 'bold' } }, grid: { display: false } }
    }
  }, 500, 240);
}

// AI Readiness score color (based on score 1–5)
function scoreColor(score) {
  if (score >= 4) return GREEN;
  if (score === 3) return AMBER;
  return RED;
}

// Colored score badge cell for AI readiness table
function scoreBadgeCell(score) {
  const color = scoreColor(score);
  const bars = '■'.repeat(score) + '□'.repeat(5 - score);
  return new TableCell({
    shading: { fill: color, type: ShadingType.CLEAR, color: 'auto' },
    borders: noBorder,
    verticalAlign: VerticalAlign.CENTER,
    children: [new Paragraph({
      children: [
        new TextRun({ text: `${score}/5  `, color: WHITE, bold: true, size: 22, font: 'Arial' }),
        new TextRun({ text: bars, color: WHITE, size: 18, font: 'Arial' })
      ],
      alignment: AlignmentType.CENTER,
      spacing: { before: 60, after: 60 }
    })]
  });
}

// Gold callout box for Pioneering Bets
function goldBox(title, paragraphTexts) {
  const children = [
    new Paragraph({
      children: [new TextRun({ text: `★ ${title}`, color: GOLDBORDER, bold: true, size: 24, font: 'Arial' })],
      spacing: { before: 120, after: 80 },
      indent: { left: 160 }
    }),
    ...paragraphTexts.map(t => new Paragraph({
      children: [new TextRun({ text: t, color: '3D2B00', size: 22, font: 'Arial' })],
      spacing: { after: 80 },
      indent: { left: 160, right: 160 }
    }))
  ];
  return new Table({
    width: { size: 100, type: WidthType.PERCENTAGE },
    rows: [new TableRow({
      children: [new TableCell({
        shading: { fill: GOLD, type: ShadingType.CLEAR, color: 'auto' },
        borders: {
          top:    { style: BorderStyle.SINGLE, size: 8, color: GOLDBORDER },
          bottom: { style: BorderStyle.SINGLE, size: 8, color: GOLDBORDER },
          left:   { style: BorderStyle.SINGLE, size: 8, color: GOLDBORDER },
          right:  { style: BorderStyle.SINGLE, size: 8, color: GOLDBORDER }
        },
        children
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
// SECTION 12 — AI AGENTIC SOLUTIONS VISION
// (built async — requires chart generation)
// ============================================================
async function buildSection12() {
  const radarBuf = await buildAIRadarChart(data.aiVision.readinessScores);

  // AI Readiness scorecard table (colored score badges)
  const readinessTable = new Table({
    width: { size: 100, type: WidthType.PERCENTAGE },
    layout: TableLayoutType.FIXED,
    rows: [
      new TableRow({
        tableHeader: true,
        children: ['Dimension', 'Score', 'Evidence / Signal', 'Implication'].map(h =>
          new TableCell({
            shading: { fill: NAVY, type: ShadingType.CLEAR, color: 'auto' },
            borders: noBorder,
            children: [new Paragraph({
              children: [new TextRun({ text: h, color: WHITE, bold: true, size: 22, font: 'Arial' })],
              spacing: { before: 60, after: 60 },
              indent: { left: 80 }
            })]
          })
        )
      }),
      ...data.aiVision.readinessScores.map((r, i) =>
        new TableRow({
          children: [
            new TableCell({
              shading: i % 2 === 1 ? { fill: ALT, type: ShadingType.CLEAR, color: 'auto' } : undefined,
              borders: { top: { style: BorderStyle.SINGLE, size: 1, color: 'DDDDDD' }, bottom: { style: BorderStyle.SINGLE, size: 1, color: 'DDDDDD' }, left: { style: BorderStyle.NONE }, right: { style: BorderStyle.NONE } },
              children: [new Paragraph({ children: [new TextRun({ text: r.dimension, bold: true, size: 22, font: 'Arial' })], spacing: { before: 60, after: 60 }, indent: { left: 80 } })]
            }),
            scoreBadgeCell(r.score),
            new TableCell({
              shading: i % 2 === 1 ? { fill: ALT, type: ShadingType.CLEAR, color: 'auto' } : undefined,
              borders: { top: { style: BorderStyle.SINGLE, size: 1, color: 'DDDDDD' }, bottom: { style: BorderStyle.SINGLE, size: 1, color: 'DDDDDD' }, left: { style: BorderStyle.NONE }, right: { style: BorderStyle.NONE } },
              children: [new Paragraph({ children: [new TextRun({ text: r.evidence, size: 20, font: 'Arial', color: '333333' })], spacing: { before: 60, after: 60 }, indent: { left: 80 } })]
            }),
            new TableCell({
              shading: i % 2 === 1 ? { fill: ALT, type: ShadingType.CLEAR, color: 'auto' } : undefined,
              borders: { top: { style: BorderStyle.SINGLE, size: 1, color: 'DDDDDD' }, bottom: { style: BorderStyle.SINGLE, size: 1, color: 'DDDDDD' }, left: { style: BorderStyle.NONE }, right: { style: BorderStyle.NONE } },
              children: [new Paragraph({ children: [new TextRun({ text: r.implication, size: 20, font: 'Arial', italics: true })], spacing: { before: 60, after: 60 }, indent: { left: 80 } })]
            })
          ]
        })
      )
    ]
  });

  // Tier color mapping for use case table
  const tierBg = { '1': 'D0F0E8', '2': 'D6E4F7', '3': 'D5D0E8' };
  const tierLabel = { '1': 'Tier 1 — Deploy Now', '2': 'Tier 2 — Build This Year', '3': 'Tier 3 — Innovate Long-Term' };

  const useCaseTable = dataTable(
    ['Use Case', 'Function', 'Strategic Link', 'Impact', 'Complexity', 'Tier'],
    data.aiVision.useCases.map(uc => [
      uc.name,
      uc.function,
      uc.strategicLink,
      uc.impact,
      uc.complexity,
      tierLabel[uc.tier] || `Tier ${uc.tier}`
    ]),
    [28, 14, 22, 9, 12, 15]
  );

  const investmentTable = dataTable(
    ['Investment Area', 'Est. Investment', 'Est. Annual Value Capture', 'Payback'],
    data.aiVision.investmentTable.map(row => [
      row.area,
      [new TextRun({ text: row.investment, size: 22, font: 'Arial' }), assumption(row.valueBasis)],
      row.valueCapture,
      row.payback
    ]),
    [30, 18, 32, 20]
  );

  return [
    spacer(10),
    sectionHeader('Section 12 — AI Agentic Solutions Vision'),
    spacer(6),
    subsection('12.1 — AI Readiness Assessment'),
    body('Each dimension scored 1–5 based on confirmed research signals. Green = strong foundation (4–5), Amber = developing (3), Red = early stage (1–2).'),
    spacer(6),
    readinessTable,
    spacer(10),
    subsection('AI Readiness Radar'),
    chartImage(radarBuf, 420, 370),
    spacer(10),
    subsection('12.2 — AI Agentic Use Case Roadmap'),
    body('Use cases ranked by business impact and implementation readiness, mapped to confirmed strategic priorities. All value estimates are [ASSUMPTION — basis provided].'),
    spacer(4),
    useCaseTable,
    spacer(10),
    subsection('12.3 — AI Delivery Model for ' + data.company.name),
    body(data.aiVision.deliveryModel),
    spacer(4),
    body([
      new TextRun({ text: 'Platform Anchors: ', bold: true, size: 22, font: 'Arial', color: BLUE }),
      new TextRun({ text: data.aiVision.platformAnchors, size: 22, font: 'Arial' })
    ]),
    spacer(10),
    subsection('12.4 — AI Investment Framing'),
    spacer(4),
    investmentTable,
    spacer(8),
    body([
      new TextRun({ text: 'CFO Business Case: ', bold: true, size: 22, font: 'Arial', color: BLUE }),
      new TextRun({ text: data.aiVision.cfoNarrative, size: 22, font: 'Arial' })
    ])
  ];
}

// ============================================================
// SECTION 13 — IP & RESEARCH OPPORTUNITIES
// (built async — requires chart generation)
// ============================================================
async function buildSection13() {
  const ipChartBuf = await buildIPChart(data.ipResearch.ipLandscape);

  const ipTable = dataTable(
    ['IP Category', 'Current State', 'Strength', 'Gap / Opportunity'],
    data.ipResearch.ipLandscape.map(ip => [
      ip.category,
      ip.currentState,
      ip.strength,
      ip.gap
    ]),
    [18, 32, 12, 38]
  );

  const researchTable = dataTable(
    ['Research Area', 'Strategic Rationale', 'Potential Output', `${data.pursuer.firm} Role`, 'Timeline'],
    data.ipResearch.researchOpportunities.map(r => [
      r.area, r.rationale, r.output, r.firmRole, r.timeline
    ]),
    [20, 28, 20, 18, 14]
  );

  const coInnoTable = dataTable(
    ['Dimension', 'Structure'],
    [
      ['Funding Model',    data.ipResearch.coInnovation.fundingModel],
      ['Governance',       data.ipResearch.coInnovation.governance],
      ['IP Framework',     data.ipResearch.coInnovation.ipFramework],
      ['Milestone Plan',   data.ipResearch.coInnovation.milestones]
    ],
    [22, 78]
  );

  const pioneeringBetBlocks = [];
  data.ipResearch.pioneeringBets.forEach((bet, i) => {
    pioneeringBetBlocks.push(spacer(10));
    pioneeringBetBlocks.push(
      goldBox(bet.title, [
        `Thesis: ${bet.thesis}`,
        `The Innovation: ${bet.innovation}`,
        `Competitive Moat: ${bet.moat}`,
        `${data.pursuer.firm} Contribution: ${bet.firmContribution}`,
        `Risk to Watch: ${bet.risk}`
      ])
    );
  });

  return [
    spacer(10),
    sectionHeader('Section 13 — IP & Research Opportunities'),
    spacer(6),
    subsection('13.1 — IP Landscape Assessment'),
    body('Analysis of current IP posture across patents, proprietary data, and processes. Sourced where confirmed; all inferences flagged [ASSUMPTION].'),
    spacer(4),
    ipTable,
    spacer(8),
    subsection('IP Strength Snapshot'),
    chartImage(ipChartBuf, 460, 220),
    spacer(10),
    subsection('13.2 — Research & Innovation Opportunities'),
    spacer(4),
    researchTable,
    spacer(10),
    subsection('13.3 — Co-Innovation Model'),
    spacer(4),
    coInnoTable,
    spacer(8),
    body(data.ipResearch.coInnovation.modelNarrative),
    spacer(10),
    subsection('13.4 — Pioneering Bets: Where ' + data.company.name + ' Could Lead the Industry'),
    body(`The following represent ${data.pursuer.firm}'s highest-conviction bets on where ${data.company.name} has the unique combination of data, domain position, and strategic moment to define the next era in its industry.`),
    ...pioneeringBetBlocks
  ];
}

// ============================================================
// ASSEMBLE AND SAVE DOCUMENT (async — awaits chart generation)
// ============================================================
async function buildAndSaveDocument() {
  // Generate charts in parallel
  const [spendingChart, opportunityChart, section12Elements, section13Elements] = await Promise.all([
    buildSpendingChart(data.techLandscape.spending),
    buildOpportunityChart(data.opportunities),
    buildSection12(),
    buildSection13()
  ]);

  // Inject spending chart into section 5
  const section5WithChart = [
    ...section5,
    spacer(8),
    subsection('Spending Allocation Overview'),
    chartImage(spendingChart, 490, 300)
  ];

  // Inject opportunity chart into section 8
  const section8WithChart = [
    ...section8,
    spacer(8),
    subsection('Opportunity Timeline Overview'),
    chartImage(opportunityChart, 540, Math.max(240, data.opportunities.length * 44 + 80))
  ];

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
          ...section5WithChart,
          ...section6,
          ...section7,
          ...section8WithChart,
          ...section9,
          ...section10,
          ...section11,
          ...section12Elements,
          ...section13Elements,
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

  const buffer = await Packer.toBuffer(doc);
  fs.writeFileSync(outputFile, buffer);
  console.log(`\n✓ Report saved to: ${outputFile}\n`);
  console.log(`  ✓ Sections 1–11 (core intelligence)`);
  console.log(`  ✓ Section 12 — AI Agentic Solutions Vision (with Radar chart)`);
  console.log(`  ✓ Section 13 — IP & Research Opportunities (with IP Strength chart)`);
  console.log(`  ✓ Section 5 — Spending Allocation doughnut chart embedded`);
  console.log(`  ✓ Section 8 — Opportunity Timeline chart embedded\n`);
}

buildAndSaveDocument().catch(err => {
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

### AI Readiness Scores — How to Assign

Each dimension in `data.aiVision.readinessScores` takes a score of 1–5:
- **1** — No evidence of capability; pre-foundation stage
- **2** — Early experiments; no production AI deployment
- **3** — Isolated AI use cases in production; no enterprise-wide approach
- **4** — Multiple production AI deployments; enterprise data platform in place
- **5** — Advanced AI programs; agentic workflows live; AI governance mature

Scores trigger color coding in the scorecard: 4–5 = GREEN, 3 = AMBER, 1–2 = RED.

### Chart Rendering Issues

- If `ChartJSNodeCanvas` fails: ensure `canvas` and `chart.js` are installed alongside `chartjs-node-canvas`
- If chart images appear blurry: increase `width`/`height` parameters in `generateChart()` and decrease the `transformation` display size proportionally for retina-equivalent quality
- If chart text is clipped: increase the `height` parameter in the specific chart builder function
- If the spending doughnut has too many labels: filter `spendingData` to the top 5 categories by value before building the chart

### Pioneering Bets — Gold Box Formatting

The `goldBox()` helper uses a warm gold fill (`FFF8DC`) with a dark gold border (`B8860B`). If more than 2 bets are defined, they render as stacked gold boxes separated by spacers. Limit to 3 bets maximum — more reduces impact. Each bet title is prefixed with a ★ symbol automatically.
