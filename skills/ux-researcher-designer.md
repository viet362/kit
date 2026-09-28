# ux-researcher-designer

Source: Claude skill
Original path: `components/claude-skills/product-team/skills/ux-researcher-designer/SKILL.md`
Description: UX research and design toolkit for Senior UX Designer/Researcher including data-driven persona generation, journey mapping, usability testing frameworks, and research synthesis. Use for user research, persona creation, journey mapping, and design validation.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# UX Researcher & Designer

Generate user personas from research data, create journey maps, plan usability tests, and synthesize research findings into actionable design recommendations.

---

## Table of Contents

- [Trigger Terms](#trigger-terms)
- [Workflows](#workflows)
  - [Workflow 1: Generate User Persona](#workflow-1-generate-user-persona)
  - [Workflow 2: Create Journey Map](#workflow-2-create-journey-map)
  - [Workflow 3: Plan Usability Test](#workflow-3-plan-usability-test)
  - [Workflow 4: Synthesize Research](#workflow-4-synthesize-research)
- [Tool Reference](#tool-reference)
- [Quick Reference Tables](#quick-reference-tables)
- [Knowledge Base](#knowledge-base)

---

## Trigger Terms

Use this skill when you need to:

- "create user persona"
- "generate persona from data"
- "build customer journey map"
- "map user journey"
- "plan usability test"
- "design usability study"
- "analyze user research"
- "synthesize interview findings"
- "identify user pain points"
- "define user archetypes"
- "calculate research sample size"
- "create empathy map"
- "identify user needs"

---

## Workflows

### Workflow 1: Generate User Persona

**Situation:** You have user data (analytics, surveys, interviews) and need to create a research-backed persona.

**Steps:**

1. **Prepare user data**

   Required format (JSON):
   ```json
   [
     {
       "user_id": "user_1",
       "age": 32,
       "usage_frequency": "daily",
       "features_used": ["dashboard", "reports", "export"],
       "primary_device": "desktop",
       "usage_context": "work",
       "tech_proficiency": 7,
       "pain_points": ["slow loading", "confusing UI"]
     }
   ]
   ```

2. **Run persona generator**
   ```bash
   # Human-readable output
   python scripts/persona_generator.py

   # JSON output for integration
   python scripts/persona_generator.py json
   ```

3. **Review generated components**

   | Component | What to Check |
   |-----------|---------------|
   | Archetype | Does it match the data patterns? |
   | Demographics | Are they derived from actual data? |
   | Goals | Are they specific and actionable? |
   | Frustrations | Do they include frequency counts? |
   | Design implications | Can designers act on these? |

4. **Validate persona**

   - Show to 3-5 real users: "Does this sound like you?"
   - Cross-check with support tickets
   - Verify against analytics data

5. **Reference:** See `references/persona-methodology.md` for validity criteria

---

### Workflow 2: Create Journey Map

**Situation:** You need to visualize the end-to-end user experience for a specific goal.

**Steps:**

1. **Define scope**

   | Element | Description |
   |---------|-------------|
   | Persona | Which user type |
   | Goal | What they're trying to achieve |
   | Start | Trigger that begins journey |
   | End | Success criteria |
   | Timeframe | Hours/days/weeks |

2. **Gather journey data**

   Sources:
   - User interviews (ask "walk me through...")
   - Session recordings
   - Analytics (funnel, drop-offs)
   - Support tickets

3. **Map the stages**

   Typical B2B SaaS stages:
   ```
   Awareness → Evaluation → Onboarding → Adoption → Advocacy
   ```

4. **Fill in layers for each stage**

   ```
   Stage: [Name]
   ├── Actions: What does user do?
   ├── Touchpoints: Where do they interact?
   ├── Emotions: How do they feel? (1-5)
   ├── Pain Points: What frustrates them?
   └── Opportunities: Where can we improve?
   ```

5. **Identify opportunities**

   Priority Score = Frequency × Severity × Solvability

6. **Reference:** See `references/journey-mapping-guide.md` for templates

---

### Workflow 3: Plan Usability Test

**Situation:** You need to validate a design with real users.

**Steps:**

1. **Define research questions**

   Transform vague goals into testable questions:

   | Vague | Testable |
   |-------|----------|
   | "Is it easy to use?" | "Can users complete checkout in <3 min?" |
   | "Do users like it?" | "Will users choose Design A or B?" |
   | "Does it make sense?" | "Can users find settings without hints?" |

2. **Select method**

   | Method | Participants | Duration | Best For |
   |--------|--------------|----------|----------|
   | Moderated remote | 5-8 | 45-60 min | Deep insights |
   | Unmoderated remote | 10-20 | 15-20 min | Quick validation |
   | Guerrilla | 3-5 | 5-10 min | Rapid feedback |

3. **Design tasks**

   Good task format:
   ```
   SCENARIO: "Imagine you're planning a trip to Paris..."
   GOAL: "Book a hotel for 3 nights in your budget."
   SUCCESS: "You see the confirmation page."
   ```

   Task progression: Warm-up → Core → Secondary → Edge case → Free exploration

4. **Define success metrics**

   | Metric | Target |
   |--------|--------|
   | Completion rate | >80% |
   | Time on task | <2× expected |
   | Error rate | <15% |
   | Satisfaction | >4/5 |

5. **Prepare moderator guide**

   - Think-aloud instructions
   - Non-leading prompts
   - Post-task questions

6. **Reference:** See `references/usability-testing-frameworks.md` for full guide

---

### Workflow 4: Synthesize Research

**Situation:** You have raw research data (interviews, surveys, observations) and need actionable insights.

**Steps:**

1. **Code the data**

   Tag each data point:
   - `[GOAL]` - What they want to achieve
   - `[PAIN]` - What frustrates them
   - `[BEHAVIOR]` - What they actually do
   - `[CONTEXT]` - When/where they use product
   - `[QUOTE]` - Direct user words

2. **Cluster similar patterns**

   ```
   User A: Uses daily, advanced features, shortcuts
   User B: Uses daily, complex workflows, automation
   User C: Uses weekly, basic needs, occasional

   Cluster 1: A, B (Power Users)
   Cluster 2: C (Casual User)
   ```

3. **Calculate segment sizes**

   | Cluster | Users | % | Viability |
   |---------|-------|---|-----------|
   | Power Users | 18 | 36% | Primary persona |
   | Business Users | 15 | 30% | Primary persona |
   | Casual Users | 12 | 24% | Secondary persona |

4. **Extract key findings**

   For each theme:
   - Finding statement
   - Supporting evidence (quotes, data)
   - Frequency (X/Y participants)
   - Business impact
   - Recommendation

5. **Prioritize opportunities**

   | Factor | Score 1-5 |
   |--------|-----------|
   | Frequency | How often does this occur? |
   | Severity | How much does it hurt? |
   | Breadth | How many users affected? |
   | Solvability | Can we fix this? |

6. **Reference:** See `references/persona-methodology.md` for analysis framework

---

## Tool Reference

### persona_generator.py

Generates data-driven personas from user research data.

| Argument | Values | Default | Description |
|----------|--------|---------|-------------|
| format | (none), json | (none) | Output format |

**Sample Output:**

```
============================================================
PERSONA: Alex the Power User
============================================================

📝 A daily user who primarily uses the product for

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
