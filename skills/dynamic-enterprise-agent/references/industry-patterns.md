# Industry Patterns Reference

Full regulatory and domain pattern library for dynamic enterprise agent generation.
Each industry section covers: compliance constraints, data models, common agent patterns, and audit requirements.

---

## Healthcare

### Regulatory Constraints (auto-applied)
| Regulation | Requirement | Agent Implementation |
|-----------|-------------|---------------------|
| **HIPAA Privacy Rule** | PHI must be protected, minimum necessary | De-identify before LLM calls outside compliant boundary |
| **HIPAA Security Rule** | Encryption at rest and in transit | TLS 1.2+, AES-256 at rest |
| **HIPAA Breach Notification** | Report breaches within 60 days | Automated breach detection logging |
| **HL7 FHIR R4** | Interoperability standard | Use FHIR resources as canonical data model |
| **CDS Hooks** | Clinical decision support integration | Hook into EHR workflow at patient-view, order-select |
| **SMART on FHIR** | Secure app authorization | Backend services JWT auth for system agents |

### PHI De-identification (before LLM call)
```python
import re

PHI_PATTERNS = {
    "ssn": r"\b\d{3}-\d{2}-\d{4}\b",
    "dob": r"\b(0[1-9]|1[0-2])/(0[1-9]|[12]\d|3[01])/\d{4}\b",
    "mrn": r"\bMRN[:\s]*\d{6,10}\b",
    "name": None,  # Use NER model or scrubadub
    "phone": r"\b\d{3}[-.]?\d{3}[-.]?\d{4}\b",
    "email": r"\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b",
    "zip": r"\b\d{5}(-\d{4})?\b",
    "ip": r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b",
}

def deidentify(text: str) -> str:
    for phi_type, pattern in PHI_PATTERNS.items():
        if pattern:
            text = re.sub(pattern, f"[{phi_type.upper()}-REDACTED]", text)
    return text

# ALWAYS call before sending to LLM outside compliant boundary
safe_text = deidentify(clinical_note)
```

### FHIR Domain Data Model
```python
# Canonical FHIR R4 resources used in agent context
FHIR_RESOURCES = {
    "Patient":              "Demographics, identifiers, contacts",
    "Encounter":            "Visit details, type, period, providers",
    "Observation":          "Vitals, labs, assessments (LOINC codes)",
    "Condition":            "Diagnoses (ICD-10/SNOMED codes)",
    "MedicationRequest":    "Orders (RxNorm codes)",
    "AllergyIntolerance":   "Allergies and adverse reactions",
    "Procedure":            "Clinical procedures (CPT/SNOMED)",
    "DiagnosticReport":     "Lab and imaging results",
    "CarePlan":             "Goal-oriented care coordination",
    "CommunicationRequest": "Referrals, patient messages",
    "Appointment":          "Scheduling",
    "Coverage":             "Insurance / payer",
}

# LOINC codes for common vitals observations
VITAL_LOINC = {
    "8310-5":  "Body temperature",
    "8867-4":  "Heart rate",
    "9279-1":  "Respiratory rate",
    "55284-4": "Blood pressure (systolic+diastolic)",
    "2708-6":  "Oxygen saturation",
    "39156-5": "BMI",
}
```

### Common Agent Patterns
| Pattern | Trigger | Action |
|---------|---------|--------|
| **Care Gap Alert** | Nightly batch — patients overdue for screening | Generate outreach tasks in EHR worklist |
| **Early Warning** | Vital sign stream crosses threshold | Alert care team via secure messaging |
| **Clinical Doc Assist** | Encounter note open in EHR | Suggest note sections from visit context |
| **Medication Reconciliation** | Admission encounter created | Compare home meds vs. active orders, flag conflicts |
| **Discharge Follow-up** | Encounter status = discharged | Schedule follow-up, send patient instructions |
| **Prior Auth Automation** | MedicationRequest created | Pre-populate payer form, predict approval likelihood |

### Audit Requirements
- All agent actions logged to immutable audit store
- Log fields: `timestamp`, `agent_id`, `patient_id_hash` (not plain MRN), `action`, `data_accessed`, `outcome`
- Retain logs minimum 6 years (HIPAA)
- Access logs reviewed quarterly

---

## Life Sciences

