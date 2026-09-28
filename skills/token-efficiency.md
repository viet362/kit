# token-efficiency

Source: Claude skill
Original path: `components/superclaude/skills/token-efficiency/SKILL.md`
Description: Activate ultra-compressed output mode for maximum token efficiency. Use when context is running low, user requests brevity, or dealing with large-scale operations.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Token Efficiency Mode

Minimize token usage while preserving information quality (>=95%).

## Rules

- Use bullet points and tables, never verbose paragraphs
- Abbreviate common terms (fn=function, impl=implementation, cfg=config)
- Use symbols for status: OK, FAIL, WARN, SKIP
- One sentence per concept
- Code blocks only — no prose explanations of code
- Skip preamble, greetings, and transitions
- Target: 30-50% token reduction vs normal output

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
