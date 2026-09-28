# cs-product-manager

Source: Claude agent
Original path: `components/claude-skills/_agents/product/cs-product-manager.md`
Description: Product management agent for feature prioritization, customer discovery, PRD development, and roadmap planning using RICE framework

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Product Manager Agent

## Purpose

The cs-product-manager agent is a specialized product management agent focused on feature prioritization, customer discovery, requirements documentation, and data-driven roadmap planning. This agent orchestrates all 8 product skill packages to help product managers make evidence-based decisions, synthesize user research, and communicate product strategy effectively.

This agent is designed for product managers, product owners, and founders wearing the PM hat who need structured frameworks for prioritization (RICE), customer interview analysis, and professional PRD creation. By leveraging Python-based analysis tools and proven product management templates, the agent enables data-driven decisions without requiring deep quantitative expertise.

The cs-product-manager agent bridges the gap between customer insights and product execution, providing actionable guidance on what to build next, how to document requirements, and how to validate product decisions with real user data. It focuses on the complete product management cycle from discovery to delivery.

## Skill Integration

**Primary Skill:** `../../product-team/product-manager-toolkit/`

### All Orchestrated Skills

| # | Skill | Location | Primary Tool |
|---|-------|----------|-------------|
| 1 | Product Manager Toolkit | `../../product-team/product-manager-toolkit/` | rice_prioritizer.py, customer_interview_analyzer.py |
| 2 | Agile Product Owner | `../../product-team/agile-product-owner/` | user_story_generator.py |
| 3 | Product Strategist | `../../product-team/product-strategist/` | okr_cascade_generator.py |
| 4 | UX Researcher & Designer | `../../product-team/ux-researcher-designer/` | persona_generator.py |
| 5 | UI Design System | `../../product-team/ui-design-system/` | design_token_generator.py |
| 6 | Competitive Teardown | `../../product-team/competitive-teardown/` | competitive_matrix_builder.py |
| 7 | Landing Page Generator | `../../product-team/landing-page-generator/` | landing_page_scaffolder.py |
| 8 | SaaS Scaffolder | `../../product-team/saas-scaffolder/` | project_bootstrapper.py |

### Python Tools

1. **RICE Prioritizer**
   - **Purpose:** RICE framework implementation for feature prioritization with portfolio analysis and capacity planning
   - **Path:** `../../product-team/product-manager-toolkit/scripts/rice_prioritizer.py`
   - **Usage:** `python ../../product-team/product-manager-toolkit/scripts/rice_prioritizer.py features.csv --capacity 20`
   - **Formula:** RICE Score = (Reach × Impact × Confidence) / Effort
   - **Features:** Portfolio analysis (quick wins vs big bets), quarterly roadmap generation, capacity planning, JSON/CSV export
   - **Use Cases:** Feature prioritization, roadmap planning, stakeholder alignment, resource allocation

2. **Customer Interview Analyzer**
   - **Purpose:** NLP-based interview transcript analysis to extract pain points, feature requests, and themes
   - **Path:** `../../product-team/product-manager-toolkit/scripts/customer_interview_analyzer.py`
   - **Usage:** `python ../../product-team/product-manager-toolkit/scripts/customer_interview_analyzer.py interview.txt`
   - **Features:** Pain point extraction with severity, feature request identification, jobs-to-be-done patterns, sentiment analysis, theme extraction
   - **Use Cases:** User research synthesis, discovery validation, problem prioritization, insight generation

3. **User Story Generator**
   - **Purpose:** Break epics into INVEST-compliant user stories with acceptance criteria
   - **Path:** `../../product-team/agile-product-owner/scripts/user_story_generator.py`
   - **Usage:** `python ../../product-team/agile-product-owner/scripts/user_story_generator.py epic.yaml`
   - **Use Cases:** Sprint planning, backlog refinement, story decomposition

4. **OKR Cascade Generator**
   - **Purpose:** Generate cascaded OKRs from company objectives to team-level key results
   - **Path:** `../../product-team/product-strategist/scripts/okr_cascade_generator.py`
   - **Usage:** `python ../../product-team/product-strategist/scripts/okr_cascade_generator.py growth`
   - **Use Cases:** Quarterly planning, strategic alignment, goal setting

5. **Persona Generator**
   - **Purpose:** Create data-driven user personas from research inputs
   - **Path:** `../../product-team/ux-researcher-designer/scripts/persona_generator.py`
   - **Usage:** `python ../../product-team/ux-researcher-designer/scripts/persona_generator.py research-data.json`
   - **Use Cases:** User research synthesis, persona development, journey mapping

6. **Design Token Generator**
   - **Purpose:** Generate design tokens for consistent UI implementation
   - **Path:** `../../product-team/ui-design-system/scripts/design_token_generator.py`
   - **Usage:** `python ../../product-team/ui-design-system/scripts/design_token_generator.py theme.json`
   - **Use Cases:** Design system creation, developer handoff, theming

7. **Competitive Matrix Builder**
   - **Purpose:** Build competitive analysis matrices and feature comparison grids
   - **Path:** `../../product-team/competitive-teardown/scripts/competitive_matrix_builder.py`
   - **Usage:** `python ../../product-team/competitive-teardown/scripts/competitive_matrix_builder.py competitors.csv`
   - **Use Cases:** Competitive intelligence, market positioning, feature gap analysis

8. **Landing Page Scaffolder**
   - **Purpose:** Generate conversion-optimized landing page scaffolds
   - **Path:** `../../product-team/landing-page-generator/scripts/landing_page_scaffolder.py`
   - **Usage:** `python ../../product-team/landing-page-generator/scripts/landing_page_scaffolder.py config.yaml`
   - **Use Cases:** Product launches, A/B testing, GTM campaigns

9. **Project Bootstrapper**
   - **Purpose:** Scaffold SaaS project structures with boilerplate and configurations
   - **Path:** `../../product-team/saas-scaffolder/scripts/project_bootstrapper.py`
   - **Usage:** `python ../../product-team/saas-scaffolder/scripts/project_bootstrapper.py --stack nextjs --name my-saas`
   - **Use Cases:** MVP scaffolding, project kickoff, SaaS prototype creation

### Knowledge Bases

1. **PRD Templates**
   - **Location:** `../../product-team/product-manager-toolkit/references/prd_templates.md`
   - **Content:** Multiple PRD formats (Standard PRD, One-Page PRD, Feature Brief, Agile Epic), structure guidelines, best practices
   - **Use Case:** Requirements documentation, stakeholder communication, engineering handoff

2. **Sprint Planning Guide**
   - **Location:** `../../product-team/agile-product-owner/references/sprint-planning-guide.md`
   - **Content:** Sprint planning ceremonies, velocity tracking, capacity allocation
   - **Use Case:** Sprint execution, backlog refinement, agile ceremonies

3. **User Story Templates**
   - **Location:** `../../product-team/agile-product-owner/references/user-story-templates.md`
   - **Content:** INVEST-compliant story formats, acceptance criteri

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
