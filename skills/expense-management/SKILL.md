---
name: expense-management
description: "Use this skill when an employee, manager, AP specialist, or finance operations team member needs to submit, review, approve, or reimburse business expenses. Covers the full expense lifecycle: policy enforcement, expense report submission, receipt verification, multi-level approval, reimbursement processing, credit card reconciliation, out-of-policy escalation, and monthly expense analytics. Trigger when an employee wants to claim a business expense, when a manager needs to approve expense reports, when AP needs to process reimbursements, or when Finance needs an expense analytics report."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [expenses, reimbursements, T&E, travel-expenses, expense-policy, expense-report, corporate-card, out-of-pocket, finance-ops, AP, employee-reimbursement]
---

# Expense Management — Employee Expenses & Reimbursements

You run the full expense management lifecycle: policy enforcement at submission, receipt validation, approval routing, reimbursement processing, corporate card reconciliation, and expense analytics. Every expense claim is processed fairly, quickly, and in compliance with company policy.

**Mission**: Employees reimbursed within 5 business days of approval. Zero out-of-policy payments without exception approval.

---

## Phase 1 — Expense Policy Reference

### 1.1 Category Limits

| Category | Per Occurrence Limit | Receipt Required | Pre-Approval Required |
|---|---|---|---|
| Meals — individual | $50 | > $25 | No |
| Meals — client entertainment | No hard limit | Always | > $200 per person |
| Ground transportation (taxi/rideshare) | $75 | > $25 | No |
| Mileage (personal car) | IRS/HMRC rate | Yes (logged) | No |
| Parking | $30/day | Yes | No |
| Domestic flight | Economy class | Always | Always |
| International flight | Economy (< 6 hrs) / Business (≥ 6 hrs) | Always | VP or above |
| Hotel — domestic | $250/night | Always | > $300/night |
| Hotel — international | $350/night | Always | > $400/night |
| Home office equipment | $500 one-time | Always | Manager + IT |
| Software / subscriptions | $50/month | Always | IT + Finance |
| Conference / training | $2,000/event | Always | Manager |
| Gifts to clients | $75/recipient | Always | Manager |
| Gifts to employees | $50/recipient | Always | HR |
| Team events / offsites | Budget varies | Always | Pre-approved budget |

**Non-reimbursable items (never pay):**
- Alcohol (unless pre-approved client entertainment)
- Personal items, toiletries (beyond travel basics)
- Fines, parking tickets, traffic violations
- First-class upgrades (unless medical need documented)
- Spouse/family travel
- Hotel minibar
- In-flight entertainment / WiFi (unless critical work need)
- Gym, spa, personal entertainment
- Expenses for which no receipt exists and amount > $25

### 1.2 Submission Deadlines

- Expenses must be submitted within 30 days of the expense date
- Expenses > 90 days old will not be reimbursed without CFO approval
- Monthly corporate card statements must be reconciled within 10 days of statement close
- Annual T&E budget submission: by end of Q4 for following year

---

## Phase 2 — Expense Report Submission

### 2.1 Expense Report Form

```yaml
expense_report:
  report_id: ""                # format: EXP-[YYYY]-[EMPLOYEE_ID]-[NNN]
  employee_name: ""
  employee_id: ""
  department: ""
  cost_center: ""
  manager: ""
  submission_date: ""
  business_purpose: ""         # clear statement — e.g. "Sales trip to NYC — client meeting at Acme Corp"

  expenses:
    - expense_id: 1
      date: ""
      category: meals | travel | accommodation | transport | equipment | software | other
      subcategory: ""          # e.g. "client entertainment", "taxi", "domestic flight"
      merchant: ""
      description: ""          # what was bought and the business purpose
      attendees: []            # required for meals/entertainment
      amount: "$0"
      currency: ""
      exchange_rate: 1.0       # if foreign currency
      amount_usd: "$0"
      receipt_attached: false
      payment_method: corporate_card | personal_card | cash
      card_last_4: ""          # if corporate card
      policy_compliant: true
      policy_exception_reason: ""  # if non-compliant; requires approver acknowledgment

  total_amount: "$0"
  total_reimbursable: "$0"    # may differ if some items on corporate card
  total_corporate_card: "$0"  # amounts charged to company card (reconciliation only, not reimbursed)
```

### 2.2 Receipt Requirements

**Valid receipts must show:**
- Merchant name
- Date of transaction
- Itemized list (for meals: full itemization, not just total)
- Amount (including tax and tip)
- Payment confirmation (credit card receipt or "PAID" stamp)

**Receipt exceptions:**
- Mileage: use mileage log (date, destination, business purpose, distance) — no receipt
- Tolls < $5: self-certification acceptable
- Ground transport < $25: no receipt required (but document in description)
- Tips left in cash: note on restaurant receipt

---

## Phase 3 — Approval Workflow

### 3.1 Approval Routing

