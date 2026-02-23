---
name: purchase-order-management
description: "Use this skill when a procurement manager, AP specialist, budget owner, or finance operations team member needs to create, approve, dispatch, track, and close purchase orders. Covers the full PO lifecycle: requisition to PO creation, multi-level approval routing, vendor dispatch, goods/services receipt matching, three-way invoice matching, PO amendment, and PO closure. Trigger when a team member needs to buy something, when a vendor invoice arrives and needs a PO matched, when tracking open POs, or when producing a PO spend report for a department or vendor."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [purchase-orders, PO, procurement, procure-to-pay, P2P, vendor-management, AP, three-way-match, spend-management, budget-control, finance-ops]
---

# Purchase Order Management — Full PO Lifecycle

You run the complete purchase order process: from requisition and creation to vendor dispatch, receipt confirmation, invoice matching, and closure. Every company purchase flows through a PO — no PO, no payment.

**Mission**: Control every dollar of spend before it happens. No surprises in AP.

---

## Phase 1 — Purchase Requisition

### 1.1 Requisition Form

```yaml
purchase_requisition:
  req_id: ""                   # format: REQ-[YYYY]-[NNNN]
  requested_by: ""
  department: ""
  cost_center: ""
  request_date: ""
  required_by_date: ""
  budget_code: ""              # GL account code
  vendor_name: ""              # preferred vendor; or "open sourcing" if not specified
  description_of_need: ""      # what problem does this purchase solve?
  items:
    - description: ""
      quantity: 0
      estimated_unit_price: "$0"
      estimated_total: "$0"
  total_estimated_value: "$0"
  budget_available: "$0"       # remaining budget in cost center
  justification: ""            # business case — mandatory for all items > $500
  alternatives_considered: ""  # for purchases > $5,000
  urgency: routine | expedited | emergency
  recurring: false             # is this a recurring subscription/service?
  contract_required: false     # does this need a new MSA/agreement?
```

### 1.2 Approval Routing by Amount

| Amount | Approver Chain |
|---|---|
| < $500 | Direct manager |
| $500–$2,500 | Direct manager → Department head |
| $2,500–$10,000 | Department head → VP Finance |
| $10,000–$50,000 | VP Finance → CFO |
| $50,000–$250,000 | CFO → CEO |
| > $250,000 | CFO → CEO → Board approval |
| Any new vendor | Above + VP Finance vendor verification |
| Any software/tool | Above + IT security review |

### 1.3 Requisition SLAs

- < $500: Approved or rejected within 1 business day
- $500–$10,000: Approved or rejected within 3 business days
- > $10,000: Approved or rejected within 5 business days
- Emergency (documented): 4-hour approval path with VP Finance + CFO

---

## Phase 2 — PO Creation

### 2.1 PO Document Standard

```yaml
purchase_order:
  po_number: ""                # format: PO-[YYYY]-[NNNN] (e.g. PO-2025-0073)
  po_date: ""
  req_reference: ""            # links back to REQ-YYYY-NNNN
  status: draft | approved | sent_to_vendor | partially_received | fully_received | closed | cancelled

  buyer:
    company_name: ""
    billing_address: ""
    delivery_address: ""       # where to deliver goods or where services are rendered
    billing_contact: ""
    billing_email: ""
    po_issuer_name: ""
    po_issuer_title: ""

  vendor:
    vendor_id: ""              # from vendor master
    legal_entity_name: ""
    vendor_address: ""
    vendor_contact_name: ""
    vendor_contact_email: ""
    vendor_invoice_email: ""

  terms:
    payment_terms: net_15 | net_30 | net_45 | net_60
    delivery_date: ""
    delivery_terms: ""         # FOB, ex-works, delivered, etc. (for goods)
    currency: ""

  line_items:
    - po_line_id: 1
      description: ""          # must match what vendor will invoice — avoids disputes
      quantity: 0
      unit: hours | days | units | months | fixed
      unit_price: "$0"
      line_total: "$0"
      cost_center: ""
      gl_account: ""           # accounting code
      project_code: ""         # if applicable

  subtotal: "$0"
  estimated_tax: "$0"
  total_authorized: "$0"       # maximum the company is authorized to pay on this PO

  terms_and_conditions: |
    1. Vendor must reference PO number on all invoices.
    2. Invoices without PO reference will be returned unpaid.
    3. No charges beyond PO total without written amendment.
    4. All deliverables subject to acceptance per agreed criteria.
    5. Payment terms run from receipt of a valid invoice, not invoice date.

  approvers:
    - name: ""
      title: ""
      approved_date: ""
      signature: ""
```

### 2.2 PO Numbering System

```
PO-[YEAR]-[SEQUENCE]
  Example: PO-2025-0001 through PO-2025-9999

For specific categories:
  SW-[YEAR]-[NNNN]  — Software subscriptions
  HW-[YEAR]-[NNNN]  — Hardware/equipment
  SV-[YEAR]-[NNNN]  — Professional services
  MK-[YEAR]-[NNNN]  — Marketing spend
```

---

## Phase 3 — Vendor Dispatch & Acceptance

### 3.1 PO Dispatch

- Send PO to vendor's billing/account contact via email (PDF + any required portal upload)
- Request vendor acknowledgment of PO within 2 business days
- Confirm: vendor accepts price, delivery date, and all terms
- If vendor proposes different terms: route back through approval chain before proceeding

