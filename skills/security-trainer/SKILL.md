---
name: security-trainer
description: "Use this skill when you need security awareness training program design, phishing simulation campaigns, role-based security curriculum development, CISO dashboard design, security metrics reporting, social engineering defense training, developer secure coding training, AI security awareness training, regulatory compliance training (GDPR, HIPAA, PCI), new employee security onboarding, or tabletop exercise facilitation. Trigger for annual training programs, new hire onboarding, or security culture improvement initiatives."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [security-training, awareness, phishing-simulation, secure-coding, ciso-dashboard, tabletop-exercise, social-engineering-defense, compliance-training, security-culture]
---

# Security Trainer — Security Awareness, Training & CISO Reporting Specialist

## Role

The Security Trainer designs and delivers security awareness programs, phishing simulations, role-based training curricula, and executive reporting dashboards. This skill builds human security defenses — transforming employees from the weakest link into an active security layer.

---

## Phase 1 — Training Program Architecture

**Role-Based Training Curriculum:**

```
TIER 1 — ALL EMPLOYEES (mandatory, annual):
Duration: 60–90 minutes total; delivered in 5–10 min modules
Topics:
  □ Security awareness fundamentals (what is cybersecurity? why does it matter?)
  □ Phishing recognition and reporting (email, SMS, voice, QR codes)
  □ Password hygiene and MFA (why, how, and what to do if compromised)
  □ Data classification and handling (what to share, with whom, how)
  □ Clean desk and screen lock policy (physical security basics)
  □ Incident reporting (how and when to report suspicious activity)
  □ Social engineering defense (recognize and resist manipulation)
  □ Remote work security (home network, VPN, public Wi-Fi)
  □ Acceptable use policy (what you can and cannot do on company systems)
Completion target: 100% by day 30 of employment; 100% annual renewal
Certification: Completion certificate issued; recorded in LMS

TIER 2 — PRIVILEGED USERS (additional, semi-annual):
Target: Anyone with admin rights, developer access, finance/HR access
Duration: 45 minutes additional per cycle
Topics:
  □ Privileged access responsibilities and risks
  □ Secure credential management (PAM, vault, no sharing)
  □ Insider threat awareness (how it happens; how to report suspicion)
  □ Advanced phishing (spear phishing, whaling, BEC recognition)
  □ Security monitoring: what SOC watches and why logging matters
  □ Change management security requirements
  □ Secure remote access (VPN, zero trust, bastion host use)

TIER 3 — DEVELOPERS (additional, quarterly):
Target: Engineers, DevOps, data scientists, ML engineers
Duration: 2–4 hours per quarter (module-based)
Topics:
  □ Secure coding practices (OWASP Top 10 with code examples)
  □ Secrets management (how to use vault; never in code)
  □ Dependency security (SCA, SBOM, license compliance)
  □ Threat modeling (STRIDE; how to run a threat model session)
  □ Security in CI/CD (SAST/DAST tools and interpreting results)
  □ API security (authentication, authorization, input validation)
  □ Container and cloud security (IaC scanning, least privilege)
  □ AI/LLM security (prompt injection, secure AI integration patterns)
  □ Incident response for developers (what to do when you find a bug)

TIER 4 — EXECUTIVES & BOARD (annual + ad-hoc):
Target: C-suite, board members, senior leadership
Duration: 2–3 hours annually; 30-minute briefings quarterly
Topics:
  □ Cyber threat landscape (what adversaries target executives)
  □ Business Email Compromise (BEC) and whaling defense
  □ Executive digital hygiene (personal device, travel, social media)
  □ Board oversight responsibilities (governance, risk, compliance)
  □ AI and emerging threat briefing (current risk landscape)
  □ Incident response role of leadership (decisions, communications)
  □ Regulatory landscape update (new laws, penalties, peer incidents)

TIER 5 — AI/DATA TEAMS (additional, quarterly):
Target: Data scientists, ML engineers, AI product managers
Topics:
  □ Responsible AI and ethics
  □ PII in AI pipelines (what to do, what to avoid)
  □ Prompt injection and AI-specific threats
  □ Data governance and model governance
  □ EU AI Act and regulatory AI compliance
  □ Hallucination risks and validation strategies
```

---

## Phase 2 — Phishing Simulation Program

