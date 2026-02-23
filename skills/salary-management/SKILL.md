---
name: salary-management
description: "Use this skill when a Payroll Specialist, HR Operations team member, or Finance team member needs to run a payroll cycle, process a salary change, generate payslips, calculate pro-rated pay, handle final settlements for departing employees, manage advance salary requests, or produce payroll registers for Finance close. This skill is the operational execution engine under the payroll-compensation skill. Trigger when running a payroll batch, onboarding a new hire with their first paycheck, processing a salary increment, handling a termination payout, generating payslips, or reconciling the payroll register to the GL."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [payroll, salary, payslip, pay-run, payroll-register, pro-rata, final-settlement, full-and-final, salary-revision, payroll-reconciliation, HR-ops, people-ops, finance]
---

# Salary Management — Payroll Run & Employee Pay Operations

You execute payroll: run pay cycles, generate payslips, calculate pro-rated pay, handle final settlements, process salary revisions, and reconcile the payroll register to the general ledger. Every employee gets paid exactly what they are owed, on time, with a clear payslip.

**Mission**: Accurate payroll run completed and submitted 3 days before pay date. Every payslip in employee hands within 24 hours of processing.

---

## Phase 1 — Payroll Run Checklist

### 1.1 Pre-Run Validation (Run 5 Business Days Before Pay Date)

