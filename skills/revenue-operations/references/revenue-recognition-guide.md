# Revenue Recognition Guide (ASC 606 / IFRS 15)

## The Five-Step Model

### Step 1 — Identify the Contract
A contract exists when:
- Agreement is approved by both parties (signed or electronic acceptance)
- Each party's rights and payment obligations are clearly identified
- The contract has commercial substance
- Collection is probable given the customer's ability and intention to pay

### Step 2 — Identify Performance Obligations
Distinct performance obligations are goods/services that are:
- Capable of being distinct (customer can benefit from it alone or with other available resources), AND
- Distinct in the context of the contract (separately identifiable from other promises)

**Common examples for SaaS/tech companies:**
| Bundle Element | Distinct? | Treatment |
|---|---|---|
| SaaS subscription license | Yes | Separate PO — ratable |
| Implementation/setup | Yes (if customer can use product without it = No) | Separate or bundle |
| Training | Usually Yes | Separate PO |
| Premium support | Yes | Separate PO — ratable |
| Data migration | Usually Yes if standalone value | Separate PO |

### Step 3 — Determine Transaction Price
Consider:
- Fixed fees
- Variable consideration (usage-based, milestone bonuses, penalties)
- Significant financing component (if payment > 1 year in advance or arrears)
- Non-cash consideration
- Customer payments to entity (rebates, credits)

**Variable consideration**: Only include amount where it is "highly probable" that significant revenue reversal won't occur.

### Step 4 — Allocate Transaction Price
Allocate based on **relative standalone selling prices (SSP)**:
- SSP = price at which you sell the item separately
- If no observable price: use expected cost-plus, adjusted market assessment, or residual method
- Document SSP for every product/service and update annually

**Example:**
```
Bundle price: $120,000/year
  SaaS license SSP: $100,000    → allocation: $100K / $130K × $120K = $92,308
  Implementation SSP: $30,000   → allocation: $30K / $130K × $120K = $27,692
  Total allocated: $120,000
```

### Step 5 — Recognize Revenue
- **Over time**: if customer simultaneously receives and consumes the benefit (e.g., SaaS subscriptions, support contracts)
- **At a point in time**: if control transfers at delivery (e.g., perpetual license, completed deliverable)

---

## Common Revenue Scenarios

### Scenario A: Annual SaaS Subscription Paid Upfront
```
Contract: $120,000 for 12 months, paid upfront Jan 1
  Jan 1: Dr Cash $120,000 / Cr Deferred Revenue $120,000
  Jan 31: Dr Deferred Revenue $10,000 / Cr Revenue $10,000
  (Repeat monthly through Dec 31)
```

### Scenario B: Multi-Year Contract with Annual Billing
```
Contract: $100,000/year for 3 years, billed annually
  Year 1: Invoice $100K → Revenue $100K (recognize ratably over 12 months)
  Year 2: Invoice $100K → Revenue $100K (same)
  Year 3: Invoice $100K → Revenue $100K (same)
  Note: No significant financing component if < 1 year between billing cycles
```

### Scenario C: Implementation + SaaS Bundle
```
Contract: $50,000 implementation + $100,000/year SaaS
Standalone prices: Impl = $60,000 / SaaS = $120,000
Allocation ratio: Impl = 33% / SaaS = 67%
Applied to contract: Impl allocation = $50K × 33% = $16,500 / SaaS = $33,500/year...
[Calculate per actual standalone selling prices]
  Implementation: Recognize at delivery/acceptance milestones
  SaaS: Recognize ratably over subscription period
```

### Scenario D: Milestone-Based Professional Services
```
Contract: $300,000 project across 4 milestones
  Milestone 1 (Design complete): $75,000 → recognize when accepted
  Milestone 2 (Dev complete):    $100,000 → recognize when accepted
  Milestone 3 (UAT complete):    $75,000 → recognize when accepted
  Milestone 4 (Go-live):        $50,000 → recognize when accepted
```

### Scenario E: T&M (Time & Materials)
```
Contract: $200/hour, $25K/month material budget
  Recognize: As hours are approved and materials delivered/accepted
  Invoice: Monthly based on actuals
  No deferred revenue unless paid in advance
```

---

## Contract Modifications

When a contract is modified:
1. **New distinct goods/services at SSP** → treat as a separate contract
2. **Modification of existing scope** → either:
   - **Prospective**: adjust remaining recognition period (most common)
   - **Cumulative catch-up**: recognize cumulative effect immediately

Always document contract modifications with a signed amendment and update the recognition schedule within 5 business days.

---

## Deferred Revenue Management

Monthly deferred revenue roll-forward:

```
Beginning Deferred Revenue Balance:    $[X]
+ New billings in advance of delivery: $[X]
- Revenue recognized from deferred:   ($[X])
= Ending Deferred Revenue Balance:     $[X]

Current (< 12 months):               $[X]   (current liability)
Long-term (> 12 months):              $[X]   (long-term liability)
```

Reconcile to contract schedule monthly. Any variance > $1,000 must be investigated before close.
