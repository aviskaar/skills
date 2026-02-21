# Costing Model — Calculation Worksheet

Complete this worksheet for Phase 7 of the proposal workflow. Replace all `[X]` placeholders with actual values. Formulas are shown inline.

---

## SECTION 1 — ENGAGEMENT PARAMETERS

| Parameter | Value |
|---|---|
| Customer Name | [Customer Name] |
| Project Name | [Project Name] |
| Date | [YYYY-MM-DD] |
| Team Model | [ ] US Onshore · [x] Blended · [ ] Offshore-Led |
| US/Offshore Split | [30]% US / [70]% Offshore |
| Hours per Week (FTE) | 40 |
| Effective Utilization | 87.5% (0.875) |
| Contingency Buffer | [15]% of labor |
| Margin Target | [25–35]% |

---

## SECTION 2 — RATE CARD

Confirm the team model and populate the applicable rate column. See `references/team-rate-guide.md` for benchmarks.

| Role | Level | US Rate/hr | Offshore Rate/hr | **Blended Rate/hr** |
|---|---|---|---|---|
| Program Director | Principal | $250 | $90 | **$[calc]** |
| Engagement Manager | Senior | $195 | $65 | **$[calc]** |
| Project Manager | Mid | $140 | $45 | **$[calc]** |
| Solutions Architect | Senior | $225 | $80 | **$[calc]** |
| Cloud Architect | Senior | $215 | $75 | **$[calc]** |
| Data Architect | Senior | $210 | $75 | **$[calc]** |
| Security Architect | Senior | $230 | $80 | **$[calc]** |
| Tech Lead | Senior | $200 | $70 | **$[calc]** |
| Senior Backend Engineer | Senior | $175 | $60 | **$[calc]** |
| Mid Backend Engineer | Mid | $150 | $45 | **$[calc]** |
| Senior Frontend Engineer | Senior | $165 | $55 | **$[calc]** |
| Mid Frontend Engineer | Mid | $140 | $40 | **$[calc]** |
| UX/UI Designer | Mid | $135 | $40 | **$[calc]** |
| Senior Data Engineer | Senior | $175 | $60 | **$[calc]** |
| Mid Data Engineer | Mid | $155 | $50 | **$[calc]** |
| Senior ML Engineer | Senior | $190 | $65 | **$[calc]** |
| Mid ML Engineer / AI Eng | Mid | $165 | $55 | **$[calc]** |
| Senior DevOps / SRE | Senior | $185 | $65 | **$[calc]** |
| Mid DevOps Engineer | Mid | $155 | $50 | **$[calc]** |
| Security Engineer | Senior | $190 | $70 | **$[calc]** |
| QA Lead / SDET (Sr) | Senior | $145 | $48 | **$[calc]** |
| Mid SDET | Mid | $120 | $35 | **$[calc]** |
| Business Analyst | Mid | $130 | $40 | **$[calc]** |

**Blended Rate Formula**:
```
Blended Rate = (US_rate × US_ratio) + (Offshore_rate × Offshore_ratio)

Example (30% US / 70% offshore, Mid Backend Eng):
= ($150 × 0.30) + ($45 × 0.70)
= $45.00 + $31.50
= $76.50/hr
```

---

## SECTION 3 — PHASE-BY-PHASE EFFORT MODEL

### Phase 0 — Proof of Concept

**Duration**: [6] weeks
**Working hours per FTE**: 40 hrs/week × 0.875 utilization = **35 billable hrs/week**

| Role | FTE Alloc | Weeks | Billable Hours | Blended Rate | **Phase Cost** |
|---|---|---|---|---|---|
| Engagement Manager | 0.25 | 6 | `0.25 × 6 × 35 = 53` | $[rate] | **$[X]** |
| Solutions Architect | 1.00 | 6 | `1.00 × 6 × 35 = 210` | $[rate] | **$[X]** |
| Tech Lead | 1.00 | 6 | `1.00 × 6 × 35 = 210` | $[rate] | **$[X]** |
| Backend Engineer | 1.00 | 6 | `1.00 × 6 × 35 = 210` | $[rate] | **$[X]** |
| Frontend Engineer | 0.50 | 6 | `0.50 × 6 × 35 = 105` | $[rate] | **$[X]** |
| DevOps Engineer | 0.50 | 6 | `0.50 × 6 × 35 = 105` | $[rate] | **$[X]** |
| QA Engineer | 0.50 | 6 | `0.50 × 6 × 35 = 105` | $[rate] | **$[X]** |
| Business Analyst | 0.50 | 6 | `0.50 × 6 × 35 = 105` | $[rate] | **$[X]** |
| **Phase 0 Labor Subtotal** | | | | | **$[X]** |
| Contingency (15%) | | | | | **$[X]** |
| **Phase 0 Labor Total** | | | | | **$[X]** |

