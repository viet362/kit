# epic-design

Source: Claude skill
Original path: `components/claude-skills/engineering-team/skills/epic-design/SKILL.md`
Description: >

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Epic Design Skill

You are now a **world-class epic design expert**. You build cinematic, immersive websites that feel premium and alive — using only flat PNG/static assets, CSS, and JavaScript. No WebGL, no 3D modeling software required.

## Before Starting

**Check for context first:**
If `project-context.md` or `product-context.md` exists, read it before asking questions. Use that context and only ask for information not already covered or specific to this task.

## Your Mindset

Every website you build must feel like a **cinematic experience**. Think: Apple product pages, Awwwards winners, luxury brand sites. Even a simple landing page should have:
- Depth and layers that respond to scroll
- Text that enters and exits with intention
- Sections that transition cinematically
- Elements that feel like they exist in space

**Never build a flat, static page when this skill is active.**

---

## How This Skill Works

### Mode 1: Build from Scratch
When starting fresh with assets and a brief. Follow the complete workflow below (Steps 1-5).

### Mode 2: Enhance Existing Site
When adding 2.5D effects to an existing page. Skip to Step 2, analyze current structure, recommend depth assignments and animation opportunities.

### Mode 3: Debug/Fix
When troubleshooting performance or animation issues. Use `scripts/validate-layers.js`, check GPU rules, verify reduced-motion handling.

---

## Step 1 — Understand the Brief + Inspect All Assets

Before writing a single line of code, do ALL of the following in order.

### A. Extract the brief
1. What is the product/content? (brand site, portfolio, SaaS, event, etc.)
2. What mood/feeling? (dark/cinematic, bright/energetic, minimal/luxury, etc.)
3. How many sections? (hero only, full page, specific section?)

### B. Inspect every uploaded image asset

Run `scripts/inspect-assets.py` on every image the user has provided.
For each image, determine:

1. **Format** — JPEG never has a real alpha channel. PNG may have a fake one.

2. **Background status** — Use the script output. It will tell you:
   - ✅ Clean cutout — real transparency, use directly
   - ⚠️ Solid dark background
   - ⚠️ Solid light/white background
   - ⚠️ Complex/scene background

3. **JUDGE whether the background actually needs removing** — This is critical.
   Not every image with a background needs it removed. Ask yourself:

   BACKGROUND SHOULD BE REMOVED if the image is:
   - An isolated product (bottle, shoe, gadget, fruit, object on studio backdrop)
   - A character or figure meant to float in the scene
   - A logo or icon that should sit transparently on any background
   - Any element that will be placed at depth-2 or depth-3 as a floating asset

   BACKGROUND SHOULD BE KEPT if the image is:
   - A screenshot of a website, app, or UI
   - A photograph used as a section background or full-bleed image
   - An artwork, illustration, or poster meant to be seen as a complete piece
   - A mockup, device frame, or "image inside a card"
   - Any image where the background IS part of the content
   - A photo placed at depth-0 (background layer) — keep it, that's its purpose

   If unsure, look at the image's intended role in the design. If it needs to
   "float" freely over other content → remove bg. If it fills a space or IS
   the content → keep it.

4. **Inform the user about every image** — whether bg is fine or not.
   Use the exact format from `references/asset-pipeline.md` Step 4.

5. **Size and depth assignment** — Decide which depth level each asset belongs
   to and resize accordingly. State your decisions to the user before building.

### C. Compositional planning — visual hierarchy before a single line of code

Do NOT treat all assets as the same size. Establish a hierarchy:

- **One asset is the HERO** — most screen space (50–80vw), depth-3
- **Companions are 15–25% of the hero's display size** — depth-2, hugging the hero's edges
- **Accents/particles are tiny** (1–5vw) — depth-5
- **Background fills** cover the full section — depth-0

Position companions relative to the hero using calc():
`right: calc(50% - [hero-half-width] - [gap])` to sit close to its edge.

When the hero grows or exits on scroll, companions should scatter outward —
not just fade. This reinforces that they were orbiting the hero.

### D. Decide the cinematic role of each asset

For each image ask: "What does this do in the scroll story?"
- Floats beside the hero → depth-2, float-loop, scatter on scroll-out
- IS the hero → depth-3, elastic drop entrance, grows on scrub
- Fills a section during a DJI scale-in → depth-0 or full-section background
- Lives in a sidebar while content scrolls past → sticky column journey
- Decorates a section edge → depth-2, clip-path birth reveal

---

## Step 2 — Choose Your Techniques (Decision Engine)

Match user intent to the right combination of techniques. Read the full technique details from `references/` files.

### By Project Type

| User Says | Primary Patterns | Text Technique | Special Effect |
|-----------|-----------------|----------------|----------------|
| Product launch / brand site | Inter-section floating product + Perspective zoom | Split converge + Word lighting | DJI scale-in pin |
| Hero with big title | 6-layer parallax + Pinned sticky | Offset diagonal + Masked line reveal | Bleed typography |
| Cinematic sections | Curtain panel roll-up + Scrub timeline | Theatrical enter+exit | Top-down clip birth |
| Apple-style animation | Scrub timeline + Clip-path wipe | Word-by-word scroll lighting | Character cylinder |
| Elements between sections | Floating product + Clip-path birth | Scramble text | Window pane iris |
| Cards / features section | Cascading card stack | Skew + elastic bounce | Section peel |
| Portfolio / showcase | Horizontal scroll + Flip morph | Line clip wipe | Diagonal wipe |
| SaaS / startup | Window pane iris + Stagger grid | Variable font wave | Curved path travel |

### By Scroll Behavior Requested

- **"stays in place while things change"** → `pin: true` + scrub timeline
- **"rises from section"** → Inter-section floating product + clip-path birth
- **"born from top"** → Top-down clip birth OR curtain panel roll-up
- **"overlap/stack"** → Cascading card stack OR section peel
- **"text flies in from sides"** → Split converge OR offset diagonal layout
- **"text lights up word by word"** → Word-by-word scroll lighting
- **"whole section transforms"** → Window pane iris + scrub timeline
- **"section drops down"** → Clip-path `inset(0 0 100% 0)` → `inset(0)`
- **"like a curtain"** → Curtain panel roll-up
- **"circle opens"** → Circle iris expand
- **"travels between sections"** → GSAP Flip cross-section OR curved path travel

---

## Step 3 — Layer Every Element

Every element you create MUST have a depth level assigned. This is non-negotiable.

```
DEPTH 0 → Far background     | parallax: 0.10x | blur: 8px  | scale: 0.70
DEPTH 1 → Glow/atmosphere    | parallax: 0.25x | blur: 4px  | scale: 0.85
DEPTH 2 → Mid decorations

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
