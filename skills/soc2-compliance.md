# soc2-compliance

Source: Claude skill
Original path: `components/claude-skills/ra-qm-team/skills/soc2-compliance/SKILL.md`
Description: Use when the user asks to prepare for SOC 2 audits, map Trust Service Criteria, build control matrices, collect audit evidence, perform gap analysis, or assess SOC 2 Type I vs Type II readiness.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# SOC 2 Compliance

SOC 2 Type I and Type II compliance preparation for SaaS companies. Covers Trust Service Criteria mapping, control matrix generation, evidence collection, gap analysis, and audit readiness assessment.

## Table of Contents

- [Overview](#overview)
- [Trust Service Criteria](#trust-service-criteria)
- [Control Matrix Generation](#control-matrix-generation)
- [Gap Analysis Workflow](#gap-analysis-workflow)
- [Evidence Collection](#evidence-collection)
- [Audit Readiness Checklist](#audit-readiness-checklist)
- [Vendor Management](#vendor-management)
- [Continuous Compliance](#continuous-compliance)
- [Anti-Patterns](#anti-patterns)
- [Tools](#tools)
- [References](#references)
- [Cross-References](#cross-references)

---

## Overview

### What Is SOC 2?

SOC 2 (System and Organization Controls 2) is an auditing framework developed by the AICPA that evaluates how a service organization manages customer data. It applies to any technology company that stores, processes, or transmits customer information — primarily SaaS, cloud infrastructure, and managed service providers.

### Type I vs Type II

| Aspect | Type I | Type II |
|--------|--------|---------|
| **Scope** | Design of controls at a point in time | Design AND operating effectiveness over a period |
| **Duration** | Snapshot (single date) | Observation window (3-12 months, typically 6) |
| **Evidence** | Control descriptions, policies | Control descriptions + operating evidence (logs, tickets, screenshots) |
| **Cost** | $20K-$50K (audit fees) | $30K-$100K+ (audit fees) |
| **Timeline** | 1-2 months (audit phase) | 6-12 months (observation + audit) |
| **Best For** | First-time compliance, rapid market need | Mature organizations, enterprise customers |

### Who Needs SOC 2?

- **SaaS companies** selling to enterprise customers
- **Cloud infrastructure providers** handling customer workloads
- **Data processors** managing PII, PHI, or financial data
- **Managed service providers** with access to client systems
- **Any vendor** whose customers require third-party assurance

### Typical Journey

```
Gap Assessment → Remediation → Type I Audit → Observation Period → Type II Audit → Annual Renewal
    (4-8 wk)      (8-16 wk)     (4-6 wk)       (6-12 mo)          (4-6 wk)       (ongoing)
```

---

## Trust Service Criteria

SOC 2 is organized around five Trust Service Criteria (TSC) categories. **Security** is required for every SOC 2 report; the remaining four are optional and selected based on business need.

### Security (Common Criteria CC1-CC9) — Required

The foundation of every SOC 2 report. Maps to COSO 2013 principles.

| Criteria | Domain | Key Controls |
|----------|--------|-------------|
| **CC1** | Control Environment | Integrity/ethics, board oversight, org structure, competence, accountability |
| **CC2** | Communication & Information | Internal/external communication, information quality |
| **CC3** | Risk Assessment | Risk identification, fraud risk, change impact analysis |
| **CC4** | Monitoring Activities | Ongoing monitoring, deficiency evaluation, corrective actions |
| **CC5** | Control Activities | Policies/procedures, technology controls, deployment through policies |
| **CC6** | Logical & Physical Access | Access provisioning, authentication, encryption, physical restrictions |
| **CC7** | System Operations | Vulnerability management, anomaly detection, incident response |
| **CC8** | Change Management | Change authorization, testing, approval, emergency changes |
| **CC9** | Risk Mitigation | Vendor/business partner risk management |

### Availability (A1) — Optional

| Criteria | Focus | Key Controls |
|----------|-------|-------------|
| **A1.1** | Capacity management | Infrastructure scaling, resource monitoring, capacity planning |
| **A1.2** | Recovery operations | Backup procedures, disaster recovery, BCP testing |
| **A1.3** | Recovery testing | DR drills, failover testing, RTO/RPO validation |

**Select when:** Customers depend on your uptime; you have SLAs; downtime causes direct business impact.

### Confidentiality (C1) — Optional

| Criteria | Focus | Key Controls |
|----------|-------|-------------|
| **C1.1** | Identification | Data classification policy, confidential data inventory |
| **C1.2** | Protection | Encryption at rest and in transit, DLP, access restrictions |
| **C1.3** | Disposal | Secure deletion procedures, media sanitization, retention enforcement |

**Select when:** You handle trade secrets, proprietary data, or contractually confidential information.

### Processing Integrity (PI1) — Optional

| Criteria | Focus | Key Controls |
|----------|-------|-------------|
| **PI1.1** | Accuracy | Input validation, processing checks, output verification |
| **PI1.2** | Completeness | Transaction monitoring, reconciliation, error handling |
| **PI1.3** | Timeliness | SLA monitoring, processing delay alerts, batch job monitoring |
| **PI1.4** | Authorization | Processing authorization controls, segregation of duties |

**Select when:** Data accuracy is critical (financial processing, healthcare records, analytics platforms).

### Privacy (P1-P8) — Optional

| Criteria | Focus | Key Controls |
|----------|-------|-------------|
| **P1** | Notice | Privacy policy, data collection notice, purpose limitation |
| **P2** | Choice & Consent | Opt-in/opt-out, consent management, preference tracking |
| **P3** | Collection | Minimal collection, lawful basis, purpose specification |
| **P4** | Use, Retention, Disposal | Purpose limitation, retention schedules, secure disposal |
| **P5** | Access | Data subject access requests, correction rights |
| **P6** | Disclosure & Notification | Third-party sharing, breach notification |
| **P7** | Quality | Data accuracy verification, correction mechanisms |
| **P8** | Monitoring & Enforcement | Privacy program monitoring, complaint handling |

**Select when:** You process PII and customers expect privacy assurance (complements GDPR compliance).

---

## Control Matrix Generation

A control matrix maps each TSC criterion to specific controls, owners, evidence, and testing procedures.

### Matrix Structure

| Field | Description |
|-------|-------------|
| **Control ID** | Unique identifier (e.g., SEC-001, AVL-003) |
| **TSC Mapping** | Which criteria the control addresses (e.g., CC6.1, A1.2) |
| **Control Description** | What the control does |
| **Control Type** | Preventive, Detective, or Corrective |
| **Owner** | Responsible person/team |
| **Frequency** | Continuous, Daily, Weekly, Monthly, Quarterly, Annual |
| **Evidence Type** | Screenshot, Log, Policy, Config, Ticket |
| **Testing Procedure** | How the auditor verifies the control |

### Control Naming Convention

```
{CATEGORY}-{NUMBER}
SEC-001 through SEC-NNN  → Security
AVL-001 through AVL-NNN  → Availability
CON-001 through CON-NNN  → Confidentiality
PRI-001 through PRI-NNN  → Processing Integrity
PRV-001 through PRV-NNN  → Privacy
```

### Workflow

1. Selec

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