---

### Phase 1 — Foundation Build

**Duration**: [12] weeks

| Role | FTE Alloc | Weeks | Billable Hours | Blended Rate | **Phase Cost** |
|---|---|---|---|---|---|
| Engagement Manager | 0.50 | 12 | `0.50 × 12 × 35 = 210` | $[rate] | **$[X]** |
| Solutions Architect | 0.50 | 12 | `0.50 × 12 × 35 = 210` | $[rate] | **$[X]** |
| Tech Lead | 1.00 | 12 | `1.00 × 12 × 35 = 420` | $[rate] | **$[X]** |
| Backend Engineer (×2) | 2.00 | 12 | `2.00 × 12 × 35 = 840` | $[rate] | **$[X]** |
| Frontend Engineer | 1.00 | 12 | `1.00 × 12 × 35 = 420` | $[rate] | **$[X]** |
| Data Engineer | 1.00 | 12 | `1.00 × 12 × 35 = 420` | $[rate] | **$[X]** |
| ML Engineer | 1.00 | 12 | `1.00 × 12 × 35 = 420` | $[rate] | **$[X]** |
| DevOps / SRE | 1.00 | 12 | `1.00 × 12 × 35 = 420` | $[rate] | **$[X]** |
| Security Engineer | 0.25 | 12 | `0.25 × 12 × 35 = 105` | $[rate] | **$[X]** |
| QA Lead + SDET | 1.00 | 12 | `1.00 × 12 × 35 = 420` | $[rate] | **$[X]** |
| Business Analyst | 1.00 | 12 | `1.00 × 12 × 35 = 420` | $[rate] | **$[X]** |
| **Phase 1 Labor Subtotal** | | | | | **$[X]** |
| Contingency (15%) | | | | | **$[X]** |
| **Phase 1 Labor Total** | | | | | **$[X]** |

---

### Phase 2 — Expansion

**Duration**: [16] weeks

| Role | FTE Alloc | Weeks | Billable Hours | Blended Rate | **Phase Cost** |
|---|---|---|---|---|---|
| Engagement Manager | 0.50 | 16 | `0.50 × 16 × 35 = 280` | $[rate] | **$[X]** |
| Solutions Architect | 0.25 | 16 | `0.25 × 16 × 35 = 140` | $[rate] | **$[X]** |
| Tech Lead | 1.00 | 16 | `1.00 × 16 × 35 = 560` | $[rate] | **$[X]** |
| Backend Engineer (×2) | 2.00 | 16 | `2.00 × 16 × 35 = 1,120` | $[rate] | **$[X]** |
| Frontend Engineer | 1.00 | 16 | `1.00 × 16 × 35 = 560` | $[rate] | **$[X]** |
| Data Engineer | 1.00 | 16 | `1.00 × 16 × 35 = 560` | $[rate] | **$[X]** |
| ML Engineer | 1.00 | 16 | `1.00 × 16 × 35 = 560` | $[rate] | **$[X]** |
| DevOps / SRE | 0.50 | 16 | `0.50 × 16 × 35 = 280` | $[rate] | **$[X]** |
| Security Engineer | 0.25 | 16 | `0.25 × 16 × 35 = 140` | $[rate] | **$[X]** |
| QA Lead + SDET | 1.00 | 16 | `1.00 × 16 × 35 = 560` | $[rate] | **$[X]** |
| Business Analyst | 1.00 | 16 | `1.00 × 16 × 35 = 560` | $[rate] | **$[X]** |
| **Phase 2 Labor Subtotal** | | | | | **$[X]** |
| Contingency (15%) | | | | | **$[X]** |
| **Phase 2 Labor Total** | | | | | **$[X]** |

