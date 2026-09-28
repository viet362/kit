# litreview

Source: Claude skill
Original path: `components/claude-skills/research/litreview/skills/litreview/SKILL.md`
Description: Academic literature orientation skill that searches papers via Consensus, builds a strategic search plan using PICO (default) or SPIDER / Decomposition / hybrid as fallbacks, and synthesizes findings into a professionally formatted Word document (.docx) research guide. Grill-me intake (research question specificity + framework hint + tentative depth) before the recon search; a second forcing checkpoint after Phase 2 confirms framework + sub-areas + depth before searches consume budget. Configurable depth (5/10/20 queries) controls coverage vs. speed. Output is a 'launching pad' — not a finished review, but an orientation guide that lets a researcher dive in confidently. Triggers: 'litreview on [topic]', 'literature review on [topic]', 'I'm starting a literature review on X', 'I'm writing a paper on X', 'help me research X', 'I'm doing research on X', 'can you help me research X'. Do NOT trigger for single one-off paper searches where the user just wants a quick list — that's a plain Consensus search.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Litreview — Academic Literature Orientation

> **Portability:** Requires a Consensus MCP connection, Node.js with `docx` package for document generation, and (in CLI) `bash_tool`. Works in Claude Code CLI natively. In Claude.ai with Consensus MCP + Code Execution, the workflow is supported.

Produce a **launching pad** — not a finished literature review, but an orientation document that gives a researcher entering an unfamiliar field everything they need to start reading and searching with confidence. Think: what a generous colleague who knows the field would tell you over coffee.

## Agent Integrity Rules (Research-Pack Convention)

Inherited from the research-pack convention; locked verbatim per PR #657's cross-skill consistency audit.

- **Source discipline.** Only cite Consensus-returned papers from THIS session. Training knowledge labeled `[Not from Consensus — model knowledge]` and excluded from cited count. Sparse results stated explicitly, never silently filled.
- **Counting discipline.** Three numbers tracked: searches executed / unique papers received (deduplicated) / papers cited. Every cited paper has a retrievable Consensus URL from this session. Use `scripts/citation_tracker.py` for deterministic counts.
- **Tool constraints.** Consensus per-query cap depends on plan tier. **Detect at first search**, report at checkpoint. Rate limit is **1 query/sec** — sequential execution mandatory.
- **Retry policy.** On failure → wait 3s → retry once → log. After 3 consecutive failures: stop, alert user, share what was collected.
- **Plan-tier detection.** Parse first-search response for "Showing top 10" / "upgrade" → free tier (10/search). 20 returned → Pro (20/search). Calculate theoretical ceiling and surface at checkpoint so user can recalibrate.

See [`references/search_budget_allocation.md`](references/search_budget_allocation.md) for the sequential-execution rationale + plan-tier signals.

## Error Handling

| Failure | Behavior |
|---|---|
| Consensus rate-limit hit | Wait 3s, retry once, log outcome |
| Search returns 0 results | Note explicitly; "either niche terminology or genuine gap"; never silently fill |
| Plan-tier cap detected | Log tier; report at checkpoint; surface in audit |
| 3 consecutive failures | Stop searching, alert user, share what's collected, ask how to proceed |
| Sub-area returns thin results (<5 papers) | Flag in audit; suggest manual PubMed/Scholar supplementation |
| User wants to adjust sub-areas | Update table, re-confirm before searching |
| DOCX validation fails | Unpack XML, fix, repack |

## Phase 0: Grill-Me Intake (3 forcing questions, one at a time)

Each question carries explicit "why I'm asking". Stop condition: max 3 before Phase 1.

### Q1 (root) — Research question specificity

> **State the research question in 1–2 sentences. Specific is better — "How do LLMs perform on clinical reasoning tasks compared to physicians?" beats "AI in medicine". Vague questions produce vague reviews.**
>
> *Why I'm asking:* The reconnaissance search hinges on precise terminology. Vague questions produce thin recon results that don't yield a useful framework breakdown.