**Phishing simulation framework:**

```
Campaign Cadence:
- Monthly: broad phishing simulation (all employees)
- Quarterly: targeted spear phishing (executives + high-risk roles)
- Semi-annual: vishing (voice phishing) simulation
- Annual: physical social engineering + USB drop test

Campaign Design Principles:
1. Realistic but safe: mimic real-world tactics without causing harm
2. Educational not punitive: failure triggers training, not discipline (first offense)
3. Escalating difficulty: start easy; increase sophistication quarterly
4. Varied techniques: credential harvest, malicious attachment, QR code, link

Phishing Template Categories (rotate monthly):
  □ Package delivery notification (FedEx/UPS/DHL impersonation)
  □ IT helpdesk: password expiry, account suspended
  □ HR: benefits update, policy acknowledgment required
  □ Finance: invoice approval, wire transfer request (whaling for executives)
  □ Executive communication: urgent action required from "CEO"
  □ Software update: VPN/Zoom/Teams/Slack update required
  □ Shared document: "Someone shared a file with you" (O365/Google Drive)
  □ QR code: scan to access your performance review
  □ Job offer / recruiter (LinkedIn-style)
  □ AI-generated personalized spear phish (quarterly advanced campaign)

Measurement Framework:
Metric                      Target          Action if Missed
Click rate                  <15%            Immediate targeted training
Credential entry rate       <5%             Mandatory training; CISO notified if >15%
Report rate                 >30%            Celebrate reporters; analyze why low
Time to SOC detection       <30 min         SOC process review if >2h
Repeat offenders (3+)       <2%             Manager conversation + mandatory training

Post-Click Response:
1. Immediate: redirect clicker to training landing page ("You were phished!")
2. Auto-enroll: clicker auto-enrolled in 15-min targeted phishing training module
3. No shaming: training focuses on education; incident not shared with manager (first offense)
4. Manager notification: only if 3rd offense within 12 months
5. Exclusions: notify CISO if C-suite click rate is high (executive briefing needed)
```

---

## Phase 3 — Social Engineering Defense Training

**Social engineering scenarios and defenses:**

```
Attack Scenario Training Modules:

Module 1: Recognizing Phishing
  - What to look for: sender address anomalies, urgency, suspicious links, unexpected requests
  - Real examples: show sanitized real-world attacks used against similar organizations
  - Test: identify phishing vs. legitimate email (quiz format)
  - Response: use "Report Phishing" button; do NOT click links; do NOT download attachments

Module 2: BEC (Business Email Compromise)
  - Pattern: executive impersonation requesting urgent wire transfer or gift cards
  - Defense: always verify via phone call using a known number (not reply-to)
  - Company policy: no wire transfer without verbal confirmation + dual approval
  - Real impact: BEC caused $2.9B in losses in 2023 (FBI IC3)

Module 3: Vishing (Voice Phishing)
  - Scenario: "IT helpdesk" calls asking for password/MFA code; "Microsoft" calling about virus
  - Defense: IT will NEVER ask for your password or MFA code by phone
  - Response: ask for name + badge ID; call back through official directory number; report to security
  - Verification protocol: use callback verification for any unsolicited IT/finance calls

Module 4: Physical Social Engineering
  - Tailgating: never let unauthorized person follow you through secured door (be polite but firm)
  - Impersonation: verify vendor/contractor identity through facilities; do not trust badge alone
  - USB drops: never plug in unknown USB devices; report found devices to IT immediately
  - Clean desk: lock screen when leaving desk; no passwords on Post-its; shred sensitive documents

Module 5: AI-Enhanced Social Engineering
  - Deepfake audio/video: adversaries can clone executive voice and video
  - Defense: establish code words for sensitive requests; verify through secondary channel
  - AI-generated spear phishing: hyper-personalized; look for urgency + unusual requests
  - Response: same as phishing; when in doubt, pick up the phone and verify
```

---

## Phase 4 — Tabletop Exercise Design

**Security tabletop exercise framework:**

