---
name: threat-hunter
description: "Use this skill when you need proactive threat hunting campaigns, MITRE ATT&CK-based hunt hypotheses, IOC sweeps, behavioral anomaly investigation, threat intelligence integration, adversary emulation planning, SOC analyst triage support, SIEM query development (KQL/SPL/YARA), or automated threat detection engineering. Trigger for threat hunting sprints, new threat intel indicators, or post-incident proactive sweeps."
license: Apache-2.0
metadata:
  author: aviskaar
  version: "1.0"
  tags: [threat-hunting, mitre-attack, ioc, siem, kql, splunk, threat-intel, soc, behavioral-analysis, adversary-emulation]
---

# Threat Hunter — Automated Threat Hunting Specialist

## Role

The Threat Hunter conducts proactive, hypothesis-driven hunts across all log sources to detect adversaries who have evaded automated detection. This skill applies ATT&CK frameworks, threat intelligence, and behavioral analytics to find threats before they cause damage.

---

## Phase 1 — Hunt Hypothesis Generation

**Hypothesis sources (priority order):**
1. Latest MITRE ATT&CK updates and newly mapped techniques
2. CISA Known Exploited Vulnerabilities (KEV) relevant to environment
3. Threat intelligence from ISACs, FS-ISAC, H-ISAC, sector-specific feeds
4. Recent incidents at peer organizations (OSINT, ISAC sharing)
5. Anomalies flagged by UEBA/ML that didn't trigger alerts
6. Red team / pen test findings that detection missed
7. Newly published threat actor TTPs (APT reports, vendor research)

**Hypothesis format:**
```
Hunt ID:      HUNT-[YYYY]-[NNN]
Date:         [Date]
Analyst:      [Name]
Hypothesis:   "If [threat actor/technique] is present, we would see [observable]
               in [data source] because [rationale]."
ATT&CK Map:   [Tactic / Technique / Sub-technique]
Data Sources: [Log type, SIEM index/table]
Priority:     Critical / High / Medium
Status:       Active / Completed / Escalated
```

---

## Phase 2 — Hunt Execution (by Technique Category)

### Initial Access Hunts:

```kql
// Phishing: Suspicious email attachments with Office macro execution
DeviceFileEvents
| where FileName endswith ".xlsm" or FileName endswith ".docm"
| join DeviceProcessEvents on DeviceId
| where InitiatingProcessParentFileName has_any ("WINWORD.EXE","EXCEL.EXE")
  and FileName in~ ("cmd.exe","powershell.exe","wscript.exe","cscript.exe")
| project Timestamp, DeviceName, FileName, ProcessCommandLine

// Drive-by: Browser spawning unexpected child processes
DeviceProcessEvents
| where InitiatingProcessFileName has_any ("chrome.exe","firefox.exe","msedge.exe")
  and FileName in~ ("cmd.exe","powershell.exe","mshta.exe","wscript.exe")
| where not(ProcessCommandLine has_any ("--type=","extension","update"))
```

### Persistence Hunts:

```kql
// Registry Run key modifications (T1547.001)
DeviceRegistryEvents
| where RegistryKey has_any ("\\Run","\\RunOnce","\\RunServices")
  and ActionType == "RegistryValueSet"
  and InitiatingProcessFileName !in~ ("msiexec.exe","setup.exe","install.exe")
| summarize count() by RegistryValueData, InitiatingProcessFileName, DeviceName

// Scheduled task creation with suspicious commands (T1053.005)
DeviceProcessEvents
| where FileName == "schtasks.exe"
  and ProcessCommandLine has_any ("powershell","cmd /c","wscript","mshta","regsvr32")
| project Timestamp, DeviceName, ProcessCommandLine, InitiatingProcessFileName
```

### Credential Access Hunts:

```kql
// LSASS memory access (T1003.001)
DeviceEvents
| where ActionType == "CreateRemoteThreadApiCall"
  and InitiatingProcessFileName !in~ ("MsSense.exe","csrss.exe","werfault.exe")
  and FileName == "lsass.exe"

// Kerberoasting: Large volume of TGS requests (T1558.003)
SecurityEvent
| where EventID == 4769 and TicketEncryptionType == "0x17"
| summarize count() by Account, ServiceName, bin(TimeGenerated, 5m)
| where count_ > 10
```

### Lateral Movement Hunts:

```kql
// Pass-the-Hash / Pass-the-Ticket indicators (T1550)
SecurityEvent
| where EventID == 4624 and LogonType == 3 and AuthenticationPackageName == "NTLM"
  and WorkstationName != TargetDomainName
  and TargetUserName !endswith "$"
| summarize count() by TargetUserName, IpAddress, bin(TimeGenerated, 1h)
| where count_ > 5

// Unusual WMI lateral movement (T1021.006)
DeviceProcessEvents
| where InitiatingProcessFileName == "wmiprvse.exe"
  and FileName in~ ("cmd.exe","powershell.exe","net.exe","whoami.exe")
| project Timestamp, DeviceName, ProcessCommandLine
```

