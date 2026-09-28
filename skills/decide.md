# decide

Source: Claude skill
Original path: `components/claude-skills/c-level-advisor/c-level-agents/skills/decide/SKILL.md`
Description: /cs:decide <memo> — Log a decision to two-layer memory via decision-logger. Approved memo becomes durable; raw transcripts kept for reference.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# /tk:decide — Log the Decision

**Command:** `/tk:decide <memo-path>`

Logs the founder's decision via the `decision-logger` skill. This is the gate where in-session deliberation becomes durable company memory.

## Pipeline Position

```
/tk:office-hours  →  /tk:brief  →  /tk:boardroom  →  /tk:decide  →  /tk:execute  →  /tk:post-mortem
                                                       ↑ you are here
```

## Two-Layer Memory Model

The `decision-logger` skill maintains two layers:

1. **Raw transcripts** — every boardroom session, every advisor's Phase 2 position, every dissent. Stored under `~/.claude/decisions/raw/`. Reference only, never feeds back automatically.
2. **Approved decisions** — only the founder-signed memos. Stored under `~/.claude/decisions/approved/`. Feeds into future `/tk:office-hours` and `/tk:founder-mode` calls.

This split prevents the system from "remembering" unresolved debates as if they were decisions.

## Input

A board memo file (output of `/tk:boardroom`).

## Workflow

1. Read the memo path
2. Verify it has founder approval (status: APPROVED)
3. Extract structured decision record:
   - Decision title
   - Date decided
   - Option chosen
   - Success + kill criteria
   - Dissent (preserved)
   - Review checkpoint date
4. Append to `~/.claude/decisions/approved/<YYYY-MM-DD>-<slug>.md`
5. Update the raw transcript pointer
6. If llm-wiki bridge configured, write to vault (`~/company-vault/10-decisions/`)
7. Schedule auto-revisit (90 days)

## Output Record Format

```markdown
# Decision: <title>
**Decided:** YYYY-MM-DD
**By:** <founder name>
**Memo:** <link to boardroom memo>
**Brief:** <link to original brief>
**Review checkpoint:** YYYY-MM-DD (90d default)

## Decision
**Chose:** <option>
**Rejected:** <other options + one-line why>

## Success Criteria (binding)
- <metric, threshold, timeframe>

## Kill Criteria (binding)
- <metric, threshold, action>

## Preserved Dissent
- **<dissenter>:** <unresolved concern>
- (preserved verbatim; dissent never erased)

## Next Action
- `/tk:execute` → 90-day plan due <date>

## Status History
- YYYY-MM-DD: APPROVED
```

## Why Preserved Dissent

The biggest risk in approved decisions is forgetting why someone disagreed. When the kill criteria trigger, the dissent often turns out to have been correct. Preserving it verbatim — not summarized — keeps the company honest at post-mortem time.

## Routing

- `/tk:execute <decision>` — build the 90-day plan
- `/tk:freeze <decision> <days>` — lock if irreversible
- (Auto-scheduled) `/tk:post-mortem <decision>` — at 90-day checkpoint

## Stale-Decision Audit

`cs-chief-of-staff` runs a weekly stale audit:
- Decisions > 90 days without revisit → flag for `/tk:post-mortem`
- Decisions with kill criteria triggered → flag immediately
- Decisions whose company-context.md basis has changed → flag for re-examination

## Related

- Skill: [`decision-logger`](../../../skills/decision-logger/SKILL.md)
- Agent: [`cs-chief-of-staff`](../../agents/cs-chief-of-staff.md)
- Bridge: [`../../references/llm-wiki-bridge.md`](../../references/llm-wiki-bridge.md)

---

**Version:** 1.0.0

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