```
PRE-PAYROLL VALIDATION CHECKLIST — [Pay Period: DD Mon to DD Mon YYYY]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NEW HIRES (to be added this cycle):
  [ ] [Employee name] — Start date: [Date] — Salary: $[X] — Pro-rated days: [N]
  [ ] Banking details confirmed: ✓ / ✗
  [ ] Tax documents received (W-4/W-8/Form 12BB): ✓ / ✗

TERMINATIONS (final settlement this cycle):
  [ ] [Employee name] — Last day: [Date] — Settlement calculation: $[X]
  [ ] Accrued PTO payout: [N] days × $[X]/day = $[X]
  [ ] Final pay and separation docs delivered: ✓ / ✗

SALARY CHANGES (effective this cycle):
  [ ] [Employee name]: $[X] → $[X] effective [Date] — Approved: ✓ / ✗

DEDUCTION CHANGES:
  [ ] New 401k/PF enrollment: [N] employees
  [ ] Benefits changes (open enrollment / life event): [N] employees
  [ ] Garnishment orders new/modified: [N]

VARIABLE PAY THIS CYCLE:
  [ ] Bonus approved by Finance + CRO: $[X] to [N] employees
  [ ] Commission payout approved: $[X] to [N] employees
  [ ] Spot awards: $[X] to [N] employees

VALIDATION CHECKS (automated):
  [ ] No employee with $0 or negative net pay
  [ ] No employee missing bank account details
  [ ] Gross payroll variance vs. prior period: [%] — acceptable range: ±10%
  [ ] Variance explained: [list reasons — new hires, terminations, salary changes, bonuses]

APPROVALS REQUIRED:
  [ ] VP Payroll reviewed and signed off: ✓
  [ ] CFO approved (or Controller if delegated): ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 2 — Payslip Generation

### 2.1 Payslip Format (US Employee)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                               PAY STUB
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EMPLOYER                                EMPLOYEE
[Company Legal Name]                    [Employee Full Name]
[Company Address]                       Employee ID:    [XXXXXX]
EIN: [XX-XXXXXXX]                       Department:     [Department]
                                        Pay Period:     [DD Mon] – [DD Mon YYYY]
                                        Pay Date:       [DD Mon YYYY]
                                        Pay Type:       [Salary / Hourly]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EARNINGS                         This Period          Year to Date
──────────────────────────────── ────────────         ────────────
Base Salary                      $[X,XXX.XX]          $[XX,XXX.XX]
Overtime                         $[XXX.XX]            $[X,XXX.XX]
Bonus                            $[X,XXX.XX]          $[X,XXX.XX]
Commission                       $[X,XXX.XX]          $[X,XXX.XX]
Other Earnings                   $[XXX.XX]            $[X,XXX.XX]
──────────────────────────────── ────────────         ────────────
GROSS EARNINGS                   $[X,XXX.XX]          $[XX,XXX.XX]

DEDUCTIONS                       This Period          Year to Date
──────────────────────────────── ────────────         ────────────
Federal Income Tax               ($[XXX.XX])          ($[X,XXX.XX])
State Income Tax — [State]       ($[XXX.XX])          ($[X,XXX.XX])
Social Security (6.2%)           ($[XXX.XX])          ($[X,XXX.XX])
Medicare (1.45%)                 ($[XXX.XX])          ($[XXX.XX])
Health Insurance Premium         ($[XXX.XX])          ($[X,XXX.XX])
401(k) Contribution ([%]%)       ($[XXX.XX])          ($[X,XXX.XX])
Dental Insurance                 ($[XX.XX])           ($[XXX.XX])
Vision Insurance                 ($[XX.XX])           ($[XXX.XX])
Other Deductions                 ($[XXX.XX])          ($[X,XXX.XX])
──────────────────────────────── ────────────         ────────────
TOTAL DEDUCTIONS                 ($[X,XXX.XX])        ($[XX,XXX.XX])

                                  ─────────────────────────────────
NET PAY                          $[X,XXX.XX]          $[XX,XXX.XX]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EMPLOYER CONTRIBUTIONS (company cost, not deducted from your pay)
  Social Security (6.2%):        $[XXX.XX]
  Medicare (1.45%):              $[XXX.XX]
  Employer 401(k) Match:         $[XXX.XX]
  Employer Health Premium:       $[XXX.XX]
  ────────────────────────────────────────
  Total Cost to Company:         $[X,XXX.XX]  | Annual CTC: $[XX,XXX.XX]

PAYMENT METHOD
  Direct Deposit to [Bank Name] ****[last 4]
  Expected in account by: [Date]

TAX SUMMARY (YTD)
  Federal taxable wages:  $[XX,XXX]  |  Federal tax withheld:  $[X,XXX]
  SS wages:               $[XX,XXX]  |  SS withheld:           $[X,XXX]
  Medicare wages:         $[XX,XXX]  |  Medicare withheld:     $[XXX]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Questions: payroll@[company].com | HR portal: [URL]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 2.2 Payslip Format (India Employee — Salary Slip)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                          SALARY SLIP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Company:  [Company Name]          Month: [Month YYYY]
Address:  [Registered Address]    Pay Date: [DD/MM/YYYY]

EMPLOYEE DETAILS
  Name:           [Full Name]     Employee ID:  [XXXXXX]
  Designation:    [Job Title]     Department:   [Department]
  Date of Joining: [DD/MM/YYYY]   PAN:          [XXXXXXXXXX]
  UAN:            [XXXXXXXXXX]    Bank:         [Bank] ****[last 4]
  Location:       [City]          Work Days:    [N] / [N]

EARNINGS                          (₹)     DEDUCTIONS                    (₹)
──────────────────────────────  ──────    ──────────────────────────  ──────
Basic Salary                    [X,XXX]   Provident Fund (Employee)   [X,XXX]
House Rent Allowance (HRA)      [X,XXX]   ESI (Employee 0.75%)        [XXX]
Leave Travel Allowance (LTA)    [X,XXX]   Professional Tax            [XXX]
Special Allowance               [X,XXX]   TDS (Income Tax)            [X,XXX]
Medical Allowance               [XXX]     Salary Advance Recovery     [XXX]
Performance Bonus               [X,XXX]   Other Deductions            [XXX]
Other Allowances                [XXX]
──────────────────────────────  ──────    ──────────────────────────  ──────
GROSS EARNINGS                  [XX,XXX]  TOTAL DEDUCTIONS            [X,XXX]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NET SALARY (IN HAND): ₹ [XX,XXX]

Amount in words: [Indian Rupees XXXXX Only]

EMPLOYER CONTRIBUTIONS
  PF — Employer (12% of basic):   ₹[X,XXX]
  ESI — Employer (3.25%):         ₹[XXX]
  Gratuity Provision:             ₹[XXX]

ANNUAL CTC: ₹ [X,XX,XXX]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
This is a system-generated payslip and does not require a signature.
Payroll queries: hr@[company].com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 3 — Pro-Rated Pay Calculations

### 3.1 New Hire Pro-Ration

```
NEW HIRE PRO-RATED PAY
  Employee: [Name]
  Start Date: [Date]
  Annual Salary: $[X]
  Monthly Salary: $[X] / 12 = $[X]

  For semi-monthly payroll:
    Pay period: [Start – End]
    Calendar days in period: [N]
    Working days in period: [N]
    Working days employee was active: [N]
    Pro-rated gross = Monthly salary × (Active working days / Total working days)
    Pro-rated gross: $[X]

  For bi-weekly payroll:
    Annual salary / 26 pay periods = regular pay = $[X]
    Days in pay period: 14
    Days employee was active: [N]
    Pro-rated gross = Regular pay × (Active days / 14) = $[X]
```

### 3.2 Salary Revision Mid-Period

```
MID-PERIOD SALARY CHANGE
  Employee: [Name]
  Change Effective Date: [Date] (mid-period)
  Old Annual Salary: $[X]   → Old Daily Rate: $[X]
  New Annual Salary: $[X]   → New Daily Rate: $[X]

  Days at old salary: [N]   → Earnings: $[X]
  Days at new salary: [N]   → Earnings: $[X]
  ──────────────────────────────────────────
  Total gross earnings this period: $[X]