```
Employee submits expense report
  ↓
System checks policy compliance (auto-flags violations)
  ↓
Direct manager reviews:
  • Validates business purpose
  • Confirms they authorized the travel/activity
  • Acknowledges any policy exceptions
  ↓
If total report > $2,000 OR any single item > $500 → additional approver:
  VP of department reviews
  ↓
If total report > $5,000 OR international travel:
  Finance team reviews
  ↓
Finance approves for payment
  ↓
Reimbursement processed in next payment batch
```

### 3.2 Approval SLAs

| Approver | SLA |
|---|---|
| Direct manager | 2 business days |
| VP review | 2 business days |
| Finance review | 1 business day |
| Total cycle | ≤ 5 business days from submission |

If approver doesn't act within SLA → auto-escalate to their manager + Finance.

### 3.3 Policy Exception Handling

For any out-of-policy items:
1. Employee must provide written justification at submission
2. Manager explicitly acknowledges the exception during approval (cannot silently approve)
3. Finance logs the exception with reason
4. Repeat policy violations (3+ in a quarter) → HR conversation
5. CFO reviews exceptions > $500 monthly

---

## Phase 4 — Reimbursement Processing

### 4.1 Reimbursement Schedule

| Payment Method | Frequency | Processing Day |
|---|---|---|
| ACH direct deposit | Semi-monthly | 15th and last business day |
| Payroll-included | Semi-monthly | With regular payroll |
| International wire | Monthly | Last business day |

All approved expense reports submitted by Day 10 → processed in 15th cycle.
All approved expense reports submitted by Day 25 → processed in last-day cycle.

### 4.2 Reimbursement Statement to Employee

```
EXPENSE REIMBURSEMENT NOTICE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Employee:         [Name]
Report ID:        EXP-[YYYY]-[ID]-[NNN]
Approved by:      [Manager Name] on [Date]
Payment Date:     [Date]
Payment Method:   Direct Deposit to [Bank] ****[last 4]

REIMBURSEMENT BREAKDOWN:
  Meals:                    $[X]
  Transportation:           $[X]
  Accommodation:            $[X]
  Other:                    $[X]
  ────────────────────────────────
  TOTAL REIMBURSED:         $[X]

ITEMS NOT REIMBURSED:
  [Item description]:       $[X]   Reason: [Policy reference]

Questions? Contact: expenses@[company].com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 5 — Corporate Card Management

### 5.1 Corporate Card Assignment

Cards are issued to employees who:
- Travel frequently (> 2 trips/quarter), OR
- Have regular recurring business expenses, OR
- Are VP-level and above

Card limits:
- Individual contributor: $2,500/month
- Manager: $5,000/month
- Director: $10,000/month
- VP+: $25,000/month (or per Finance approval)

### 5.2 Monthly Card Reconciliation

Every cardholder must reconcile their statement monthly:

```
For each charge on the corporate card:
  1. Code to the correct expense category and GL account
  2. Enter the business purpose
  3. Attach the receipt
  4. Flag any personal charges (must be repaid immediately)
  5. Submit reconciliation to Finance by Day 10 of following month
```

**Personal charges on corporate card:**
- Must be self-identified and flagged immediately
- Employee must repay within 5 business days
- Repeated personal charges → card revoked

### 5.3 Card Misuse Policy

Grounds for immediate card revocation:
- Undisclosed personal charges
- Exceeding card limit without prior authorization
- Cash advances
- Splitting charges to avoid approval limits
- Charges for non-business purposes

---

## Phase 6 — Expense Analytics

### 6.1 Monthly Expense Report

```
EXPENSE ANALYTICS — [Month Year]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SUMMARY
  Total expense reports submitted:    [N]
  Total amount submitted:             $[X]
  Total reimbursed:                   $[X]
  Total rejected / returned:          $[X]   ([N] reports)
  Policy exception rate:              [%]    (target: < 5%)

BY CATEGORY
  Travel (flights + hotels):          $[X]   ([%] of total)
  Meals & Entertainment:              $[X]   ([%] of total)
  Transportation (local):             $[X]   ([%] of total)
  Equipment & Tools:                  $[X]   ([%] of total)
  Other:                              $[X]   ([%] of total)

BY DEPARTMENT
  Engineering:                        $[X]
  Sales:                              $[X]   (highest — review if aligned with activity)
  Marketing:                          $[X]
  G&A:                                $[X]

EFFICIENCY
  Avg. days from submission to payment:  [N] days  (target: ≤ 5)
  Reports > 30 days old at submission:   [N]        (employee education needed)
  Missing receipts:                      [N]        (policy enforcement needed)

TOP 5 CATEGORIES OVER BUDGET
  [Category]: budget $[X] / actual $[X] / variance $[X]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Quality Rules

- No expense is reimbursed without a valid receipt (for amounts > $25) and business purpose.
- Meals with > 2 attendees require names and companies of all attendees in the expense description.
- Expenses > 90 days old are automatically rejected unless CFO approves an exception in writing.
- Corporate card reconciliations submitted more than 15 days after statement close → card temporarily suspended until reconciled.
- Any expense submitted by a VP or above requires Finance team review regardless of amount.
- The approver is responsible for validating that the expense occurred for a legitimate business purpose — approving without review is a controls failure.
