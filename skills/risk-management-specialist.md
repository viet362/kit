# risk-management-specialist

Source: Claude skill
Original path: `components/claude-skills/ra-qm-team/skills/risk-management-specialist/SKILL.md`
Description: Medical device risk management specialist implementing ISO 14971 throughout product lifecycle. Provides risk analysis, risk evaluation, risk control, and post-production information analysis. Use when user mentions risk management, ISO 14971, risk analysis, FMEA, fault tree analysis, hazard identification, risk control, risk matrix, benefit-risk analysis, residual risk, risk acceptability, or post-market risk.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Risk Management Specialist

ISO 14971:2019 risk management implementation throughout the medical device lifecycle.

---

## Table of Contents

- [Risk Management Planning Workflow](#risk-management-planning-workflow)
- [Risk Analysis Workflow](#risk-analysis-workflow)
- [Risk Evaluation Workflow](#risk-evaluation-workflow)
- [Risk Control Workflow](#risk-control-workflow)
- [Post-Production Risk Management](#post-production-risk-management)
- [Risk Assessment Templates](#risk-assessment-templates)
- [Decision Frameworks](#decision-frameworks)
- [Tools and References](#tools-and-references)

---

## Risk Management Planning Workflow

Establish risk management process per ISO 14971.

### Workflow: Create Risk Management Plan

1. Define scope of risk management activities:
   - Medical device identification
   - Lifecycle stages covered
   - Applicable standards and regulations
2. Establish risk acceptability criteria:
   - Define probability categories (P1-P5)
   - Define severity categories (S1-S5)
   - Create risk matrix with acceptance thresholds
3. Assign responsibilities:
   - Risk management lead
   - Subject matter experts
   - Approval authorities
4. Define verification activities:
   - Methods for control verification
   - Acceptance criteria
5. Plan production and post-production activities:
   - Information sources
   - Review triggers
   - Update procedures
6. Obtain plan approval
7. Establish risk management file
8. **Validation:** Plan approved; acceptability criteria defined; responsibilities assigned; file established

### Risk Management Plan Content

| Section | Content | Evidence |
|---------|---------|----------|
| Scope | Device and lifecycle coverage | Scope statement |
| Criteria | Risk acceptability matrix | Risk matrix document |
| Responsibilities | Roles and authorities | RACI chart |
| Verification | Methods and acceptance | Verification plan |
| Production/Post-Production | Monitoring activities | Surveillance plan |

### Risk Acceptability Matrix (5x5)

| Probability \ Severity | Negligible | Minor | Serious | Critical | Catastrophic |
|------------------------|------------|-------|---------|----------|--------------|
| **Frequent (P5)** | Medium | High | High | Unacceptable | Unacceptable |
| **Probable (P4)** | Medium | Medium | High | High | Unacceptable |
| **Occasional (P3)** | Low | Medium | Medium | High | High |
| **Remote (P2)** | Low | Low | Medium | Medium | High |
| **Improbable (P1)** | Low | Low | Low | Medium | Medium |

### Risk Level Actions

| Level | Acceptable | Action Required |
|-------|------------|-----------------|
| Low | Yes | Document and accept |
| Medium | ALARP | Reduce if practicable; document rationale |
| High | ALARP | Reduction required; demonstrate ALARP |
| Unacceptable | No | Design change mandatory |

---

## Risk Analysis Workflow

Identify hazards and estimate risks systematically.

### Workflow: Conduct Risk Analysis

1. Define intended use and reasonably foreseeable misuse:
   - Medical indication
   - Patient population
   - User population
   - Use environment
2. Select analysis method(s):
   - FMEA for component/function analysis
   - FTA for system-level analysis
   - HAZOP for process deviations
   - Use Error Analysis for user interaction
3. Identify hazards by category:
   - Energy hazards (electrical, mechanical, thermal)
   - Biological hazards (bioburden, biocompatibility)
   - Chemical hazards (residues, leachables)
   - Operational hazards (software, use errors)
4. Determine hazardous situations:
   - Sequence of events
   - Foreseeable misuse scenarios
   - Single fault conditions
5. Estimate probability of harm (P1-P5)
6. Estimate severity of harm (S1-S5)
7. Document in hazard analysis worksheet
8. **Validation:** All hazard categories addressed; all hazards documented; probability and severity assigned

### Hazard Categories Checklist

| Category | Examples | Analyzed |
|----------|----------|----------|
| Electrical | Shock, burns, interference | ☐ |
| Mechanical | Crushing, cutting, entrapment | ☐ |
| Thermal | Burns, tissue damage | ☐ |
| Radiation | Ionizing, non-ionizing | ☐ |
| Biological | Infection, biocompatibility | ☐ |
| Chemical | Toxicity, irritation | ☐ |
| Software | Incorrect output, timing | ☐ |
| Use Error | Misuse, perception, cognition | ☐ |
| Environment | EMC, mechanical stress | ☐ |

### Analysis Method Selection

| Situation | Recommended Method |
|-----------|-------------------|
| Component failures | FMEA |
| System-level failure | FTA |
| Process deviations | HAZOP |
| User interaction | Use Error Analysis |
| Software behavior | Software FMEA |
| Early design phase | PHA |

### Probability Criteria

| Level | Name | Description | Frequency |
|-------|------|-------------|-----------|
| P5 | Frequent | Expected to occur | >10⁻³ |
| P4 | Probable | Likely to occur | 10⁻³ to 10⁻⁴ |
| P3 | Occasional | May occur | 10⁻⁴ to 10⁻⁵ |
| P2 | Remote | Unlikely | 10⁻⁵ to 10⁻⁶ |
| P1 | Improbable | Very unlikely | <10⁻⁶ |

### Severity Criteria

| Level | Name | Description | Harm |
|-------|------|-------------|------|
| S5 | Catastrophic | Death | Death |
| S4 | Critical | Permanent impairment | Irreversible injury |
| S3 | Serious | Injury requiring intervention | Reversible injury |
| S2 | Minor | Temporary discomfort | No treatment needed |
| S1 | Negligible | Inconvenience | No injury |

See: [references/risk-analysis-methods.md](references/risk-analysis-methods.md)

---

## Risk Evaluation Workflow

Evaluate risks against acceptability criteria.

### Workflow: Evaluate Identified Risks

1. Calculate initial risk level from probability × severity
2. Compare to risk acceptability criteria
3. For each risk, determine:
   - Acceptable: Document and accept
   - ALARP: Proceed to risk control
   - Unacceptable: Mandatory risk control
4. Document evaluation rationale
5. Identify risks requiring benefit-risk analysis
6. Complete benefit-risk analysis if applicable
7. Compile risk evaluation summary
8. **Validation:** All risks evaluated; acceptability determined; rationale documented

### Risk Evaluation Decision Tree

```
Risk Estimated
      │
      ▼
Apply Acceptability Criteria
      │
      ├── Low Risk ──────────► Accept and document
      │
      ├── Medium Risk ───────► Consider risk reduction
      │   │                    Document ALARP if not reduced
      │   ▼
      │   Practicable to reduce?
      │   │
      │   Yes──► Implement control
      │   No───► Document ALARP rationale
      │
      ├── High Risk ─────────► Risk reduction required
      │   │                    Must demonstrate ALARP
      │   ▼
      │   Implement control
      │   Verify residual risk
      │
      └── Unacceptable ──────► Design change mandatory
                               Cannot proceed without control
```

### ALARP Demonstration Requirements

| Criterion | Evidence Required |
|-----------|-------------------|
| Technical feasibility | Analysis of alternative controls

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