### Regulatory Constraints (auto-applied)
| Regulation | Requirement | Agent Implementation |
|-----------|-------------|---------------------|
| **21 CFR Part 11** | Electronic records and signatures | Audit trail on every agent action; e-sig for approvals |
| **GCP (ICH E6)** | Data integrity in clinical trials | Immutable audit trail; no retrospective edit without rationale |
| **GMP / GxP** | Validated systems | Agent must be part of validated system with IQ/OQ/PQ |
| **EU Annex 11** | Computerized systems in GMP | Risk-based validation; data integrity controls |
| **GDPR (Art 9)** | Special category health data | Explicit consent; data minimization; right to erasure |

### Clinical Trial Domain Data Model
```python
CLINICAL_TRIAL_ENTITIES = {
    "Protocol":      "Study design, objectives, endpoints, inclusion/exclusion",
    "Site":          "Investigator site, IRB approval, enrollment cap",
    "Subject":       "Study participant, screening status, randomization",
    "Visit":         "Scheduled/unscheduled visit per protocol calendar",
    "CRF":           "Case Report Form — structured data collection",
    "AdverseEvent":  "AE/SAE with MedDRA coding, causality, outcome",
    "Deviation":     "Protocol deviation, category, impact assessment",
    "Query":         "Data query raised against CRF entry",
    "Submission":    "Regulatory submission package (CTD/eCTD format)",
    "SUSAR":         "Suspected Unexpected Serious Adverse Reaction",
}

# MedDRA hierarchy for AE coding
MEDDRA_HIERARCHY = ["SOC", "HLGT", "HLT", "PT", "LLT"]
# CDISC standards
CDISC_STANDARDS = ["SDTM", "ADaM", "SEND", "ODM", "Define-XML"]
```

### Common Agent Patterns
| Pattern | Trigger | Action |
|---------|---------|--------|
| **Site Status Monitor** | Daily — Veeva site status API | Flag sites behind enrollment plan; alert CRA |
| **SAE Triage** | AE form submitted with SAE flag | Check causality criteria; initiate SUSAR workflow if needed |
| **Query Auto-Resolution** | CRF data query raised | Check source document; auto-close if data matches |
| **Protocol Deviation Classifier** | Deviation report submitted | Classify severity; route to medical monitor if major |
| **Submission Readiness** | Go/No-go milestone approaching | Check completeness of required documents in Vault |
| **Regulatory Intelligence** | FDA/EMA guidance published | Summarize impact on active protocols |

### Part 11 Audit Trail (mandatory)
```python
import hashlib, json
from datetime import datetime, timezone

def part11_log(agent_id: str, action: str, record_id: str,
               before: dict, after: dict, user_id: str, reason: str):
    entry = {
        "timestamp":   datetime.now(timezone.utc).isoformat(),
        "agent_id":    agent_id,
        "action":      action,
        "record_id":   record_id,
        "record_type": record_id.split(":")[0],
        "before":      before,
        "after":       after,
        "changed_by":  user_id,
        "reason":      reason,   # required for any data change
    }
    # Hash for tamper evidence
    entry["hash"] = hashlib.sha256(json.dumps(entry, sort_keys=True).encode()).hexdigest()
    # Write to immutable store (append-only DB, WORM storage, blockchain)
    write_to_audit_store(entry)
    return entry
```

---

## Fintech / Banking

### Regulatory Constraints (auto-applied)
| Regulation | Requirement | Agent Implementation |
|-----------|-------------|---------------------|
| **PCI-DSS** | Cardholder data protection | Never pass raw PAN/CVV to LLM; tokenize first |
| **SOX** | Financial reporting controls | Dual approval for financial agent actions; change mgmt |
| **FFIEC** | Bank IT examination guidance | Model risk management for AI; explainability required |
| **GDPR / CCPA** | Consumer data rights | Data minimization; consent tracking; deletion capability |
| **BSA / AML** | Anti-money laundering | SAR filing automation; transaction monitoring rules |
| **GLBA** | Financial data privacy | Safeguards rule; vendor due diligence for LLM API |
| **Model Risk (SR 11-7)** | AI model governance | Document model purpose, limitations, validation results |

