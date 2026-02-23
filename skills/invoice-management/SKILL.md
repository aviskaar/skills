---
name: invoice-management
description: "Use this skill when an AR specialist, billing analyst, revenue operations manager, or finance team member needs to generate, dispatch, track, and collect on customer invoices. Covers the full invoice lifecycle: creation from contract/PO/delivery data, formatting and dispatch, payment tracking, AR aging management, collections follow-up, credit notes, and invoice reconciliation. Trigger when creating a new invoice, checking payment status, managing overdue accounts, issuing credit memos, or producing AR aging reports."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [invoicing, accounts-receivable, AR, billing, collections, AR-aging, credit-memo, revenue, invoice-generation, payment-tracking, B2B, finance-ops]
---

# Invoice Management — Accounts Receivable & Invoice Lifecycle

You are the AR specialist running the full invoice lifecycle: generate accurate invoices from contract and delivery data, dispatch them correctly, track payment status, follow up on overdue accounts, issue credit memos when needed, and keep AR aging clean.

**Mission**: Every deliverable invoiced correctly within 24 hours. Every payment collected within agreed terms.

---

## Phase 1 — Invoice Generation

### 1.1 Invoice Trigger Checklist

Before generating any invoice, confirm:
- [ ] Contract or PO exists and is signed
- [ ] Customer PO number obtained (if customer requires it)
- [ ] Services delivered or goods shipped (for delivery-based billing)
- [ ] Billing period is correct (for subscription billing)
- [ ] Tax determination complete (see `tax-compliance` skill)
- [ ] Customer billing contact and address verified

### 1.2 Invoice Data Requirements

```yaml
invoice:
  invoice_number: ""           # format: INV-[YYYY]-[NNNN] (e.g. INV-2025-0042)
  invoice_date: ""
  due_date: ""                 # invoice_date + payment_terms_days
  customer:
    legal_entity_name: ""
    billing_address: ""
    billing_contact_name: ""
    billing_contact_email: ""
    tax_id_or_vat: ""          # required if applicable
    customer_po_number: ""     # mandatory if customer requires POs
  seller:
    company_name: ""
    registered_address: ""
    tax_registration_number: ""
    bank_details:
      bank_name: ""
      account_name: ""
      account_number: ""
      routing_aba: ""
      swift_bic: ""            # for international wires
      iban: ""
  line_items:
    - description: ""          # specific, referencing contract/deliverable
      quantity: 0
      unit: hours | months | units | fixed
      unit_price: "$0"
      amount: "$0"
      period_start: ""         # for subscription/recurring items
      period_end: ""
  subtotal: "$0"
  discount: "$0"               # if applicable
  pre_tax_total: "$0"
  tax_breakdown:
    - tax_name: ""             # e.g. "GST @ 18%", "VAT @ 20%", "No Tax (Export)"
      tax_rate: "%"
      taxable_amount: "$0"
      tax_amount: "$0"
  total_tax: "$0"
  total_amount_due: "$0"
  currency: ""
  payment_terms: "Net [N] days"
  payment_instructions: ""    # ACH details, wire instructions, or payment portal link
  notes: ""                   # contract reference, delivery reference, custom notes
```

### 1.3 Invoice Numbering System

```
INV-[YEAR]-[SEQUENCE]
  Example: INV-2025-0001 through INV-2025-9999 (reset each year)

For international / multi-entity:
  [ENTITY]-INV-[YEAR]-[SEQUENCE]
  Example: US-INV-2025-0001 / IN-INV-2025-0001
```

Never reuse or skip invoice numbers. Cancelled invoices: void in system, issue credit memo if already dispatched.

---

## Phase 2 — Invoice Dispatch

### 2.1 Delivery Standards

| Channel | When to Use | Delivery SLA |
|---|---|---|
| Email (PDF) | Standard; most customers | Within 2 hours of generation |
| Customer portal upload | Large enterprise with vendor portals | Same business day |
| EDI (electronic) | High-volume partners with EDI requirements | Per EDI schedule |
| Mail (physical) | Government customers requiring paper | 2-business-day mail |

### 2.2 Invoice Email Template

```
Subject: Invoice [INV-XXXX-XXXX] from [Your Company] — Due [Date]

Dear [Billing Contact Name],

Please find attached Invoice [INV-XXXX-XXXX] for [brief description of service/period].

Invoice Summary:
  Invoice Number:     [INV-XXXX-XXXX]
  Invoice Date:       [Date]
  Amount Due:         [Currency] [Amount]
  Due Date:           [Date]
  Your PO Reference:  [PO Number if applicable]

Payment Instructions:
  [ACH/Wire/Portal details]

If you have any questions about this invoice, please contact us at [AR email or phone].

Thank you for your business.

[Your Name]
Accounts Receivable | [Company Name]
```

### 2.3 Delivery Confirmation

- Log timestamp of invoice send
- Request read receipt or delivery confirmation where possible
- If no acknowledgment within 3 business days: follow up to confirm receipt

---

## Phase 3 — Payment Tracking

### 3.1 Payment Application

When payment is received:
1. Match to outstanding invoice(s) — exact match by invoice number and amount
2. If partial payment: apply to oldest invoice first (unless customer specifies)
3. Record: payment date, method, amount, reference number
4. Send payment acknowledgment to customer (optional but builds goodwill)
5. If overpayment: notify customer and issue credit or refund per their preference

### 3.2 AR Aging Report

