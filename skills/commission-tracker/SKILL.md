---
name: commission-tracker
description: "Use this skill when a Revenue Operations manager, Sales Compensation analyst, Finance team member, or Sales leader needs to calculate, track, dispute, and pay out sales commissions and incentive compensation. Covers commission plan design, attainment calculation, accelerators, SPIFFs, clawbacks, dispute resolution, and payout processing. Trigger when running the monthly or quarterly commission calculation, when a sales rep raises a commission dispute, when designing or changing a commission plan, when producing attainment reports for sales leadership, or when reconciling commission accruals for finance close."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [commissions, sales-compensation, incentive-compensation, ICM, attainment, quota, accelerators, SPIFFs, clawback, OTE, sales-ops, revenue-ops, finance]
---

# Commission Tracker — Sales Commission Calculation & Payout Engine

You are the commission calculation and payout engine. You take closed deals from CRM, apply the commission plan rules, calculate each rep's earned commissions, process disputes, and produce payment files for payroll. Every rep knows exactly what they earned and why.

**Mission**: Accurate commissions published within 5 business days of period close. Zero disputes unresolved > 10 business days.

---

## Phase 1 — Commission Plan Architecture

### 1.1 Standard Commission Plan Document

```yaml
commission_plan:
  plan_id: ""
  plan_name: ""                # e.g. "AE Commission Plan FY2025 H1"
  plan_year: ""
  effective_dates:
    start: ""
    end: ""
  eligible_roles: [AE, SDR, SE, CSM, Partner Manager, Channel AE]
  approved_by: ""              # CRO + CFO signatures required

  compensation_structure:
    ote: "$0"                  # On-Target Earnings (base + target variable)
    base_salary: "$0"
    target_variable: "$0"      # total commission if 100% quota attained
    variable_pct_of_ote: "%"   # typically 30–50% for AEs

  quota:
    annual_quota: "$0"
    quarterly_quota: "$0"      # typically annual / 4 with seasonal weighting
    measurement: ARR | TCV | revenue | units
    quota_currency: ""

  commission_rates:
    # Rate table — applied based on attainment band
    - attainment_band: "0–50%"
      rate_on_quota_attained: "0%"   # below threshold, no commission
    - attainment_band: "50–75%"
      rate_on_quota_attained: "50%"  # below target, below plan rate
    - attainment_band: "75–100%"
      rate_on_quota_attained: "100%" # at plan rate
    - attainment_band: "100–125%"
      rate_on_quota_attained: "150%" # first accelerator
    - attainment_band: "> 125%"
      rate_on_quota_attained: "200%" # super-accelerator

  plan_rate: "$0 per $ of ARR"   # or % of deal value; the base commission rate at 100%

  product_multipliers:
    # Commission rates may vary by product
    - product: "Core Platform"
      multiplier: 1.0x
    - product: "Add-on Module A"
      multiplier: 0.5x
    - product: "Professional Services"
      multiplier: 0.25x
    - product: "Strategic / New Logo"
      multiplier: 1.25x

  spiff_eligibility: true
  clawback_period_months: 6      # commission returned if customer churns within this window
```

### 1.2 Plan Variants by Role

| Role | OTE Split (Base/Variable) | Quota Type | Commission Basis |
|---|---|---|---|
| Account Executive | 50/50 | New ARR | Closed-won deals |
| SDR / BDR | 70/30 | Meetings / Pipeline created | Qualified meetings + SQL conversion |
| Sales Engineer | 80/20 | Team quota | % of AE commission earned in territory |
| Customer Success Manager | 75/25 | NRR / GRR | Net Revenue Retention + expansion ARR |
| Partner / Channel Manager | 65/35 | Partner-sourced ARR | Partner-sourced deal ARR |
| Sales Manager | 60/40 | Team quota | Multiplier on team attainment |

---

## Phase 2 — Commission Calculation Engine

### 2.1 Deal-Level Commission Calculation

For each closed-won deal in the period:

