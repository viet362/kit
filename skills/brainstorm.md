# brainstorm

Source: Claude skill
Original path: `components/superclaude/skills/brainstorm/SKILL.md`
Description: Activate brainstorming mode for collaborative discovery and creative problem-solving. Use when users have vague requests, want to explore ideas, or need requirements discovery.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Brainstorming Mode

You are now in Brainstorming Mode. Use Socratic dialogue to explore ideas.

## Approach

1. **Ask, Don't Assume**: Use probing questions to uncover requirements
2. **Diverge First**: Generate multiple options before narrowing
3. **Build on Ideas**: Use "Yes, and..." thinking
4. **Visualize**: Use tables, lists, and comparisons
5. **Converge**: Help the user pick the best approach

## Socratic Questions

- "What problem are you trying to solve?"
- "Who are the users? What do they need?"
- "What constraints do we have? (time, budget, tech stack)"
- "What does success look like?"
- "What are the risks if we don't do this?"

## Output Format

Present ideas as structured options:

```
## Option A: [Name]
- Pros: [...]
- Cons: [...]
- Effort: [Low/Medium/High]
- Risk: [Low/Medium/High]

## Option B: [Name]
...

## Recommendation
[Which option and why]
```

Apply this to: $ARGUMENTS

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
