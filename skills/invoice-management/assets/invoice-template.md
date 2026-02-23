# Invoice Template

## Standard B2B Invoice

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                                INVOICE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

FROM (Seller)                          INVOICE DETAILS
─────────────────────────────────      ─────────────────────────────────────
[Company Legal Name]                   Invoice Number:  INV-[YEAR]-[####]
[Registered Address Line 1]            Invoice Date:    [DD Mon YYYY]
[City, State, ZIP / Pin Code]          Due Date:        [DD Mon YYYY]
[Country]                              Currency:        [USD / EUR / INR]
Tax ID / GSTIN / VAT No: [XXXXXXXXXX]  PO Reference:    [Customer PO#]
Email: ar@[company].com
Phone: [+X XXX XXX XXXX]

TO (Bill To)                           SHIP TO (if different)
─────────────────────────────────      ─────────────────────────────────────
[Customer Legal Entity Name]           [Delivery Entity / Address]
[Billing Address Line 1]
[City, State, ZIP / Pin Code]
[Country]
Attn: [Billing Contact Name]
Email: [billing@customer.com]
VAT / GST No: [if applicable]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  #  │ Description                              │ Qty  │ Unit  │ Unit Price │ Amount
─────┼──────────────────────────────────────────┼──────┼───────┼────────────┼────────
  1  │ [Service/Product Name]                   │  1   │ Fixed │  $[XXXX]  │ $[XXXX]
     │ [Period: DD Mon YYYY – DD Mon YYYY]      │      │       │            │
     │ [Contract Ref: MSA-2025-001]             │      │       │            │
─────┼──────────────────────────────────────────┼──────┼───────┼────────────┼────────
  2  │ [Professional Services — [Name/Role]]    │  40  │ Hours │  $[XXX]   │ $[XXXX]
     │ [Period: DD Mon YYYY – DD Mon YYYY]      │      │       │            │
─────┼──────────────────────────────────────────┼──────┼───────┼────────────┼────────
  3  │ [Add additional line items as needed]    │      │       │            │
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                                                          Subtotal:  $[XXXX.XX]
                                                          Discount:  ($[XX.XX])
                                                       Pre-tax Total: $[XXXX.XX]

TAX BREAKDOWN
  GST @ 18% on $[XXXX.XX]:                                          $[XXX.XX]
  [OR: VAT @ 20% / No Tax — Export / Reverse Charge applies]
                                                        ─────────────────────
                                                       AMOUNT DUE:  $[XXXX.XX]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PAYMENT INSTRUCTIONS
─────────────────────────────────────────────────────────────────────────────
Payment Terms: Net [30] days from invoice date. Due by [DD Mon YYYY].

Bank Transfer (Preferred):
  Bank Name:        [Bank Name]
  Account Name:     [Company Legal Name]
  Account Number:   [XXXXXXXXXX]
  Routing (ABA):    [XXXXXXXXX]
  SWIFT / BIC:      [XXXXXXXXX]
  IBAN:             [XXXXXXXXXXXXXXXXXXXX]  (for international)
  Reference:        Please use Invoice Number [INV-YEAR-####]

Online Payment:     [https://pay.company.com] (credit card / ACH)
Check payable to:   [Company Legal Name], mail to [address]

Late payments are subject to [1.5%/month] interest as per [contract clause X.X].

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTES
  [Any special notes: contract reference, delivery confirmation, project milestone]
  [E.g. "Services delivered per SOW dated [Date] — Milestone 2: Development Complete"]

For billing questions: ar@[company].com | [phone] | [company website]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## India GST Invoice (Tax Invoice Format — mandatory fields per GST Act)

```
TAX INVOICE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SUPPLIER                                  DOCUMENT
──────────────────────────────────────    ──────────────────────────────
[Legal Entity Name]                       Invoice No:    [INV-2025-####]
[Address Line 1]                          Invoice Date:  [DD/MM/YYYY]
[City, State – PIN]                       Due Date:      [DD/MM/YYYY]
GSTIN: [15-character GSTIN]               Place of Supply: [State]
PAN: [XXXXXXXXXX]

RECIPIENT (Bill To)
──────────────────────────────────────────────────────────────────────
[Customer Legal Entity Name]
[Address Line 1], [City, State – PIN]
GSTIN: [Customer GSTIN if registered]
PAN: [Customer PAN if applicable]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 S.No │ Description of Service        │ SAC Code │ Qty │ Rate      │ Amount
──────┼───────────────────────────────┼──────────┼─────┼───────────┼────────
   1  │ [IT / Management Consulting / │ [XXXXXX] │  1  │ ₹[XXXXX]  │ ₹[XXXXX]
      │  Software Development / etc.] │          │     │           │
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

                                               Taxable Value:  ₹[XXXXX.XX]

GST (Intra-state supply — same state as supplier):
  CGST @ 9%:                                                   ₹[XXXX.XX]
  SGST @ 9%:                                                   ₹[XXXX.XX]
                                              ────────────────────────────
OR (Inter-state supply — different state):
  IGST @ 18%:                                                  ₹[XXXX.XX]
                                              ────────────────────────────
                                          TOTAL AMOUNT DUE:   ₹[XXXXX.XX]

Amount in words: [Indian Rupees XXXXX Only]

BANK DETAILS FOR NEFT / RTGS
  Bank:           [Bank Name and Branch]
  Account Name:   [Legal Entity Name]
  Account No:     [XXXXXXXXXX]
  IFSC Code:      [XXXXXXXXXXXX]
  UPI:            [upi-id@bank]

This is a computer-generated invoice and does not require a signature.
GST is payable by supplier (forward charge) / reverse charge as applicable.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Credit Note Template

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
                              CREDIT NOTE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Credit Note Number:      CN-[YEAR]-[####]
Credit Note Date:        [DD Mon YYYY]
Original Invoice Number: INV-[YEAR]-[####]
Original Invoice Date:   [DD Mon YYYY]
Customer:                [Customer Legal Entity Name]

REASON FOR CREDIT:
  [Specific, factual reason — e.g., "Credit for service outage on [dates] per
   SLA clause 8.3. Downtime: 6.2 hours. Credit rate per contract: $[X]/hour."]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 Description                                                       Amount
──────────────────────────────────────────────────────────────────────────
 [Credit description]                                             ($[XXXX])
──────────────────────────────────────────────────────────────────────────
 Pre-tax credit:                                                  ($[XXXX])
 Tax credit (GST/VAT @ [%]):                                      ($[XXX])
                                               ────────────────────────────
                                  TOTAL CREDIT:                   ($[XXXX])
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

This credit will be:
  ☐ Applied to next invoice
  ☐ Refunded to [payment method] within [N] business days
  ☐ Held on account as credit balance

Approved by: [VP Revenue Ops Name]           Date: [Date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
