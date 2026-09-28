# capa-officer

Source: Claude skill
Original path: `components/claude-skills/ra-qm-team/skills/capa-officer/SKILL.md`
Description: CAPA system management for medical device QMS. Covers root cause analysis, corrective action planning, effectiveness verification, and CAPA metrics. Use for CAPA investigations, 5-Why analysis, fishbone diagrams, root cause determination, corrective action tracking, effectiveness verification, or CAPA program optimization.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# CAPA Officer

Corrective and Preventive Action (CAPA) management within Quality Management Systems, focusing on systematic root cause analysis, action implementation, and effectiveness verification.

---

## Table of Contents

- [CAPA Investigation Workflow](#capa-investigation-workflow)
- [Root Cause Analysis](#root-cause-analysis)
- [Corrective Action Planning](#corrective-action-planning)
- [Effectiveness Verification](#effectiveness-verification)
- [CAPA Metrics and Reporting](#capa-metrics-and-reporting)
- [Reference Documentation](#reference-documentation)
- [Tools](#tools)

---

## CAPA Investigation Workflow

Conduct systematic CAPA investigation from initiation through closure:

1. Document trigger event with objective evidence
2. Assess significance and determine CAPA necessity
3. Form investigation team with relevant expertise
4. Collect data and evidence systematically
5. Select and apply appropriate RCA methodology
6. Identify root cause(s) with supporting evidence
7. Develop corrective and preventive actions
8. **Validation:** Root cause explains all symptoms; if eliminated, problem would not recur

### CAPA Necessity Determination

| Trigger Type | CAPA Required | Criteria |
|--------------|---------------|----------|
| Customer complaint (safety) | Yes | Any complaint involving patient/user safety |
| Customer complaint (quality) | Evaluate | Based on severity and frequency |
| Internal audit finding (Major) | Yes | Systematic failure or absence of element |
| Internal audit finding (Minor) | Recommended | Isolated lapse or partial implementation |
| Nonconformance (recurring) | Yes | Same NC type occurring 3+ times |
| Nonconformance (isolated) | Evaluate | Based on severity and risk |
| External audit finding | Yes | All Major and Minor findings |
| Trend analysis | Evaluate | Based on trend significance |

### Investigation Team Composition

| CAPA Severity | Required Team Members |
|---------------|----------------------|
| Critical | CAPA Officer, Process Owner, QA Manager, Subject Matter Expert, Management Rep |
| Major | CAPA Officer, Process Owner, Subject Matter Expert |
| Minor | CAPA Officer, Process Owner |

### Evidence Collection Checklist

- [ ] Problem description with specific details (what, where, when, who, how much)
- [ ] Timeline of events leading to issue
- [ ] Relevant records and documentation
- [ ] Interview notes from involved personnel
- [ ] Photos or physical evidence (if applicable)
- [ ] Related complaints, NCs, or previous CAPAs
- [ ] Process parameters and specifications

---

## Root Cause Analysis

Select and apply appropriate RCA methodology based on problem characteristics.

### RCA Method Selection Decision Tree

```
Is the issue safety-critical or involves system reliability?
├── Yes → Use FAULT TREE ANALYSIS
└── No → Is human error the suspected primary cause?
    ├── Yes → Use HUMAN FACTORS ANALYSIS
    └── No → How many potential contributing factors?
        ├── 1-2 factors (linear causation) → Use 5 WHY ANALYSIS
        ├── 3-6 factors (complex, systemic) → Use FISHBONE DIAGRAM
        └── Unknown/proactive assessment → Use FMEA
```

### 5 Why Analysis

Use when: Single-cause issues with linear causation, process deviations with clear failure point.

**Template:**

```
PROBLEM: [Clear, specific statement]

WHY 1: Why did [problem] occur?
BECAUSE: [First-level cause]
EVIDENCE: [Supporting data]

WHY 2: Why did [first-level cause] occur?
BECAUSE: [Second-level cause]
EVIDENCE: [Supporting data]

WHY 3: Why did [second-level cause] occur?
BECAUSE: [Third-level cause]
EVIDENCE: [Supporting data]

WHY 4: Why did [third-level cause] occur?
BECAUSE: [Fourth-level cause]
EVIDENCE: [Supporting data]

WHY 5: Why did [fourth-level cause] occur?
BECAUSE: [Root cause]
EVIDENCE: [Supporting data]
```

**Example - Calibration Overdue:**

```
PROBLEM: pH meter (EQ-042) found 2 months overdue for calibration

WHY 1: Why was calibration overdue?
BECAUSE: Equipment was not on calibration schedule
EVIDENCE: Calibration schedule reviewed, EQ-042 not listed

WHY 2: Why was it not on the schedule?
BECAUSE: Schedule not updated when equipment was purchased
EVIDENCE: Purchase date 2023-06-15, schedule dated 2023-01-01

WHY 3: Why was the schedule not updated?
BECAUSE: No process requires schedule update at equipment purchase
EVIDENCE: SOP-EQ-001 reviewed, no such requirement

WHY 4: Why is there no such requirement?
BECAUSE: Procedure written before equipment tracking was centralized
EVIDENCE: SOP last revised 2019, equipment system implemented 2021

WHY 5: Why has procedure not been updated?
BECAUSE: Periodic review did not assess compatibility with new systems
EVIDENCE: No review against new equipment system documented

ROOT CAUSE: Procedure review process does not assess compatibility
with organizational systems implemented after original procedure creation.
```

### Fishbone Diagram Categories (6M)

| Category | Focus Areas | Typical Causes |
|----------|-------------|----------------|
| Man (People) | Training, competency, workload | Skill gaps, fatigue, communication |
| Machine (Equipment) | Calibration, maintenance, age | Wear, malfunction, inadequate capacity |
| Method (Process) | Procedures, work instructions | Unclear steps, missing controls |
| Material | Specifications, suppliers, storage | Out-of-spec, degradation, contamination |
| Measurement | Calibration, methods, interpretation | Instrument error, wrong method |
| Mother Nature | Temperature, humidity, cleanliness | Environmental excursions |

See `references/rca-methodologies.md` for complete method details and templates.

### Root Cause Validation

Before proceeding to action planning, validate root cause:

- [ ] Root cause can be verified with objective evidence
- [ ] If root cause is eliminated, problem would not recur
- [ ] Root cause is within organizational control
- [ ] Root cause explains all observed symptoms
- [ ] No other significant causes remain unaddressed

---

## Corrective Action Planning

Develop effective actions addressing identified root causes:

1. Define immediate containment actions
2. Develop corrective actions targeting root cause
3. Identify preventive actions for similar processes
4. Assign responsibilities and resources
5. Establish timeline with milestones
6. Define success criteria and verification method
7. Document in CAPA action plan
8. **Validation:** Actions directly address root cause; success criteria are measurable

### Action Types

| Type | Purpose | Timeline | Example |
|------|---------|----------|---------|
| Containment | Stop immediate impact | 24-72 hours | Quarantine affected product |
| Correction | Fix the specific occurrence | 1-2 weeks | Rework or replace affected items |
| Corrective | Eliminate root cause | 30-90 days | Revise procedure, add controls |
| Preventive | Prevent in other areas | 60-120 days | Extend solution to similar processes |

### Action Plan Components

```
ACTION PLAN TEMPLATE

CAPA Number

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
