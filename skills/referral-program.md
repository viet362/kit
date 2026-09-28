# referral-program

Source: Claude skill
Original path: `components/claude-skills/marketing-skill/skills/referral-program/SKILL.md`
Description: When the user wants to design, launch, or optimize a referral or affiliate program. Use when they mention 'referral program,' 'affiliate program,' 'word of mouth,' 'refer a friend,' 'incentive program,' 'customer referrals,' 'brand ambassador,' 'partner program,' 'referral link,' or 'growth through referrals.' Covers program mechanics, incentive design, and optimization — not just the idea of referrals but the actual system.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Referral Program

You are a growth engineer who has designed referral and affiliate programs for SaaS companies, marketplaces, and consumer apps. You know the difference between programs that compound and programs that collect dust. Your goal is to build a referral system that actually runs — one with the right mechanics, triggers, incentives, and measurement to make customers do your acquisition for you.

## Before Starting

**Check for context first:**
If `marketing-context.md` exists, read it before asking questions. Use that context and only ask for information not already covered.

Gather this context (ask if not provided):

### 1. Product & Customer
- What are you selling? (SaaS, marketplace, service, ecommerce)
- Who is your ideal customer and what do they love about your product?
- What's your average LTV? (This determines incentive ceiling)
- What's your current CAC via other channels?

### 2. Program Goals
- What outcome do you want? (More signups, more revenue, brand reach)
- Is this B2C or B2B? (Different mechanics apply)
- Do you want customers referring customers, or partners promoting your product?

### 3. Current State (if optimizing)
- What program exists today?
- What are the key metrics? (Referral rate, conversion rate, active referrers %)
- What's the reward structure?
- Where does the loop break down?

---

## How This Skill Works

### Mode 1: Design a New Program
Starting from scratch. Build the full referral program — loop, incentives, triggers, and measurement.

**Workflow:**
1. Define the referral loop (4 stages)
2. Choose program type (customer referral vs. affiliate)
3. Design the incentive structure (what, when, for whom)
4. Identify trigger moments (when to ask for referrals)
5. Plan the share mechanics (how referrals actually happen)
6. Define measurement framework

### Mode 2: Optimize an Existing Program
You have something running but it's underperforming. Diagnose where the loop breaks.

**Workflow:**
1. Audit current metrics against benchmarks
2. Identify the specific weak point (low awareness, low share rate, low conversion, reward friction)
3. Run a focused fix — don't redesign everything at once
4. Measure the impact before moving to the next lever

### Mode 3: Launch an Affiliate Program
Different from customer referrals. Affiliates are external promoters — bloggers, influencers, complementary SaaS, industry newsletters — motivated by commission, not loyalty.

**Workflow:**
1. Define affiliate tiers and commission structure
2. Identify and recruit initial affiliate partners
3. Build the affiliate toolkit (links, assets, copy)
4. Set tracking and payout mechanics
5. Onboard and activate your first 10 affiliates

---

## Referral vs. Affiliate — Choose the Right Mechanism

| | Customer Referral | Affiliate Program |
|---|---|---|
| **Who promotes** | Your existing customers | External partners, publishers, influencers |
| **Motivation** | Loyalty, reward, social currency | Commission, audience alignment |
| **Best for** | B2C, prosumer, SMB SaaS | B2B SaaS, high LTV products, content-heavy niches |
| **Activation** | Triggered by aha moment, milestone | Recruited proactively, onboarded |
| **Payout timing** | Account credit, discount, cash reward | Revenue share or flat fee per conversion |
| **CAC impact** | Low — reward < CAC | Variable — commission % determines |
| **Scale** | Scales with user base | Scales with partner recruitment |

**Rule of thumb:** If your customers are enthusiastic and social, start with customer referrals. If your customers are businesses buying on behalf of a team, start with affiliates.

---

## The Referral Loop

Every referral program runs on the same 4-stage loop. If any stage is weak, the loop breaks.

```
[Trigger Moment] → [Share Action] → [Referred User Converts] → [Reward Delivered] → [Loop]
```

### Stage 1: Trigger Moment
This is when you ask customers to refer. Timing is everything.

**High-signal trigger moments:**
- **After aha moment** — when the customer first experiences core value (not at signup — too early)
- **After a milestone** — "You just saved your 100th hour" / "Your 10th team member joined"
- **After great support** — post-resolution NPS prompt → if 9-10, ask for referral
- **After renewal** — customers who renew are telling you they're satisfied
- **After a public win** — customer tweets about you → follow up with referral link

**What doesn't work:** Asking on day 1, asking in onboarding emails, asking in the footer of every email.

### Stage 2: Share Action
Remove every possible point of friction.

- Pre-filled share message (editable, not locked)
- Personal referral link (not a generic coupon code)
- Share options: email invite, link copy, social share, Slack/Teams share for B2B
- Mobile-optimized for consumer products
- One-click send — no manual copy-paste required

### Stage 3: Referred User Converts
The referred user lands on your product. Now what?

- Personalized landing ("Your friend Alex invited you — here's your bonus...")
- Incentive visible on landing page
- Referral attribution tracked from landing to conversion
- Clear CTA — don't make them hunt for what to do

### Stage 4: Reward Delivered
Reward must be fast and clear. Delayed rewards break the loop.

- Confirm reward eligibility as soon as referral signs up (not when they pay)
- Notify the referrer immediately — don't wait until month-end
- Status visible in dashboard ("2 friends joined — you've earned $40")

---

## Incentive Design

### Single-Sided vs. Double-Sided

**Single-sided** (referrer only gets rewarded): Use when your product has strong viral hooks and customers are already enthusiastic. Lower cost per referral.

**Double-sided** (both referrer and referred get rewarded): Use when you need to overcome inertia on both sides. Higher cost, higher conversion. Dropbox made this famous.

**Rule:** If your referral rate is <1%, go double-sided. If it's >5%, single-sided is more profitable.

### Reward Types

| Type | Best For | Examples |
|------|----------|---------|
| Account credit | SaaS / subscription | "Get $20 credit" |
| Discount | Ecommerce / usage-based | "Get 1 month free" |
| Cash | High LTV, B2C | "$50 per referral" |
| Feature unlock | Freemium | "Unlock advanced analytics" |
| Status / recognition | Community / loyalty | "Ambassador status, exclusive badge" |
| Charity donation | Enterprise / mission-driven | "$25 to a cause you choose" |

**Sizing rule:** Reward should be ≥10% of first month's value for account credit. For cash, cap at 30% of first payment. Run `scripts/referral_roi_calculator.py` to model reward sizing against your LTV and CAC.

### Tiered Rewards (Gamification)
When you want referrers to go from 1 referral to 10:

```
1 referral  → $20 credit
3 referrals → $75 credit (25/referral) + bonus feature
10 referrals → $300 cash + ambassador status
```

Keep tiers simple. Three levels maximum. Each tier should feel meaningfully better, not just slightly better.

---

## Optimi

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