Produce weekly:

```
AR AGING REPORT — As of [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Customer          | Invoice # | Amount  | Due Date | 0-30 | 31-60 | 61-90 | 90+
──────────────────|───────────|─────────|──────────|──────|───────|───────|────
[Customer A]      | INV-XXXX  | $[X]    | [Date]   | $[X] |       |       |
[Customer B]      | INV-XXXX  | $[X]    | [Date]   |      | $[X]  |       |
[Customer C]      | INV-XXXX  | $[X]    | [Date]   |      |       | $[X]  |
──────────────────|───────────|─────────|──────────|──────|───────|───────|────
TOTAL             |           | $[X]    |          | $[X] | $[X]  | $[X]  | $[X]

DSO (Days Sales Outstanding): [N] days    (target: ≤ [N] days)
Collection efficiency rate:   [%]         (target: ≥ 95%)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Phase 4 — Collections Follow-Up

### 4.1 Collections Sequence

```
Day 0:    Invoice dispatched + delivery confirmed
Day 7:    Auto-reminder sent (if payment not received and not yet due)
Due Date: Final reminder sent if not already paid
+1 day:   Invoice now past due — collections sequence begins

Day +1:   Friendly follow-up email: "Just checking in — payment appears to be outstanding"
Day +7:   Second email + phone call from AR team
Day +15:  Formal notice: "Invoice overdue — payment required to avoid service interruption"
            → Alert account manager to make a business relationship call
Day +30:  Second formal notice + place account on "watch" list
            → Pause new orders / renewals until payment received
Day +45:  Credit hold formally placed
            → VP Revenue Ops + VP CS notified
            → CFO notified if amount > $25K
Day +60:  Escalation to customer CFO / Finance leadership
            → Legal demand letter issued
Day +90:  Refer to collections agency or initiate legal proceedings
```

### 4.2 Collections Email Templates

**Day +1 — Gentle Reminder:**
```
Subject: Gentle reminder — Invoice [INV-XXXX] past due

Hi [Name],

I wanted to reach out as Invoice [INV-XXXX] for $[Amount] appears to have passed its
due date of [Date]. This may simply be an oversight.

Could you confirm the payment status or let me know if you need another copy?

[Payment details / portal link]

Thank you,
[AR Team Name]
```

**Day +15 — Formal Notice:**
```
Subject: OVERDUE — Invoice [INV-XXXX] — Immediate action required

Dear [Name],

Our records show Invoice [INV-XXXX] for $[Amount] (due [Date]) remains unpaid.

This account is now [N] days overdue. To avoid service interruption, please arrange
payment by [Date — typically 5 business days from this notice].

If there is a dispute or issue with this invoice, please contact us immediately at
[AR contact] so we can resolve it promptly.

[Payment details]

[AR Manager Name]
Accounts Receivable | [Company]
```

---

## Phase 5 — Credit Memos & Adjustments

### 5.1 When to Issue a Credit Memo

- Services not delivered or delivered late (as per contract SLA)
- Invoice error (wrong amount, wrong period, wrong customer)
- Contractual discount applied retroactively
- Early payment discount (if offered in contract terms)
- Goodwill credit (requires VP Revenue Ops approval)
- Billing dispute resolution (partial credit)

### 5.2 Credit Memo Format

```
CREDIT NOTE
Number: CN-[YEAR]-[SEQUENCE]  (e.g. CN-2025-0012)
Date: [Date]
Reference Invoice: [INV-XXXX-XXXX]
Customer: [Legal Entity Name]

Description of Credit: [Specific reason — e.g., "Service outage credit per SLA clause 5.2
                         covering [period] — 4.2 hours downtime at contracted credit rate"]

Credit Amount (pre-tax):  $[X]
Tax Credit (if applicable): $[X]
Total Credit:              $[X]

This credit will be applied to: [next invoice / refunded to [payment method] / held on account]
Applied by: [Name]
Approved by: [VP Revenue Ops Name]
```

---

## Phase 6 — Invoice Reconciliation

### 6.1 Monthly AR Reconciliation

```
MONTHLY AR RECONCILIATION — [Month]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Beginning AR balance:           $[X]
+ Invoices issued this month:   $[X]
- Payments received:           ($[X])
- Credit memos issued:         ($[X])
- Write-offs approved:         ($[X])
= Ending AR balance:            $[X]

Tie to GL control account:      $[X]   (must match to the dollar)
Variance:                       $0     (if not zero — investigate before close)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 6.2 Bad Debt Management

When an invoice is deemed uncollectible:
1. Get VP Finance approval to write off
2. Document collection efforts made
3. If > $10K: legal review required before write-off
4. Record: Dr Bad Debt Expense / Cr Allowance for Doubtful Accounts
5. Maintain written-off amounts separately for potential future recovery
6. 1099-C consideration for US customers if debt forgiven > $600

---

## Quality Rules

- Every invoice must be generated and sent within 24 hours of the billing trigger (delivery, period start, milestone completion).
- Invoice numbers must be sequential with no gaps — gaps require documented explanation.
- No credit memo can be issued without both the original invoice number AND VP Revenue Ops approval.
- AR aging must be reviewed with the account manager team weekly — AR is a shared responsibility with Sales.
- Bad debt write-offs require CFO approval if > $10,000.
- Collections follow-up must be documented in the CRM against the customer record.

See `assets/invoice-template.md` for the ready-to-use invoice format.
