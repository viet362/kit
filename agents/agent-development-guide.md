# Agent Development Guide

Source: Claude agent
Original path: `components/claude-skills/_agents/CLAUDE.md`
Description: This guide provides comprehensive instructions for creating **cs-* prefixed agents** that seamlessly integrate with the 42 production skills in this repository.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Agent Development Guide

This guide provides comprehensive instructions for creating **cs-* prefixed agents** that seamlessly integrate with the 42 production skills in this repository.

## Agent Architecture

### What are cs-* Agents?

**cs-* agents** are specialized Claude Code agents that orchestrate the 177 existing skills. Each agent:
- References skills via relative paths (`../../marketing-skill/`)
- Executes Python automation tools from skill packages
- Follows established workflows and templates
- Maintains skill portability and independence

**Key Principle**: Agents ORCHESTRATE skills, they don't replace them. Skills remain self-contained and portable.

### ClawHub Publishing Constraints

When skills are published to **ClawHub** (clawhub.com):
- **cs- prefix for slug conflicts only** — applies only on the ClawHub registry when another publisher already owns the slug. Repo folder names and local skill names are never renamed.
- **No paid/commercial service dependencies** — skills must not require paid third-party API keys or commercial services unless provided by the project itself.
- **plugin.json** — ONLY fields: `name`, `description`, `version`, `author`, `homepage`, `repository`, `license`, `skills: "./"`.
- **Rate limit:** 5 new skills/hour on ClawHub. Use drip publishing for bulk operations.

### Production Agents

**16 Agents Currently Available**:

| Agent | Domain | Description |
|-------|--------|-------------|
| [cs-content-creator](marketing/cs-content-creator.md) | Marketing | AI-powered content creation with brand voice consistency and SEO optimization |
| [cs-demand-gen-specialist](marketing/cs-demand-gen-specialist.md) | Marketing | Demand generation and customer acquisition specialist |
| [cs-ceo-advisor](c-level/cs-ceo-advisor.md) | C-Level | Strategic leadership advisor for CEOs |
| [cs-cto-advisor](c-level/cs-cto-advisor.md) | C-Level | Technical leadership advisor for CTOs |
| [cs-product-manager](product/cs-product-manager.md) | Product | RICE prioritization and customer discovery |
| [cs-product-strategist](product/cs-product-strategist.md) | Product | Product strategy, OKR cascades, market positioning |
| [cs-agile-product-owner](product/cs-agile-product-owner.md) | Product | Agile product ownership and backlog management |
| [cs-ux-researcher](product/cs-ux-researcher.md) | Product | UX research, usability testing, design insights |
| [cs-product-analyst](product/cs-product-analyst.md) | Product | Product analytics, KPI design, experiment design |
| [cs-engineering-lead](engineering-team/cs-engineering-lead.md) | Engineering | Engineering team coordination and incident management |
| [cs-workspace-admin](engineering-team/cs-workspace-admin.md) | Engineering | Google Workspace administration via gws CLI |
| [cs-senior-engineer](engineering/cs-senior-engineer.md) | Engineering | Architecture decisions, code review, CI/CD setup |
| [cs-growth-strategist](business-growth/cs-growth-strategist.md) | Business | Growth strategy and revenue optimization |
| [cs-financial-analyst](finance/cs-financial-analyst.md) | Finance | Financial analysis, DCF valuation, SaaS metrics |
| [cs-project-manager](project-management/cs-project-manager.md) | PM | Project management with Atlassian integration |
| [cs-quality-regulatory](ra-qm-team/cs-quality-regulatory.md) | RA/QM | Regulatory affairs and quality management |

**Template Available**: [templates/agent-template.md](../templates/agent-template.md) (318 lines) - Use this to create new agents

### Agent vs Skill

| Aspect | Agent (cs-*) | Skill |
|--------|-------------|-------|
| **Purpose** | Orchestrate and execute workflows | Provide tools, knowledge, templates |
| **Location** | `agents/domain/` | `domain-skill/skill-name/` |
| **Structure** | Single .md file with YAML frontmatter | SKILL.md + scripts/ + references/ + assets/ |
| **Integration** | References skills via `../../` | Self-contained, no dependencies |
| **Naming** | cs-content-creator, cs-ceo-advisor | content-creator, ceo-advisor |

## Agent File Structure

### Required YAML Frontmatter

Every agent file must start with valid YAML frontmatter:

```yaml
---
name: cs-agent-name
description: One-line description of what this agent does
skills: skill-folder-name
domain: domain-name
model: sonnet
tools: [Read, Write, Bash, Grep, Glob]
---
```

**Field Definitions:**
- **name**: Agent identifier with `cs-` prefix (e.g., `cs-content-creator`)
- **description**: Single sentence describing agent's purpose
- **skills**: Skill folder this agent references (e.g., `marketing-skill/content-creator`)
- **domain**: Domain category (marketing, product, engineering, c-level, pm, ra-qm)
- **model**: Claude model to use (sonnet, opus, haiku)
- **tools**: Array of Claude Code tools agent can use

### Required Markdown Sections

After YAML frontmatter, include these sections:

1. **Purpose** (2-3 paragraphs)
2. **Skill Integration** (with subsections)
   - Skill Location
   - Python Tools
   - Knowledge Bases
   - Templates
3. **Workflows** (minimum 3 workflows)
4. **Integration Examples** (concrete code/command examples)
5. **Success Metrics** (how to measure effectiveness)
6. **Related Agents** (cross-references)
7. **References** (links to documentation)

## Relative Path Resolution

### Path Pattern

All skill references use the `../../` pattern:

```markdown
**Skill Location:** `../../marketing-skill/content-creator/`

### Python Tools

1. **Brand Voice Analyzer**
   - **Path:** `../../marketing-skill/content-creator/scripts/brand_voice_analyzer.py`
   - **Usage:** `python ../../marketing-skill/content-creator/scripts/brand_voice_analyzer.py content.txt`

2. **SEO Optimizer**
   - **Path:** `../../marketing-skill/content-creator/scripts/seo_optimizer.py`
   - **Usage:** `python ../../marketing-skill/content-creator/scripts/seo_optimizer.py article.md "keyword"`
```

### Why `../../`?

From agent location: `agents/marketing/cs-content-creator.md`
To skill location: `marketing-skill/content-creator/`

Navigation: `agents/marketing/` → `../../` (up to root) → `marketing-skill/content-creator/`

**Always test paths resolve correctly!**

## Python Tool Integration

### Execution Pattern

Agents execute Python tools from skill packages:

```bash
# From agent context
python ../../marketing-skill/content-creator/scripts/brand_voice_analyzer.py input.txt

# With JSON output
python ../../marketing-skill/content-creator/scripts/brand_voice_analyzer.py input.txt json

# With arguments
python ../../product-team/product-manager-toolkit/scripts/rice_prioritizer.py features.csv --capacity 20
```

### Tool Requirements

All Python tools must:
- Use standard library only (or minimal dependencies documented in SKILL.md)
- Support both JSON and human-readable output
- Provide `--help` flag with usage information
- Return appropriate exit codes (0 = success, 1 = error)
- Handle missing arguments gracefully

### Error Handling

When Python tools fail:
1. Check file path

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