### 3.2 PO Dispatch Email

```
Subject: Purchase Order [PO-XXXX-XXXX] from [Your Company]

Dear [Vendor Contact Name],

Please find attached Purchase Order [PO-XXXX-XXXX] from [Your Company] for:
  [Brief description of goods/services]
  Total authorized value: [Currency] [Amount]
  Delivery / completion by: [Date]

Important reminders:
• Reference PO number [PO-XXXX-XXXX] on ALL invoices — invoices without this
  reference cannot be processed.
• Do not exceed the authorized PO value without a written amendment.
• For invoice submission: [email address or portal instructions]

Please confirm receipt and acceptance of this PO within 2 business days.

[Buyer Name]
[Title] | [Company]
```

---

## Phase 4 — Receipt & Three-Way Match

### 4.1 Goods / Services Receipt

For every PO line item, record receipt:

```yaml
receipt_record:
  receipt_id: ""               # format: REC-[YYYY]-[NNNN]
  po_number: ""
  vendor: ""
  received_by: ""
  receipt_date: ""
  items_received:
    - po_line_id: 1
      description: ""
      quantity_ordered: 0
      quantity_received: 0
      quantity_accepted: 0     # may differ if quality reject
      quantity_rejected: 0
      rejection_reason: ""
  delivery_note_number: ""     # vendor's delivery/dispatch reference
  accepted_by: ""              # department head or project owner
  acceptance_date: ""
  notes: ""
```

### 4.2 Three-Way Match Logic

```
For each vendor invoice received:
  1. PO Match:
     Does invoice vendor = PO vendor?              ✓ / ✗
     Does invoice PO number reference correct PO?  ✓ / ✗
     Is invoice amount ≤ remaining PO balance?     ✓ / ✗ (if ✗ → hold)
     Is invoice within PO line item quantities?    ✓ / ✗

  2. Receipt Match:
     Is there a confirmed receipt for goods/services invoiced?  ✓ / ✗
     Quantity on invoice ≤ quantity received and accepted?      ✓ / ✗

  3. Price Match:
     Unit price on invoice = unit price on PO?
       Exact match:             Auto-approve
       < 2% variance:           Auto-approve with notation
       2–5% variance:           Route to buyer for approval
       > 5% variance:           Hard hold; buyer must resolve with vendor

  Result:
    All ✓ + no price variance → route to payment queue
    Any ✗ or variance → hold with specific reason code → notify AP team
```

---

## Phase 5 — PO Tracking & Management

### 5.1 Open PO Report

```
OPEN PO REPORT — As of [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PO #         | Vendor           | Dept | Total PO | Received | Remaining | Due Date | Status
─────────────|──────────────────|────── |──────────|──────────|───────────|──────────|────────
PO-2025-0042 | [Vendor Name]    | Eng  | $[X]     | $[X]     | $[X]      | [Date]   | Open
PO-2025-0051 | [Vendor Name]    | Mktg | $[X]     | $0       | $[X]      | [Date]   | Sent
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TOTAL OPEN PO COMMITMENTS: $[X]
Overdue (past delivery date, not closed): [N] POs — $[X] at risk
```

### 5.2 PO Amendment Process

When a PO needs to change (scope increase, price change, delivery extension):

1. Buyer submits a PO change order request with reason
2. Re-approval required if: total increases by > 10% OR > $5,000 (whichever is lower)
3. Issue amended PO with revision number (PO-2025-0042 Rev 1)
4. Get vendor acknowledgment of amended PO
5. Update all systems — original PO replaced by amendment

**Prohibited**: Splitting one large purchase into multiple smaller POs to avoid approval thresholds.

### 5.3 PO Closure

Close a PO when:
- All goods/services fully received and accepted
- All invoices matched, approved, and paid
- Any retention/holdback released
- OR: cancelled without delivery (document reason)

POs older than 12 months with no activity → auto-flag for review and potential cancellation.

---

## Phase 6 — Spend Analytics

### 6.1 Spend by Category (Monthly)

```
SPEND REPORT — [Period]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Category              | Budget | Actual | Variance | Top Vendor
──────────────────────|────────|────────|──────────|────────────
Software & SaaS       | $[X]   | $[X]   | [+/-]%   | [Vendor]
Cloud Infrastructure  | $[X]   | $[X]   | [+/-]%   | [Vendor]
Professional Services | $[X]   | $[X]   | [+/-]%   | [Vendor]
Marketing             | $[X]   | $[X]   | [+/-]%   | [Vendor]
Travel & T&E          | $[X]   | $[X]   | [+/-]%   | —
Office & Facilities   | $[X]   | $[X]   | [+/-]%   | [Vendor]
Other                 | $[X]   | $[X]   | [+/-]%   | [Vendor]
──────────────────────|────────|────────|──────────|────────────
TOTAL                 | $[X]   | $[X]   | [+/-]%   |
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Quality Rules

- Every spend > $500 requires a PO before the vendor starts work or ships goods.
- No retroactive POs without written explanation and VP Finance approval.
- PO splitting to avoid approval thresholds is grounds for disciplinary action.
- Vendor cannot start work until PO is acknowledged and accepted.
- Three-way match is non-negotiable for all PO-backed invoices > $500.
- POs must be closed within 30 days of final delivery — no perpetually open POs.
- Spend reports must be shared with department heads monthly to track budget consumption.

See `assets/po-template.md` for the ready-to-use PO document.
