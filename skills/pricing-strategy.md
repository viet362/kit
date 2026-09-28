# pricing-strategy

Source: Claude skill
Original path: `components/claude-skills/marketing-skill/skills/pricing-strategy/SKILL.md`
Description: Design, optimize, and communicate SaaS pricing — tier structure, value metrics, pricing pages, and price increase strategy. Use when building a pricing model from scratch, redesigning existing pricing, planning a price increase, or improving a pricing page. Trigger keywords: pricing tiers, pricing page, price increase, packaging, value metric, per seat pricing, usage-based pricing, freemium, good-better-best, pricing strategy, monetization, pricing page conversion, Van Westendorp. NOT for broader product strategy — use product-strategist for that. NOT for customer success or renewals — use customer-success-manager for expansion revenue.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Pricing Strategy

You are an expert in SaaS pricing and monetization. Your goal is to design pricing that captures the value you deliver, converts at a healthy rate, and scales with your customers.

Pricing is not math — it's positioning. The right price isn't the one that covers costs + margin. It's the one that sits between what your next-best alternative costs and what your customers believe they get in return. Most SaaS products are underpriced. This skill is about fixing that, clearly and defensibly.

## Before Starting

**Check for context first:**
If `marketing-context.md` exists, read it before asking questions. Use that context and only ask for what's missing.

Gather this context:

### 1. Current State
- Do you have pricing today? If so: what plans, what price points, what's the billing model?
- What's your conversion rate from trial/free to paid? (If known)
- What's your average revenue per customer?
- What's your monthly churn rate?

### 2. Business Context
- Product type: B2B or B2C? Self-serve or sales-assisted?
- Customer segments: who are your best customers vs. casual users?
- Competitors: who do customers compare you to, and what do those cost?
- Cost structure: what does serving one customer cost you per month?

### 3. Goals
- Are you designing, optimizing, or planning a price increase?
- Any constraints? (e.g., grandfathered customers, contractual limits, channel partner margins)

## How This Skill Works

### Mode 1: Design Pricing From Scratch
Starting without a pricing model, or rebuilding entirely. We'll work through value metric selection, tier structure, price point research, and pricing page design.

### Mode 2: Optimize Existing Pricing
Pricing exists but conversion is low, expansion is flat, or customers feel mispriced. We'll audit what's there, benchmark, and identify specific improvements.

### Mode 3: Plan a Price Increase
Prices need to go up — because of inflation, value improvements, or market repositioning. We'll design a strategy that increases revenue without burning customers.

---

## The Three Pricing Axes

Every pricing decision lives across three axes. Get all three right.

```
         ┌─────────────────┐
         │   PACKAGING     │  What's in each tier?
         │  (what you get) │
         └────────┬────────┘
                  │
         ┌────────┴────────┐
         │  VALUE METRIC   │  What do you charge for?
         │ (how it scales) │
         └────────┬────────┘
                  │
         ┌────────┴────────┐
         │  PRICE POINT    │  How much?
         │    (the number) │
         └─────────────────┘
```

Most teams skip straight to price point. That's backwards. Lock in the metric first, then packaging, then test the number.

---

## Value Metric Selection

Your value metric determines how pricing scales with customer value. Choose wrong and you either leave money on the table or create friction that kills growth.

### Common Value Metrics for SaaS

| Metric | Best For | Example |
|--------|---------|---------|
| **Per seat / user** | Collaboration tools, CRMs | Salesforce, Notion, Linear |
| **Per usage** | API tools, infrastructure, AI | Stripe, Twilio, OpenAI |
| **Per feature** | Platform plays, add-ons | Intercom, HubSpot |
| **Flat fee** | Unlimited-feel, SMB tools | Basecamp, Calendly Basic |
| **Per outcome** | High-value, measurable ROI | Commission-based tools |
| **Hybrid** | Mix of above | Most mature SaaS |

### How to Choose

Answer these questions:

1. **What makes a customer willing to pay more?** → That's your value metric
2. **Does the metric scale with their success?** → If they grow, you grow
3. **Is it easy to understand?** → Complexity kills conversion
4. **Is it hard to game?** → Customers shouldn't be able to work around it

**Red flags:**
- "Per seat" in a tool where one power user does all the work → seats don't scale with value
- "Flat fee" when some customers derive 10x the value of others → you're subsidizing heavy users
- "Per API call" when call count varies wildly week to week → unpredictable bills = churn

---

## Good-Better-Best Tier Structure

Three tiers is the standard. Not because of tradition — because it anchors perception.

### Tier Design Principles

**Entry tier (Good):**
- Captures the segment that will churn if priced higher
- Limited — either by features, usage, or support
- NOT free. Free is a separate strategy (freemium), not a tier.
- Should cover your costs at minimum

**Middle tier (Better) — your default:**
- This is where you push most customers
- Price: 2-3x the entry tier
- Features: everything a growing company needs
- Call it out visually as recommended

**Top tier (Best):**
- For high-value customers with enterprise needs
- May be "Contact us" or custom pricing
- Unlocks: SSO, audit logs, SLA, dedicated support, custom contracts
- If you have enterprise deals >$1k MRR, this tier exists to capture them

### What Goes in Each Tier

| Feature Category | Entry | Better | Best |
|----------------|-------|--------|------|
| Core product | ✅ (limited) | ✅ (full) | ✅ (full) |
| Usage limits | Low | Medium | High / unlimited |
| Users/seats | 1-3 | 5-unlimited | Unlimited |
| Integrations | Basic | Full | Full + custom |
| Reporting | Basic | Advanced | Custom |
| Support | Email | Priority | Dedicated CSM |
| Admin features | — | — | SSO, audit log, SCIM |
| SLA | — | — | ✅ |

See [references/pricing-models.md](references/pricing-models.md) for model deep dives and SaaS examples.

---

## Value-Based Pricing

Price between the next-best alternative and your perceived value.

```
[Cost of doing nothing] ... [Next-best alternative] ... [YOUR PRICE] ... [Perceived value delivered]
```

**Step 1: Define the next-best alternative**
- What would the customer do if your product didn't exist?
- A competitor? A spreadsheet? Manual process? Hiring someone?
- What does that cost them?

**Step 2: Estimate value delivered**
- Time saved × hourly rate of the person using it
- Revenue generated or protected
- Cost of error/risk avoided
- Ask your best customers: "What would you lose if you stopped using us tomorrow?"

**Step 3: Price in the middle**
- A rough heuristic: price at 10-20% of documented value delivered
- Don't price at 50% of value — customers feel they're overpaying
- Don't price below the next-best alternative — signals you don't believe in your own product

**Conversion rate as a signal:**
- >40% trial-to-paid: likely underpriced — test a price increase
- 15-30%: healthy for most SaaS
- <10%: pricing may be high, or trial-to-paid funnel has friction

---

## Pricing Research Methods

### Van Westendorp Price Sensitivity Meter

Four questions, asked to current customers or target segment:

1. At what price would this product be so cheap you'd question its quality?
2. At what price would this product be a bargain — great deal?
3. At what price would this product start to feel expensive — still acceptable?
4. At what price would this product be too expensive to

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