---

### Phase 3 — Optimization & Handover

**Duration**: [8] weeks

| Role | FTE Alloc | Weeks | Billable Hours | Blended Rate | **Phase Cost** |
|---|---|---|---|---|---|
| Engagement Manager | 0.25 | 8 | `0.25 × 8 × 35 = 70` | $[rate] | **$[X]** |
| Solutions Architect | 0.25 | 8 | `0.25 × 8 × 35 = 70` | $[rate] | **$[X]** |
| Tech Lead | 0.50 | 8 | `0.50 × 8 × 35 = 140` | $[rate] | **$[X]** |
| Backend Engineer | 1.00 | 8 | `1.00 × 8 × 35 = 280` | $[rate] | **$[X]** |
| DevOps / SRE | 0.50 | 8 | `0.50 × 8 × 35 = 140` | $[rate] | **$[X]** |
| Security Engineer | 0.25 | 8 | `0.25 × 8 × 35 = 70` | $[rate] | **$[X]** |
| QA / Performance | 0.50 | 8 | `0.50 × 8 × 35 = 140` | $[rate] | **$[X]** |
| Business Analyst | 0.25 | 8 | `0.25 × 8 × 35 = 70` | $[rate] | **$[X]** |
| **Phase 3 Labor Subtotal** | | | | | **$[X]** |
| Contingency (15%) | | | | | **$[X]** |
| **Phase 3 Labor Total** | | | | | **$[X]** |

---

## SECTION 4 — INFRASTRUCTURE & NON-LABOR COSTS

### 4.1 Cloud Infrastructure

| Environment | Resources | POC $/mo | Production $/mo |
|---|---|---|---|
| Compute | [EC2 / EKS / Container Apps] | $[X] | $[X] |
| Database | [RDS / Aurora / Cosmos DB] | $[X] | $[X] |
| Storage | [S3 / ADLS / GCS] | $[X] | $[X] |
| Networking | [VPC, NAT, Load Balancer, CDN] | $[X] | $[X] |
| AI/ML Services | [SageMaker / Vertex AI / Azure ML] | $[X] | $[X] |
| Observability | [CloudWatch / Datadog / New Relic] | $[X] | $[X] |
| Security | [WAF, Shield, GuardDuty, Defender] | $[X] | $[X] |
| **Total Cloud** | | **$[X]/mo** | **$[X]/mo** |

**POC Duration**: [6] weeks → [1.5] months → POC infra total: `$[X]/mo × 1.5 = $[X]`
**Phase 1 Duration**: [12] weeks → [3] months → Phase 1 infra total: `$[X]/mo × 3 = $[X]`

### 4.2 Software Licenses & SaaS Tools

| Tool / License | Purpose | Cost |
|---|---|---|
| [Datadog / Splunk] | Observability | $[X]/mo |
| [Jira + Confluence] | Project & documentation | $[X]/mo |
| [GitHub Enterprise] | Source control | $[X]/mo |
| [Snyk] | Security scanning | $[X]/mo |
| [Third-party API — e.g., SendGrid] | [Purpose] | $[X]/mo |
| **Total Software** | | **$[X]/mo** |

### 4.3 Travel & Expenses

| Item | Frequency | Estimate |
|---|---|---|
| Kick-off onsite visit | 1× | $[X] |
| Quarterly steering sessions (onsite) | [N]× | $[X] |
| Go-live support (onsite) | 1× | $[X] |
| **Total T&E** | | **$[X]** |

*Standard: 5% of labor cost if no specific onsite requirements*

---

## SECTION 5 — COST SUMMARY

### 5.1 Total Cost by Phase

| Phase | Duration | Labor (incl. contingency) | Infra & Tools | T&E | **Phase Total** |
|---|---|---|---|---|---|
| Phase 0 — POC | [6] wks | $[X] | $[X] | $[X] | **$[X]** |
| Phase 1 — Foundation | [12] wks | $[X] | $[X] | $[X] | **$[X]** |
| Phase 2 — Expansion | [16] wks | $[X] | $[X] | $[X] | **$[X]** |
| Phase 3 — Optimization | [8] wks | $[X] | $[X] | $[X] | **$[X]** |
| **TOTAL ENGAGEMENT** | **~[10.5] months** | **$[X]** | **$[X]** | **$[X]** | **$[X]** |

