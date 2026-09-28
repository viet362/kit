# inbox-triage

Source: Claude skill
Original path: `components/claude-skills/productivity/email/skills/inbox-triage/SKILL.md`
Description: Runs a full inbox triage using the knowledge base created by the 'inbox-setup' skill. Light-intake by design (most invocations skip questions and run with KB-default preferences); asks at most 2 grill-me override questions when invocation is outside normal cadence or includes category-skip intent. Searches recent emails, classifies them via the user's taxonomy, researches new senders, generates recommendations, drafts replies (NEVER sends), delivers a report in the user's preferred format, and updates the knowledge base with learnings. Designed to run on a recurring schedule (1-3x daily) or on demand. Triggers: 'triage my inbox', 'inbox triage', 'check my email', 'run email triage', 'process my inbox', 'what's new in my email', 'handle my email', 'email triage', or any variation where the user wants their inbox processed. Requires the inbox-setup skill to have been run first.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Inbox-Triage — Recurring Email Triage

> **Paired with `inbox-setup`.** This skill consumes the 7-file knowledge base that `inbox-setup` writes at `${WORKSPACE}/Email/`. The file contracts MUST match exactly. See [`references/kb_file_contract.md`](references/kb_file_contract.md) — this is the mirror of the setup-side contract, viewed from the read side.

Run on a recurring schedule (1–3x daily) or on demand. Classify recent emails, research new senders, generate decision recommendations, draft replies (**NEVER SEND**), deliver a clean report, and update the knowledge base with what was learned this run.

## Invocation Triggers

- "triage my inbox"
- "inbox triage"
- "check my email"
- "run email triage"
- "process my inbox"
- "what's new in my email"
- "handle my email"
- "email triage"

## Prerequisites

Required reads at start (fail-fast if missing):

**Core (required):**
- `${WORKSPACE}/Email/email-taxonomy.md` — classification + report preferences
- `${WORKSPACE}/Email/email-patterns.md` — voice, persona, templates, hard rules

**Optional core (read if exists):**
- `${WORKSPACE}/Email/evaluation-framework.md`
- `${WORKSPACE}/Email/rate-card.md`

**Evolving (read AND update every run):**
- `${WORKSPACE}/Email/blocklist.md`
- `${WORKSPACE}/Email/tracker.md`

**Output:**
- `${WORKSPACE}/Email/triage-log/<YYYY-MM-DD>-<run-label>.md` — per-run log

If any core required file is missing → **halt**, direct user to run `inbox-setup` first. Use `scripts/kb_reader.py` to perform the read + validation.

## DRAFTS ONLY — Never Send

> **This skill creates drafts. It NEVER sends.**

This is the safety property that makes the skill safe to run automatically. Stated multiple times in this skill body. Non-negotiable.

The `scripts/draft_safety_validator.py` enforces it post-run. Any send-shaped tool call in the action log fails validation. See [`references/drafts_only_safety.md`](references/drafts_only_safety.md) for the full discipline canon.

## Step 0: Grill-Me Intake (Light — 0–2 Optional Override Questions)

Inbox-triage is **light-intake by design** — it runs on a recurring cadence with preferences pre-baked into the knowledge base from `inbox-setup`. The grill-me discipline here is asking ONLY the override questions that matter THIS run.

### Q1 (optional, asked only when on-demand run is outside normal cadence)

> **Override the default 9-hour search window? Pick: yes (specify hours) / no (use default).**
>
> *Why I'm asking:* If you're running on-demand outside your normal 2x/day cadence, you may want a wider window (24h after a long break) or narrower (2h for a quick check).

Skip if cadence is normal.

### Q2 (optional, asked only when user invokes with category-skip intent)

> **Skip any categories this run? E.g., "skip newsletters", "skip financial".**
>
> *Why I'm asking:* Sometimes you just want to scan opportunities or just want to clear active threads. Category skip narrows the run scope.

Skip if user gave no category-skip signal.

