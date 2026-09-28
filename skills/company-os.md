# company-os

Source: Claude skill
Original path: `components/claude-skills/c-level-advisor/skills/company-os/SKILL.md`
Description: The meta-framework for how a company runs — the connective tissue between all C-suite roles. Covers operating system selection (EOS, Scaling Up, OKR-native, hybrid), accountability charts, scorecards, meeting pulse, issue resolution, and 90-day rocks. Use when setting up company operations, selecting a management framework, designing meeting rhythms, building accountability systems, implementing OKRs, or when user mentions EOS, Scaling Up, operating system, L10 meetings, rocks, scorecard, accountability chart, or quarterly planning.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Company Operating System

The operating system is the collection of tools, rhythms, and agreements that determine how the company functions. Every company has one — most just don't know what it is. Making it explicit makes it improvable.

## Keywords
operating system, EOS, Entrepreneurial Operating System, Scaling Up, Rockefeller Habits, OKR, Holacracy, L10 meeting, rocks, scorecard, accountability chart, issues list, IDS, meeting pulse, quarterly planning, weekly scorecard, management framework, company rhythm, traction, Gino Wickman, Verne Harnish

## Why This Matters

Most operational dysfunction isn't a people problem — it's a system problem. When:
- The same issues recur every week: no issue resolution system
- Meetings feel pointless: no structured meeting pulse
- Nobody knows who owns what: no accountability chart
- Quarterly goals slip: rocks aren't real commitments

Fix the system. The people will operate better inside it.

## The Six Core Components

Every effective operating system has these six, regardless of which framework you choose:

### 1. Accountability Chart

Not an org chart. An accountability chart answers: "Who owns this outcome?"

**Key distinction:** One person owns each function. Multiple people may work in it. Ownership means the buck stops with one person.

**Structure:**
```
CEO
├── Sales (CRO/VP Sales)
│   ├── Inbound pipeline
│   └── Outbound pipeline
├── Product & Engineering (CTO/CPO)
│   ├── Product roadmap
│   └── Engineering delivery
├── Operations (COO)
│   ├── Customer success
│   └── Finance & Legal
└── People (CHRO/VP People)
    ├── Recruiting
    └── People operations
```

**Rules:**
- No shared ownership. "Alice and Bob both own it" means nobody owns it.
- One person can own multiple seats at early stages. That's fine. Just be explicit.
- Revisit quarterly as you scale. Ownership shifts as the company grows.

**Build it in a workshop:**
1. List all functions the company performs
2. Assign one owner per function — no exceptions
3. Identify gaps (functions nobody owns) and overlaps (functions two people think they own)
4. Publish it. Update it when something changes.

### 2. Scorecard

Weekly metrics that tell you if the company is on track. Not monthly. Not quarterly. Weekly.

**Rules:**
- 5–15 metrics maximum. More than 15 and nothing gets attention.
- Each metric has an owner and a weekly target (not a range — a number).
- Red/yellow/green status. Not paragraphs.
- The scorecard is discussed at the leadership team weekly meeting. Only red metrics get discussion time.

**Example scorecard structure:**

| Metric | Owner | Target | This Week | Status |
|--------|-------|--------|-----------|--------|
| New MRR | CRO | €50K | €43K | 🔴 |
| Churn | CS Lead | < 1% | 0.8% | 🟢 |
| Active users | CPO | 2,000 | 2,150 | 🟢 |
| Deployments | CTO | 3/week | 3 | 🟢 |
| Open critical bugs | CTO | 0 | 2 | 🔴 |
| Runway | CFO | > 18mo | 16mo | 🟡 |

**Anti-pattern:** Measuring everything. If you track 40 KPIs, you're watching, not managing.

### 3. Meeting Pulse

The meeting rhythm that drives the company. Not optional — the pulse is what keeps the company alive.

**The full rhythm:**

| Meeting | Frequency | Duration | Who | Purpose |
|---------|-----------|----------|-----|---------|
| Daily standup | Daily | 15 min | Each team | Blockers only |
| L10 / Leadership sync | Weekly | 90 min | Leadership team | Scorecard + issues |
| Department review | Monthly | 60 min | Dept + leadership | OKR progress |
| Quarterly planning | Quarterly | 1–2 days | Leadership | Set rocks, review strategy |
| Annual planning | Annual | 2–3 days | Leadership | 1-year + 3-year vision |

**The L10 meeting (Weekly Leadership Sync):**
Named for the goal of each meeting being a 10/10. Fixed agenda:
1. Good news (5 min) — personal + business
2. Scorecard review (5 min) — flag red items only
3. Rock review (5 min) — on/off track for each rock
4. Customer/employee headlines (5 min)
5. Issues list (60 min) — IDS (see below)
6. To-dos review (5 min) — last week's commitments
7. Conclude (5 min) — rate the meeting 1–10, what would make it a 10 next time

### 4. Issue Resolution (IDS)

The core problem-solving loop. Maximum 15 minutes per issue.

**IDS: Identify, Discuss, Solve**

- **Identify:** What is the actual issue? (Not the symptom — the root cause) State it in one sentence.
- **Discuss:** Relevant facts + perspectives. Time-boxed. When discussion starts repeating, stop.
- **Solve:** One owner. One action. One due date. Written on the to-do list.

**Anti-patterns:**
- "Let's take this offline" — most things taken offline never get resolved
- Discussing without deciding — a great discussion with no action item is wasted time
- Revisiting decided issues — once solved, it leaves the list. Reopen only with new information.

**The Issues List:** A running, prioritized list of all unresolved issues. Owned by the leadership team. Reviewed and pruned weekly. If an issue has been on the list for 3+ meetings and hasn't been discussed, it's either not a real issue or it's too scary to address — both deserve attention.

### 5. Rocks (90-Day Priorities)

Rocks are the 3–7 most important things each person must accomplish in the next 90 days. They're not the job description — they're the things that move the company forward.

**Why 90 days?** Long enough for meaningful progress. Short enough to stay real.

**Rock rules:**
- Each person: 3–7 rocks maximum. More than 7 and none get done.
- Company-level rocks (shared priorities): 3–7 for the leadership team
- Each rock is binary: done or not done. No "60% complete."
- Set at the quarterly planning session. Reviewed weekly (on/off track).

**Bad rock:** "Improve our sales process"
**Good rock:** "Implement Salesforce CRM with full pipeline stages and weekly reporting by March 31"

**Rock vs. to-do:** A to-do takes one action. A rock takes 90 days of consistent work.

### 6. Communication Cadence

Who gets what information, when, and how.

| Audience | What | When | Format |
|----------|------|------|--------|
| All employees | Company update | Monthly | Written + Q&A |
| All employees | Quarterly results + next priorities | Quarterly | All-hands |
| Leadership team | Scorecard | Weekly | Dashboard |
| Board | Company performance | Monthly | Board memo |
| Investors | Key metrics + narrative | Monthly or quarterly | Investor update |
| Customers | Product updates | Per release | Release notes |

**Default rule:** If you're deciding whether to share something internally, share it. The cost of under-communication always exceeds the cost of over-communication inside a company.

---

## Operating System Selection

See `references/os-comparison.md` for full comparison. Quick guide:

| If you are... | Consider... |
|---------------|-------------|
| 10–250 person company, founder-led, operational chaos | EOS / Traction |
| Ambitious growth company, need rigorous strategy cascade | Scaling Up |
| Tech company, engineering culture, hypothesis-dr

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
