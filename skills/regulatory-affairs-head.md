# regulatory-affairs-head

Source: Claude skill
Original path: `components/claude-skills/ra-qm-team/skills/regulatory-affairs-head/SKILL.md`
Description: Senior Regulatory Affairs Manager for HealthTech and MedTech companies. Prepares FDA 510(k), De Novo, and PMA submission packages; analyzes regulatory pathways for new medical devices; drafts responses to FDA deficiency letters and Notified Body queries; develops CE marking technical documentation under EU MDR 2017/745; coordinates multi-market approval strategies across FDA, EU, Health Canada, PMDA, and NMPA; and maintains regulatory intelligence on evolving standards. Use when users need to plan or execute FDA submissions, navigate 510(k) or PMA approval processes, achieve CE marking, prepare pre-submission meeting materials, write regulatory strategy documents, respond to agency queries, or manage compliance documentation for medical device market access.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Head of Regulatory Affairs

Regulatory strategy development, submission management, and global market access for medical device organizations.

---

## Table of Contents

- [Regulatory Strategy Workflow](#regulatory-strategy-workflow)
- [FDA Submission Workflow](#fda-submission-workflow)
- [EU MDR Submission Workflow](#eu-mdr-submission-workflow)
- [Global Market Access Workflow](#global-market-access-workflow)
- [Regulatory Intelligence Workflow](#regulatory-intelligence-workflow)
- [Decision Frameworks](#decision-frameworks)
- [Tools and References](#tools-and-references)

---

## Regulatory Strategy Workflow

Develop regulatory strategy aligned with business objectives and product characteristics.

### Workflow: New Product Regulatory Strategy

1. Gather product information:
   - Intended use and indications
   - Device classification (risk level)
   - Technology platform
   - Target markets and timeline
2. Identify applicable regulations per target market:
   - FDA (US): 21 CFR Part 820, 510(k)/PMA/De Novo
   - EU: MDR 2017/745, Notified Body requirements
   - Other markets: Health Canada, PMDA, NMPA, TGA
3. Determine optimal regulatory pathway:
   - Compare submission types (510(k) vs De Novo vs PMA)
   - Assess predicate device availability
   - Evaluate clinical evidence requirements
4. Develop regulatory timeline with milestones
5. Estimate resource requirements and budget
6. Identify regulatory risks and mitigation strategies
7. Obtain stakeholder alignment and approval
8. **Validation:** Strategy document approved; timeline accepted; resources allocated

### Regulatory Pathway Selection Matrix

| Factor | 510(k) | De Novo | PMA |
|--------|--------|---------|-----|
| Predicate Available | Yes | No | N/A |
| Risk Level | Low-Moderate | Low-Moderate | High |
| Clinical Data | Usually not required | May be required | Required |
| Review Time | 90 days (MDUFA) | 150 days | 180 days |
| User Fee | ~$22K (2024) | ~$135K | ~$440K |
| Best For | Me-too devices | Novel low-risk | High-risk, novel |

### Regulatory Strategy Document Template

```
REGULATORY STRATEGY

Product: [Name]   Version: [X.X]   Date: [Date]

1. PRODUCT OVERVIEW
   Intended use: [One-sentence statement of intended patient population, body site, and clinical purpose]
   Device classification: [Class I / II / III]
   Technology: [Brief description, e.g., "AI-powered wound-imaging software, SaMD"]

2. TARGET MARKETS & TIMELINE
   | Market | Pathway        | Priority | Target Date |
   |--------|----------------|----------|-------------|
   | USA    | 510(k) / PMA   | 1        | Q1 20XX     |
   | EU     | Class [X] MDR  | 2        | Q2 20XX     |

3. REGULATORY PATHWAY RATIONALE
   FDA: [510(k) / De Novo / PMA] — Predicate: [K-number or "none"]
   EU:  Class [X] via [Annex IX / X / XI] — NB: [Name or TBD]
   Rationale: [2–3 sentences on key factors driving pathway choice]

4. CLINICAL EVIDENCE STRATEGY
   Requirements: [Summarize what each market needs, e.g., "510(k): bench + usability; EU Class IIb: PMCF study"]
   Approach: [Literature review / Prospective study / Combination]

5. RISKS AND MITIGATION
   | Risk                         | Prob | Impact | Mitigation                        |
   |------------------------------|------|--------|-----------------------------------|
   | Predicate delisted by FDA    | Low  | High   | Identify secondary predicate now  |
   | NB audit backlog             | Med  | Med    | Engage NB 6 months before target  |

6. RESOURCE REQUIREMENTS
   Budget: $[Amount]   Personnel: [FTEs]   External: [Consultants / CRO]
```

---

## FDA Submission Workflow

Prepare and submit FDA regulatory applications.

### Workflow: 510(k) Submission

1. Confirm 510(k) pathway suitability:
   - Predicate device identified (note K-number, e.g., K213456)
   - Substantial equivalence (SE) argument supportable on intended use and technological characteristics
   - No new intended use or technology concerns triggering De Novo
2. Schedule and conduct Pre-Submission (Q-Sub) meeting if needed (see [Pre-Sub Decision](#pre-submission-meeting-decision))
3. Compile submission package checklist:
   - [ ] Cover letter with device name, product code, and predicate K-number
   - [ ] Section 1: Administrative information (applicant, contact, 510(k) type)
   - [ ] Section 2: Device description — include photos, dimensions, materials list
   - [ ] Section 3: Intended use and indications for use
   - [ ] Section 4: Substantial equivalence comparison table (see example below)
   - [ ] Section 5: Performance testing — protocols, standards cited, pass/fail results
   - [ ] Section 6: Biocompatibility summary (ISO 10993-1 risk assessment, if patient contact)
   - [ ] Section 7: Software documentation (IEC 62304 level, cybersecurity per FDA guidance, if applicable)
   - [ ] Section 8: Labeling — final draft IFU, device label
   - [ ] Section 9: Summary and conclusion
4. Conduct internal review and quality check against FDA RTA checklist
5. Prepare eCopy per FDA format requirements (PDF bookmarked, eCopy cover page)
6. Submit via FDA ESG portal with user fee payment
7. Monitor MDUFA clock and respond to AI/RTA requests within deadlines
8. **Validation:** Submission accepted; MDUFA date received; tracking system updated

#### Substantial Equivalence Comparison Example

| Characteristic | Predicate (K213456) | Subject Device | Same? | Notes |
|----------------|---------------------|----------------|-------|-------|
| Intended use | Wound measurement | Wound measurement | ✓ | Identical |
| Technology | 2D camera | 2D + AI analysis | ✗ | New TC; address below |
| Energy type | Non-energized | Non-energized | ✓ | |
| Patient contact | No | No | ✓ | |
| SE conclusion | New TC does not raise new safety/effectiveness questions; bench data demonstrates equivalent accuracy (±2mm vs ±3mm predicate) |

### Workflow: PMA Submission

1. Confirm PMA pathway:
   - Class III device or no suitable predicate
   - Clinical data strategy defined
2. Complete IDE clinical study if required:
   - IDE approval
   - Clinical protocol execution
   - Study report completion
3. Conduct Pre-Submission meeting
4. Compile PMA submission checklist:
   - [ ] Volume I: Administrative, device description, manufacturing
   - [ ] Volume II: Nonclinical studies (bench, animal, biocompatibility)
   - [ ] Volume III: Clinical studies (IDE protocol, data, statistical analysis)
   - [ ] Volume IV: Labeling
   - [ ] Volume V: Manufacturing information, sterilization
5. Submit original PMA application
6. Address FDA questions and deficiencies
7. Prepare for FDA facility inspection
8. **Validation:** PMA approved; approval letter received; post-approval requirements documented

### FDA Submission Timeline

| Milestone | 510(k) | De Novo | PMA |
|-----------|--------|---------|-----|
| Pre-Sub Meeting | Day -90 | Day -90 | Day -120 |
| Submission | Day 0 | Day 0 | Day 0 |
| RTA Review | Day 15 | Day 15 | Day 45 |
| Substantive Review | Days 15–90 | Days 15

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