**Refuse mush.** Re-ask once with examples if user is too broad. If still vague, deliver with explicit "broad-scope orientation, not depth review" caveat.

### Q2 (depends on Q1) — Framework hint

> **Framework — pick one or say "you pick":**
>
> 1. **PICO** (Population / Intervention / Comparison / Outcome — most clinical questions)
> 2. **SPIDER** (Sample / Phenomenon / Design / Evaluation / Research-type — social/qualitative)
> 3. **Decomposition** (Problem / Solution / Evaluation / Limitations — technology-focused)
> 4. **Hybrid** (you pick which components from which framework)
> 5. **You pick** — analyze Q1 and recommend
>
> *Why I'm asking:* PICO is the default for ~70% of clinical questions but maps poorly to qualitative work or technology evaluation. Picking upfront saves the recon search from suggesting a misaligned framework.

Forcing choice with default ("you pick"). The skill surfaces its own framework recommendation after the recon search so user can override. Use `scripts/framework_recommender.py` for the heuristic.

See [`references/framework_selection.md`](references/framework_selection.md) for PICO / SPIDER / Decomposition canon.

### Q3 (depends on Q1) — Tentative depth

> **Tentative depth — pick one. Final confirmation comes after the framework breakdown:**
>
> 1. **Quick scan** (5 searches)
> 2. **Standard review** (10 searches)
> 3. **Deep dive** (20 searches)
>
> *Why I'm asking:* I ask this twice — once now to calibrate the recon search emphasis, once after the framework breakdown to confirm. Tentative answer affects which sub-areas to surface first; final answer drives search budget allocation.

Forcing choice. **Re-asked** at the post-Phase-2 checkpoint after the user has seen the framework breakdown.

**Stop condition:** 3 questions max before Phase 1. The post-Phase-2 checkpoint is its own grill-me moment (framework table + sub-area-adjustment + depth-reconfirmation).

## Phase 1: Initial Reconnaissance

**One broad Consensus search** to map themes, terminology, methodological distinctions.

- Query: broad version of Q1 (terminology variants are okay; first search casts wide)
- Record: `citation_tracker.py --action record_search --session NAME --query "..."`
- Record received count: `citation_tracker.py --action record_papers_received --session NAME --count N`
- **Detect plan tier** from response: "Showing top 10" / "upgrade" → free; 20 returned → Pro

Synthesize for the checkpoint:
- Themes that surfaced
- Terminology variations (e.g., "LLM" vs "large language model" vs "GPT-style model")
- Methodological distinctions (clinical trials vs benchmark eval vs case study)
- Coverage gaps (sub-questions absent from recon results)

## Phase 2: Framework Selection + Sub-area Generation

Choose framework (from Q2 OR override based on recon):
- **PICO** — most clinical questions (~70% default)
- **SPIDER** — social / qualitative
- **Decomposition** — technology focus (Problem / Solution / Evaluation / Limitations)
- **Hybrid** — explicit cross-framework mapping

Generate **4-5 sub-area questions** mapped to framework components. Each becomes a targeted Phase 3 search.

## Checkpoint (grill-me forcing-options moment)

After Phase 2, halt and present:

### 3-4 sentence recon summary
- What themes surfaced
- Terminology landscape
- Evidence landscape characterization

### Framework breakdown table

| Framework Component | How It Maps to This Topic | Proposed Sub-area to Explore |
|---|---|---|
| (Component 1) | ... | Sub-area 1 |
| (Component 2) | ... | Sub-area 2 |
| (Component 3) | ... | Sub-area 3 |
| (Component 4) | ... | Sub-area 4 |
| Cross-cutting theme | ... | Sub-area 5 |

### Depth re-confirmation (forcing choice)

Surface the **practical constraint**: detected plan tier + theoretical ceiling.

- Quick scan (5 searches × ~10 results each = ~50

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
