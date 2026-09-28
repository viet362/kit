# iso42001-specialist

Source: Claude skill
Original path: `components/claude-skills/ra-qm-team/skills/iso42001-specialist/SKILL.md`
Description: ISO/IEC 42001:2023 AI Management System (AIMS) specialist for compliance teams running internal audits. Three decisions: (1) Where are the gaps against Clauses 4-10 and what do we close first? (2) What goes in the AI risk register and which Annex A controls treat each risk? (3) What's the 12-month internal audit plan that satisfies Clause 9.2? Use when preparing for certification, scoping internal audit cycles, or onboarding AI systems into an existing ISMS (27001) / QMS (13485) program. NOT an executive AI strategy skill (see chief-ai-officer-advisor). NOT EU AI Act compliance (see compliance-team-eu-ai-act).

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# ISO/IEC 42001 AI Management System Specialist

Internal-audit-grade operating skill for ISO/IEC 42001:2023. **Three decisions, no executive AI strategy:**

1. **Where are the AIMS gaps against Clauses 4–10?** — coverage scoring per clause + remediation priority
2. **What's the AI risk register, and which controls treat each risk?** — Annex A.2–A.10 control mapping per ISO 23894 risk method
3. **What's the Clause 9.2 internal audit plan?** — 12-month schedule with scope, frequency, auditor independence checks

This skill is **NOT a chief-ai-officer-advisor replacement**. CAIO decides whether to build/buy a model and what business risk to accept. This skill operates the management-system discipline that captures those decisions in audit-ready evidence.

This skill is **NOT an EU AI Act compliance skill**. ISO 42001 is a voluntary management-system standard; EU AI Act is binding product-safety regulation. They overlap (a high-risk AI system per Article 6(2) of the AI Act typically requires the QMS in Article 17, which ISO 42001 can satisfy in part) but the artefacts differ. See `compliance-team-eu-ai-act` for Article-level conformity assessment.

This skill is **NOT a substitute for ISO 23894 + 38507**. 42001 is the management system; 23894 is the AI risk methodology that feeds Clause 6.1; 38507 is the governance lens. The `ai_risk_register_builder.py` tool implements the 23894 process; treat the references as the methodology bridge.

## Keywords

ISO 42001, ISO/IEC 42001:2023, AI Management System, AIMS, AI governance, AI risk management, ISO 23894, AI risk assessment, ISO 38507, AI compliance, AI audit, internal audit AI, Annex A controls, AI risk register, AI policy, AI impact assessment, conformity declaration, AI lifecycle, AI risk treatment, NIST AI RMF, NIST AI Risk Management Framework, ISACA AI audit, BSI AIC4, AI assurance, responsible AI, AI ethics governance, AI system inventory, third-party AI risk, AI vendor management, AI change management, AI incident management

## Quick Start

```bash
# Decision A: AIMS gap analysis against Clauses 4-10
python scripts/aims_gap_analyzer.py                           # embedded sample (mid-stage AI SaaS)
python scripts/aims_gap_analyzer.py path/to/aims_evidence.json

# Decision B: AI risk register + Annex A control mapping
python scripts/ai_risk_register_builder.py                    # embedded 7-risk sample
python scripts/ai_risk_register_builder.py path/to/risks.json

# Decision C: Clause 9.2 internal audit 12-month plan
python scripts/aims_audit_scheduler.py                        # embedded 4-domain sample
python scripts/aims_audit_scheduler.py path/to/scope.json
```

## Key Questions (ask these first)

- **Does the AIMS scope statement (Clause 4.3) name every AI system, including embedded models and third-party AI services?** If "AI features added by our SaaS vendors" is not in scope, the AIMS is incomplete.
- **Does the AI policy (Clause 5.2) commit to lawful use AND beneficial purpose AND human oversight AND continual improvement?** Missing any of the four = nonconformity at certification.
- **Has the AI risk assessment (Clause 6.1.2) been re-run since the last material model change?** Concept drift is not a one-time event.
- **Who signs the AI impact assessment for high-impact systems (Annex A.5.4)?** If no signed accountability, the control is missing.
- **What's the internal audit cadence (Clause 9.2)?** ISO management-system standards expect ≥ once per 3-year cycle per clause; mature programs do annual.
- **Is there a documented procedure for AI incidents (Annex A.9.3)?** Untreated post-deployment monitoring is the #1 nonconformity in early adopters.

## Core Responsibilities

### 1. AIMS Gap Analysis (Clauses 4–10)

**The framework:** ISO 42001 follows the Annex SL high-level structure shared with ISO 9001 / 27001 / 13485. Clauses 4–10 are the management-system requirements; Annex A controls A.1–A.10 are the AI-specific operational controls.

| Clause | What it requires | Common gap |
|---|---|---|
| **4. Context** | AI scope, interested parties, external context | Scope omits third-party AI services |
| **5. Leadership** | AI policy, roles, accountability | Policy treats "AI ethics" as marketing copy, not commitment |
| **6. Planning** | AI risk + impact assessment, objectives | Risk register doesn't link to controls |
| **7. Support** | Resources, competence, awareness, documented info | Competence requirements undefined for ML engineers |
| **8. Operation** | Operational planning, AI system lifecycle | Lifecycle stages not mapped to Annex A controls |
| **9. Performance** | Monitoring, internal audit, management review | Drift monitoring exists in code but not in management review inputs |
| **10. Improvement** | Nonconformity, corrective action, continual improvement | CAPA loop separate from existing 13485/9001 CAPA — duplication |

**Run** `aims_gap_analyzer.py` with an evidence inventory JSON to score each clause (full / partial / missing) and get a prioritized remediation list.

See `references/iso42001_clauses.md` for the full clause-by-clause walkthrough with audit evidence expectations.

### 2. AI Risk Register + Annex A Control Mapping

**The framework:** Clause 6.1.2 requires AI risk assessment; Clause 6.1.3 requires risk treatment. Annex A provides 38 controls organized into 10 control categories (A.2–A.10). The risk register must show each identified risk linked to ≥ 1 control that treats it.

**Annex A control categories (the 10):**

| ID | Category | Example controls |
|---|---|---|
| **A.2** | AI policy | A.2.2 AI policy, A.2.3 alignment with other policies |
| **A.3** | Internal organization | A.3.2 AI roles & responsibilities, A.3.3 reporting concerns |
| **A.4** | Resources for AI systems | A.4.2 data resources, A.4.3 tooling, A.4.4 human resources |
| **A.5** | Assessing impacts | A.5.2 AI system impact assessment, A.5.4 documentation of impact assessment |
| **A.6** | AI system lifecycle | A.6.2.2 objectives, A.6.2.3 lifecycle phases, A.6.2.4 verification & validation |
| **A.7** | Data for AI systems | A.7.2 data management, A.7.3 data quality, A.7.4 data provenance, A.7.5 data preparation |
| **A.8** | Information for interested parties | A.8.2 system documentation, A.8.3 user information, A.8.4 communication of incidents |
| **A.9** | Use of AI systems | A.9.2 intended use, A.9.3 monitoring of operation, A.9.4 logging of system events |
| **A.10** | Third-party & customer relationships | A.10.2 supplier relationships, A.10.3 customer relationships |

ISO/IEC 23894:2023 provides the AI-specific risk-management process (the methodology); 42001 Annex A provides the controls. The risk register is the bridge.

**Run** `ai_risk_register_builder.py` with an identified-risks JSON to produce a structured register with mapped controls + residual-risk verdict per ISO 23894 risk-treatment options.

See `references/aims_controls_annex_a.md` for the full 38-control catalogue with audit evidence pe

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
