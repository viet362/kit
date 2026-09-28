# app-store-optimization

Source: Claude skill
Original path: `components/claude-skills/marketing-skill/skills/app-store-optimization/SKILL.md`
Description: App Store Optimization (ASO) toolkit for researching keywords, analyzing competitor rankings, generating metadata suggestions, and improving app visibility on Apple App Store and Google Play Store. Use when the user asks about ASO, app store rankings, app metadata, app titles and descriptions, app store listings, app visibility, or mobile app marketing on iOS or Android. Supports keyword research and scoring, competitor keyword analysis, metadata optimization, A/B test planning, launch checklists, and tracking ranking changes.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# App Store Optimization (ASO)

---

## Keyword Research Workflow

Discover and evaluate keywords that drive app store visibility.

### Workflow: Conduct Keyword Research

1. Define target audience and core app functions:
   - Primary use case (what problem does the app solve)
   - Target user demographics
   - Competitive category
2. Generate seed keywords from:
   - App features and benefits
   - User language (not developer terminology)
   - App store autocomplete suggestions
3. Expand keyword list using:
   - Modifiers (free, best, simple)
   - Actions (create, track, organize)
   - Audiences (for students, for teams, for business)
4. Evaluate each keyword:
   - Search volume (estimated monthly searches)
   - Competition (number and quality of ranking apps)
   - Relevance (alignment with app function)
5. Score and prioritize keywords:
   - Primary: Title and keyword field (iOS)
   - Secondary: Subtitle and short description
   - Tertiary: Full description only
6. Map keywords to metadata locations
7. Document keyword strategy for tracking
8. **Validation:** Keywords scored; placement mapped; no competitor brand names included; no plurals in iOS keyword field

### Keyword Evaluation Criteria

| Factor | Weight | High Score Indicators |
|--------|--------|----------------------|
| Relevance | 35% | Describes core app function |
| Volume | 25% | 10,000+ monthly searches |
| Competition | 25% | Top 10 apps have <4.5 avg rating |
| Conversion | 15% | Transactional intent ("best X app") |

### Keyword Placement Priority

| Location | Search Weight |
|----------|---------------|
| App Title | Highest |
| Subtitle (iOS) | High |
| Keyword Field (iOS) | High |
| Short Description (Android) | High |
| Full Description | Medium |

See: [references/keyword-research-guide.md](references/keyword-research-guide.md)

---

## Metadata Optimization Workflow

Optimize app store listing elements for search ranking and conversion.

### Workflow: Optimize App Metadata

1. Audit current metadata against platform limits:
   - Title character count and keyword presence
   - Subtitle/short description usage
   - Keyword field efficiency (iOS)
   - Description keyword density
2. Optimize title following formula:
   ```
   [Brand Name] - [Primary Keyword] [Secondary Keyword]
   ```
3. Write subtitle (iOS) or short description (Android):
   - Focus on primary benefit
   - Include secondary keyword
   - Use action verbs
4. Optimize keyword field (iOS only):
   - Remove duplicates from title
   - Remove plurals (Apple indexes both forms)
   - No spaces after commas
   - Prioritize by score
5. Rewrite full description:
   - Hook paragraph with value proposition
   - Feature bullets with keywords
   - Social proof section
   - Call to action
6. Validate character counts for each field
7. Calculate keyword density (target 2-3% primary)
8. **Validation:** All fields within character limits; primary keyword in title; no keyword stuffing (>5%); natural language preserved

### Platform Character Limits

| Field | Apple App Store | Google Play Store |
|-------|-----------------|-------------------|
| Title | 30 characters | 50 characters |
| Subtitle | 30 characters | N/A |
| Short Description | N/A | 80 characters |
| Keywords | 100 characters | N/A |
| Promotional Text | 170 characters | N/A |
| Full Description | 4,000 characters | 4,000 characters |
| What's New | 4,000 characters | 500 characters |

### Description Structure

```
PARAGRAPH 1: Hook (50-100 words)
├── Address user pain point
├── State main value proposition
└── Include primary keyword

PARAGRAPH 2-3: Features (100-150 words)
├── Top 5 features with benefits
├── Bullet points for scanability
└── Secondary keywords naturally integrated

PARAGRAPH 4: Social Proof (50-75 words)
├── Download count or rating
├── Press mentions or awards
└── Summary of user testimonials

PARAGRAPH 5: Call to Action (25-50 words)
├── Clear next step
└── Reassurance (free trial, no signup)
```

See: [references/platform-requirements.md](references/platform-requirements.md)

---

## Competitor Analysis Workflow

Analyze top competitors to identify keyword gaps and positioning opportunities.

### Workflow: Analyze Competitor ASO Strategy

1. Identify top 10 competitors:
   - Direct competitors (same core function)
   - Indirect competitors (overlapping audience)
   - Category leaders (top downloads)
2. Extract competitor keywords from:
   - App titles and subtitles
   - First 100 words of descriptions
   - Visible metadata patterns
3. Build competitor keyword matrix:
   - Map which keywords each competitor targets
   - Calculate coverage percentage per keyword
4. Identify keyword gaps:
   - Keywords with <40% competitor coverage
   - High volume terms competitors miss
   - Long-tail opportunities
5. Analyze competitor visual assets:
   - Icon design patterns
   - Screenshot messaging and style
   - Video presence and quality
6. Compare ratings and review patterns:
   - Average rating by competitor
   - Common praise themes
   - Common complaint themes
7. Document positioning opportunities
8. **Validation:** 10+ competitors analyzed; keyword matrix complete; gaps identified with volume estimates; visual audit documented

### Competitor Analysis Matrix

| Analysis Area | Data Points |
|---------------|-------------|
| Keywords | Title keywords, description frequency |
| Metadata | Character utilization, keyword density |
| Visuals | Icon style, screenshot count/style |
| Ratings | Average rating, total count, velocity |
| Reviews | Top praise, top complaints |

### Gap Analysis Template

| Opportunity Type | Example | Action |
|------------------|---------|--------|
| Keyword gap | "habit tracker" (40% coverage) | Add to keyword field |
| Feature gap | Competitor lacks widget | Highlight in screenshots |
| Visual gap | No videos in top 5 | Create app preview |
| Messaging gap | None mention "free" | Test free positioning |

---

## App Launch Workflow

Execute a structured launch for maximum initial visibility.

### Workflow: Launch App to Stores

1. Complete pre-launch preparation (4 weeks before):
   - Finalize keywords and metadata
   - Prepare all visual assets
   - Set up analytics (Firebase, Mixpanel)
   - Build press kit and media list
2. Submit for review (2 weeks before):
   - Complete all store requirements
   - Verify compliance with guidelines
   - Prepare launch communications
3. Configure post-launch systems:
   - Set up review monitoring
   - Prepare response templates
   - Configure rating prompt timing
4. Execute launch day:
   - Verify app is live in both stores
   - Announce across all channels
   - Begin review response cycle
5. Monitor initial performance (days 1-7):
   - Track download velocity hourly
   - Monitor reviews and respond within 24 hours
   - Document any issues for quick fixes
6. Conduct 7-day retrospective:
   - Compare performance to projections
   - Identify quick optimization wins
   - Plan first metadata update
7. Schedule

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
