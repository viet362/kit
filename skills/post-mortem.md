# post-mortem

Source: Claude skill
Original path: `components/claude-skills/c-level-advisor/c-level-agents/skills/post-mortem/SKILL.md`
Description: /cs:post-mortem <decision> — Honest retrospective on an executed decision, scored against original assumptions and dissent. Closes the strategic sprint loop.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# /tk:post-mortem — Honest Retrospective

**Command:** `/tk:post-mortem <decision-path>`

Closes the strategic sprint loop. Scores a decision against the success and kill criteria written **before** the decision (not retro-fitted) and revisits the preserved dissent. This is the rigor that compounds over time.

## Pipeline Position

```
/tk:office-hours  →  /tk:brief  →  /tk:boardroom  →  /tk:decide  →  /tk:execute  →  /tk:post-mortem
                                                                                       ↑ you are here
```

## When to Run

- At the 90-day checkpoint (auto-scheduled by `/tk:decide`)
- When a kill criterion triggers
- After a major decision is reversed
- Quarterly on all decisions of the past quarter

## Inputs

- The decision record (output of `/tk:decide`)
- The execution plan (output of `/tk:execute`)
- Actual outcomes (metrics, events, customer signals)

## Output: Post-Mortem Record

Saved to `~/.claude/postmortems/YYYY-MM-DD-<slug>.md`:

```markdown
# Post-Mortem: <decision title>
**Decision date:** YYYY-MM-DD
**Post-mortem date:** YYYY-MM-DD
**Status:** WIN / PARTIAL / LOSS / MIXED

## Outcome Scoring (against pre-committed criteria)

| Success Criterion | Threshold | Actual | Met? |
|---|---|---|---|
| <metric 1> | <threshold> | <actual> | ✅ / ❌ |
| <metric 2> | <threshold> | <actual> | ✅ / ❌ |

| Kill Criterion | Threshold | Actual | Triggered? |
|---|---|---|---|
| <metric> | <threshold> | <actual> | ✅ / ❌ |

**Overall:** WIN / PARTIAL / LOSS / MIXED

## What We Got Right
- <factor 1>
- <factor 2>

## What We Got Wrong
- <factor 1>
- <factor 2>

## Preserved Dissent — Revisited
[Original dissent from the boardroom memo, scored:]

- **<dissenter>:** <original concern>
  - **Did it materialize?** YES / NO / PARTIAL
  - **Cost if YES:** <quantified impact>
  - **Lesson:** <one sentence>

## Assumption Audit
[Original brief's assumptions, scored:]

- **Assumption 1:** <text>
  - **Held?** YES / NO / PARTIAL
  - **Why:** <explanation>

## Process Lessons
- **Phase 2 isolation worked?** YES / NO
- **Devil's advocate concerns played out?** YES / NO / PARTIAL
- **Cadence was right?** YES / TOO LOOSE / TOO TIGHT

## Forward Actions
- [ ] <change to operating system or routing logic>
- [ ] <new decision to make based on this learning>
- [ ] <update company-context.md>

## Status
- WIN → archive, log lesson
- LOSS → schedule follow-up boardroom: `/tk:brief` for the next call
```

## Why Pre-Committed Criteria Matter

The biggest temptation in post-mortems is retroactive justification: "we always knew X, that's why we did Y." Pre-committed criteria, signed at `/tk:decide` time, eliminate that move. The numbers either matched or they didn't.

## Why Revisit Dissent

The dissent column from `/tk:boardroom` is the single most useful piece of organizational memory. Most of the time, the dissenter was directionally right. Revisiting and scoring it builds calibration over years.

## Routing

- `/tk:brief` — if the post-mortem surfaces a new decision
- `/tk:freeze` — if the post-mortem reveals a process gap that needs cooldown enforcement
- Updates to company-context.md via `cs-onboard`

## Related

- Skill: [`decision-logger`](../../../skills/decision-logger/SKILL.md)
- Agent: [`cs-chief-of-staff`](../../agents/cs-chief-of-staff.md)
- Sibling: [`/em:postmortem`](../../../executive-mentor/skills/postmortem/SKILL.md) — adversarial single-decision post-mortem

---

**Version:** 1.0.0

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