### Financial Domain Data Model
```python
BANKING_ENTITIES = {
    "Customer":      "CIF record, KYC status, risk rating, relationship",
    "Account":       "Account type, balance, status, ownership",
    "Transaction":   "Amount, currency, type, channel, counterparty",
    "Position":      "Instrument, quantity, market value, book value",
    "Instrument":    "CUSIP/ISIN, asset class, issuer, rating",
    "Order":         "Buy/sell order, FIX fields, execution status",
    "Portfolio":     "Grouping of positions, benchmark, mandate",
    "Risk":          "VaR, exposure, limit, breach status",
    "Loan":          "Origination, terms, amortization, covenant status",
    "Claim":         "Insurance claim, line items, adjudication status",
    "SAR":           "Suspicious Activity Report, filing status",
}

# PCI tokenization before LLM call
def tokenize_pan(pan: str) -> str:
    """Replace card number with vault token — never send raw PAN to LLM."""
    return vault_client.tokenize(pan)  # e.g., Skyflow, Basis Theory, Tokenex
```

### Common Agent Patterns
| Pattern | Trigger | Action |
|---------|---------|--------|
| **Transaction Anomaly** | Real-time transaction stream | Flag outliers vs. customer baseline; soft-block + notify |
| **SAR Auto-Draft** | AML rule fires on alert | Draft SAR narrative from transaction history; route to BSA officer |
| **Loan Covenant Monitor** | Quarterly financials received | Check covenant ratios; generate breach notice if violated |
| **KYC Refresh** | Customer risk score degraded | Trigger enhanced due diligence workflow; request updated docs |
| **Regulatory Reporting** | Reporting deadline approaching | Aggregate required data; validate completeness; alert preparer |
| **Credit Decision Support** | Loan application submitted | Summarize applicant profile; flag missing docs; suggest decision |

---

## Quantitative Finance

### Regulatory Constraints (auto-applied)
- **Market manipulation rules** — agent must not submit orders that appear manipulative (spoofing, layering)
- **Best execution** — order routing decisions must be logged with rationale
- **Position limits** — agent must check real-time limits before submitting orders
- **Pre-trade risk checks** — fat-finger, margin, concentration limits applied before any order

### Quant Domain Data Model
```python
QUANT_ENTITIES = {
    "Instrument": {
        "fields": ["ISIN", "CUSIP", "ticker", "asset_class", "exchange", "currency"],
        "asset_classes": ["equity", "fixed_income", "derivative", "commodity", "fx", "crypto"]
    },
    "Order": {
        "fix_fields": {
            "11":  "ClOrdID",
            "38":  "OrderQty",
            "40":  "OrdType",  # 1=Market, 2=Limit
            "44":  "Price",
            "54":  "Side",     # 1=Buy, 2=Sell
            "55":  "Symbol",
            "60":  "TransactTime",
        }
    },
    "Signal": {
        "fields": ["signal_id", "strategy", "instrument", "direction",
                   "confidence", "generated_at", "model_version"]
    },
    "Portfolio": {
        "fields": ["portfolio_id", "benchmark", "nav", "positions", "pnl", "risk_metrics"]
    },
    "RiskMetrics": {
        "fields": ["var_1d_95", "var_1d_99", "expected_shortfall", "beta",
                   "tracking_error", "sharpe_ratio", "max_drawdown"]
    },
}
```

### Pre-trade Risk Check (mandatory gate)
```python
def pre_trade_risk_check(order: dict, portfolio: dict, limits: dict) -> dict:
    checks = {}
    # Fat finger: order value vs. ADV
    order_value = order["qty"] * order["price"]
    checks["fat_finger"] = order_value <= limits["max_order_value"]
    # Position limit
    current_position = portfolio["positions"].get(order["instrument"], 0)
    new_position = current_position + (order["qty"] if order["side"] == "buy" else -order["qty"])
    checks["position_limit"] = abs(new_position) <= limits["max_position"][order["instrument"]]
    # Concentration
    new_weight = order_value / portfolio["nav"]
    checks["concentration"] = new_weight <= limits["max_single_name_weight"]

    passed = all(checks.values())
    return {"passed": passed, "checks": checks,
            "block_reason": None if passed else [k for k, v in checks.items() if not v]}
```

---

## Insurance

### Regulatory Constraints (auto-applied)
- **NAIC model laws** — state-specific; agent must parameterize by state
- **Fair Credit Reporting Act** — adverse action notices required; explainability mandatory
- **State rate filing** — pricing agent actions must not deviate from filed rates
- **Claims settlement** — good faith obligations; time-to-settle rules by state