```
DEAL COMMISSION CALCULATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Deal: [Deal Name] | CRM ID: [XXXXXXX]
Close Date: [Date] | Customer: [Customer Name]
Commission-Eligible Amount: $[X]
  (Total contract value: $[X] less non-commissionable: $[X])
AE: [Name] | Commission Plan: [Plan ID]

DEAL BREAKDOWN
  New ARR component:       $[X] × Plan rate [Y]% × Product multiplier [Z]x = $[X]
  Services component:      $[X] × Plan rate [P]% × Services multiplier [Q]x = $[X]
  Renewal/expansion:       $[X] × Renewal rate [R]%                          = $[X]
  ─────────────────────────────────────────────────────────────────────────────
  Total deal commission:   $[X]

SPLIT (if applicable)
  Primary AE [Name]:       [%] → $[X]
  Supporting AE [Name]:    [%] → $[X]   (overlay, co-sell, or BDR assist)
  Manager override [Name]: [%] → $[X]   (if manager commission applies)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 2.2 Monthly Commission Statement (Per Rep)

```
COMMISSION STATEMENT — [Rep Name] — [Month/Quarter]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
QUOTA ATTAINMENT
  Period Quota:              $[X]
  Closed (commission-eligible ARR/TCV): $[X]
  Attainment:                [%]         Attainment Band: [band name]
  Accelerator applied:       [Y/N]       Accelerator rate: [X%]

DEALS INCLUDED
  [Deal 1 — Customer Name]:  $[X] ARR → commission: $[X]
  [Deal 2 — Customer Name]:  $[X] ARR → commission: $[X]
  [Deal 3 — Customer Name]:  $[X] ARR → commission: $[X]
  ─────────────────────────────────────────────────────────────
  Total deals closed:        $[X]

COMMISSION EARNED THIS PERIOD
  Base commission (pre-accelerator): $[X]
  Accelerator add-on:                $[X]
  SPIFFs earned:                     $[X]    [SPIFF name: $X]
  ─────────────────────────────────────────────────────────────
  Gross commission earned:           $[X]

ADJUSTMENTS
  Clawbacks (churned deals):        ($[X])   [Deal name: $X]
  Prior period corrections:         ($[X])   [Description]
  ─────────────────────────────────────────────────────────────
  Net commission payable:            $[X]

YEAR-TO-DATE SUMMARY
  YTD quota:                 $[X]   YTD attainment: [%]
  YTD commission earned:     $[X]   YTD commission paid: $[X]
  YTD SPIFFs:                $[X]

PAYMENT
  Payment date:              [Date]
  Payment method:            Included in payroll / separate payment
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 3 — Accelerators & SPIFFs

### 3.1 Accelerator Design

Accelerators reward overperformance — commissions increase as reps exceed quota:

```
STANDARD ACCELERATOR STRUCTURE

  Attainment    | Commission Rate | Effective Rate on $ earned above threshold
  ──────────────|─────────────────|──────────────────────────────────────────
  0–49%         | 0%              | No commission below threshold (threshold plan)
  50–74%        | 50% of plan     | Ramp-in below target
  75–99%        | 100% of plan    | Standard plan rate
  100–124%      | 150% of plan    | First accelerator: 1.5x for overperformance
  125–149%      | 200% of plan    | Super accelerator: 2x
  ≥ 150%        | 250% of plan    | Presidents Club accelerator: 2.5x

Example: Plan rate = 10% of new ARR
  Rep closes $1M against $800K quota (125% attainment)
  $0–$400K (0–50%):   0% → $0
  $400K–$600K (50–75%): 5% → $10,000
  $600K–$800K (75–100%): 10% → $20,000
  $800K–$1M (100–125%): 15% → $30,000
  Total commission: $60,000
```

### 3.2 SPIFF Management

SPIFFs (Sales Performance Incentive Fund Features) are short-term bonuses for specific behaviors:

```yaml
spiff:
  spiff_id: ""
  name: ""                     # e.g. "Q3 New Logo Blitz"
  eligible_roles: []
  start_date: ""
  end_date: ""
  target_behavior: ""          # what must the rep do to earn it
  reward:
    type: cash | gift_card | trip | merchandise
    amount: "$0"               # per qualifying action or total pool
  budget_total: "$0"           # total maximum company exposure
  approval: ""                 # CRO + Finance must approve all SPIFFs
  conditions: []               # any restrictions or qualifications
  reporting_frequency: ""      # how often leaderboard is updated
```

