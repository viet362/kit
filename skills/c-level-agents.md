# c-level-agents

Source: Claude skill
Original path: `components/claude-skills/c-level-advisor/c-level-agents/skills/c-level-agents/SKILL.md`
Description: Founder-mode executive team. 8 cs-* C-suite agents (CFO, CMO, CRO, CPO, COO, CHRO, CISO, Chief of Staff) and 17 /cs:* slash commands for forcing-question office hours, multi-role boardroom deliberation, strategic sprint pipeline, and meta routing. Use when the founder needs a virtual executive team, when invoking /cs:* commands, or when orchestrating multi-role decisions.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# c-level-agents — Founder-Mode Executive Team

A virtual C-suite delivered through slash commands and persona agents.

## Keywords

founder mode, virtual c-suite, executive team, boardroom, office hours, cfo review, cmo review, strategic sprint, decision logging, cross-model consensus, persona agents, chief of staff, forcing questions

## What This Plugin Provides

### 8 cs-* Agents (in `agents/`)

Each agent wraps an existing c-level skill and adds:
- A distinct cognitive voice (numerate skeptic, narrative-first, etc.)
- Forcing questions specific to the role
- Workflow orchestration tied to skill Python tools
- Output template: Bottom Line → What → Why → How to Act → Your Decision

See `../references/persona-voices.md` for voice specs.

### 17 /tk:* Slash Commands (in `skills/`)

**Forcing-question office hours (8):**
- `/tk:office-hours` — YC-style 6-question intake
- `/tk:cfo-review` — unit economics, runway, dilution
- `/tk:cmo-review` — ICP, CAC payback, positioning
- `/tk:cpo-review` — RICE, JTBD, North Star, PMF
- `/tk:cro-review` — pipeline coverage, win rate, NRR
- `/tk:cto-review` — architecture risk, scaling cliff
- `/tk:ciso-review` — threat model, blast radius, compliance
- `/tk:gc-review` — contracts, IP, regulatory, term sheets

**Strategic sprint pipeline (5):**
- `/tk:brief` → `/tk:boardroom` → `/tk:decide` → `/tk:execute` → `/tk:post-mortem`

**Meta + safety (4):**
- `/tk:founder-mode` — auto-routes to the right C-role
- `/tk:onboard` — founder interview → `company-context.md`
- `/tk:cross-eval` — multi-model consensus
- `/tk:freeze` — cooldown lock on a decision

## Quick Start

```
/tk:onboard                          # populate company context first
/tk:office-hours "should we hire a VP Sales?"
/tk:founder-mode "runway pressure"   # auto-routes to CFO
/tk:boardroom briefs/pricing-v3.md   # full panel
```

## Architecture

```
User question
   │
   ├─ Single-role? → cs-{role}-advisor agent
   │                     ↓
   │                  /tk:{role}-review command (forcing Qs)
   │                     ↓
   │                  Skill tools + references
   │                     ↓
   │                  Bottom Line + Memo
   │
   └─ Multi-role?  → /tk:boardroom
                        ↓
                     6-phase deliberation (Phase 2 isolation)
                        ↓
                     /tk:decide → decision-logger (two-layer memory)
                        ↓
                     /tk:execute → 90-day plan
```

## Integration Points

- **Existing 28 c-level skills** — wrapped, not replaced
- **decision-logger** — every `/tk:decide` writes here
- **chief-of-staff** — routing layer the agent orchestrates
- **board-meeting** — protocol the `/tk:boardroom` command runs
- **llm-wiki** — optional persistent memory bridge (see `../references/llm-wiki-bridge.md`)
- **executive-mentor** — adversarial `/em:*` commands stack cleanly on top

## Design Principles

1. **Voice is bookended, analysis is neutral.**
2. **Artifacts over chat.** Every command produces a Markdown artifact the next command consumes.
3. **Phase 2 isolation in boardroom.** Independent thinking before cross-examination.
4. **Graceful degradation.** `/tk:cross-eval` falls back to Claude-only.
5. **No paid dependencies.** All Python tools are stdlib-only.

## References

- [persona-voices.md](../../references/persona-voices.md)
- [llm-wiki-bridge.md](../../references/llm-wiki-bridge.md)
- [Parent c-level CLAUDE.md](../../../CLAUDE.md)
- [Existing executive-mentor sibling](../../../executive-mentor/)

---

**Version:** 1.0.0
**Last Updated:** 2026-05-12
**Status:** Production Ready

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
