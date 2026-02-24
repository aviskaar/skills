# Industry Vertical Playbooks

Apply the matching playbook after identifying the target company's industry vertical. Each playbook defines: priority focus areas, likely technology platforms, typical spending patterns, likely incumbents, and the most compelling entry points.

---

## HOW TO USE

1. Identify the vertical from research (usually obvious from the company's products and markets)
2. Load this playbook to calibrate Section 4 (Strategic Priorities), Section 5 (Tech Spending), Section 7 (Tech Stack), and Section 8 (Opportunity Map)
3. Where this playbook says "likely," apply an [ASSUMPTION — vertical standard for this company size] flag
4. Where this playbook says "confirm," this is a mandatory research check before including it

---

## VERTICAL 1 — LIFE SCIENCES: PHARMA / BIOTECH

### Priority Focus Areas
| Area | Why It Matters | Typical Budget Driver |
|---|---|---|
| Commercial launch infrastructure | Every new product requires CRM, HCP engagement, sample management, and patient services IT | Upcoming NDA/BLA approval or launch |
| Pharmacovigilance / safety reporting | Global regulatory mandate — penalties for non-compliance | FAERS, EudraVigilance, ICH E2B compliance |
| Clinical trial systems | EDC, CTMS, eTMF modernization; Decentralized clinical trials adding complexity | Active Phase 2/3 pipeline |
| Regulatory submissions technology | NDA/BLA/MAA eCTD submission and lifecycle management | Imminent submission deadlines |
| SAP S/4HANA migration | Most large pharma still on SAP ECC 6.0; 2027 EOM creates hard deadline | 2027 SAP deadline |
| Gross-to-net / finance transformation | Price reporting, Medicaid rebates, chargebacks — complex reconciliation | Revenue recognition accuracy |

### Likely Technology Platforms
| Platform | Confidence | Basis |
|---|---|---|
| SAP ECC or S/4HANA | High — confirm | Industry standard; >80% of large pharma |
| Veeva Vault (QMS, RIM, or eTMF) | High — confirm | Veeva dominates life sciences content management |
| Veeva CRM or OCE | High for commercial stage | Dominant in pharma field force |
| Oracle Argus or ARISg | Medium — confirm | Pharmacovigilance leaders |
| Medidata Rave or Oracle InForm | Medium | EDC leaders in clinical trials |
| Workday (HCM/Finance) | Medium — confirm | Common in mid-large pharma |
| Azure or AWS | Medium — confirm | Most pharma running hybrid cloud |
| Salesforce Health Cloud | Lower | Emerging in patient services / market access |

### Likely Incumbents
- **Accenture / Infosys / Cognizant / TCS / Wipro** — large pharma SAP and managed services
- **Deloitte / KPMG / EY** — regulatory and compliance advisory
- **Veeva Systems** — platform; often also implementation consulting
- **IQVIA / Syneos / Parexel** — clinical operations and technology

### Entry Points (ranked)
1. New CIO or CDO (< 18 months) evaluating inherited landscape
2. Upcoming commercial launch (within 18 months) requiring launch IT stack
3. Pharmacovigilance system gap or regulatory finding
4. SAP S/4HANA migration program starting
5. Post-acquisition integration

---

## VERTICAL 2 — LIFE SCIENCES: MEDICAL DEVICES / MEDTECH

### Priority Focus Areas
| Area | Why It Matters | Typical Budget Driver |
|---|---|---|
| FDA compliance and QMS | 21 CFR Part 820 / ISO 13485 mandate; warning letters create urgency | FDA inspection, 483 observations |
| EU MDR compliance | EU Medical Device Regulation — significant documentation and UDI requirements | May 2024 MDR deadline (many still complying) |
| Manufacturing ERP | Production, quality, serialization/UDI, and supply chain in a regulated environment | SAP/Oracle modernization |
| Connected device / IoT platform | Collecting and analyzing device field data at scale | New product lines with connected sensors |
| Post-acquisition integration | Medtech M&A rate is high; each deal creates ERP, QMS, and CRM consolidation work | Recent acquisition close |
| Service and field force management | Technician dispatching, service contracts, remote diagnostics | Installed base growth |

### Likely Technology Platforms
| Platform | Confidence | Basis |
|---|---|---|
| SAP (ECC or S/4HANA) | High — confirm | Standard for large MedTech manufacturing |
| Oracle ERP (Cloud or E-Business Suite) | Medium — confirm | Alternative to SAP in mid-market |
| Veeva Quality or TrackWise (Honeywell) | Medium — confirm | QMS leaders in MedTech |
| Salesforce (CRM / Field Service) | Medium — confirm | Common for capital equipment and service |
| Azure IoT or AWS IoT | Medium | Standard connected device backend |
| Workday | Medium | Common in $1B+ MedTech |
| Agile PLM or Windchill | Medium | Product lifecycle management |

### Likely Incumbents
- **Deloitte / Accenture / PwC** — regulatory advisory, SAP
- **DXC / HCL** — infrastructure and managed services
- **Cognizant / Infosys** — SAP and application services

### Entry Points (ranked)
1. FDA warning letter or 483 observation requiring QMS remediation
2. EU MDR compliance program still in progress
3. Post-acquisition ERP and QMS integration
4. S/4HANA migration (2027 deadline)
5. Connected device platform build

---

## VERTICAL 3 — LIFE SCIENCES: GENOMICS / DIAGNOSTICS

### Priority Focus Areas
| Area | Why It Matters | Typical Budget Driver |
|---|---|---|
| Cloud bioinformatics platform | NGS data at scale requires AWS/Azure HPC infrastructure | New sequencing product launch |
| Clinical market IT readiness | CLIA certification, LIS/EHR integration, patient data governance | Moving from research to clinical use |
| NGS data infrastructure | Variant databases, pipeline automation, storage/compute at scale | Volume growth |
| Post-merger data consolidation | Diagnostics sector consolidating rapidly | Recent acquisition |
| Commercial CRM / market access | Salesforce or Veeva for payer contracting and physician outreach | Lab or diagnostic test commercialization |
| LIMS modernization | Lab information management — often on legacy systems | Scaling throughput |

### Likely Technology Platforms
| Platform | Confidence | Basis |
|---|---|---|
| AWS or Azure (primary cloud) | High — confirm | Industry standard for genomics compute |
| LIMS (LabVantage, STARLIMS, or custom) | High — confirm | All sequencing labs run a LIMS |
| Salesforce or Veeva CRM | Medium | Commercialization requirement |
| Snowflake or Databricks | Medium | Common data platform in genomics |
| Informatica or custom ETL | Medium | Data integration for multi-source pipelines |

### Entry Points
1. Clinical market entry (research → diagnostic use requires full IT stack rebuild)
2. Post-merger data consolidation
3. NGS platform scale-out (throughput growth driving infrastructure investment)
4. LIMS modernization (frequently deferred until it becomes a bottleneck)

---

## VERTICAL 4 — FINANCIAL SERVICES: BANKING

### Priority Focus Areas
| Area | Why It Matters | Typical Budget Driver |
|---|---|---|
| Core banking modernization | Legacy mainframe platforms reaching end of support; competitive pressure from digital challengers | Competitive differentiation, cost |
| Digital banking platform | Mobile and web banking rebuild for customer experience | Customer retention, acquisition |
| Regulatory compliance technology | Basel III/IV, stress testing, AML/BSA, CRA — ongoing regulatory change | Exam findings, regulatory mandate |
| AI in fraud detection and credit risk | Real-time fraud scoring, credit model modernization | Loss reduction, regulatory pressure |
| Data platform and analytics | Risk reporting, customer 360, regulatory reporting | Cost of manual reconciliation |
| Post-merger integration | Bank M&A creates core systems consolidation requirement | Acquisition close |

### Likely Technology Platforms
| Platform | Confidence | Basis |
|---|---|---|
| Temenos, FIS, or Fiserv (core banking) | High — confirm | Three platforms dominate community/regional banking |
| Salesforce Financial Services Cloud | Medium — confirm | Common in relationship banking and wealth |
| Pega (case management / lending) | Medium | Common in loan origination and servicing |
| Workday | Medium | Common for HR/Finance in $5B+ banks |
| Snowflake | Medium | Common data platform |
| Azure or AWS | Medium | Banking cloud adoption accelerating |
| Murex / Finastra (capital markets) | High for capital markets banks — confirm | Standard in trading and treasury |

### Likely Incumbents
- **Accenture / Deloitte / IBM** — large bank transformation programs
- **Cognizant / Infosys / TCS / Wipro** — application development and managed services
- **FIS / Fiserv / Jack Henry** — core banking platform and services bundled

### Entry Points (ranked)
1. Core banking modernization program (identified by IT leadership commentary or vendor end-of-life)
2. New CIO (< 18 months) evaluating vendor portfolio
3. Post-acquisition integration
4. Regulatory finding requiring system remediation
5. Digital banking platform rebuild

---

## VERTICAL 5 — FINANCIAL SERVICES: INSURANCE

### Priority Focus Areas
| Area | Why It Matters | Typical Budget Driver |
|---|---|---|
| Policy administration modernization | Legacy PAS systems (30+ years old) being replaced by Guidewire, Duck Creek, Majesco | Platform end-of-life, competitive pressure |
| IFRS 17 compliance | New accounting standard for insurance contracts — required globally | Regulatory deadline |
| Claims automation | Straight-through processing, AI-assisted claims adjudication | Loss ratio improvement |
| Distribution platform digitization | Agent portal, API-first product configuration, digital quote-bind | Broker channel competition |
| Actuarial and pricing technology | Catastrophe modeling, rate filing, predictive pricing | Profitability improvement |
| Customer experience modernization | Policy self-service, first notice of loss, digital servicing | Customer retention |

### Likely Technology Platforms
| Platform | Confidence | Basis |
|---|---|---|
| Guidewire (P&C) | High — confirm | Market leader in P&C policy admin and claims |
| Duck Creek (P&C) | Medium — confirm | Strong challenger to Guidewire |
| Majesco (Life/P&C) | Medium | Mid-market leader |
| Salesforce (agent CRM) | Medium | Common in distribution management |
| Snowflake | Medium | Common data platform |
| Workday | Medium | Common in $5B+ carriers |

### Entry Points (ranked)
1. Policy admin replacement program (Guidewire or Duck Creek migration)
2. IFRS 17 compliance program
3. Claims automation initiative
4. Post-merger consolidation

---

## VERTICAL 6 — RETAIL / CONSUMER

### Priority Focus Areas
| Area | Why It Matters | Typical Budget Driver |
|---|---|---|
| Unified commerce / OMS | Omnichannel fulfillment requires a single inventory and order view | Online + store channel growth |
| Supply chain resilience | Post-COVID supply chain visibility and diversification | Inventory accuracy, stockout reduction |
| Loyalty platform modernization | Legacy loyalty points systems being replaced by modern composable platforms | Customer lifetime value |
| AI in merchandising and forecasting | Demand planning, assortment optimization, markdown optimization | Gross margin improvement |
| ERP modernization (SAP/Oracle) | Many large retailers still on legacy ERP; S/4HANA deadline 2027 | Cost reduction, SAP deadline |
| Customer data platform | Unified customer identity for personalization across channels | Marketing efficiency |

### Likely Technology Platforms
| Platform | Confidence | Basis |
|---|---|---|
| SAP (retail) or Oracle Retail | High — confirm | Standard in $1B+ retail |
| Salesforce Commerce Cloud | Medium — confirm | Common in direct-to-consumer |
| Blue Yonder or Manhattan Associates | Medium — confirm | Supply chain leaders |
| Snowflake or Databricks | Medium | Common analytics platform |
| Workday | Medium | Common HCM in large retail |
| Salesforce (CRM/loyalty) | Medium | Common in enterprise retail |

### Entry Points (ranked)
1. Unified commerce platform program (triggered by OMS job postings or announcements)
2. SAP S/4HANA migration (2027 deadline)
3. Supply chain platform modernization
4. Loyalty platform replacement

---

## VERTICAL 7 — MANUFACTURING / INDUSTRIAL

### Priority Focus Areas
| Area | Why It Matters | Typical Budget Driver |
|---|---|---|
| SAP S/4HANA migration | 2027 SAP ECC end-of-maintenance deadline — the most broadly funded program in manufacturing right now | Hard 2027 deadline |
| Smart factory / IoT platform | OT/IT convergence, production monitoring, quality sensing | Productivity and quality improvement |
| Predictive maintenance | Reducing unplanned downtime through sensor analytics | Maintenance cost reduction |
| Post-acquisition ERP consolidation | Manufacturing M&A drives ERP harmonization needs | Acquisition close |
| Workforce skills and training technology | Technical workforce shortage; skills tracking and reskilling platforms | Retention and productivity |
| Supply chain planning modernization | Demand-supply synchronization, supplier visibility | Working capital improvement |

### Likely Technology Platforms
| Platform | Confidence | Basis |
|---|---|---|
| SAP (ECC → S/4HANA) | Very High — confirm | SAP dominates large manufacturing |
| Siemens Opcenter or Dassault | Medium — confirm for discrete mfg | MES leaders |
| PTC ThingWorx or GE Predix | Medium | IoT platform leaders |
| Workday | Medium | Common HCM in large manufacturing |
| Salesforce (CRM) | Medium | Common in industrial distribution channels |
| Blue Yonder (supply chain) | Medium | Dominant in manufacturing supply chain |

### Entry Points (ranked)
1. SAP S/4HANA migration (every large manufacturer is somewhere on this path)
2. Smart factory / IoT program
3. Post-acquisition integration
4. Predictive maintenance platform

---

## VERTICAL 8 — ENERGY / UTILITIES

### Priority Focus Areas
| Area | Why It Matters | Typical Budget Driver |
|---|---|---|
| Grid modernization (AMI, ADMS, DERMS) | AMI deployments, advanced distribution management, distributed energy resource management | Rate case recovery, regulatory mandate |
| OT/IT cybersecurity convergence | NERC CIP compliance; OT systems increasingly connected to enterprise IT | NERC CIP audits, ransomware incidents |
| Renewable integration | Wind and solar dispatching, storage management, forecasting | State renewable portfolio standards |
| Customer experience / CIS modernization | Legacy customer information systems being replaced | Customer satisfaction, regulatory pressure |
| Workforce management | Field technician scheduling, work order management, safety compliance | O&M cost reduction |
| Asset management platform | EAM and GIS integration for transmission and distribution assets | Capital program efficiency |

### Likely Technology Platforms
| Platform | Confidence | Basis |
|---|---|---|
| SAP IS-U or SAP S/4HANA Utilities | High — confirm | Standard in large IOUs |
| Oracle Utilities (CC&B / Customer Cloud Service) | Medium — confirm | Strong in municipal and co-ops |
| IBM Maximo | Medium — confirm | EAM leader in utilities |
| Salesforce Energy & Utilities Cloud | Medium | Emerging in customer experience |
| Itron (AMI platform) | Medium — confirm | Dominant in smart metering |
| Azure or AWS | Medium | Utility cloud adoption accelerating |

### Entry Points (ranked)
1. Grid modernization program (AMI or ADMS — identify from rate case or press release)
2. OT/IT cybersecurity (NERC CIP gap assessment or recent audit finding)
3. CIS replacement program
4. SAP S/4HANA migration

---

## VERTICAL 9 — TECHNOLOGY / SOFTWARE

### Priority Focus Areas
| Area | Why It Matters | Typical Budget Driver |
|---|---|---|
| Post-acquisition system integration | M&A rate in tech is high; CRM, finance, and HR consolidation always follows | Acquisition close |
| AI product infrastructure | LLM integration, MLOps, vector databases, inference infrastructure | Product differentiation |
| GTM systems modernization | Salesforce, Gainsight, Clari, Outreach — CRO-driven investment | Revenue efficiency |
| Public company finance readiness | IPO or recent public = Workday, Coupa, and financial reporting upgrade | Compliance requirement |
| Data platform | Snowflake, Databricks — revenue analytics and product telemetry | Business intelligence |
| Engineering platform / DevSecOps | GitHub Enterprise, security scanning, developer experience tooling | Developer productivity |

### Likely Technology Platforms
| Platform | Confidence | Basis |
|---|---|---|
| Salesforce (CRM) | Very High — confirm | Near-universal in enterprise SaaS |
| Workday (HCM/Finance) | High — confirm | Standard for $100M+ tech companies |
| Snowflake or Databricks | Medium — confirm | Data platform leaders in tech |
| GitHub Enterprise or GitLab | Medium | Engineering platform leaders |
| Gainsight or Totango | Medium | Customer success platforms in SaaS |
| AWS or GCP or Azure | High — confirm | All tech companies run on one or more |

### Entry Points (ranked)
1. Post-acquisition integration (search for recent acquisitions in last 12 months)
2. New CIO or CFO (< 18 months) evaluating inherited vendor portfolio
3. IPO-readiness or post-IPO finance/HR systems upgrade
4. GTM systems consolidation (CRO-driven)

---

## VERTICAL 10 — HEALTHCARE PROVIDERS / PAYERS

### Priority Focus Areas
| Area | Why It Matters | Typical Budget Driver |
|---|---|---|
| EHR optimization (Epic/Cerner) | Most large health systems have Epic or Cerner; post-go-live optimization and analytics are evergreen | Go-live readiness, post-live performance |
| Revenue cycle management | Coding accuracy, denials management, prior authorization automation | Revenue leakage recovery |
| Prior authorization automation | CMS final rule (effective Jan 2026) mandates prior auth API; compliance + efficiency | Regulatory compliance |
| Clinical analytics and population health | Value-based care programs require patient stratification and outcomes reporting | VBC contract requirements |
| Workforce management | Nurse and clinical staff scheduling, vacancy management | Labor cost reduction |
| Payer-provider data exchange | FHIR APIs, interoperability mandate compliance | CMS interoperability rule |

### Likely Technology Platforms
| Platform | Confidence | Basis |
|---|---|---|
| Epic or Oracle Health (Cerner) | Very High — confirm | 90%+ of large health systems |
| Workday | High — confirm | Standard HCM in large health systems |
| ServiceNow (ITSM) | Medium — confirm | Common in health system IT operations |
| Salesforce Health Cloud | Medium | Emerging in patient engagement and payer CRM |
| Infor (Lawson) | Medium — confirm | Legacy ERP at many health systems; being replaced |
| IBM Watson Health / Merative | Low (declining) | Verify before citing |

### Entry Points (ranked)
1. Epic or Cerner optimization (post-go-live is the perpetual need)
2. Prior authorization automation (CMS compliance deadline)
3. Revenue cycle performance improvement
4. Workforce management system replacement (Infor or legacy system)

---

## VERTICAL 11 — FEDERAL / GOVERNMENT

### Priority Focus Areas
| Area | Why It Matters | Typical Budget Driver |
|---|---|---|
| IT Modernization (TMF, FITARA) | Technology Modernization Fund provides central funding for agencies; FITARA requires CIO authority | OMB mandate, TMF application |
| Zero Trust Architecture | OMB M-22-09 mandates ZTA by Sept 2024 (most agencies still implementing) | OMB deadline, CISA guidance |
| Cloud migration (Cloud-First/Smart) | Cloud-first policy; FedRAMP-authorized platforms required | OMB Cloud Smart policy |
| CDM (Continuous Diagnostics and Mitigation) | DHS-run program; agencies must participate; tools deployment and integration ongoing | DHS mandate |
| ERP modernization | Many agencies on legacy financial and HR systems (JIRA → Oracle Federal Financials → Workday) | CFO Act compliance, GAO findings |
| Cybersecurity (CMMC for DoD, FISMA) | CMMC 2.0 is now in effect for DoD contractors; FISMA compliance is annual | FedRAMP ATO, CMMC compliance |

### Contract Vehicles to Reference
| Vehicle | Scope | Notes |
|---|---|---|
| CIO-SP4 | IT services — government-wide | NITAAC-managed; verify award status |
| SEWP VI | Products and services — government-wide | NASA-managed |
| GSA MAS (IT Schedule 70) | IT products and services | Open market; most common |
| OASIS+ | Professional services | GSA-managed; replaces OASIS |
| Alliant 3 | Complex IT services | GSA-managed; high-value contracts |
| Agency-specific IDIQ | Varies by agency | Check SAM.gov for agency-specific vehicles |

### Likely Incumbents
- **Booz Allen Hamilton / SAIC / Leidos / MITRE** — large IT program integrators
- **Accenture Federal / Deloitte Federal / KPMG Federal** — management consulting + IT
- **IBM / HPE / Dell** — infrastructure and legacy system management
- **CGI Federal / GDIT / Maximus** — ERP, benefits, and agency-specific systems

### Entry Points (ranked)
1. Active RFP or Sources Sought on SAM.gov (respond directly)
2. IT Modernization Plan published — request a capabilities briefing
3. Contract recompete approaching (within 18 months of expiration)
4. OIG or GAO finding that mandates a specific remediation
5. New Agency CIO appointment

### Federal-Specific Research Sources
| Source | What to Find There |
|---|---|
| SAM.gov | Contract awards, RFPs, Sources Sought, capability statements |
| USASpending.gov | Contract award values, prime contractors by agency |
| FITARA Scorecard | Agency-by-agency IT grades — gaps = opportunities |
| CIO.gov | Agency IT leadership directory |
| GAO Reports (gao.gov) | High-risk areas, IT management findings |
| OIG Reports (agency-specific) | Findings that require funded remediation |
| Congress.gov (appropriations) | Budget line items for specific programs |
| FedBizOpps via SAM.gov | Current solicitations |

---

## CROSS-VERTICAL PATTERNS

### SAP S/4HANA Migration — Universal Signal
Applies to: Manufacturing, Pharma, Retail, Utilities, Financial Services, Federal ERP
- SAP ECC end-of-maintenance is Jan 1, 2027 (extended maintenance available until 2030, at cost)
- Every company on SAP ECC is somewhere on the migration decision path
- The program is large enough to require an SI for any company > $500M revenue
- Signal: open "SAP S/4HANA" job postings = program is funded and staffed
- Signal: no SAP postings + large ECC deployment = decision not yet made = entry point

### Workday — Universal HCM Signal
Applies to all verticals above $200M revenue
- Workday has ~50% market share in enterprise HCM for companies $200M–$5B
- If Workday is confirmed, ask about implementation quality and optimization needs
- If Workday is not confirmed and company is > $200M, it is either on Oracle HCM, SAP SuccessFactors, or an older system — all of which are Workday migration candidates

### New Leader Rule (Universal)
A C-suite executive who joined < 18 months ago is in their "evaluation window":
- They are still forming their vendor and partner opinions
- They have not yet fully committed to an incumbent's renewal
- They may be actively looking for a win to establish their own program
- They are more likely to take a meeting than an entrenched leader
- The entry pitch should be: "We know your inherited stack; here's what we see"
