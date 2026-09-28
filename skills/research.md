# research

Source: Claude skill
Original path: `components/claude-skills/research/research/skills/research/SKILL.md`
Description: Default entry point for any research request — a hybrid router that classifies the question deterministically and either delegates to a specialist research skill (pulse for trends/sentiment, grants for NIH funding, litreview for academic literature, syllabus for course reading, patent for prior-art + IP landscape, dossier for entity research) or runs its own plan-decompose-multi-source-search-synthesize-cite fallback workflow when no specialist matches. Always surfaces the routing decision so users can override. Triggers — "research [topic]", "look into [topic]", "what do we know about [topic]", "investigate [topic]", "find me information on [topic]", "do some research on [topic]", "I need to understand [topic]", or any research request that doesn't obviously match a more-specific specialist skill. Output is a markdown briefing (default) or .docx document (on request) with full citations and an audit log.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Research — Hybrid Router + Fallback

**The runtime orchestrator for the research domain.** Architecture C: deterministic classification → specialist delegation OR own plan-decompose-search-synthesize-cite workflow.

## Portability

Requires `WebSearch` + `WebFetch` for the fallback workflow; specialist skills (`pulse`, `grants`, `litreview`, `syllabus`, `patent`, `dossier`) must be present for delegation to work. Node.js with `docx` package required if Q2 = document mode. Works in Claude Code CLI natively. In Claude.ai with web tools + Code Execution, the workflow is supported.

## Distinct From `engineering/autoresearch-agent`

These two skills share the word "research" but serve **completely different use cases**:

- **`research/research/`** (this skill) — research-query router + fallback workflow ("Research X")
- **`engineering/autoresearch-agent/`** — Karpathy's autonomous file-optimization experiment loop ("Make this code faster")

No overlap. They coexist.

## Hybrid Architecture (C)

Every invocation produces one of three outcomes:

1. **Delegation** — Classified as specialist-domain. Routes there. User sees the specialist's output.
2. **Fallback execution** — Classified as general research. Runs own plan → search → synthesize workflow.
3. **Clarification request** — Classification ambiguous. Asks one forcing question to disambiguate, then routes.

The skill **never silently runs its fallback** when a specialist would have done better. **Routing transparency** is what makes the hybrid architecture trustworthy.

## Specialist Registry

| Specialist | Routing signals | Domain |
|---|---|---|
| `pulse` | reddit / hn / x / buzz / sentiment / trending / "what's people saying" / "pulse on" / "take the pulse" / "current conversation" | Multi-source recency research |
| `grants` | NIH / grant / R01 / K-award / RePORTER / NOSI / "grants for" / FDA / "study section" / "principal investigator" | NIH grant-funding intelligence |
| `litreview` | literature review / PICO / SPIDER / systematic review / "review papers on" / meta-analysis | Academic literature orientation |
| `syllabus` | syllabus / course outline / curriculum / "reading list" / "for my class" / "for my students" | Course supplementary reading |
| `patent` | prior art / FTO / freedom to operate / patent / "patent landscape" / invention / novelty search / "ip landscape" | Patent prior-art + landscape |
| `dossier` | "dossier on" / "due diligence" / "background check" / "prep me for" / "competitor research" / "investor diligence" / "interview prep" / "background on" | Decision-grade entity research |

## Agent Integrity Rules

This skill obeys the research-pack convention:

- **Execution discipline (fallback only)**: Sequential searches. 1 q/sec rate limit. Confirm response received before next call.
- **Source discipline**: Cite only sources returned by this session's tool calls. Training knowledge labeled `[Background — not from search]` and excluded from counts.
- **Three-count tracking (fallback only)**: Queries sent / sources received / sources cited.
- **Retry policy**: On failure → wait 3s → retry once → log. After 3 consecutive failures: stop, alert user.
- **Plan-tier detection**: If delegated to Consensus-using specialist, that specialist handles detection. In fallback mode, surface any rate-limit signals.
- **Routing discipline**: Never delegate silently. Always state the decision + accept override.

## Phase 1: Grill-Me Intake (2–4 Questions)

Intake is intentionally minimal — the goal is to route fast, not to interrogate. One question per turn.

### Q1 (always) — Research question

> **What's the research question? State it in 1–2 sentences. Specific is better than broad — "AI for healthcare" gets you a vague survey; "How are health systems integrating LLM-based clinical decision support in 2026?" gets you a useful answer.**
>
> *Why I'm asking:* Specificity dictates classification accuracy and search precision. A vague question routes to fallback; a specific question often matches a specialist cleanly.

**Refuse mush.** If user says "research AI", push back once: "What about AI specifically — adoption, safety, capability, funding, regulation, comparison? Pick an angle."

### Q2 (always) — Output preference

> **What output do you want? Pick one:**
> 1. Quick chat briefing (5-min read, markdown in chat)
> 2. Standalone document (.docx with citations, shareable)
>
> *Why I'm asking:* Document mode triggers deeper search budgets and full audit logs. Chat mode optimizes for fast delivery.

Forcing choice.

### Q3 (asked only if classification ambiguous — ≤1 signal) — Domain disambiguation

> **Quick clarification — pick the closest match:**
> 1. Academic literature (papers, peer-reviewed)
> 2. Industry / trends (what's the buzz, news, sentiment)
> 3. Specific entity (a company, person, organization)
> 4. Technology / patents (prior art, IP landscape)
> 5. Grant funding (NIH, foundations)
> 6. Course material (syllabus or curriculum)
> 7. None of the above — run general research
>
> *Why I'm asking:* I couldn't classify confidently from your question alone. This routes you to the right specialist or confirms general-research fallback.

**Skip if Q1 + Q2 produced clear specialist match (≥2 signals).**

### Q4 (asked only if Q3 was needed AND user picked "none of the above") — General-research scope

> **For general research, what's your time horizon — quick scan (5 searches) or thorough (15 searches)?**
>
> *Why I'm asking:* General research has no specialist budget; you pick it. Quick is good for "what's the lay of the land". Thorough is for "I'll make a decision based on this".

Skip if a specialist took over.

**Stop condition:** After Q4 (or earlier if dependency skips applied), commit and start Phase 2. **Most invocations exit intake after Q1 + Q2.**

## Phase 2: Deterministic Classification

This is **deterministic, not LLM-reasoned** — for speed, debuggability, and consistency.

```python
SIGNALS = {
  pulse:    ["reddit", "hn", "hacker news", "x.com", "twitter", "buzz",
             "sentiment", "trending", "what are people saying",
             "what's happening", "the conversation around",
             "pulse on", "take the pulse", "current conversation"],
  grants:   ["nih", "grant", "grants for", "r01", "r21", "k-award", "reporter",
             "nosi", "funding", "fda", "study section", "principal investigator"],
  litreview:["literature review", "lit review", "litreview", "pico", "spider",
             "systematic review", "review papers on", "research papers on",
             "papers about", "meta-analysis"],
  syllabus: ["syllabus", "course outline", "curriculum", "reading list",
             "for my class", "for my students", "course material"],
  patent:   ["prior art", "fto", "freedom to operate", "patent",
             "patent landscape", "invention", "novelty search",
             "patent search", "ip landscape"],
  dossier:  ["dossier on", "due diligence", "background check",

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