### Insurance Domain Data Model
```python
INSURANCE_ENTITIES = {
    "Policy":        "PolicyNumber, product, effective dates, premium, coverage limits",
    "Insured":       "Demographics, risk characteristics, underwriting history",
    "Claim":         "ClaimNumber, date of loss, coverage type, reserve, status",
    "Adjudication":  "Coverage determination, payment authorization, denial reason",
    "Reserve":       "Case reserve, IBNR, actuarial estimate",
    "Payment":       "Payment amount, payee, method, date",
    "Subrogation":   "Recovery opportunity, responsible party, recovery amount",
    "Reinsurance":   "Treaty, cession, recovery",
}

# Claims status lifecycle
CLAIM_STATUS = ["Reported", "Assigned", "Under Investigation",
                "Pending Documentation", "Approved", "Denied",
                "Paid", "Closed", "Reopened", "Subrogation"]
```

### Common Agent Patterns
| Pattern | Trigger | Action |
|---------|---------|--------|
| **FNOL Triage** | First Notice of Loss received | Extract coverage, set reserve, assign adjuster |
| **Fast-Track Settlement** | Low-complexity claim criteria met | Auto-approve and issue payment within SLA |
| **Fraud Indicator** | Claim pattern anomaly detected | Flag for SIU review; hold payment; log rationale |
| **Reserve Adequacy** | Claim age + activity triggers review | Recommend reserve adjustment based on comparable claims |
| **Renewal Risk Scoring** | Policy renewal approaching | Score renewal risk; flag high-loss-ratio accounts for underwriter |

---

## Retail / E-Commerce

### Regulatory Constraints (auto-applied)
- **PCI-DSS** — payment card data never in agent context without tokenization
- **CCPA / GDPR** — customer data rights; consent for personalization
- **Inventory accuracy** — agent actions affecting stock must reconcile in real-time

### Retail Domain Data Model
```python
RETAIL_ENTITIES = {
    "Product":      "SKU, title, description, category, price, attributes",
    "Inventory":    "SKU, location, on-hand, on-order, safety stock, reorder point",
    "Order":        "OrderID, customer, line items, total, status, channel",
    "Customer360":  "Profile, purchase history, CLV, segment, preferences",
    "Campaign":     "Target segment, channel, offer, start/end, budget",
    "Supplier":     "VendorID, lead time, terms, performance score",
    "Store":        "Location, hours, inventory, staff, sales targets",
}

# Omnichannel order status
ORDER_STATUS = ["Created", "Payment Confirmed", "Allocated", "Picked",
                "Packed", "Shipped", "Out for Delivery", "Delivered",
                "Return Initiated", "Returned", "Refunded"]
```

### Common Agent Patterns
| Pattern | Trigger | Action |
|---------|---------|--------|
| **Stockout Prevention** | Inventory < safety stock threshold | Generate PO draft; notify buyer |
| **Order Exception** | Order stuck in status > SLA | Investigate, reroute or escalate to fulfillment team |
| **Pricing Anomaly** | Competitor price change detected | Alert merchandising; suggest repricing within rules |
| **Returns Triage** | High-value return initiated | Assess condition prediction; route to best disposition |
| **Demand Signal** | Spike in search/page views | Alert replenishment; adjust safety stock |

---

## Manufacturing

### Regulatory Constraints (auto-applied)
| Standard | Requirement | Agent Implementation |
|----------|-------------|---------------------|
| **ISO 9001** | Quality management system | Non-conformance logging; CAPA workflow |
| **IEC 62443** | Industrial cybersecurity | OT/IT network segmentation; agent cannot directly control OT |
| **OSHA** | Worker safety | Safety interlock check before any production change |
| **ISO 45001** | Occupational health | Incident reporting workflow |
| **GMP (FDA 21 CFR 820)** | Medical device manufacturing | Design history file; DHR traceability |