**Stop condition:** Max 2 questions. Default invocations skip both questions and run with KB-default preferences. The skill is optimized for fast recurring execution; intake is the exception, not the norm.

## Step 1: Determine Search Window

Compute via current date math. Default lookback: **9 hours** (works for 2x/day cadence with slight overlap so emails between runs aren't missed).

Use `scripts/search_window_calculator.py --cadence <CADENCE> --now <ISO>`:

```
now = current_datetime
window_start = now - 9_hours   (default for 2x-daily)
run_label = "Morning" if now.hour < 12 else "Afternoon" if now.hour < 17 else "Evening"
```

Cadence-to-default-window mapping (override via Q1):

| Cadence (from email-taxonomy.md S1.Q5) | Default window |
|---|---|
| once daily | 26h |
| 2x daily | 9h |
| 3x daily | 6h |
| on-demand only | 24h (asks Q1) |

## Step 2: Email Search

Two queries (provider-agnostic adapter pattern):

- **Primary:** Inbox + sent after `window_start`
- **Secondary:** Starred unread (catch flagged items missed in primary)

Collect for each email: sender, subject, date, snippet, thread ID, labels.

Provider adapter mapping:

| Provider | Tool |
|---|---|
| Gmail | Gmail MCP |
| Outlook / Microsoft 365 | Outlook MCP |
| IMAP (Fastmail, ProtonMail, etc.) | IMAP MCP if available; halt otherwise |
| (no email tool available) | Halt with clear message: "No email tool registered for this session." |

## Step 3: Classification

Apply the taxonomy from `email-taxonomy.md`. For **lowest-priority** category (newsletters / automation / spam): skip thread reads entirely — context cost not worth it. For everything else: read full thread.

## Step 4: Sender Research

For senders not in tracker / blocklist / prior logs:

1. Check `blocklist.md` → if matched, auto-skip
2. Check `tracker.md` → if known thread, note existing context
3. For opportunity senders (per evaluation framework): web search for company legitimacy, social presence, intermediary status

**Skip research entirely** for: known senders (in tracker), internal email, automated notifications, obvious low-priority.

## Step 5: Recommendations

For decision-required emails, apply the framework from `evaluation-framework.md`. Categorize:

| Category | When | Output |
|---|---|---|
| **TAKE IT** | Meets criteria | Recommend engaging; draft reply (Step 6) |
| **WORTH CONSIDERING** | Has potential, needs user judgment | Surface key context; draft for user to edit |
| **PASS** | Doesn't meet criteria | Brief "why" (1–3 sentences); draft polite decline |
| **FLAG FOR REVIEW** | Unusual; needs direct user decision | Surface fully; NO draft (user decides response shape) |

Each: brief "why", relevant context, pricing/timeline comparison if applicable.

**Skip Step 5 entirely if no `evaluation-framework.md` exists.**

See [`references/triage_decision_framework.md`](references/triage_decision_framework.md) for the framework canon.

## Step 6: Drafts

For every reasonable reply candidate, create a draft using `email-patterns.md` voice rules.

**Draft for:** opportunity responses (TAKE IT / WORTH / PASS), active conversations needing reply, action items, important personal emails.

**Do NOT draft for:**
- Clearly no-response emails (newsletters, automation, FYI)
- Threads where user already replied
- Blocked senders (unless new info changes the calculus)

**Mechanics:**

- Draft only in the existing thread when possible (preserves context)
- Set `to`, `subject` (`Re: [original]`)
- **NEVER call any send operation. Only create drafts.**

The draft body MUST honor:
- Voice register from `email-patterns.md`
- Forbidden tokens (S3.Q2 pet peeves)
- Sign-off patterns
- Persona context
- Hard rules (S3.Q6 — non-negotiable)
- Reply length per `email-patterns.md`

If `evaluation-framework.md` exists, draft tone matches recommendation:
- TAKE IT → engaged + concrete next step
- WORTH → curious + 1-2 clarifying questions
- PASS → polite decline + brief reason (no hedging promises)
- FLAG → NO draf

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
