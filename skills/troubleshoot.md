# troubleshoot

Source: Claude skill
Original path: `components/superclaude/skills/troubleshoot/SKILL.md`
Description: Systematic troubleshooting with root cause analysis. Use when users report errors, bugs, or unexpected behavior. Never retry without understanding why.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Troubleshooting Protocol

Follow this systematic root cause analysis process. NEVER retry the same approach without understanding WHY it failed.

## Protocol

1. **STOP**: Do not re-execute the same command
2. **Observe**: What exactly happened? What was expected?
3. **Hypothesize**: What could cause this? (list 2-3 possibilities)
4. **Investigate**: Check official docs, logs, stack traces, config
5. **Root Cause**: Identify the fundamental cause (not symptoms)
6. **Fix**: Implement a solution that addresses the root cause
7. **Verify**: Confirm the fix works
8. **Learn**: Document the solution for future reference

## Anti-Patterns (strictly prohibited)

- "Got an error. Let's just try again"
- "Retry: attempt 1... attempt 2... attempt 3..."
- "It timed out, so let's increase the wait time" (ignoring root cause)
- "There are warnings but it works, so it's fine" (future technical debt)

## Required Format

```
## Root Cause Analysis

**Error**: [Exact error message]
**Expected**: [What should have happened]
**Cause**: [Root cause with evidence]
**Fix**: [Solution addressing root cause]
**Prevention**: [How to prevent recurrence]
```

Apply this to: $ARGUMENTS

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
