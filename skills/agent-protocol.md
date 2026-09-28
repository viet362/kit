# agent-protocol

Source: Claude skill
Original path: `components/claude-skills/c-level-advisor/skills/agent-protocol/SKILL.md`
Description: Inter-agent communication protocol for C-suite agent teams. Defines invocation syntax, loop prevention, isolation rules, and response formats. Use when C-suite agents need to query each other, coordinate cross-functional analysis, or run board meetings with multiple agent roles.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Inter-Agent Protocol

How C-suite agents talk to each other. Rules that prevent chaos, loops, and circular reasoning.

## Keywords
agent protocol, inter-agent communication, agent invocation, agent orchestration, multi-agent, c-suite coordination, agent chain, loop prevention, agent isolation, board meeting protocol

## Invocation Syntax

Any agent can query another using:

```
[INVOKE:role|question]
```

**Examples:**
```
[INVOKE:cfo|What's the burn rate impact of hiring 5 engineers in Q3?]
[INVOKE:cto|Can we realistically ship this feature by end of quarter?]
[INVOKE:chro|What's our typical time-to-hire for senior engineers?]
[INVOKE:cro|What does our pipeline look like for the next 90 days?]
```

**Valid roles:** `ceo`, `cfo`, `cro`, `cmo`, `cpo`, `cto`, `chro`, `coo`, `ciso`

## Response Format

Invoked agents respond using this structure:

```
[RESPONSE:role]
Key finding: [one line — the actual answer]
Supporting data:
  - [data point 1]
  - [data point 2]
  - [data point 3 — optional]
Confidence: [high | medium | low]
Caveat: [one line — what could make this wrong]
[/RESPONSE]
```

**Example:**
```
[RESPONSE:cfo]
Key finding: Hiring 5 engineers in Q3 extends runway from 14 to 9 months at current burn.
Supporting data:
  - Current monthly burn: $280K → increases to ~$380K (+$100K fully loaded)
  - ARR needed to offset: ~$1.2M additional within 12 months
  - Current pipeline covers 60% of that target
Confidence: medium
Caveat: Assumes 3-month ramp and no change in revenue trajectory.
[/RESPONSE]
```

## Loop Prevention (Hard Rules)

These rules are enforced unconditionally. No exceptions.

### Rule 1: No Self-Invocation
An agent cannot invoke itself.
```
❌ CFO → [INVOKE:cfo|...] — BLOCKED
```

### Rule 2: Maximum Depth = 2
Chains can go A→B→C. The third hop is blocked.
```
✅ CRO → CFO → COO (depth 2)
❌ CRO → CFO → COO → CHRO (depth 3 — BLOCKED)
```

### Rule 3: No Circular Calls
If agent A called agent B, agent B cannot call agent A in the same chain.
```
✅ CRO → CFO → CMO
❌ CRO → CFO → CRO (circular — BLOCKED)
```

### Rule 4: Chain Tracking
Each invocation carries its call chain. Format:
```
[CHAIN: cro → cfo → coo]
```
Agents check this chain before responding with another invocation.

**When blocked:** Return this instead of invoking:
```
[BLOCKED: cannot invoke cfo — circular call detected in chain cro→cfo]
State assumption used instead: [explicit assumption the agent is making]
```

## Isolation Rules

### Board Meeting Phase 2 (Independent Analysis)
**NO invocations allowed.** Each role forms independent views before cross-pollination.
- Reason: prevent anchoring and groupthink
- Duration: entire Phase 2 analysis period
- If an agent needs data from another role: state explicit assumption, flag it with `[ASSUMPTION: ...]`

### Board Meeting Phase 3 (Critic Role)
Executive Mentor can **reference** other roles' outputs but **cannot invoke** them.
- Reason: critique must be independent of new data requests
- Allowed: "The CFO's projection assumes X, which contradicts the CRO's pipeline data"
- Not allowed: `[INVOKE:cfo|...]` during critique phase

### Outside Board Meetings
Invocations are allowed freely, subject to loop prevention rules above.

## When to Invoke vs When to Assume

**Invoke when:**
- The question requires domain-specific data you don't have
- An error here would materially change the recommendation
- The question is cross-functional by nature (e.g., hiring impact on both budget and capacity)

**Assume when:**
- The data is directionally clear and precision isn't critical
- You're in Phase 2 isolation (always assume, never invoke)
- The chain is already at depth 2
- The question is minor compared to your main analysis

**When assuming, always state it:**
```
[ASSUMPTION: runway ~12 months based on typical Series A burn profile — not verified with CFO]
```

## Conflict Resolution

When two invoked agents give conflicting answers:

1. **Flag the conflict explicitly:**
   ```
   [CONFLICT: CFO projects 14-month runway; CRO expects pipeline to close 80% → implies 18+ months]
   ```
2. **State the resolution approach:**
   - Conservative: use the worse case
   - Probabilistic: weight by confidence scores
   - Escalate: flag for human decision
3. **Never silently pick one** — surface the conflict to the user.

## Broadcast Pattern (Crisis / CEO)

CEO can broadcast to all roles simultaneously:
```
[BROADCAST:all|What's the impact if we miss the fundraise?]
```

Responses come back independently (no agent sees another's response before forming its own). Aggregate after all respond.

## Quick Reference

| Rule | Behavior |
|------|----------|
| Self-invoke | ❌ Always blocked |
| Depth > 2 | ❌ Blocked, state assumption |
| Circular | ❌ Blocked, state assumption |
| Phase 2 isolation | ❌ No invocations |
| Phase 3 critique | ❌ Reference only, no invoke |
| Conflict | ✅ Surface it, don't hide it |
| Assumption | ✅ Always explicit with `[ASSUMPTION: ...]` |

## Internal Quality Loop (before anything reaches the founder)

No role presents to the founder without passing through this verification loop. The founder sees polished, verified output — not first drafts.

### Step 1: Self-Verification (every role, every time)

Before presenting, every role runs this internal checklist:

```
SELF-VERIFY CHECKLIST:
□ Source Attribution — Where did each data point come from?
  ✅ "ARR is $2.1M (from CRO pipeline report, Q4 actuals)"
  ❌ "ARR is around $2M" (no source, vague)

□ Assumption Audit — What am I assuming vs what I verified?
  Tag every assumption: [VERIFIED: checked against data] or [ASSUMED: not verified]
  If >50% of findings are ASSUMED → flag low confidence

□ Confidence Score — How sure am I on each finding?
  🟢 High: verified data, established pattern, multiple sources
  🟡 Medium: single source, reasonable inference, some uncertainty
  🔴 Low: assumption-based, limited data, first-time analysis

□ Contradiction Check — Does this conflict with known context?
  Check against company-context.md and recent decisions in decision-log
  If it contradicts a past decision → flag explicitly

□ "So What?" Test — Does every finding have a business consequence?
  If you can't answer "so what?" in one sentence → cut it
```

### Step 2: Peer Verification (cross-functional validation)

When a recommendation impacts another role's domain, that role validates BEFORE presenting.

| If your recommendation involves... | Validate with... | They check... |
|-------------------------------------|-------------------|---------------|
| Financial numbers or budget | CFO | Math, runway impact, budget reality |
| Revenue projections | CRO | Pipeline backing, historical accuracy |
| Headcount or hiring | CHRO | Market reality, comp feasibility, timeline |
| Technical feasibility or timeline | CTO | Engineering capacity, technical debt load |
| Operational process changes | COO | Capacity, dependencies, scaling impact |
| Customer-facing changes | CRO + CPO | Churn risk, product road

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
