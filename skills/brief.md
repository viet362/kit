# brief

Source: Claude skill
Original path: `components/claude-skills/c-level-advisor/c-level-agents/skills/brief/SKILL.md`
Description: /cs:brief <topic> — Generate a one-page strategy brief from an office-hours intake. First step in the strategic sprint pipeline.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# /tk:brief — One-Page Strategy Brief

**Command:** `/tk:brief <topic>` or `/tk:brief <office-hours-output>`

Turns intake (raw question or office-hours output) into a one-page strategy brief that the boardroom can deliberate on. This is **Step 1** of the strategic sprint pipeline.

## Pipeline Position

```
/tk:office-hours  →  /tk:brief  →  /tk:boardroom  →  /tk:decide  →  /tk:execute  →  /tk:post-mortem
                       ↑ you are here
```

## Inputs

- A topic string, **or**
- An office-hours brief (preferred — more rigor)
- `~/.claude/company-context.md` (loaded automatically)

## Output

A single Markdown file under `~/.claude/briefs/YYYY-MM-DD-<slug>.md` with this structure:

```markdown
# Strategy Brief: <topic>
**Date:** YYYY-MM-DD
**Author:** cs-chief-of-staff
**Status:** DRAFT | UNDER REVIEW | APPROVED | RETIRED

## Context
[1-2 paragraphs: where the company sits today on this topic — pulled from company-context.md]

## Question
[The one sentence question the boardroom must answer]

## Options
1. **Option A:** <name> — <one-sentence summary>
2. **Option B:** <name> — <one-sentence summary>
3. **Option C:** <name> — <one-sentence summary>

(Minimum 2 options. "Do nothing" is always an option.)

## Assumptions
- <assumption 1 — explicit>
- <assumption 2>
- <assumption 3>

## Constraints
- Time: <by when must this decide>
- Money: <budget envelope>
- People: <who can / can't be reallocated>
- Reversibility: <one-way door | two-way door>

## Affected Roles
[Which cs-* advisors should weigh in. Used to route to /tk:boardroom panel composition.]

- [ ] cs-ceo-advisor
- [ ] cs-cfo-advisor
- [ ] cs-cto-advisor
- [ ] cs-cmo-advisor
- [ ] cs-cro-advisor
- [ ] cs-cpo-advisor
- [ ] cs-coo-advisor
- [ ] cs-chro-advisor
- [ ] cs-ciso-advisor
- [ ] cs-chief-of-staff

## Success Criteria
[Measurable outcomes that define success — set BEFORE the decision]
- <metric 1, threshold, timeframe>
- <metric 2, threshold, timeframe>

## Kill Criteria
[What signal would tell you in 90 days that this was the wrong call]
- <metric, threshold, action if missed>
```

## Workflow

1. Load company-context.md via context-engine
2. If input is office-hours output, parse the 6 answers
3. If input is a raw topic, prompt the founder for the missing pieces
4. Draft 2-3 options (never just one — every brief needs a counterfactual)
5. Make assumptions and constraints explicit
6. Identify affected roles → drives panel composition for `/tk:boardroom`
7. Write success + kill criteria BEFORE the decision (this is the rigor moment)
8. Save to `~/.claude/briefs/`

## Why This Step Exists

The biggest decision-making failure is debating implementation before agreeing on the question. The brief locks the question, options, and success criteria so the boardroom can deliberate without scope creep.

This is also the **artifact handoff** — the next command consumes this file, not your memory.

## Routing

- `/tk:boardroom <brief>` — multi-role deliberation
- `/tk:cross-eval <brief>` — multi-model sanity check before boardroom (for high-stakes)
- `/tk:freeze <brief>` — cooldown lock for irreversible decisions

## Related

- Agent: [`cs-chief-of-staff`](../../agents/cs-chief-of-staff.md)
- Skills: [`context-engine`](../../../skills/context-engine/SKILL.md), [`board-meeting`](../../../skills/board-meeting/SKILL.md)

---

**Version:** 1.0.0

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
