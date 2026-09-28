# threat-detection

Source: Claude skill
Original path: `components/claude-skills/engineering-team/skills/threat-detection/SKILL.md`
Description: Use when hunting for threats in an environment, analyzing IOCs, or detecting behavioral anomalies in telemetry. Covers hypothesis-driven threat hunting, IOC sweep generation, z-score anomaly detection, and MITRE ATT&CK-mapped signal prioritization.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Threat Detection

Threat detection skill for proactive discovery of attacker activity through hypothesis-driven hunting, IOC analysis, and behavioral anomaly detection. This is NOT incident response (see incident-response) or red team operations (see red-team) — this is about finding threats that have evaded automated controls.

---

## Table of Contents

- [Overview](#overview)
- [Threat Signal Analyzer](#threat-signal-analyzer)
- [Threat Hunting Methodology](#threat-hunting-methodology)
- [IOC Analysis](#ioc-analysis)
- [Anomaly Detection](#anomaly-detection)
- [MITRE ATT&CK Signal Prioritization](#mitre-attck-signal-prioritization)
- [Deception and Honeypot Integration](#deception-and-honeypot-integration)
- [Workflows](#workflows)
- [Anti-Patterns](#anti-patterns)
- [Cross-References](#cross-references)

---

## Overview

### What This Skill Does

This skill provides the methodology and tooling for **proactive threat detection** — finding attacker activity through structured hunting hypotheses, IOC analysis, and statistical anomaly detection before alerts fire.

### Distinction from Other Security Skills

| Skill | Focus | Approach |
|-------|-------|----------|
| **threat-detection** (this) | Finding hidden threats | Proactive — hunt before alerts |
| incident-response | Active incidents | Reactive — contain and investigate declared incidents |
| red-team | Offensive simulation | Offensive — test defenses from attacker perspective |
| cloud-security | Cloud misconfigurations | Posture — IAM, S3, network exposure |

### Prerequisites

Read access to SIEM/EDR telemetry, endpoint logs, and network flow data. IOC feeds require freshness within 30 days to avoid false positives. Hunting hypotheses must be scoped to the environment before execution.

---

## Threat Signal Analyzer

The `threat_signal_analyzer.py` tool supports three modes: `hunt` (hypothesis scoring), `ioc` (sweep generation), and `anomaly` (statistical detection).

```bash
# Hunt mode: score a hypothesis against MITRE ATT&CK coverage
python3 scripts/threat_signal_analyzer.py --mode hunt \
  --hypothesis "Lateral movement via PtH using compromised service account" \
  --actor-relevance 3 --control-gap 2 --data-availability 2 --json

# IOC mode: generate sweep targets from an IOC feed file
python3 scripts/threat_signal_analyzer.py --mode ioc \
  --ioc-file iocs.json --json

# Anomaly mode: detect statistical outliers in telemetry events
python3 scripts/threat_signal_analyzer.py --mode anomaly \
  --events-file telemetry.json \
  --baseline-mean 100 --baseline-std 25 --json

# List all supported MITRE ATT&CK techniques
python3 scripts/threat_signal_analyzer.py --list-techniques
```

### IOC file format

```json
{
  "ips": ["1.2.3.4", "5.6.7.8"],
  "domains": ["malicious.example.com"],
  "hashes": ["abc123def456..."]
}
```

### Telemetry events file format

```json
[
  {"timestamp": "2024-01-15T14:32:00Z", "entity": "host-01", "action": "dns_query", "volume": 450},
  {"timestamp": "2024-01-15T14:33:00Z", "entity": "host-02", "action": "dns_query", "volume": 95}
]
```

### Exit codes

| Code | Meaning |
|------|---------|
| 0 | No high-priority findings |
| 1 | Medium-priority signals detected |
| 2 | High-priority confirmed findings |

---

## Threat Hunting Methodology

Structured threat hunting follows a five-step loop: hypothesis → data source identification → query execution → finding triage → feedback to detection engineering.

### Hypothesis Scoring

| Factor | Weight | Description |
|--------|--------|-------------|
| Actor relevance | ×3 | How closely does this TTP match known threat actors in your sector? |
| Control gap | ×2 | How many of your existing controls would miss this behavior? |
| Data availability | ×1 | Do you have the telemetry data needed to test this hypothesis? |

Priority score = (actor_relevance × 3) + (control_gap × 2) + (data_availability × 1)

### High-Value Hunt Hypotheses by Tactic

| Hypothesis | MITRE ID | Data Sources | Priority Signal |
|-----------|----------|--------------|-----------------|
| WMI lateral movement via remote execution | T1047 | WMI logs, EDR process telemetry | WMI process spawned from WINRM, unusual parent-child chain |
| LOLBin execution for defense evasion | T1218 | Process creation, command-line args | certutil.exe, regsvr32.exe, mshta.exe with network activity |
| Beaconing C2 via jitter-heavy intervals | T1071.001 | Proxy logs, DNS logs | Regular interval outbound connections ±10% jitter |
| Pass-the-Hash lateral movement | T1550.002 | Windows security event 4624 type 3 | NTLM auth from unexpected source host to admin share |
| LSASS memory access | T1003.001 | EDR memory access events | OpenProcess on lsass.exe from non-system process |
| Kerberoasting | T1558.003 | Windows event 4769 | High volume TGS requests for service accounts |
| Scheduled task persistence | T1053.005 | Sysmon Event 1/11, Windows 4698 | Scheduled task created in non-standard directory |

---

## IOC Analysis

IOC analysis determines whether indicators are fresh, maps them to required sweep targets, and filters stale data that generates false positives.

### IOC Types and Sweep Priority

| IOC Type | Staleness Threshold | Sweep Target | MITRE Coverage |
|---------|--------------------|--------------|----|
| IP addresses | 30 days | Firewall logs, NetFlow, proxy logs | T1071, T1105 |
| Domains | 30 days | DNS resolver logs, proxy logs | T1568, T1583 |
| File hashes | 90 days | EDR file creation, AV scan logs | T1105, T1027 |
| URLs | 14 days | Proxy access logs, browser history | T1566.002 |
| Mutex names | 180 days | EDR runtime artifacts | T1055 |

### IOC Staleness Handling

IOCs older than their threshold are flagged as `stale` and excluded from sweep target generation. Running sweeps against stale IOCs inflates false positive rates and reduces SOC credibility. Refresh IOC feeds from threat intelligence platforms (MISP, OpenCTI, commercial TI) before every hunt cycle.

---

## Anomaly Detection

Statistical anomaly detection identifies behavior that deviates from established baselines without relying on known-bad signatures.

### Z-Score Thresholds

| Z-Score | Classification | Response |
|---------|---------------|----------|
| < 2.0 | Normal | No action required |
| 2.0–2.9 | Soft anomaly | Log and monitor — increase sampling |
| ≥ 3.0 | Hard anomaly | Escalate to hunt analyst — investigate entity |

### Baseline Requirements

Effective anomaly detection requires at least 14 days of historical telemetry to establish a valid baseline. Baselines must be recomputed after:
- Security incidents (post-incident behavior change)
- Major infrastructure changes (cloud migrations, new SaaS deployments)
- Seasonal usage pattern changes (end of quarter, holiday periods)

### High-Value Anomaly Targets

| Entity Type | Metric | Anomaly Indicator |
|-------------|--------|--------------------|
| DNS resolver | Queries per hour per host | Beaconing, tunneling, DGA |
| Endpoint | Un

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