---

## Phase 4 — Clawbacks

### 4.1 Clawback Policy

If a customer cancels within the clawback period (typically 6 months), commission is partially recovered:

```
CLAWBACK CALCULATION
  Original deal ARR:          $[X]
  Commission paid:            $[X]
  Customer cancellation date: [Date]
  Months from close to cancel: [N]
  Clawback period:            [6] months

  If cancelled within clawback period:
    Pro-rated recovery = commission × (clawback_months_remaining / total_clawback_months)
    Example: cancelled month 3 of 6 → recover 50% of commission

  Clawback amount:            $[X]

  How clawback is collected:
    - Deducted from next commission payout (preferred)
    - If rep no longer employed: demand letter + payroll deduction agreement
    - Cannot exceed [100%] of one month's base salary per period deducted
```

---

## Phase 5 — Dispute Resolution

### 5.1 Commission Dispute Process

```
Rep submits dispute via commission dispute form (within 30 days of statement):
  - Which deal(s) are in dispute
  - What the rep believes was earned
  - What was actually paid
  - Supporting evidence (CRM screenshot, signed contract, email)

Step 1: Sales Comp analyst reviews within 3 business days
  → If clear calculation error: correct immediately, reprocess
  → If requires investigation: advance to Step 2

Step 2: Sales Comp + CRO + Finance joint review within 5 business days
  → Review CRM data, contract, commission plan
  → Document decision with rationale

Step 3: Decision communicated to rep with full explanation
  → Approved adjustments processed in next payout cycle
  → Denied disputes documented with appeal path

Step 4 (Appeal): Disputed to CRO + CFO
  → Final decision within 5 business days — no further appeal
  → All decisions documented in commission system
```

### 5.2 Dispute Tracker

```
OPEN COMMISSION DISPUTES — [As of Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Rep      | Deal      | Amount in Dispute | Submitted  | Status
─────────|───────────|──────────────────|────────────|────────
[Name]   | [Deal]    | $[X]             | [Date]     | Under review
[Name]   | [Deal]    | $[X]             | [Date]     | Resolved: approved $[X]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 6 — Commission Accrual (Finance)

### 6.1 Monthly Commission Accrual

Finance must accrue commission expense each month, even if payout is quarterly:

```
COMMISSION ACCRUAL — [Month]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Revenue closed this month:          $[X]
Effective commission rate (blended): [%]

Commission earned this month:        $[X]
  Attributable to: Sales team
  GL Account: 6100 — Sales Commissions Expense

Commission paid this month:          $[X]
  (from prior period accrual)

Accrued commission liability balance: $[X]
  Dr Sales Commissions Expense: $[X]
  Cr Accrued Commission Liability: $[X]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 7 — Team Attainment Dashboard

```
SALES TEAM ATTAINMENT — [Month/Quarter]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Rep Name          | Quota    | Closed   | Attainment | Commission Earned
──────────────────|──────────|──────────|────────────|──────────────────
[Rep 1]           | $[X]     | $[X]     | [%]        | $[X]
[Rep 2]           | $[X]     | $[X]     | [%]        | $[X]
[Rep 3]           | $[X]     | $[X]     | [%]        | $[X]
──────────────────|──────────|──────────|────────────|──────────────────
TEAM TOTAL        | $[X]     | $[X]     | [%]        | $[X]

Reps at ≥ 100%:  [N] / [total]   ([%] of team)
Reps at 75–99%:  [N] / [total]
Reps at < 75%:   [N] / [total]   (review coaching plan)

Projected full-period commission expense:  $[X]
Commission expense as % of revenue:        [%]  (target: [%])
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Quality Rules

- Commission statements must be published within 5 business days of period close.
- All commission plan changes require CRO + CFO sign-off and 30-day notice to sales team.
- Disputes must be acknowledged within 24 hours and resolved within 10 business days.
- Clawbacks deducted from a single pay period cannot exceed one month's base salary.
- Commission calculations must tie exactly to CRM closed-won data — no manual overrides without documentation.
- Commission accruals are booked monthly regardless of payout frequency.
- All SPIFFs must have a defined budget and CRO + Finance approval before launch.
