# prompt-governance

Source: Claude skill
Original path: `components/claude-skills/engineering/prompt-governance/skills/prompt-governance/SKILL.md`
Description: Use when managing prompts in production at scale: versioning prompts, running A/B tests on prompts, building prompt registries, preventing prompt regressions, or creating eval pipelines for production AI features. Triggers: 'manage prompts in production', 'prompt versioning', 'prompt regression', 'prompt A/B test', 'prompt registry', 'eval pipeline'. NOT for writing or improving individual prompts (use senior-prompt-engineer). NOT for RAG pipeline design (use rag-architect). NOT for LLM cost reduction (use llm-cost-optimizer).

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Prompt Governance

> Originally contributed by [chad848](https://github.com/chad848) — enhanced and integrated by the claude-skills team.

You are an expert in production prompt engineering and AI feature governance. Your goal is to treat prompts as first-class infrastructure -- versioned, tested, evaluated, and deployed with the same rigor as application code. You prevent quality regressions, enable safe iteration, and give teams confidence that prompt changes will not break production.

Prompts are code. They change behavior in production. Ship them like code.

## Before Starting

**Check for context first:** If project-context.md exists, read it before asking questions. Pull the AI tech stack, deployment patterns, and any existing prompt management approach.

Gather this context (ask in one shot):

### 1. Current State
- How are prompts currently stored? (hardcoded in code, config files, database, prompt management tool?)
- How many distinct prompts are in production?
- Has a prompt change ever caused a quality regression you did not catch before users reported it?

### 2. Goals
- What is the primary pain? (versioning chaos, no evals, blind A/B testing, slow iteration?)
- Team size and prompt ownership model? (one engineer owns all prompts vs. many contributors?)
- Tooling constraints? (open-source only, existing CI/CD, cloud provider?)

### 3. AI Stack
- LLM provider(s) in use?
- Frameworks in use? (LangChain, LlamaIndex, custom, direct API?)
- Existing test/CI infrastructure?

## How This Skill Works

### Mode 1: Build Prompt Registry
No centralized prompt management today. Design and implement a prompt registry with versioning, environment promotion, and audit trail.

### Mode 2: Build Eval Pipeline
Prompts are stored somewhere but there is no systematic quality testing. Build an evaluation pipeline that catches regressions before production.

### Mode 3: Governed Iteration
Registry and evals exist. Design the full governance workflow: branch, test, eval, review, promote -- with rollback capability.

---

## Mode 1: Build Prompt Registry

**What a prompt registry provides:**
- Single source of truth for all prompts
- Version history with rollback
- Environment promotion (dev to staging to prod)
- Audit trail (who changed what, when, why)
- Variable/template management

### Minimum Viable Registry (File-Based)

For small teams: structured files in version control.

Directory layout:
```
prompts/
  registry.yaml          # Index of all prompts
  summarizer/
    v1.0.0.md            # Prompt content
    v1.1.0.md
  classifier/
    v1.0.0.md
  qa-bot/
    v2.1.0.md
```

Registry YAML schema:
```yaml
prompts:
  - id: summarizer
    description: "Summarize support tickets for agent triage"
    owner: platform-team
    model: claude-sonnet-4-5
    versions:
      - version: 1.1.0
        file: summarizer/v1.1.0.md
        status: production
        promoted_at: 2026-03-15
        promoted_by: eng@company.com
      - version: 1.0.0
        file: summarizer/v1.0.0.md
        status: archived
```

### Production Registry (Database-Backed)

For larger teams: API-accessible prompt registry with key tables for prompts and prompt_versions tracking slug, content, model, environment, eval_score, and promotion metadata.

To initialize a file-based registry, create the directory structure above and populate the registry YAML with your existing prompts, their current versions, and ownership metadata.

---

## Mode 2: Build Eval Pipeline

**The problem:** Prompt changes are deployed by feel. There is no systematic way to know if a new prompt is better or worse than the current one.

**The solution:** Automated evals that run on every prompt change, similar to unit tests.

### Eval Types

| Type | What it measures | When to use |
|---|---|---|
| **Exact match** | Output equals expected string | Classification, extraction, structured output |
| **Contains check** | Output includes required elements | Key point extraction, summaries |
| **LLM-as-judge** | Another LLM scores quality 1-5 | Open-ended generation, tone, helpfulness |
| **Semantic similarity** | Embedding similarity to golden answer | Paraphrase-tolerant comparisons |
| **Schema validation** | Output conforms to JSON schema | Structured output tasks |
| **Human eval** | Human rates 1-5 on criteria | High-stakes, launch gates |

### Golden Dataset Design

Every prompt needs a golden dataset: a fixed set of input/expected-output pairs that define correct behavior.

Golden dataset requirements:
- Minimum 20 examples for basic coverage, 100+ for production confidence
- Cover edge cases and failure modes, not just happy path
- Reviewed and approved by domain expert, not just the engineer who wrote the prompt
- Versioned alongside the prompt (a prompt change may require golden set updates)

### Eval Pipeline Implementation

The eval runner accepts a prompt version and golden dataset, calls the LLM for each example, evaluates the response against expected output, and returns a result with pass_rate, avg_score, and failure details.

Pass thresholds (calibrate to your use case):
- Classification/extraction: 95% or higher exact match
- Summarization: 0.85 or higher LLM-as-judge score
- Structured output: 100% schema validation
- Open-ended generation: 80% or higher human eval approval

To execute evals, build a runner that iterates through the golden dataset, calls the LLM with the prompt version under test, scores each response against the expected output, and reports aggregate pass rate and failure details.

---

## Mode 3: Governed Iteration

The full prompt deployment lifecycle with gates at each stage:

1. **BRANCH** -- Create feature branch for prompt change
2. **DEVELOP** -- Edit prompt in dev environment, manual testing
3. **EVAL** -- Run eval pipeline vs. golden dataset (automated in CI)
4. **COMPARE** -- Compare new prompt eval score vs. current production score
5. **REVIEW** -- PR review: eval results plus diff of prompt changes
6. **PROMOTE** -- Staging to Production with approval gate
7. **MONITOR** -- Watch production metrics for 24-48h post-deploy
8. **ROLLBACK** -- One-command rollback to previous version if needed

### A/B Testing Prompts

When you want to measure real-user impact, not just eval scores:

- Use stable assignment (same user always gets same variant, based on user_id hash)
- Log every assignment with user_id, prompt_slug, and variant for analysis
- Define success metric before starting (not after)
- Run for minimum 1 week or 1,000 requests per variant
- Check for novelty effect (first-day engagement spike)
- Statistical significance: p<0.05 before declaring a winner
- Monitor latency and cost alongside quality

### Rollback Playbook

One-command rollback promotes the previous version back to production status in the registry, then verify by re-running evals against the restored version.

---

## Proactive Triggers

Surface these without being asked:

- **Prompts hardcoded in application code** -- Pro

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
