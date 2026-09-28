# quality-manager-qms-iso13485

Source: Claude skill
Original path: `components/claude-skills/ra-qm-team/skills/quality-manager-qms-iso13485/SKILL.md`
Description: ISO 13485 Quality Management System implementation and maintenance for medical device organizations. Provides QMS design, documentation control, internal auditing, CAPA management, and certification support. Use when working with medical device quality systems, preparing for ISO 13485 audits, managing regulatory compliance documentation, setting up corrective actions, or building audit preparation programs. Useful for quality management, audit preparation, regulatory compliance, medical device documentation, and corrective action workflows.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Quality Manager - QMS ISO 13485 Specialist

ISO 13485:2016 Quality Management System implementation, maintenance, and certification support for medical device organizations.

---

## Table of Contents

- [QMS Implementation Workflow](#qms-implementation-workflow)
- [Document Control Workflow](#document-control-workflow)
- [Internal Audit Workflow](#internal-audit-workflow)
- [Process Validation Workflow](#process-validation-workflow)
- [Supplier Qualification Workflow](#supplier-qualification-workflow)
- [QMS Process Reference](#qms-process-reference)
- [Decision Frameworks](#decision-frameworks)
- [Tools and References](#tools-and-references)

---

## QMS Implementation Workflow

Implement ISO 13485:2016 compliant quality management system from gap analysis through certification.

### Workflow: Initial QMS Implementation

1. Conduct gap analysis against ISO 13485:2016 requirements
2. Document current state vs. required state for each clause
3. Prioritize gaps by:
   - Regulatory criticality
   - Risk to product safety
   - Resource requirements
4. Develop implementation roadmap with milestones
5. Establish Quality Manual per Clause 4.2.2:
   - QMS scope with justified exclusions
   - Process interactions
   - Procedure references
6. Create required documented procedures — see [Mandatory Documented Procedures](#quick-reference-mandatory-documented-procedures) for the full list
7. Deploy processes with training
8. **Validation:** Gap analysis complete; Quality Manual approved; all required procedures documented and trained

> Use the Gap Analysis Matrix template in [qms-process-templates.md](references/qms-process-templates.md) to document clause-by-clause current state, gaps, priority, and actions.

### QMS Structure

| Level | Document Type | Example |
|-------|---------------|---------|
| 1 | Quality Manual | QM-001 |
| 2 | Procedures | SOP-02-001 |
| 3 | Work Instructions | WI-06-012 |
| 4 | Records | Training records |

---

## Document Control Workflow

Establish and maintain document control per ISO 13485 Clause 4.2.3.

### Workflow: Document Creation and Approval

1. Identify need for new document or revision
2. Assign document number per numbering convention:
   - Format: `[TYPE]-[AREA]-[SEQUENCE]-[REV]`
   - Example: `SOP-02-001-01`
3. Draft document using approved template
4. Route for review to subject matter experts
5. Collect and address review comments
6. Obtain required approvals based on document type
7. Update Document Master List
8. **Validation:** Document numbered correctly; all reviewers signed; Master List updated

### Document Numbering Convention

| Prefix | Document Type | Approval Authority |
|--------|---------------|-------------------|
| QM | Quality Manual | Management Rep + CEO |
| POL | Policy | Department Head + QA |
| SOP | Procedure | Process Owner + QA |
| WI | Work Instruction | Supervisor + QA |
| TF | Template/Form | Process Owner |
| SPEC | Specification | Engineering + QA |

### Area Codes

| Code | Area | Examples |
|------|------|----------|
| 01 | Quality Management | Quality Manual, policy |
| 02 | Document Control | This procedure |
| 03 | Training | Competency procedures |
| 04 | Design | Design control |
| 05 | Purchasing | Supplier management |
| 06 | Production | Manufacturing |
| 07 | Quality Control | Inspection, testing |
| 08 | CAPA | Corrective actions |

### Document Change Control

| Change Type | Approval Level | Examples |
|-------------|----------------|----------|
| Administrative | Document Control | Typos, formatting |
| Minor | Process Owner + QA | Clarifications |
| Major | Full review cycle | Process changes |
| Emergency | Expedited + retrospective | Safety issues |

### Document Review Schedule

| Document Type | Review Period | Trigger for Unscheduled Review |
|---------------|---------------|-------------------------------|
| Quality Manual | Annual | Organizational change |
| Procedures | Annual | Audit finding, regulation change |
| Work Instructions | 2 years | Process change |
| Forms | 2 years | User feedback |

---

## Internal Audit Workflow

Plan and execute internal audits per ISO 13485 Clause 8.2.4.

### Workflow: Annual Audit Program

1. Identify processes and areas requiring audit coverage
2. Assess risk factors for audit frequency:
   - Previous audit findings
   - Regulatory changes
   - Process changes
   - Complaint trends
3. Assign qualified auditors (independent of area audited)
4. Develop annual audit schedule
5. Obtain management approval
6. Communicate schedule to process owners
7. Track completion and reschedule as needed
8. **Validation:** All processes covered; auditors qualified and independent; schedule approved

> Use the Audit Program Template in [qms-process-templates.md](references/qms-process-templates.md) to schedule audits by clause and quarter across processes such as Document Control (4.2.3/4.2.4), Management Review (5.6), Design Control (7.3), Production (7.5), and CAPA (8.5.2/8.5.3).

### Workflow: Individual Audit Execution

1. Prepare audit plan with scope, criteria, and schedule
2. Notify auditee minimum 1 week prior
3. Review procedures and previous audit results
4. Prepare audit checklist
5. Conduct opening meeting
6. Collect evidence through:
   - Document review
   - Record sampling
   - Process observation
   - Personnel interviews
7. Classify findings:
   - Major NC: Absence or breakdown of system
   - Minor NC: Single lapse or deviation
   - Observation: Risk of future NC
8. Conduct closing meeting
9. Issue audit report within 5 business days
10. **Validation:** All checklist items addressed; findings supported by evidence; report distributed

### Auditor Qualification Requirements

| Criterion | Requirement |
|-----------|-------------|
| Training | ISO 13485 awareness + auditor training |
| Experience | Minimum 1 audit as observer |
| Independence | Not auditing own work area |
| Competence | Understanding of audited process |

### Finding Classification Guide

| Classification | Criteria | Response Time |
|----------------|----------|---------------|
| Major NC | System absence, total breakdown, regulatory violation | 30 days for CAPA |
| Minor NC | Single instance, partial compliance | 60 days for CAPA |
| Observation | Potential risk, improvement opportunity | Track in next audit |

---

## Process Validation Workflow

Validate special processes per ISO 13485 Clause 7.5.6.

### Workflow: Process Validation Protocol

1. Identify processes requiring validation:
   - Output cannot be verified by inspection
   - Deficiencies appear only in use
   - Sterilization, welding, sealing, software
2. Form validation team with subject matter experts
3. Write validation protocol including:
   - Process description and parameters
   - Equipment and materials
   - Acceptance criteria
   - Statistical approach
4. Execute IQ: verify equipment installed correctly and document specifications
5. Execute OQ: test parameter ranges and verify process control
6. Execute

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