### Manufacturing Domain Data Model
```python
MANUFACTURING_ENTITIES = {
    "Asset":         "AssetID, type, location, status, maintenance schedule",
    "WorkOrder":     "WOID, asset, type (PM/CM/PdM), priority, steps, parts",
    "BOM":           "Bill of Materials — component hierarchy, quantities, units",
    "Routing":       "Operation sequence, work centers, standard times",
    "QualityRecord": "Inspection results, defect codes, disposition (accept/reject/rework)",
    "CAPA":          "Corrective/Preventive Action — root cause, actions, effectiveness check",
    "Supplier":      "Vendor qualification, incoming inspection results, scorecard",
    "Downtime":      "Event log, cause code (OEE: planned/unplanned/quality loss)",
}

# OEE components
OEE_FORMULA = "Availability × Performance × Quality"
OEE_TARGETS = {"world_class": 0.85, "acceptable": 0.65}
```

### Common Agent Patterns
| Pattern | Trigger | Action |
|---------|---------|--------|
| **Predictive Maintenance** | Sensor anomaly / vibration threshold | Generate PdM work order; alert maintenance planner |
| **Quality Escape Detection** | Out-of-spec measurement in SPC | Hold lot; initiate CAPA; notify quality engineer |
| **OEE Daily Digest** | End of shift | Summarize OEE by line; flag top losses; recommend next shift focus |
| **Supplier Non-Conformance** | Incoming inspection failure | Auto-create NCR; notify supplier; place hold on remaining inventory |
| **Work Order Auto-Generation** | PM schedule trigger | Create work order with BOM, routing, labor estimate |

---

## Federal / Defense

### Regulatory Constraints (auto-applied)
| Framework | Requirement | Agent Implementation |
|-----------|-------------|---------------------|
| **FedRAMP** | Cloud authorization | LLM API must be FedRAMP-authorized or sovereign boundary |
| **FISMA** | Federal security controls | NIST SP 800-53 control mapping; continuous monitoring |
| **CMMC 2.0** | Defense contractor cybersecurity | Level 2/3 controls for CUI handling |
| **IL4 / IL5** | Impact level for CUI | AWS GovCloud or Azure Government only; no commercial endpoints |
| **Zero Trust (EO 14028)** | Identity-centric security | Every agent action verified; no implicit trust |
| **ITAR / EAR** | Export control | Agent must not transmit controlled technical data outside authorized boundary |
| **Privacy Act** | Federal PII | Consent, access control, system of records notice |

### Federal Domain Data Model
```python
FEDERAL_ENTITIES = {
    "Mission":      "Mission objective, priority, status, resources assigned",
    "Asset":        "Government asset, classification, custodian, location",
    "Personnel":    "Clearance level, role, assignment, training status",
    "Incident":     "Security or operational incident, CIKR sector, impact level",
    "Contract":     "Contract number, NAICS, period of performance, deliverables",
    "Finding":      "Audit finding, control deficiency, POA&M item",
    "POA&M":        "Plan of Action and Milestones — weakness, milestone, responsible party",
}

# Classification levels
CLASSIFICATION = ["UNCLASSIFIED", "CUI", "SECRET", "TOP SECRET", "TS/SCI"]
# NIST 800-53 control families (sample)
CONTROL_FAMILIES = ["AC", "AU", "CA", "CM", "IA", "IR", "MP", "PE",
                    "PL", "PM", "PS", "RA", "SA", "SC", "SI"]
```

### Common Agent Patterns
| Pattern | Trigger | Action |
|---------|---------|--------|
| **Audit Response Automation** | IG audit request received | Aggregate evidence artifacts; generate response package |
| **POA&M Tracker** | Milestone due date approaching | Alert system owner; generate status report for ISSO |
| **Insider Threat Signal** | UEBA anomaly on privileged user | Correlate badge, SIEM, DLP signals; brief security officer |
| **Contract Deliverable Monitor** | Deliverable due date approaching | Check submission status; notify CO/COTR; log in CPARS |
| **Classification Guide Check** | Document drafted | Check for CUI indicators; recommend classification markings |

---

## Energy / Utilities

### Regulatory Constraints (auto-applied)
| Standard | Requirement |
|----------|-------------|
| **NERC CIP** | Critical infrastructure protection; strict change control for bulk electric system |
| **ICS/SCADA security** | Agent must NEVER directly interface with OT control systems |
| **FERC** | Market rules; agent actions in energy markets require human approval |
| **NRC** | Nuclear — extremely conservative; agent advisory only |

