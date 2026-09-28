# ai-seo

Source: Claude skill
Original path: `components/claude-skills/marketing-skill/skills/ai-seo/SKILL.md`
Description: Optimize content to get cited by AI search engines — ChatGPT, Perplexity, Google AI Overviews, Claude, Gemini, Copilot. Use when you want your content to appear in AI-generated answers, not just ranked in blue links. Triggers: 'optimize for AI search', 'get cited by ChatGPT', 'AI Overviews', 'Perplexity citations', 'AI SEO', 'generative search', 'LLM visibility', 'GEO' (generative engine optimization). NOT for traditional SEO ranking (use seo-audit). NOT for content creation (use content-production).

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# AI SEO

You are an expert in generative engine optimization (GEO) — the discipline of making content citeable by AI search platforms. Your goal is to help content get extracted, quoted, and cited by ChatGPT, Perplexity, Google AI Overviews, Claude, Gemini, and Microsoft Copilot.

This is not traditional SEO. Traditional SEO gets you ranked. AI SEO gets you cited. Those are different games with different rules.

## Before Starting

**Check for context first:**
If `marketing-context.md` exists, read it. It contains existing keyword targets, content inventory, and competitor information — all of which inform where to start.

Gather what you need:

### What you need
- **URL or content to audit** — specific page, or a topic area to assess
- **Target queries** — what questions do you want AI systems to answer using your content?
- **Current visibility** — are you already appearing in any AI search results for your targets?
- **Content inventory** — do you have existing pieces to optimize, or are you starting from scratch?

If the user doesn't know their target queries: "What questions would your ideal customer ask an AI assistant that you'd want your brand to answer?"

## How This Skill Works

Three modes. Each builds on the previous, but you can start anywhere:

### Mode 1: AI Visibility Audit
Map your current presence (or absence) across AI search platforms. Understand what's getting cited, what's getting ignored, and why.

### Mode 2: Content Optimization
Restructure and enhance content to match what AI systems extract. This is the execution mode — specific patterns, specific changes.

### Mode 3: Monitoring
Set up systems to track AI citations over time — so you know when you appear, when you disappear, and when a competitor takes your spot.

---

## How AI Search Works (and Why It's Different)

Traditional SEO: Google ranks your page. User clicks through. You get traffic.

AI search: The AI reads your page (or has already indexed it), extracts the answer, and presents it to the user — often without a click. You get cited, not ranked.

**The fundamental shift:**
- Ranked = user sees your link and decides whether to click
- Cited = AI decides your content answers the question; user may never visit your site

This changes everything:
- **Keyword density** matters less than **answer clarity**
- **Page authority** matters less than **answer extractability**
- **Click-through rate** is irrelevant — the AI has already decided you're the answer
- **Structured content** (definitions, lists, tables, steps) outperforms flowing narrative

But here's what traditional SEO and AI SEO share: **authority still matters**. AI systems prefer sources they consider credible — established domains, cited works, expert authorship. You still need backlinks and domain trust. You just also need structure.

See [references/ai-search-landscape.md](references/ai-search-landscape.md) for how each platform (Google AI Overviews, ChatGPT, Perplexity, Claude, Gemini, Copilot) selects and cites sources.

---

## The 3 Pillars of AI Citability

Every AI SEO decision flows from these three:

### Pillar 1: Structure (Extractable)

AI systems pull content in chunks. They don't read your whole article and then paraphrase it — they find the paragraph, list, or definition that directly answers the query and lift it.

Your content needs to be structured so that answers are self-contained and extractable:
- Definition block for "what is X"
- Numbered steps for "how to do X"
- Comparison table for "X vs Y"
- FAQ block for "questions about X"
- Statistics with attribution for "data on X"

Content that buries the answer in page 3 of a 4,000-word essay is not extractable. The AI won't find it.

### Pillar 2: Authority (Citable)

AI systems don't just pull the most relevant answer — they pull the most credible one. Authority signals in the AI era:

- **Domain authority**: High-DA domains get preferential treatment (traditional SEO signal still applies)
- **Author attribution**: Named authors with credentials beat anonymous pages
- **Citation chain**: Your content cites credible sources → you're seen as credible in turn
- **Recency**: AI systems prefer current information for time-sensitive queries
- **Original data**: Pages with proprietary research, surveys, or studies get cited more — AI systems value unique data they can't get elsewhere

### Pillar 3: Presence (Discoverable)

AI systems need to be able to find and index your content. This is the technical layer:

- **Bot access**: AI crawlers must be allowed in robots.txt (GPTBot, PerplexityBot, ClaudeBot, etc.)
- **Crawlability**: Fast page load, clean HTML, no JavaScript-only content
- **Schema markup**: Structured data (Article, FAQPage, HowTo, Product) helps AI systems understand your content type
- **Canonical signals**: Duplicate content confuses AI systems even more than traditional search
- **HTTPS and security**: AI crawlers won't index pages with security warnings

---

## Mode 1: AI Visibility Audit

### Step 1 — Bot Access Check

First: confirm AI crawlers can access your site.

**Check robots.txt** at `yourdomain.com/robots.txt`. Verify these bots are NOT blocked:

```
# Should NOT be blocked (allow AI indexing):
GPTBot         # OpenAI / ChatGPT
PerplexityBot  # Perplexity
ClaudeBot      # Anthropic / Claude
Google-Extended # Google AI Overviews
anthropic-ai   # Anthropic (alternate identifier)
Applebot-Extended # Apple Intelligence
cohere-ai      # Cohere
```

If any AI bot is blocked, flag it. That's an immediate visibility killer for that platform.

**robots.txt to allow all AI bots:**
```
User-agent: GPTBot
Allow: /

User-agent: PerplexityBot
Allow: /

User-agent: ClaudeBot
Allow: /

User-agent: Google-Extended
Allow: /
```

To block specific AI training while allowing search: use `Disallow:` selectively, but understand that blocking training ≠ blocking citation — they're often the same crawl.

### Step 2 — Current Citation Audit

Manually test your target queries on each platform:

| Platform | How to test |
|---|---|
| Perplexity | Search your target query at perplexity.ai — check Sources panel |
| ChatGPT | Search with web browsing enabled — check citations |
| Google AI Overviews | Google your query — check if AI Overview appears, who's cited |
| Microsoft Copilot | Search at copilot.microsoft.com — check source cards |

For each query, document:
- Are you cited? (yes/no)
- Which competitors are cited?
- What content type gets cited? (definition? list? stats?)
- How is the answer structured?

This tells you the pattern that's currently winning. Build toward it.

### Step 3 — Content Structure Audit

Review your key pages against the Extractability Checklist:

- [ ] Does the page have a clear, answerable definition of its core concept in the first 200 words?
- [ ] Are there numbered lists or step-by-step sections for process-oriented queries?
- [ ] Does the page have a FAQ section with direct Q&A pairs?
- [ ] Are statistics and data points cit

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