### Exfiltration Hunts:

```kql
// Unusual outbound data volume (T1048)
DeviceNetworkEvents
| where ActionType == "ConnectionSuccess" and Direction == "Outbound"
  and RemoteIPType == "Public"
| summarize TotalBytes = sum(SentBytes) by RemoteIP, DeviceName, bin(Timestamp, 1h)
| where TotalBytes > 100000000  // >100MB in 1 hour
| join (ThreatIntelligenceIndicator | where ThreatType == "ip") on $left.RemoteIP == $right.NetworkIP

// DNS exfiltration: Abnormally long DNS queries (T1048.003)
DnsEvents
| where QueryType == "A" and strlen(Name) > 100
| extend DomainParts = split(Name, ".")
| where array_length(DomainParts) > 5
```

---

## Phase 3 — IOC Sweep Playbook

**Weekly IOC sweep process:**

```
1. Pull latest IOC feeds:
   - CISA Alerts and IOC lists
   - FS-ISAC / H-ISAC TLP:WHITE/GREEN indicators
   - Commercial threat intel (Recorded Future, CrowdStrike, Mandiant)
   - MISP community feeds

2. IOC categories to sweep:
   - IP addresses (firewall/proxy logs, 90 days)
   - Domain names (DNS logs, proxy logs, 90 days)
   - File hashes (MD5/SHA256 — endpoint EDR telemetry, 90 days)
   - URLs (web proxy, email gateway logs)
   - Email sender domains/addresses (email security logs)
   - Certificate hashes (network SSL inspection logs)
   - YARA rules (endpoint file system scans)

3. Positive match actions:
   - Immediate: isolate affected endpoint
   - Notify: security-operations → incident-responder
   - Document: create incident ticket with IOC match details
   - Threat intel: report new IOC if not in feeds (contribute back)
```

---

## Phase 4 — Adversary Emulation (Purple Team)

**Quarterly purple team exercise structure:**

```
Week 1: Planning
- Select 3–5 ATT&CK techniques based on recent threat intel
- Map to relevant log sources and detection rules
- Brief SOC team on exercise (NOT the specific techniques)
- Define success criteria: detection rate, alert time, response time

Week 2: Execution
- Red team executes techniques in production (agreed scope)
- Blue team monitors and responds normally (no foreknowledge)
- Log all actions (timestamp, technique, tool used, target system)

Week 3: Analysis
- Review: detected vs. undetected techniques
- Gap analysis: missing log sources? Tuning needed? Coverage gaps?
- Document detection improvements needed

Week 4: Remediation
- Implement new detection rules for missed techniques
- Tune existing rules to reduce false negatives
- Update hunt hypotheses backlog
- Report to CISO: detection coverage improvement
```

---

## Phase 5 — Threat Intelligence Integration

**TI consumption pipeline:**

```
Sources → Normalization → Enrichment → Action

Sources:
- STIX/TAXII feeds (automated ingestion into SIEM/SOAR)
- ISAC sharing (sector-specific, TLP-controlled)
- Commercial platforms (API integration)
- OSINT (manual curation, analyst-curated)

Normalization:
- Deduplicate across feeds
- Apply confidence scoring (high/medium/low)
- Assign TLP classification (RED/AMBER/GREEN/WHITE)
- Tag with relevant ATT&CK techniques

Action Thresholds:
- High confidence IOC: auto-block in firewall/EDR + alert
- Medium confidence: alert only + investigate within 24h
- Low confidence: watchlist; alert on additional corroboration
- Expired IOC (>90 days old for IPs, >365 days for domains): archive
```

---

## Phase 6 — Hunt Outputs & Metrics

**Hunt report format:**
```
Hunt ID:         [HUNT-YYYY-NNN]
Hypothesis:      [Statement]
Duration:        [Start – End]
Data Searched:   [Sources, time range, record count]
Findings:        [Confirmed / Suspected / No findings]
ATT&CK Coverage: [Techniques hunted]
True Positives:  [N incidents identified]
False Positives: [N benign anomalies reviewed]
New Rules:       [Detection rules created from hunt]
Improvements:    [Log gaps identified, tuning recommendations]
```

**Monthly threat hunting KPIs:**
| Metric | Target |
|---|---|
| Hunts completed per month | ≥8 (2 per week) |
| Techniques covered (ATT&CK) | ≥80% of critical techniques annually |
| True positives found via hunting | Track (any finding = success) |
| New detection rules from hunts | ≥4 per month |
| IOC sweep coverage | 100% of latest feed within 48h |
| Mean dwell time (hunted threats) | <72h post-detection |
