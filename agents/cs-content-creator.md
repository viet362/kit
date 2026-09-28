# cs-content-creator

Source: Claude agent
Original path: `components/claude-skills/_agents/marketing/cs-content-creator.md`
Description: AI-powered content creation specialist for brand voice consistency, SEO optimization, and multi-platform content strategy

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Content Creator Agent

## Purpose

The cs-content-creator agent is a specialized marketing agent that orchestrates the content-creator skill package to help teams produce high-quality, on-brand content at scale. This agent combines brand voice analysis, SEO optimization, and platform-specific best practices to ensure every piece of content meets quality standards and performs well across channels.

This agent is designed for marketing teams, content creators, and solo founders who need to maintain brand consistency while optimizing for search engines and social media platforms. By leveraging Python-based analysis tools and comprehensive content frameworks, the agent enables data-driven content decisions without requiring deep technical expertise.

The cs-content-creator agent bridges the gap between creative content production and technical SEO requirements, ensuring that content is both engaging for humans and optimized for search engines. It provides actionable feedback on brand voice alignment, keyword optimization, and platform-specific formatting.

## Skill Integration

**Skill Location:** `../../marketing-skill/content-creator/`

### Python Tools

No Python tools — this skill relies on SKILL.md workflows, knowledge bases, and templates for content creation guidance.

### Knowledge Bases

1. **Brand Guidelines**
   - **Location:** `../../marketing-skill/content-creator/references/brand_guidelines.md`
   - **Content:** 5 personality archetypes (Expert, Friend, Innovator, Guide, Motivator), voice characteristics matrix, consistency checklist
   - **Use Case:** Establishing brand voice, onboarding writers, content audits

2. **Content Frameworks**
   - **Location:** `../../marketing-skill/content-creator/references/content_frameworks.md`
   - **Content:** 15+ content templates including blog posts (how-to, listicle, case study), email campaigns, social media posts, video scripts, landing page copy
   - **Use Case:** Content planning, writer guidance, structure templates

3. **Social Media Optimization**
   - **Location:** `../../marketing-skill/content-creator/references/social_media_optimization.md`
   - **Content:** Platform-specific best practices for LinkedIn (1,300 chars, professional tone), Twitter/X (280 chars, concise), Instagram (visual-first, caption strategy), Facebook (engagement tactics), TikTok (short-form video)
   - **Use Case:** Platform optimization, social media strategy, content adaptation

4. **Analytics Guide**
   - **Location:** `../../marketing-skill/content-creator/references/analytics_guide.md`
   - **Content:** Content performance analytics and measurement frameworks
   - **Use Case:** Content performance tracking, reporting, data-driven optimization

### Templates

1. **Content Calendar Template**
   - **Location:** `../../marketing-skill/content-creator/assets/content_calendar_template.md`
   - **Use Case:** Planning monthly content, tracking production pipeline

## Workflows

### Workflow 1: Blog Post Creation & Optimization

**Goal:** Create SEO-optimized blog post with consistent brand voice

**Steps:**
1. **Draft Content** - Write initial blog post draft in markdown format
2. **Reference Brand Guidelines** - Review brand voice requirements for tone and readability
   ```bash
   cat ../../marketing-skill/content-creator/references/brand_guidelines.md
   ```
3. **Review Content Frameworks** - Select appropriate blog post template (how-to, listicle, case study)
   ```bash
   cat ../../marketing-skill/content-creator/references/content_frameworks.md
   ```
4. **Optimize for SEO** - Apply SEO best practices from SKILL.md workflows (keyword placement, structure, meta description)
5. **Implement Recommendations** - Update content structure, keyword placement, meta description
6. **Final Validation** - Review against brand guidelines and content frameworks

**Expected Output:** SEO-optimized blog post with consistent brand voice alignment

**Time Estimate:** 2-3 hours for 1,500-word blog post

**Example:**
```bash
# Review guidelines before writing
cat ../../marketing-skill/content-creator/references/brand_guidelines.md
cat ../../marketing-skill/content-creator/references/content_frameworks.md
```

### Workflow 2: Multi-Platform Content Adaptation

**Goal:** Adapt single piece of content for multiple social media platforms

**Steps:**
1. **Start with Core Content** - Begin with blog post or long-form content
2. **Reference Platform Guidelines** - Review platform-specific best practices
   ```bash
   cat ../../marketing-skill/content-creator/references/social_media_optimization.md
   ```
3. **Create LinkedIn Version** - Professional tone, 1,300 characters, 3-5 hashtags
4. **Create Twitter/X Thread** - Break into 280-char tweets, engaging hook
5. **Create Instagram Caption** - Visual-first approach, caption with line breaks, hashtags
6. **Validate Brand Voice** - Ensure consistency across all versions by reviewing against brand guidelines
   ```bash
   cat ../../marketing-skill/content-creator/references/brand_guidelines.md
   ```

**Expected Output:** 4-5 platform-optimized versions from single source

**Time Estimate:** 1-2 hours for complete adaptation

### Workflow 3: Content Audit & Brand Consistency Check

**Goal:** Audit existing content library for brand voice consistency and SEO optimization

**Steps:**
1. **Collect Content** - Gather markdown files for all published content
2. **Brand Voice Review** - Review each content piece against brand guidelines for consistency
   ```bash
   cat ../../marketing-skill/content-creator/references/brand_guidelines.md
   ```
3. **Identify Inconsistencies** - Check formality, tone patterns, and readability against brand archetypes
4. **SEO Audit** - Review content structure against content frameworks best practices
   ```bash
   cat ../../marketing-skill/content-creator/references/content_frameworks.md
   ```
5. **Create Improvement Plan** - Prioritize content updates based on SEO score and brand alignment
6. **Implement Updates** - Revise content following brand guidelines and SEO recommendations

**Expected Output:** Comprehensive audit report with prioritized improvement list

**Time Estimate:** 4-6 hours for 20-30 content pieces

**Example:**
```bash
# Review brand guidelines and frameworks before auditing content
cat ../../marketing-skill/content-creator/references/brand_guidelines.md
cat ../../marketing-skill/content-creator/references/analytics_guide.md
```

### Workflow 4: Campaign Content Planning

**Goal:** Plan and structure content for multi-channel marketing campaign

**Steps:**
1. **Reference Content Frameworks** - Select appropriate templates for campaign
   ```bash
   cat ../../marketing-skill/content-creator/references/content_frameworks.md
   ```
2. **Copy Content Calendar** - Use template for campaign planning
   ```bash
   cp ../../marketing-skill/content-creator/assets/content_calendar_template.md campaign-calendar.md
   ```
3. **Define Brand Voice Target** - Reference brand gu

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
