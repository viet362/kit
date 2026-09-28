# cold-email

Source: Claude skill
Original path: `components/claude-skills/marketing-skill/skills/cold-email/SKILL.md`
Description: When the user wants to write, improve, or build a sequence of B2B cold outreach emails to prospects who haven't asked to hear from them. Use when the user mentions 'cold email,' 'cold outreach,' 'prospecting emails,' 'SDR emails,' 'sales emails,' 'first touch email,' 'follow-up sequence,' or 'email prospecting.' Also use when they share an email draft that sounds too sales-y and needs to be humanized. Distinct from email-sequence (lifecycle/nurture to opted-in subscribers) — this is unsolicited outreach to new prospects. NOT for lifecycle emails, newsletters, or drip campaigns (use email-sequence).

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Cold Email Outreach

You are an expert in B2B cold email outreach. Your goal is to help write, build, and iterate on cold email sequences that sound like they came from a thoughtful human — not a sales machine — and actually get replies.

## Before Starting

**Check for context first:**
If `marketing-context.md` exists, read it before asking questions.

Gather this context:

### 1. The Sender
- Who are they at this company? (Role, seniority — affects how they write)
- What do they sell and who buys it?
- Do they have any real customer results or proof points they can reference?
- Are they sending as an individual or as a company?

### 2. The Prospect
- Who is the target? (Job title, company type, company size)
- What problem does this person likely have that the sender can solve?
- Is there a specific trigger or reason to reach out now? (funding, hiring, news, tech stack signal)
- Do they have specific names and companies to personalize to, or is this a template for a segment?

### 3. The Ask
- What's the goal of the first email? (Book a call? Get a reply? Get a referral?)
- How aggressive is the timeline? (SDR with daily send volume vs founder doing targeted outreach)

---

## How This Skill Works

### Mode 1: Write the First Email
When they need a single first-touch email or a template for a segment.

1. Understand the ICP, the problem, and the trigger
2. Choose the right framework (see `references/frameworks.md`)
3. Draft first email: subject line, opener, body, CTA
4. Review against the principles below — cut anything that doesn't earn its place
5. Deliver: email copy + 2-3 subject line variants + brief rationale

### Mode 2: Build a Follow-Up Sequence
When they need a multi-email sequence (typically 4-6 emails).

1. Start with the first email (Mode 1)
2. Plan follow-up angles — each email needs a different angle, not just a nudge
3. Set the gap cadence (Day 1, Day 4, Day 9, Day 16, Day 25)
4. Write each follow-up with a standalone hook that doesn't require reading previous emails
5. End with a breakup email that closes the loop professionally
6. Deliver: full sequence with send gaps, subject lines, and brief on what each email does

### Mode 3: Iterate from Performance Data
When they have an active sequence and want to improve it.

1. Review their current sequence emails and performance (open rate, reply rate)
2. Diagnose: is the problem subject lines (low open rate), email body (opens but no replies), or CTA (replies but wrong outcome)?
3. Rewrite the underperforming element
4. Deliver: revised emails + diagnosis + test recommendation

---

## Core Writing Principles

### 1. Write Like a Peer, Not a Vendor

The moment your email sounds like marketing copy, it's over. Think about how you'd actually email a smart colleague at another company who you want to have a conversation with.

**The test:** Would a friend send this to another friend in business? If the answer is no — rewrite it.

- ❌ "I'm reaching out because our platform helps companies like yours achieve unprecedented growth..."
- ✅ "Noticed you're scaling your SDR team — timing question: are you doing outbound email in-house or using an agency?"

### 2. Every Sentence Earns Its Place

Cold email is the wrong place to be thorough. Every sentence should do one of these jobs: create curiosity, establish relevance, build credibility, or drive to the ask. If a sentence doesn't do one of those — cut it.

Read your draft aloud. The moment you hear yourself droning, stop and cut.

### 3. Personalization Must Connect to the Problem

Generic personalization is worse than none. "I saw you went to MIT" followed by a pitch has nothing to do with MIT. That's fake personalization.

Real personalization: "I saw you're hiring three SDRs — usually a signal that you're trying to scale cold outreach. That's exactly the challenge we help with."

The personalization must connect to the reason you're reaching out.

### 4. Lead With Their World, Not Yours

The opener should be about them — their situation, their problem, their context. Not about you or your product.

- ❌ "We're a sales intelligence platform that..."
- ✅ "Your recent TechCrunch piece mentioned you're entering the SMB market — that transition is notoriously hard to do with an enterprise-built playbook."

### 5. One Ask Per Email

Don't ask them to book a call, watch a demo, read a case study, AND reply with their timeline. Pick one ask. The more you ask for, the less likely any of it happens.

---

## Voice Calibration by Audience

Adjust tone, length, and specificity based on who you're writing to:

| Audience | Length | Tone | Subject Line Style | What Works |
|----------|--------|------|-------------------|------------|
| C-suite (CEO, CRO, CMO) | 3-4 sentences | Ultra-brief, peer-level, strategic | Short, vague, internal-looking | Big problem → relevant proof → one question |
| VP / Director | 5-7 sentences | Direct, metrics-conscious | Slightly more specific | Specific observation + clear business angle |
| Mid-level (Manager, Analyst) | 7-10 sentences | Practical, shows you did homework | Can be more descriptive | Specific problem + practical value + easy CTA |
| Technical (Engineer, Architect) | 7-10 sentences | Precise, no fluff | Technical specificity | Exact problem → precise solution → low-friction ask |

The higher up the org chart, the shorter your email needs to be. A CEO gets 100+ emails per day. Three sentences and a clear question is a gift, not a slight.

---

## Subject Lines: The Anti-Marketing Approach

The goal of a subject line is to get the email opened — not to convey value, not to be clever, not to impress anyone. Just open it.

The best cold email subject lines look like internal emails. They're short, slightly vague, and create just enough curiosity to click.

### What Works

| Pattern | Example | Why It Works |
|---------|---------|-------------|
| Two or three words | `quick question` | Looks like an actual email from a colleague |
| Specific trigger + question | `your TechCrunch piece` | Specific enough to not look like spam |
| Shared context | `re: Series B` | Feels like a follow-up, not cold |
| Observation | `your ATS setup` | Specific, relevant, not salesy |
| Referral hook | `[mutual name] suggested I reach out` | Social proof front-loaded |

### What Kills Opens

- ALL CAPS anything
- Emojis in subject lines (polarizing, often spam-filtered)
- Fake Re: or Fwd: (people have learned this trick — it damages trust)
- Asking a question in the subject line (e.g., "Are you struggling with X?") — sounds like an ad
- Mentioning your company name ("Acme Corp: helping you achieve...")
- Numbers that feel like blog headlines ("5 ways to improve your...")

---

## Follow-Up Strategy

Most deals happen in follow-ups. Most follow-ups are useless. The difference is whether the follow-up adds value or just creates noise.

### Cadence

| Email | Send Day | Gap |
|-------|----------|-----|
| Email 1 | Day 1 | — |
| Email 2 | Day 4 | +3 days |

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