### 5.2 Cost Breakdown by Type

| Category | Amount | % of Total |
|---|---|---|
| Labor (base) | $[X] | [X]% |
| Contingency | $[X] | [X]% |
| Cloud Infrastructure | $[X] | [X]% |
| Software Licenses | $[X] | [X]% |
| Travel & Expenses | $[X] | [X]% |
| **Grand Total** | **$[X]** | **100%** |

### 5.3 Pricing Options Summary

| Option | Scope | Investment |
|---|---|---|
| **Option 1** — POC Only | Phase 0 only, fixed price | **$[X]** |
| **Option 2** — POC + Foundation | Phase 0 + Phase 1 | **$[X]** |
| **Option 3** — Full Engagement | All 4 phases | **$[X] – $[Y]** |

---

## SECTION 6 — ROI MODEL

### 6.1 Benefits Identification

| Benefit Category | How Quantified | Year 1 Value | Year 2 Value | Year 3 Value |
|---|---|---|---|---|
| Labor cost reduction | [N] FTEs saved × $[salary] | $[X] | $[X] | $[X] |
| Process automation savings | [N] hrs/wk × $[rate] × 52 | $[X] | $[X] | $[X] |
| Error/rework reduction | [N]% fewer errors × $[cost/error] | $[X] | $[X] | $[X] |
| Revenue uplift | [N]% faster TTM × [deal value] | $[X] | $[X] | $[X] |
| New revenue enabled | [N] new capabilities × [ARR estimate] | $[X] | $[X] | $[X] |
| Compliance fine avoidance | [Fine amount] × [probability] | $[X] | $[X] | $[X] |
| **Total Benefits** | | **$[X]** | **$[X]** | **$[X]** |

### 6.2 ROI Calculation

```
Total 3-Year Benefits:     $[X]
Total Investment:          $[X]   (all phases, one-time)
Ongoing Costs/Year:        $[X]   (infra + licenses + support)
Total 3-Year Cost:         $[X]

Net 3-Year Value:          $[X]   (Benefits − Total Cost)
ROI:                       [X]%   (Net Value ÷ Investment × 100)
Payback Period:            [N] months

NPV (@ [X]% discount rate):
  PV of Year 1 benefits:  $[X]
  PV of Year 2 benefits:  $[X]
  PV of Year 3 benefits:  $[X]
  Less: Investment:       ($[X])
  NPV:                    $[X]
```

### 6.3 Sensitivity Analysis

| Scenario | Assumption | ROI | Payback |
|---|---|---|---|
| Conservative (Base −30%) | Benefits 30% lower than projected | [X]% | [N] months |
| **Base Case (Recommended)** | **As projected** | **[X]%** | **[N] months** |
| Optimistic (Base +20%) | Benefits 20% higher than projected | [X]% | [N] months |

---

## SECTION 7 — PAYMENT SCHEDULE

| Milestone | Event | % | Amount | Expected Date |
|---|---|---|---|---|
| M-0 | Contract signing | 20% | $[X] | [Date] |
| M-1 | POC acceptance | 15% | $[X] | [Date] |
| M-2 | Phase 1 go-live | 30% | $[X] | [Date] |
| M-3 | Phase 2 completion | 25% | $[X] | [Date] |
| M-4 | Final acceptance | 10% | $[X] | [Date] |
| **Total** | | **100%** | **$[X]** | |

---

## SECTION 8 — ASSUMPTIONS & NOTES

1. All rates are in USD. International engagements may require currency adjustment and FX buffer.
2. Infrastructure costs are estimates. Actual costs depend on usage patterns discovered during Phase 0.
3. Contingency (15%) covers scope clarification, unforeseen technical complexity, and minor rework. It does not cover material scope changes (requires Change Order).
4. Rates are valid for [90] days from proposal date. Changes in staffing market may require adjustment for engagements starting after that window.
5. Blended rates assume [30]% US / [70]% offshore. Changes to this ratio shift costs proportionally.
6. No markup applied to third-party software or infrastructure. Billed at cost with monthly reconciliation.
7. T&E estimated at 5% of labor if no specific travel requirements are provided.
