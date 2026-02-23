# Purchase Order Template

## Standard Purchase Order

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                           PURCHASE ORDER
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

FROM (Buyer)                               PO DETAILS
──────────────────────────────────────     ──────────────────────────────────────
[Your Company Legal Name]                  PO Number:       PO-[YYYY]-[####]
[Address Line 1]                           PO Date:         [DD Mon YYYY]
[City, State, ZIP / Pin]                   Delivery By:     [DD Mon YYYY]
[Country]                                  Requisition Ref: REQ-[YYYY]-[####]
Contact: [Name, email, phone]              Currency:        [USD / EUR / INR]
Billing Email: ap@[company].com            Payment Terms:   Net [30] days

TO (Vendor / Supplier)                     DELIVER TO
──────────────────────────────────────     ──────────────────────────────────────
[Vendor Legal Entity Name]                 [Delivery Company Name]
[Vendor Address]                           [Delivery Address]
Attn: [Sales/Account Contact]              Attn: [Receiving Department/Contact]
Email: [vendor-ar@vendor.com]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Line │ Description                             │ Qty │ Unit     │ Unit Price │ Total
──────┼─────────────────────────────────────────┼─────┼──────────┼────────────┼─────────
  1   │ [Specific item or service description]  │  1  │ Fixed    │  $[XXXX]  │ $[XXXX]
      │ [Any relevant specs or SOW reference]   │     │          │            │
──────┼─────────────────────────────────────────┼─────┼──────────┼────────────┼─────────
  2   │ [Item 2 — e.g., implementation hours]   │ 40  │ Hours    │  $[XXX]   │ $[XXXX]
      │ [Delivery period or description]        │     │          │            │
──────┼─────────────────────────────────────────┼─────┼──────────┼────────────┼─────────
  3   │ [Additional line items as needed]       │     │          │            │
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                                                    Subtotal:        $[XXXXX.XX]
                                                    Estimated Tax:   $[XXXX.XX]
                                              TOTAL PO VALUE:        $[XXXXX.XX]

Note: Vendor shall not exceed the Total PO Value without a written PO amendment.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TERMS AND CONDITIONS
──────────────────────────────────────────────────────────────────────────────
1. INVOICE INSTRUCTIONS: All invoices must reference PO Number [PO-YYYY-####].
   Invoices without this PO reference will be returned unpaid and processing
   will be delayed until a corrected invoice is received.
   Submit invoices to: ap@[company].com

2. PO LIMIT: Vendor may not exceed the total authorized PO value. Any additional
   work must be covered by a written PO amendment signed by an authorized
   representative of [Your Company].

3. ACCEPTANCE: Goods and services are subject to acceptance by [Your Company].
   Payment does not constitute acceptance of defective goods or substandard
   services.

4. PAYMENT: Payment terms are Net [30] days from receipt of a valid invoice that
   references this PO and has been three-way matched to this PO and delivery
   confirmation.

5. WARRANTIES: Vendor warrants that all goods are free from defects, and all
   services conform to the specifications and standards agreed in the applicable
   Statement of Work or agreement.

6. CONFIDENTIALITY: Vendor shall maintain the confidentiality of all [Your Company]
   information and shall not disclose it to any third party.

7. COMPLIANCE: Vendor shall comply with all applicable laws, regulations, and
   standards in performing under this PO.

8. TERMINATION: [Your Company] may terminate this PO with [5] days notice. Vendor
   is entitled to payment only for authorized work completed and accepted prior
   to termination.

9. GOVERNING LAW: This PO shall be governed by the laws of [State/Jurisdiction].

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
AUTHORIZATION

Approved by:  ______________________________    Date: _______________
              [Approver Name]
              [Approver Title]
              [Your Company Legal Name]

[For amounts > $[threshold], second approval required:]
Approved by:  ______________________________    Date: _______________
              [Second Approver Name]
              [Second Approver Title]

Vendor Acknowledgment:
By signing below, Vendor acknowledges receipt and acceptance of this PO including
all terms and conditions.

Vendor signature: ______________________    Date: _______________
                  [Vendor Representative Name and Title]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## PO Change Order / Amendment

When the original PO needs modification:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
              PURCHASE ORDER AMENDMENT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Amendment No:     [PO-YYYY-#### Rev X]
Amendment Date:   [DD Mon YYYY]
Original PO:      [PO-YYYY-####] dated [Original Date]
Vendor:           [Vendor Legal Entity Name]

REASON FOR AMENDMENT:
  [Specific reason — e.g., "Scope expanded to include Phase 2 development
   per discussion on [Date]. Additional 80 hours of engineering services."]

CHANGES:

  Original Line 2:
    Description: [Original description]
    Quantity: 40 hours  |  Unit Price: $[XXX]  |  Total: $[XXXX]

  Amended Line 2:
    Description: [Amended description]
    Quantity: 120 hours  |  Unit Price: $[XXX]  |  Total: $[XXXX]

  Change: +80 hours  |  Additional value: $[XXXX]

ORIGINAL PO TOTAL:   $[XXXXX]
THIS AMENDMENT:      $[XXXX]
REVISED PO TOTAL:    $[XXXXX]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
All other terms and conditions of the original PO remain unchanged.

Authorized by: ______________________    Date: _______________
               [Approver Name, Title]
               [Your Company]

Vendor acknowledgment: ______________    Date: _______________
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