```
Exercise Types:
1. Discussion-based (tabletop): talk through scenario; no systems touched
2. Functional: test specific functions (communications, notifications)
3. Full-scale: simulate full incident with real system interactions

Annual Tabletop Schedule (minimum):
Q1: Ransomware attack scenario
Q2: Data breach / insider threat scenario
Q3: Third-party / supply chain compromise
Q4: AI system failure / misuse scenario

Tabletop Facilitation Template:

PRE-EXERCISE SETUP:
□ Scenario development: realistic, based on current threat landscape
□ Injects: 5–8 escalating "news" items that evolve the scenario
□ Participants: CISO, Legal, IR team, IT, Communications, relevant business owners
□ Facilitator: internal (security team lead) or external firm
□ Observer notes: record gaps and decision points for debrief

EXERCISE FLOW (3–4 hours):
Hour 1: Scene-setting + initial response (what do you do first?)
Hour 2: Escalation + stakeholder communication decisions
Hour 3: Regulatory notification decision points + business impact
Hour 4: Recovery and post-incident (debrief + lessons)

INJECTS (sample for ransomware scenario):
  T+0min: SOC alert fires — suspicious encryption activity on file server
  T+15min: IT confirms ransomware; 50 servers encrypted; more encrypting
  T+30min: Ransom note discovered; $2M in Bitcoin; 72h deadline
  T+45min: News: journalists have been tipped off; social media posts appearing
  T+60min: Legal: if >500 customers affected, HIPAA notification required
  T+90min: Board Chair calls CEO asking for status; investor relations concerned
  T+120min: FBI contacts company; evidence of nation-state involvement

POST-EXERCISE DEBRIEF:
□ What worked well? (communication, decision speed, technical response)
□ What gaps were identified? (missing playbooks, unclear ownership)
□ What decisions were hardest? (regulatory notification, ransom, public comms)
□ Action items: specific, owned, time-bound improvements
□ Update IR playbooks based on gaps identified
□ Schedule next exercise before leaving room
```

---

## Phase 5 — CISO Security Dashboard Design

**CISO Operational Dashboard (real-time, weekly review):**

```
╔══════════════════════════════════════════════════════════════════╗
║              CISO SECURITY DASHBOARD — [Date/Period]            ║
╠══════════════════════════════════════════════════════════════════╣
║  OVERALL SECURITY POSTURE: [🔴 Critical / 🟡 Caution / 🟢 Good] ║
╠════════════════════════╦═════════════════════════════════════════╣
║  ACTIVE THREATS        ║  COMPLIANCE POSTURE                     ║
║  P1 Incidents: [N]     ║  SOC 2: [PASS/FAIL] — Audit: [Date]    ║
║  P2 Incidents: [N]     ║  ISO 27001: [PASS/FAIL] — Cert: [Date] ║
║  Open Critical CVEs:[N]║  GDPR: [COMPLIANT/GAPS]                 ║
║  Threat Alerts:[N/day] ║  HIPAA: [COMPLIANT/GAPS]               ║
╠════════════════════════╬═════════════════════════════════════════╣
║  DETECTION & RESPONSE  ║  IDENTITY & ACCESS                      ║
║  MTTD: [Xh] (T:<1h)    ║  MFA Enrollment: [X%] (T:100%)         ║
║  MTTR: [Xh] (T:<4h)    ║  Privileged Accounts: [N]               ║
║  Alert Volume: [N/day] ║  Orphan Accounts: [N] (T:0)            ║
║  FP Rate: [X%] (T:<10%)║  Access Reviews Due: [N]               ║
╠════════════════════════╬═════════════════════════════════════════╣
║  VULNERABILITY MGMT    ║  SECURITY TRAINING                      ║
║  Critical Open: [N]    ║  Training Completion: [X%] (T:100%)    ║
║  High Open: [N]        ║  Phishing Click Rate: [X%] (T:<5%)     ║
║  Patch Compliance: [X%]║  Overdue Training: [N employees]        ║
║  Pen Test: [Status]    ║  Last Tabletop: [Date]                 ║
╠════════════════════════╬═════════════════════════════════════════╣
║  CLOUD & INFRA         ║  AI SECURITY                           ║
║  CSPM Score: [X/100]   ║  AI Systems Deployed: [N]              ║
║  Cert Expiring <30d:[N]║  AI Incidents: [N]                     ║
║  Public Buckets: [N]   ║  Hallucination Rate: [X%]              ║
║  Firewall Rules >1yr:  ║  HITL Bypass Attempts: [N]             ║
║  [N rules for review]  ║  PII Exposure Incidents: [N]           ║
╠════════════════════════╩═════════════════════════════════════════╣
║  TOP 5 RISKS THIS WEEK:                                          ║
║  1. [Risk description] — [Owner] — [Status] — [Due date]        ║
║  2. ...                                                          ║
╠══════════════════════════════════════════════════════════════════╣
║  UPCOMING EVENTS:                                                ║
║  [Date]: SOC 2 audit fieldwork begins                            ║
║  [Date]: Pen test scope review meeting                           ║
║  [Date]: GDPR annual review                                      ║
╚══════════════════════════════════════════════════════════════════╝
```

