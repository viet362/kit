# qms-audit-expert

Source: Claude skill
Original path: `components/claude-skills/ra-qm-team/skills/qms-audit-expert/SKILL.md`
Description: ISO 13485 internal audit expertise for medical device QMS. Covers audit planning, execution, nonconformity classification, and CAPA verification. Use for internal audit planning, audit execution, finding classification, external audit preparation, or audit program management.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# QMS Audit Expert

ISO 13485 internal audit methodology for medical device quality management systems.

---

## Table of Contents

- [Audit Planning Workflow](#audit-planning-workflow)
- [Audit Execution](#audit-execution)
- [Nonconformity Management](#nonconformity-management)
- [External Audit Preparation](#external-audit-preparation)
- [Reference Documentation](#reference-documentation)
- [Tools](#tools)

---

## Audit Planning Workflow

Plan risk-based internal audit program:

1. List all QMS processes requiring audit
2. Assign risk level to each process (High/Medium/Low)
3. Review previous audit findings and trends
4. Determine audit frequency by risk level
5. Assign qualified auditors (verify independence)
6. Create annual audit schedule
7. Communicate schedule to process owners
8. **Validation:** All ISO 13485 clauses covered within cycle

### Risk-Based Audit Frequency

| Risk Level | Frequency | Criteria |
|------------|-----------|----------|
| High | Quarterly | Design control, CAPA, production validation |
| Medium | Semi-annual | Purchasing, training, document control |
| Low | Annual | Infrastructure, management review (if stable) |

### Audit Scope by Clause

| Clause | Process | Focus Areas |
|--------|---------|-------------|
| 4.2 | Document Control | Document approval, distribution, obsolete control |
| 5.6 | Management Review | Inputs complete, decisions documented, actions tracked |
| 6.2 | Training | Competency defined, records complete, effectiveness verified |
| 7.3 | Design Control | Inputs, reviews, V&V, transfer, changes |
| 7.4 | Purchasing | Supplier evaluation, incoming inspection |
| 7.5 | Production | Work instructions, process validation, DHR |
| 7.6 | Calibration | Equipment list, calibration status, out-of-tolerance |
| 8.2.2 | Internal Audit | Schedule compliance, auditor independence |
| 8.3 | NC Product | Identification, segregation, disposition |
| 8.5 | CAPA | Root cause, implementation, effectiveness |

### Auditor Independence

Verify auditor independence before assignment:

- [ ] Auditor not responsible for area being audited
- [ ] No direct reporting relationship to auditee
- [ ] Not involved in recent activities under audit
- [ ] Documented qualification for audit scope

---

## Audit Execution

Conduct systematic internal audit:

1. Prepare audit plan (scope, criteria, schedule)
2. Review relevant documentation before audit
3. Conduct opening meeting with auditee
4. Collect evidence (records, interviews, observation)
5. Classify findings (Major/Minor/Observation)
6. Conduct closing meeting with preliminary findings
7. Prepare audit report within 5 business days
8. **Validation:** All scope items covered, findings supported by evidence

### Evidence Collection

| Method | Use For | Documentation |
|--------|---------|---------------|
| Document review | Procedures, records | Document number, version, date |
| Interview | Process understanding | Interviewee name, role, summary |
| Observation | Actual practice | What, where, when observed |
| Record trace | Process flow | Record IDs, dates, linkage |

### Audit Questions by Clause

**Document Control (4.2):**
- Show me the document master list
- How do you control obsolete documents?
- Show me evidence of document change approval

**Design Control (7.3):**
- Show me the Design History File for [product]
- Who participates in design reviews?
- Show me design input to output traceability

**CAPA (8.5):**
- Show me the CAPA log with open items
- How do you determine root cause?
- Show me effectiveness verification records

See `references/iso13485-audit-guide.md` for complete question sets.

### Finding Documentation

Document each finding with:

```
Requirement: [Specific ISO 13485 clause or procedure]
Evidence: [What was observed, reviewed, or heard]
Gap: [How evidence fails to meet requirement]
```

**Example:**
```
Requirement: ISO 13485:2016 Clause 7.6 requires calibration
at specified intervals.

Evidence: Calibration records for pH meter (EQ-042) show
last calibration 2024-01-15. Calibration interval is
12 months. Today is 2025-03-20.

Gap: Equipment is 2 months overdue for calibration,
representing a gap in calibration program execution.
```

---

## Nonconformity Management

Classify and manage audit findings:

1. Evaluate finding against classification criteria
2. Assign severity (Major/Minor/Observation)
3. Document finding with objective evidence
4. Communicate to process owner
5. Initiate CAPA for Major/Minor findings
6. Track to closure
7. Verify effectiveness at follow-up
8. **Validation:** Finding closed only after effective CAPA

### Classification Criteria

| Category | Definition | CAPA Required | Timeline |
|----------|------------|---------------|----------|
| Major | Systematic failure or absence of element | Yes | 30 days |
| Minor | Isolated lapse or partial implementation | Recommended | 60 days |
| Observation | Improvement opportunity | Optional | As appropriate |

### Classification Decision

```
Is required element absent or failed?
├── Yes → Systematic (multiple instances)? → MAJOR
│   └── No → Could affect product safety? → MAJOR
│       └── No → MINOR
└── No → Deviation from procedure?
    ├── Yes → Recurring? → MAJOR
    │   └── No → MINOR
    └── No → Improvement opportunity? → OBSERVATION
```

### CAPA Integration

| Finding Severity | CAPA Depth | Verification |
|------------------|------------|--------------|
| Major | Full root cause analysis (5-Why, Fishbone) | Next audit or within 6 months |
| Minor | Immediate cause identification | Next scheduled audit |
| Observation | Not required | Noted at next audit |

See `references/nonconformity-classification.md` for detailed guidance.

---

## External Audit Preparation

Prepare for certification body or regulatory audit:

1. Complete all scheduled internal audits
2. Verify all findings closed with effective CAPA
3. Review documentation for currency and accuracy
4. Conduct management review with audit as input
5. Prepare facility and personnel
6. Conduct mock audit (full scope)
7. Brief personnel on audit protocol
8. **Validation:** Mock audit findings addressed before external audit

### Pre-Audit Readiness Checklist

**Documentation:**
- [ ] Quality Manual current
- [ ] Procedures reflect actual practice
- [ ] Records complete and retrievable
- [ ] Previous audit findings closed

**Personnel:**
- [ ] Key personnel available during audit
- [ ] Subject matter experts identified
- [ ] Personnel briefed on audit protocol
- [ ] Escorts assigned

**Facility:**
- [ ] Work areas organized
- [ ] Documents at point of use current
- [ ] Equipment calibration status visible
- [ ] Nonconforming product segregated

### Mock Audit Protocol

1. Use external auditor or qualified internal auditor
2. Cover full scope of upcoming external audit
3. Simulate actual audit conditions (timing, formality)
4. Document findings as for real audit
5. Address all Major and Minor findings before external audit
6. Brief ma

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