```

---

## Phase 4 — Final Settlement (Full & Final)

### 4.1 Final Settlement Calculation

For employees leaving the company:

```
FULL & FINAL SETTLEMENT — [Employee Name]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Last Working Day: [Date]
Notice Period:    [N] days  |  Notice served: [N] days
Notice buyout:    [N days shortfall × daily rate = $[X]]   (deducted if short)
                  [N days excess × daily rate = $[X]]       (paid if over-served)

EARNINGS PAYABLE
  Salary for period [start] to [last day]:   $[X]
  Pro-rated salary for partial month:         $[X]
  Unused PTO payout: [N] days × $[X]/day:   $[X]   (per policy)
  Annual bonus pro-rated: [months/12 × target]: $[X] (if applicable per plan)
  Gratuity (India — if > 5 yrs service):     ₹[X]  = 15/26 × last basic × years served
  Leave encashment (India — EL balance):      ₹[X]
  Any approved pending reimbursements:        $[X]
  ─────────────────────────────────────────────────────────────
  Total Earnings Payable:                    $[X]

DEDUCTIONS
  Notice period shortfall:                  ($[X])
  Outstanding salary advance:               ($[X])
  Corporate card balance:                   ($[X])
  Equipment not returned:                   ($[X])  (at depreciated value)
  Commission clawback (if applicable):      ($[X])
  Any other dues:                           ($[X])
  ─────────────────────────────────────────────────────────────
  Total Deductions:                         ($[X])

NET SETTLEMENT AMOUNT:                       $[X]
Payment within: [30–45] days of last working day (per local labor law)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 4.2 Exit Compliance Checklist

```
Pre-final settlement — confirm:
  [ ] IT equipment returned and documented
  [ ] Access revoked (all systems, email, VPN, cloud)
  [ ] Corporate card surrendered and balance cleared
  [ ] Ongoing project handover confirmed with manager
  [ ] COBRA notification sent (US — within 14 days of coverage end)
  [ ] Reference letter request noted
  [ ] Non-compete/NDA acknowledgment obtained
  [ ] Exit interview completed
  [ ] Form 16 issued by June 15 (India)
  [ ] Final payslip issued with settlement breakdown
```

---

## Phase 5 — Payroll Register & GL Reconciliation

### 5.1 Payroll Register Summary

```
PAYROLL REGISTER — [Pay Period] — [Pay Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Emp ID | Name        | Dept  | Gross    | Total Deduct | Net Pay  | Method
───────|─────────────|───────|──────────|──────────────|──────────|───────
[ID]   | [Name]      | [Dept]| $[X,XXX] | ($[XXX])     | $[X,XXX] | DD
[ID]   | [Name]      | [Dept]| $[X,XXX] | ($[XXX])     | $[X,XXX] | DD
───────|─────────────|───────|──────────|──────────────|──────────|───────
TOTAL  |             |       | $[XX,XXX]| ($[X,XXX])   | $[XX,XXX]|

EMPLOYER TAX SUMMARY
  Social Security (employer):  $[X,XXX]
  Medicare (employer):         $[XXX]
  FUTA:                        $[XXX]
  SUTA:                        $[XXX]
  ─────────────────────────────────────
  Total employer tax:          $[X,XXX]

TOTAL CASH OUTFLOW THIS PAYROLL:  $[XX,XXX]
  (Net pay + all employee tax deposits)

GL JOURNAL ENTRY:
  Dr Salaries & Wages Expense (6000):         $[XX,XXX]  [gross payroll]
  Dr Payroll Tax Expense — Employer (6050):   $[X,XXX]   [employer taxes]
  Dr Benefits Expense (6060):                 $[X,XXX]   [employer benefits]
    Cr Cash — Payroll Account:               ($[XX,XXX]) [net pay]
    Cr Federal Tax Payable (2300):           ($[X,XXX])  [federal withholding + FICA]
    Cr State Tax Payable (2310):             ($[XXX])
    Cr Benefits Payable (2320):              ($[XXX])
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Quality Rules

- Payroll must be submitted to the payment processor at least 3 business days before pay date.
- Any payroll run variance vs. prior period > 10% must be explained before submission.
- Final settlements must comply with local labor law timelines (US: final check by last day in most states; India: 30–45 days from last working day).
- Salary data is strictly confidential — access limited to HR, Payroll team, and executive leadership.
- Payslips are personal and private — never share one employee's payslip with another person.
- Salary advances require written request, manager approval, and Finance sign-off; maximum one month's net salary.
- Every payroll run must be approved by the VP Payroll before submission — no exceptions.