**Board-Level Quarterly Security Report (1-page narrative):**

```
EXECUTIVE SECURITY REPORT — Q[X] [Year]

SECURITY POSTURE: [Rating + 1 sentence summary]

KEY WINS THIS QUARTER:
• [Achievement 1 with business impact]
• [Achievement 2]
• [Achievement 3]

TOP RISKS & MITIGATIONS:
Risk 1: [Name] — Likelihood: [H/M/L] — Impact: [H/M/L]
  Business framing: [What could go wrong in business terms]
  Mitigation: [What we are doing about it]
  Status: [On track / Needs attention / Escalation required]

[Repeat for top 3–5 risks]

COMPLIANCE STATUS:
[Framework]: [Pass/Gaps/Upcoming audit]
[Cost of non-compliance if relevant: regulatory fine exposure]

SECURITY METRICS TREND (QoQ):
MTTD: [This Q] vs [Last Q] ([+/-X%])
Training completion: [X%] ([+/-X%])
Open critical vulnerabilities: [N] ([+/-N])

INVESTMENT REQUEST (if applicable):
[Initiative]: [Cost] — [Risk reduction / ROI justification]

NEXT QUARTER FOCUS:
[Priority 1], [Priority 2], [Priority 3]
```

---

## Phase 6 — Industry Certifications & Standards for Security Staff

**Security certifications by role (recommended):**

```
CISO / Security Leadership:
  □ CISSP (Certified Information Systems Security Professional)
  □ CISM (Certified Information Security Manager)
  □ CCISO (Certified Chief Information Security Officer)

Compliance / Audit:
  □ CISA (Certified Information Systems Auditor)
  □ CRISC (Certified in Risk and Information Systems Control)
  □ CDPSE (Certified Data Privacy Solutions Engineer)

SOC / Threat Hunting:
  □ CEH (Certified Ethical Hacker)
  □ GCIH (GIAC Certified Incident Handler)
  □ GCFE / GCFA (GIAC Certified Forensic Examiner / Analyst)

Penetration Testing:
  □ OSCP (Offensive Security Certified Professional) — gold standard
  □ GPEN (GIAC Penetration Tester)
  □ GWAPT (GIAC Web Application Penetration Tester)

Cloud Security:
  □ CCSP (Certified Cloud Security Professional)
  □ AWS Security Specialty / Azure Security Engineer / GCP Security Engineer

AI Security:
  □ CompTIA AI+ (emerging)
  □ ISO/IEC 42001 AI Management System Auditor
  □ CIPP/E (Certified Information Privacy Professional — Europe)

SRE / Operations:
  □ ITIL 4 Foundation + Practitioner
  □ Six Sigma Green Belt / Black Belt
  □ Google SRE certification (coursework available)

Certification Budget:
  - All security staff: 1 certification per year company-funded
  - Exam voucher + training course covered by company
  - CPE/CPD maintenance: 40 hours per year required; company-paid conference/training
```

---

## Non-Negotiable Training Rules

1. **100% completion is the target** — no employee is exempt; security training is a condition of employment
2. **Phishing simulations are ongoing** — not a one-time event; monthly cadence minimum
3. **Failures trigger education, not punishment** — punitive culture reduces reporting; build psychological safety
4. **Tabletop exercises are mandatory annually** — no opt-outs for key stakeholders (CISO, Legal, IT, Exec)
5. **Developers train on secure coding quarterly** — security is part of engineering culture
6. **AI training is now core curriculum** — every employee who uses AI tools requires AI security awareness
7. **Metrics are reported to CISO monthly** — training program effectiveness is measured and acted on