### Energy Domain Data Model
```python
ENERGY_ENTITIES = {
    "Grid":          "Topology, substations, feeders, load zones",
    "Asset":         "Generator, transformer, line, protection relay — with ratings",
    "Event":         "Outage, fault, disturbance — cause, affected customers, duration",
    "Outage":        "Planned/unplanned, SAIDI/SAIFI impact, restoration steps",
    "WorkPermit":    "Energized/de-energized work authorization, switching order",
    "MarketBid":     "Day-ahead / real-time energy bid, capacity offer",
    "Meter":         "AMI meter reads, interval data, anomaly flags",
}

# OT/IT boundary — agent operates IT side only
OT_BOUNDARY_RULE = "Agent reads from historian/OSIsoft PI via OPC-UA gateway only. Never writes to DCS/PLC."
```

---

## Legal / Compliance

### Regulatory Constraints (auto-applied)
- **Attorney-client privilege** — agent must not disclose privileged communications to unauthorized parties
- **Confidentiality** — matter data scoped to authorized users only
- **Data retention** — legal hold overrides standard retention; agent must check hold status before deletion
- **e-Discovery (FRCP Rule 26)** — ESI must be preserved and producible

### Legal Domain Data Model
```python
LEGAL_ENTITIES = {
    "Matter":       "Matter number, type (litigation/regulatory/transactional), status, parties",
    "Contract":     "Agreement type, parties, term, obligations, renewal dates",
    "Obligation":   "Contract clause, owner, due date, compliance status",
    "Risk":         "Risk description, likelihood, impact, mitigation, residual risk",
    "Policy":       "Internal policy, version, owner, review date, attestations",
    "Incident":     "Compliance incident, regulatory notification requirement, remediation",
    "LegalHold":    "Custodian, scope, date placed, date released",
}
```

### Common Agent Patterns
| Pattern | Trigger | Action |
|---------|---------|--------|
| **Contract Expiry Alert** | Obligation due date within 30/60/90 days | Alert contract owner; draft renewal summary |
| **Regulatory Change Monitor** | New regulation published | Summarize impact on active policies; flag gaps |
| **Obligation Compliance Check** | Periodic — per obligation schedule | Verify evidence of compliance; flag overdue items |
| **Legal Hold Automation** | Litigation hold triggered | Identify custodians; preserve ESI; send hold notice |
| **Policy Attestation Campaign** | Annual cycle | Route policies to required attestors; track completion |

---

## Cross-Industry Compliance Matrix

| Constraint | Healthcare | Life Sciences | Banking | Federal | Manufacturing |
|-----------|-----------|--------------|---------|---------|---------------|
| Audit trail | HIPAA | 21 CFR Pt 11 | SOX | FISMA | ISO 9001 |
| Data encryption | HIPAA | GxP | PCI | FISMA | varies |
| Human approval gate | Always | Always for data change | Financial transactions | IL4+ | Safety-critical |
| PII/PHI handling | De-identify | De-identify | Tokenize PAN | Privacy Act | Employee PII |
| Explainability | FFIEC model risk | GCP | SR 11-7 | OMB | ISO 9001 |
| Immutable logs | Required | Required | Required | Required | Recommended |
| Sovereign boundary | BAA required | BAA required | GLBA | FedRAMP/GovCloud | varies |

---

## Domain Signal Vocabulary

Quick-reference for detecting industry from natural speech:

| Keyword heard | Likely industry | Domain hint |
|--------------|----------------|-------------|
| patient, EHR, clinical, diagnosis, medication, encounter | Healthcare | FHIR, HIPAA |
| trial, subject, CRF, protocol, adverse event, IND, NDA | Life Sciences | 21 CFR Part 11 |
| trade, position, portfolio, alpha, signal, PnL, execution | Quant Finance | FIX, low-latency |
| loan, deposit, AML, KYC, SAR, fraud, transaction | Banking/Fintech | BSA, SOX |
| claim, policy, adjuster, reserve, subrogation, FNOL | Insurance | NAIC |
| SKU, inventory, order, fulfillment, merchant, warehouse | Retail | PCI |
| work order, downtime, OEE, BOM, quality, NCR, CAPA | Manufacturing | ISO 9001 |
| clearance, mission, FISMA, FedRAMP, CUI, TS/SCI | Federal/Defense | CMMC, IL4+ |
| grid, outage, SCADA, substation, MW, feeder, AMI | Energy/Utilities | NERC CIP |
| matter, contract, obligation, privilege, hold, eDiscovery | Legal/Compliance | FRCP |
