# red-team

Source: Claude skill
Original path: `components/claude-skills/engineering-team/skills/red-team/SKILL.md`
Description: Use when planning or executing authorized red team engagements, attack path analysis, or offensive security simulations. Covers MITRE ATT&CK kill-chain planning, technique scoring, choke point identification, OPSEC risk assessment, and crown jewel targeting.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Red Team

Red team engagement planning and attack path analysis skill for authorized offensive security simulations. This is NOT vulnerability scanning (see security-pen-testing) or incident response (see incident-response) — this is about structured adversary simulation to test detection, response, and control effectiveness.

---

## Table of Contents

- [Overview](#overview)
- [Engagement Planner Tool](#engagement-planner-tool)
- [Kill-Chain Phase Methodology](#kill-chain-phase-methodology)
- [Technique Scoring and Prioritization](#technique-scoring-and-prioritization)
- [Choke Point Analysis](#choke-point-analysis)
- [OPSEC Risk Assessment](#opsec-risk-assessment)
- [Crown Jewel Targeting](#crown-jewel-targeting)
- [Attack Path Methodology](#attack-path-methodology)
- [Workflows](#workflows)
- [Anti-Patterns](#anti-patterns)
- [Cross-References](#cross-references)

---

## Overview

### What This Skill Does

This skill provides the methodology and tooling for **red team engagement planning** — building structured attack plans from MITRE ATT&CK technique selection, access level, and crown jewel targets. It scores techniques by effort and detection risk, assembles kill-chain phases, identifies choke points, and flags OPSEC risks.

### Distinction from Other Security Skills

| Skill | Focus | Approach |
|-------|-------|----------|
| **red-team** (this) | Adversary simulation | Offensive — structured attack planning and execution |
| security-pen-testing | Vulnerability discovery | Offensive — systematic exploitation of specific weaknesses |
| threat-detection | Finding attacker activity | Proactive — detect TTPs in telemetry |
| incident-response | Active incident management | Reactive — contain and investigate confirmed incidents |

### Authorization Requirement

**All red team activities described here require written authorization.** This includes a signed Rules of Engagement (RoE) document, defined scope, and explicit executive approval. The `engagement_planner.py` tool will not generate output without the `--authorized` flag. Unauthorized use of these techniques is illegal under the CFAA, Computer Misuse Act, and equivalent laws worldwide.

---

## Engagement Planner Tool

The `engagement_planner.py` tool builds a scored, kill-chain-ordered attack plan from technique selection, access level, and crown jewel targets.

```bash
# Basic engagement plan — external access, specific techniques
python3 scripts/engagement_planner.py \
  --techniques T1059,T1078,T1003 \
  --access-level external \
  --authorized --json

# Internal network access with crown jewel targeting
python3 scripts/engagement_planner.py \
  --techniques T1059,T1078,T1021,T1550,T1003 \
  --access-level internal \
  --crown-jewels "Database,Active Directory,Payment Systems" \
  --authorized --json

# Credentialed (assumed breach) scenario with scale
python3 scripts/engagement_planner.py \
  --techniques T1059,T1078,T1021,T1550,T1003,T1486,T1048 \
  --access-level credentialed \
  --crown-jewels "Domain Controller,S3 Data Lake" \
  --target-count 50 \
  --authorized --json

# List all 29 supported MITRE ATT&CK techniques
python3 scripts/engagement_planner.py --list-techniques
```

### Access Level Definitions

| Level | Starting Position | Techniques Available |
|-------|------------------|----------------------|
| external | No internal access — internet only | External-facing techniques only (T1190, T1566, etc.) |
| internal | Network foothold — no credentials | Internal recon + lateral movement prep |
| credentialed | Valid credentials obtained | Full kill chain including priv-esc, lateral movement, impact |

### Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Engagement plan generated successfully |
| 1 | Missing authorization or invalid technique |
| 2 | Scope violation — technique outside access-level constraints |

---

## Kill-Chain Phase Methodology

The engagement planner organizes techniques into eight kill-chain phases and orders the execution plan accordingly.

### Kill-Chain Phase Order

| Phase | Order | MITRE Tactic | Examples |
|-------|-------|--------------|----------|
| Reconnaissance | 1 | TA0043 | T1595, T1596, T1598 |
| Resource Development | 2 | TA0042 | T1583, T1588 |
| Initial Access | 3 | TA0001 | T1190, T1566, T1078 |
| Execution | 4 | TA0002 | T1059, T1047, T1204 |
| Persistence | 5 | TA0003 | T1053, T1543, T1136 |
| Privilege Escalation | 6 | TA0004 | T1055, T1548, T1134 |
| Credential Access | 7 | TA0006 | T1003, T1110, T1558 |
| Lateral Movement | 8 | TA0008 | T1021, T1550, T1534 |
| Collection | 9 | TA0009 | T1074, T1560, T1114 |
| Exfiltration | 10 | TA0010 | T1048, T1041, T1567 |
| Impact | 11 | TA0040 | T1486, T1491, T1498 |

### Phase Execution Principles

Each phase must be completed before advancing to the next unless the engagement scope specifies assumed breach (skip to a later phase). Do not skip persistence before attempting lateral movement — persistence ensures operational continuity if a single foothold is detected and removed.

---

## Technique Scoring and Prioritization

Techniques are scored by effort (how hard to execute without detection) and prioritized in the engagement plan.

### Effort Score Formula

```
effort_score = detection_risk × (len(prerequisites) + 1)
```

Lower effort score = easier to execute without triggering detection.

### Technique Scoring Reference

| Technique | Detection Risk | Prerequisites | Effort Score | MITRE ID |
|-----------|---------------|---------------|-------------|---------|
| PowerShell execution | 0.7 | initial_access | 1.4 | T1059.001 |
| Scheduled task persistence | 0.5 | execution | 1.0 | T1053.005 |
| Pass-the-Hash | 0.6 | credential_access, internal_network | 1.8 | T1550.002 |
| LSASS credential dump | 0.8 | local_admin | 1.6 | T1003.001 |
| Spearphishing link | 0.4 | none | 0.4 | T1566.001 |
| Ransomware deployment | 0.9 | persistence, lateral_movement | 2.7 | T1486 |

---

## Choke Point Analysis

Choke points are techniques required by multiple paths to crown jewel assets. Detecting a choke point technique detects all attack paths that pass through it.

### Choke Point Identification

The engagement planner identifies choke points by finding techniques in `credential_access` and `privilege_escalation` tactics that serve as prerequisites for multiple subsequent techniques targeting crown jewels.

Prioritize detection rule development and monitoring density around choke point techniques — hardening a choke point has multiplied defensive value.

### Common Choke Points by Environment

| Environment Type | Common Choke Points | Detection Priority |
|-----------------|--------------------|--------------------|
| Active Directory domain | T1003 (credential dump), T1558 (Kerberoasting) | Highest |
| AWS environment | T1078.004 (cloud account), iam:PassRole chains | Highest |
| Hybrid cloud | T1550.002 (PtH), T1021.006 (WinRM) | High |
| Containerized apps | T1610 (deploy container), T1611 (container esc

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
