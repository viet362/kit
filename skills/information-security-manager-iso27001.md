# information-security-manager-iso27001

Source: Claude skill
Original path: `components/claude-skills/ra-qm-team/skills/information-security-manager-iso27001/SKILL.md`
Description: ISO 27001 ISMS implementation and cybersecurity governance for HealthTech and MedTech companies. Use for ISMS design, security risk assessment, control implementation, ISO 27001 certification, security audits, incident response, and compliance verification. Covers ISO 27001, ISO 27002, healthcare security, and medical device cybersecurity.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Information Security Manager - ISO 27001

Implement and manage Information Security Management Systems (ISMS) aligned with ISO 27001:2022 and healthcare regulatory requirements.

---

## Table of Contents

- [Trigger Phrases](#trigger-phrases)
- [Quick Start](#quick-start)
- [Tools](#tools)
- [Workflows](#workflows)
- [Reference Guides](#reference-guides)
- [Validation Checkpoints](#validation-checkpoints)

---

## Trigger Phrases

Use this skill when you hear:
- "implement ISO 27001"
- "ISMS implementation"
- "security risk assessment"
- "information security policy"
- "ISO 27001 certification"
- "security controls implementation"
- "incident response plan"
- "healthcare data security"
- "medical device cybersecurity"
- "security compliance audit"

---

## Quick Start

### Run Security Risk Assessment

```bash
python scripts/risk_assessment.py --scope "patient-data-system" --output risk_register.json
```

### Check Compliance Status

```bash
python scripts/compliance_checker.py --standard iso27001 --controls-file controls.csv
```

### Generate Gap Analysis Report

```bash
python scripts/compliance_checker.py --standard iso27001 --gap-analysis --output gaps.md
```

---

## Tools

### risk_assessment.py

Automated security risk assessment following ISO 27001 Clause 6.1.2 methodology.

**Usage:**

```bash
# Full risk assessment
python scripts/risk_assessment.py --scope "cloud-infrastructure" --output risks.json

# Healthcare-specific assessment
python scripts/risk_assessment.py --scope "ehr-system" --template healthcare --output risks.json

# Quick asset-based assessment
python scripts/risk_assessment.py --assets assets.csv --output risks.json
```

**Parameters:**

| Parameter | Required | Description |
|-----------|----------|-------------|
| `--scope` | Yes | System or area to assess |
| `--template` | No | Assessment template: `general`, `healthcare`, `cloud` |
| `--assets` | No | CSV file with asset inventory |
| `--output` | No | Output file (default: stdout) |
| `--format` | No | Output format: `json`, `csv`, `markdown` |

**Output:**
- Asset inventory with classification
- Threat and vulnerability mapping
- Risk scores (likelihood × impact)
- Treatment recommendations
- Residual risk calculations

### compliance_checker.py

Verify ISO 27001/27002 control implementation status.

**Usage:**

```bash
# Check all ISO 27001 controls
python scripts/compliance_checker.py --standard iso27001

# Gap analysis with recommendations
python scripts/compliance_checker.py --standard iso27001 --gap-analysis

# Check specific control domains
python scripts/compliance_checker.py --standard iso27001 --domains "access-control,cryptography"

# Export compliance report
python scripts/compliance_checker.py --standard iso27001 --output compliance_report.md
```

**Parameters:**

| Parameter | Required | Description |
|-----------|----------|-------------|
| `--standard` | Yes | Standard to check: `iso27001`, `iso27002`, `hipaa` |
| `--controls-file` | No | CSV with current control status |
| `--gap-analysis` | No | Include remediation recommendations |
| `--domains` | No | Specific control domains to check |
| `--output` | No | Output file path |

**Output:**
- Control implementation status
- Compliance percentage by domain
- Gap analysis with priorities
- Remediation recommendations

---

## Workflows

### Workflow 1: ISMS Implementation

**Step 1: Define Scope and Context**

Document organizational context and ISMS boundaries:
- Identify interested parties and requirements
- Define ISMS scope and boundaries
- Document internal/external issues

**Validation:** Scope statement reviewed and approved by management.

**Step 2: Conduct Risk Assessment**

```bash
python scripts/risk_assessment.py --scope "full-organization" --template general --output initial_risks.json
```

- Identify information assets
- Assess threats and vulnerabilities
- Calculate risk levels
- Determine risk treatment options

**Validation:** Risk register contains all critical assets with assigned owners.

**Step 3: Select and Implement Controls**

Map risks to ISO 27002 controls:

```bash
python scripts/compliance_checker.py --standard iso27002 --gap-analysis --output control_gaps.md
```

Control categories:
- Organizational (policies, roles, responsibilities)
- People (screening, awareness, training)
- Physical (perimeters, equipment, media)
- Technological (access, crypto, network, application)

**Validation:** Statement of Applicability (SoA) documents all controls with justification.

**Step 4: Establish Monitoring**

Define security metrics:
- Incident count and severity trends
- Control effectiveness scores
- Training completion rates
- Audit findings closure rate

**Validation:** Dashboard shows real-time compliance status.

### Workflow 2: Security Risk Assessment

**Step 1: Asset Identification**

Create asset inventory:

| Asset Type | Examples | Classification |
|------------|----------|----------------|
| Information | Patient records, source code | Confidential |
| Software | EHR system, APIs | Critical |
| Hardware | Servers, medical devices | High |
| Services | Cloud hosting, backup | High |
| People | Admin accounts, developers | Varies |

**Validation:** All assets have assigned owners and classifications.

**Step 2: Threat Analysis**

Identify threats per asset category:

| Asset | Threats | Likelihood |
|-------|---------|------------|
| Patient data | Unauthorized access, breach | High |
| Medical devices | Malware, tampering | Medium |
| Cloud services | Misconfiguration, outage | Medium |
| Credentials | Phishing, brute force | High |

**Validation:** Threat model covers top-10 industry threats.

**Step 3: Vulnerability Assessment**

```bash
python scripts/risk_assessment.py --scope "network-infrastructure" --output vuln_risks.json
```

Document vulnerabilities:
- Technical (unpatched systems, weak configs)
- Process (missing procedures, gaps)
- People (lack of training, insider risk)

**Validation:** Vulnerability scan results mapped to risk register.

**Step 4: Risk Evaluation and Treatment**

Calculate risk: `Risk = Likelihood × Impact`

| Risk Level | Score | Treatment |
|------------|-------|-----------|
| Critical | 20-25 | Immediate action required |
| High | 15-19 | Treatment plan within 30 days |
| Medium | 10-14 | Treatment plan within 90 days |
| Low | 5-9 | Accept or monitor |
| Minimal | 1-4 | Accept |

**Validation:** All high/critical risks have approved treatment plans.

### Workflow 3: Incident Response

**Step 1: Detection and Reporting**

Incident categories:
- Security breach (unauthorized access)
- Malware infection
- Data leakage
- System compromise
- Policy violation

**Validation:** Incident logged within 15 minutes of detection.

**Step 2: Triage and Classification**

| Severity | Criteria | Response Time |
|----------|----------|---------------|
| Critical | Data breach, system down | Immediate |
| High | Active threat, significant risk | 1 hour |
| Medium | Contained

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
