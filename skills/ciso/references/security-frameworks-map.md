# Security Frameworks Cross-Reference Map

## Framework Control Harmonization

Use this reference to avoid duplicate implementation work when multiple frameworks apply.
One technical control often satisfies requirements across 4–6 frameworks simultaneously.

---

## Control Domain: Encryption

| Control | SOC 2 | ISO 27001:2022 | NIST CSF 2.0 | NIST SP 800-53 | HIPAA | GDPR | PCI-DSS v4 |
|---|---|---|---|---|---|---|---|
| Encryption at rest | CC6.1 | A.8.24 | PR.DS-02 | SC-28 | §164.312(a)(2)(iv) | Art. 32 | Req 3.5 |
| Encryption in transit | CC6.7 | A.8.24 | PR.DS-02 | SC-8 | §164.312(e)(2)(ii) | Art. 32 | Req 4.2 |
| Key management | CC6.1 | A.8.24 | PR.DS-02 | SC-12, SC-17 | N/A | Art. 32 | Req 3.7 |
| TLS standards | CC6.7 | A.8.24 | PR.DS-02 | SC-8(1) | §164.312(e)(2)(i) | Art. 32 | Req 4.2.1 |

## Control Domain: Access Control

| Control | SOC 2 | ISO 27001:2022 | NIST CSF 2.0 | NIST SP 800-53 | HIPAA | GDPR | PCI-DSS v4 |
|---|---|---|---|---|---|---|---|
| User provisioning | CC6.2 | A.5.16, A.5.18 | PR.AA-01 | AC-2 | §164.308(a)(4) | Art. 25 | Req 7.2 |
| Least privilege | CC6.3 | A.5.15 | PR.AA-05 | AC-6 | §164.308(a)(4)(ii)(B) | Art. 25 | Req 7.2.1 |
| MFA | CC6.6 | A.8.5 | PR.AA-03 | IA-2(1) | N/A explicit | Art. 32 | Req 8.4 |
| Privileged access | CC6.3 | A.8.2 | PR.AA-05 | AC-6(5) | §164.312(a)(2)(ii) | Art. 25 | Req 8.6 |
| Access reviews | CC6.3 | A.5.18 | GV.PO-02 | AC-2(1) | §164.308(a)(3) | Art. 25 | Req 7.2.4 |
| User termination | CC6.3 | A.6.5 | PR.AA-01 | AC-2(3) | §164.308(a)(3)(ii)(C) | Art. 17 | Req 8.2.4 |

## Control Domain: Audit Logging

| Control | SOC 2 | ISO 27001:2022 | NIST CSF 2.0 | NIST SP 800-53 | HIPAA | GDPR | PCI-DSS v4 |
|---|---|---|---|---|---|---|---|
| Security event logging | CC7.2 | A.8.15 | DE.AE-03 | AU-2, AU-12 | §164.312(b) | Art. 32 | Req 10.2 |
| Log retention | CC7.2 | A.8.15 | DE.AE-03 | AU-11 | §164.316(b)(2)(i) | Art. 30 | Req 10.7 |
| Log integrity | CC7.1 | A.8.15 | DE.AE-03 | AU-9 | §164.312(b) | Art. 32 | Req 10.3 |
| Privileged access logging | CC6.3 | A.8.15, A.8.2 | DE.AE-03 | AU-2(4) | §164.312(b) | Art. 32 | Req 10.2.1 |

## Control Domain: Incident Response

| Control | SOC 2 | ISO 27001:2022 | NIST CSF 2.0 | NIST SP 800-53 | HIPAA | GDPR | PCI-DSS v4 |
|---|---|---|---|---|---|---|---|
| IR plan | CC7.3 | A.5.26 | RS.MA-01 | IR-8 | §164.308(a)(6) | Art. 32 | Req 12.10 |
| IR testing | CC7.3 | A.5.26 | RS.MA-01 | IR-3 | §164.308(a)(6)(ii) | Art. 32 | Req 12.10.2 |
| Breach notification | CC7.4 | A.5.26 | RS.CO-02 | IR-6 | §164.408–414 | Art. 33–34 | Req 12.10.4 |

## Control Domain: Vulnerability Management

| Control | SOC 2 | ISO 27001:2022 | NIST CSF 2.0 | NIST SP 800-53 | HIPAA | GDPR |
|---|---|---|---|---|---|---|
| Vuln scanning | CC7.1 | A.8.8 | ID.RA-01 | RA-5 | §164.308(a)(1) | Art. 32 |
| Patch management | CC7.1 | A.8.8 | ID.RA-01 | SI-2 | §164.308(a)(1) | Art. 32 |
| Pen testing | CC7.1 | A.8.8 | ID.RA-05 | CA-8 | §164.308(a)(1) | Art. 32 |

---

## Regulatory Penalty Reference

| Regulation | Maximum Penalty | Notes |
|---|---|---|
| GDPR | €20M or 4% global annual revenue (higher) | Per violation; willful violations higher |
| HIPAA | $100–$50,000 per violation; $1.9M annual cap per category | Tiered by culpability |
| PCI-DSS | $5,000–$100,000/month | Imposed by card brands; plus breach costs |
| CCPA/CPRA | $2,500 per violation; $7,500 intentional | Plus private right of action |
| SOX | Up to $5M fine + 20 years imprisonment (willful) | For individuals; corporate fines higher |
| NYDFS 23 NYCRR 500 | Up to $1M per violation | Financial sector |
| EU AI Act | Up to €35M or 7% global revenue for prohibited uses | Tier-based penalties |
| DORA | Varies by national implementation | ECB supervisory powers |

---

## Certification Renewal Calendar

| Certification | Initial Cycle | Renewal | Audit Type |
|---|---|---|---|
| SOC 2 Type II | 6–12 month observation | Annual | Third-party CPA |
| ISO 27001:2022 | 3-year cycle | Annual surveillance + 3-year recert | Accredited CB |
| PCI-DSS v4 | Annual | Annual ROC or SAQ | QSA (L1 merchants) |
| FedRAMP | ATO valid 3 years | Annual ConMon | 3PAO |
| HITRUST r2 | Initial assessment | Annual interim + 2-year recert | HITRUST assessor |
| ISO 42001 (AI) | 3-year cycle | Annual surveillance | Accredited CB |
| CMMC 2.0 L2 | Triennial | Triennial | C3PAO |

---

## Quick Reference: Data Breach Notification Deadlines

| Regulation | Notify Authority | Notify Individuals | Trigger |
|---|---|---|---|
| GDPR | 72 hours | Without undue delay (if high risk) | Breach of EU personal data |
| HIPAA | 60 days | 60 days (≥500: also media) | PHI breach |
| NY SHIELD / NYDFS | 72 hours (NYDFS) | Expedient (SHIELD) | NY resident data |
| California CCPA/CPRA | Notify AG if >500k affected | Expedient | CA resident data |
| SEC (public companies) | 4 business days (Form 8-K) | N/A | Material cybersecurity incident |
| PCI-DSS | Immediately to acquirer | Per state breach law | Cardholder data |
| EU AI Act | Promptly to market surveillance authority | If fundamental rights impacted | AI system serious incident |
