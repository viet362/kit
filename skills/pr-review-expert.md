# pr-review-expert

Source: Claude skill
Original path: `components/claude-skills/engineering/skills/pr-review-expert/SKILL.md`
Description: Use when the user asks to review pull requests, analyze code changes, check for security issues in PRs, or assess code quality of diffs.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# PR Review Expert

**Tier:** POWERFUL
**Category:** Engineering
**Domain:** Code Review / Quality Assurance

---

## Overview

Structured, systematic code review for GitHub PRs and GitLab MRs. Goes beyond style nits — this skill
performs blast radius analysis, security scanning, breaking change detection, and test coverage delta
calculation. Produces a reviewer-ready report with a 30+ item checklist and prioritized findings.

---

## Core Capabilities

- **Blast radius analysis** — trace which files, services, and downstream consumers could break
- **Security scan** — SQL injection, XSS, auth bypass, secret exposure, dependency vulns
- **Test coverage delta** — new code vs new tests ratio
- **Breaking change detection** — API contracts, DB schema migrations, config keys
- **Ticket linking** — verify Jira/Linear ticket exists and matches scope
- **Performance impact** — N+1 queries, bundle size regression, memory allocations

---

## When to Use

- Before merging any PR/MR that touches shared libraries, APIs, or DB schema
- When a PR is large (>200 lines changed) and needs structured review
- Onboarding new contributors whose PRs need thorough feedback
- Security-sensitive code paths (auth, payments, PII handling)
- After an incident — review similar PRs proactively

---

## Fetching the Diff

### GitHub (gh CLI)
```bash
# View diff in terminal
gh pr diff <PR_NUMBER>

# Get PR metadata (title, body, labels, linked issues)
gh pr view <PR_NUMBER> --json title,body,labels,assignees,milestone

# List files changed
gh pr diff <PR_NUMBER> --name-only

# Check CI status
gh pr checks <PR_NUMBER>

# Download diff to file for analysis
gh pr diff <PR_NUMBER> > /tmp/pr-<PR_NUMBER>.diff
```

### GitLab (glab CLI)
```bash
# View MR diff
glab mr diff <MR_IID>

# MR details as JSON
glab mr view <MR_IID> --output json

# List changed files
glab mr diff <MR_IID> --name-only

# Download diff
glab mr diff <MR_IID> > /tmp/mr-<MR_IID>.diff
```

---

## Workflow

### Step 1 — Fetch Context

```bash
PR=123
gh pr view $PR --json title,body,labels,milestone,assignees | jq .
gh pr diff $PR --name-only
gh pr diff $PR > /tmp/pr-$PR.diff
```

### Step 2 — Blast Radius Analysis

For each changed file, identify:

1. **Direct dependents** — who imports this file?
```bash
# Find all files importing a changed module
grep -r "from ['\"].*changed-module['\"]" src/ --include="*.ts" -l
grep -r "require(['\"].*changed-module" src/ --include="*.js" -l

# Python
grep -r "from changed_module import\|import changed_module" . --include="*.py" -l
```

2. **Service boundaries** — does this change cross a service?
```bash
# Check if changed files span multiple services (monorepo)
gh pr diff $PR --name-only | cut -d/ -f1-2 | sort -u
```

3. **Shared contracts** — types, interfaces, schemas
```bash
gh pr diff $PR --name-only | grep -E "types/|interfaces/|schemas/|models/"
```

**Blast radius severity:**
- CRITICAL — shared library, DB model, auth middleware, API contract
- HIGH     — service used by >3 others, shared config, env vars
- MEDIUM   — single service internal change, utility function
- LOW      — UI component, test file, docs

### Step 3 — Security Scan

```bash
DIFF=/tmp/pr-$PR.diff

# SQL Injection — raw query string interpolation
grep -n "query\|execute\|raw(" $DIFF | grep -E '\$\{|f"|%s|format\('

# Hardcoded secrets
grep -nE "(password|secret|api_key|token|private_key)\s*=\s*['\"][^'\"]{8,}" $DIFF

# AWS key pattern
grep -nE "AKIA[0-9A-Z]{16}" $DIFF

# JWT secret in code
grep -nE "jwt\.sign\(.*['\"][^'\"]{20,}['\"]" $DIFF

# XSS vectors
grep -n "dangerouslySetInnerHTML\|innerHTML\s*=" $DIFF

# Auth bypass patterns
grep -n "bypass\|skip.*auth\|noauth\|TODO.*auth" $DIFF

# Insecure hash algorithms
grep -nE "md5\(|sha1\(|createHash\(['\"]md5|createHash\(['\"]sha1" $DIFF

# eval / exec
grep -nE "\beval\(|\bexec\(|\bsubprocess\.call\(" $DIFF

# Prototype pollution
grep -n "__proto__\|constructor\[" $DIFF

# Path traversal risk
grep -nE "path\.join\(.*req\.|readFile\(.*req\." $DIFF
```

### Step 4 — Test Coverage Delta

```bash
# Count source vs test files changed
CHANGED_SRC=$(gh pr diff $PR --name-only | grep -vE "\.test\.|\.spec\.|__tests__")
CHANGED_TESTS=$(gh pr diff $PR --name-only | grep -E "\.test\.|\.spec\.|__tests__")

echo "Source files changed: $(echo "$CHANGED_SRC" | wc -w)"
echo "Test files changed:   $(echo "$CHANGED_TESTS" | wc -w)"

# Lines of new logic vs new test lines
LOGIC_LINES=$(grep "^+" /tmp/pr-$PR.diff | grep -v "^+++" | wc -l)
echo "New lines added: $LOGIC_LINES"

# Run coverage locally
npm test -- --coverage --changedSince=main 2>/dev/null | tail -20
pytest --cov --cov-report=term-missing 2>/dev/null | tail -20
```

**Coverage delta rules:**
- New function without tests → flag
- Deleted tests without deleted code → flag
- Coverage drop >5% → block merge
- Auth/payments paths → require 100% coverage

### Step 5 — Breaking Change Detection

#### API Contract Changes
```bash
# OpenAPI/Swagger spec changes
grep -n "openapi\|swagger" /tmp/pr-$PR.diff | head -20

# REST route removals or renames
grep "^-" /tmp/pr-$PR.diff | grep -E "router\.(get|post|put|delete|patch)\("

# GraphQL schema removals
grep "^-" /tmp/pr-$PR.diff | grep -E "^-\s*(type |field |Query |Mutation )"

# TypeScript interface removals
grep "^-" /tmp/pr-$PR.diff | grep -E "^-\s*(export\s+)?(interface|type) "
```

#### DB Schema Changes
```bash
# Migration files added
gh pr diff $PR --name-only | grep -E "migrations?/|alembic/|knex/"

# Destructive operations
grep -E "DROP TABLE|DROP COLUMN|ALTER.*NOT NULL|TRUNCATE" /tmp/pr-$PR.diff

# Index removals (perf regression risk)
grep "DROP INDEX\|remove_index" /tmp/pr-$PR.diff
```

#### Config / Env Var Changes
```bash
# New env vars referenced in code (might be missing in prod)
grep "^+" /tmp/pr-$PR.diff | grep -oE "process\.env\.[A-Z_]+" | sort -u

# Removed env vars (could break running instances)
grep "^-" /tmp/pr-$PR.diff | grep -oE "process\.env\.[A-Z_]+" | sort -u
```

### Step 6 — Performance Impact

```bash
# N+1 query patterns (DB calls inside loops)
grep -n "\.find\|\.findOne\|\.query\|db\." /tmp/pr-$PR.diff | grep "^+" | head -20
# Then check surrounding context for forEach/map/for loops

# Heavy new dependencies
grep "^+" /tmp/pr-$PR.diff | grep -E '"[a-z@].*":\s*"[0-9^~]' | head -20

# Unbounded loops
grep -n "while (true\|while(true" /tmp/pr-$PR.diff | grep "^+"

# Missing await (accidentally sequential promises)
grep -n "await.*await" /tmp/pr-$PR.diff | grep "^+" | head -10

# Large in-memory allocations
grep -n "new Array([0-9]\{4,\}\|Buffer\.alloc" /tmp/pr-$PR.diff | grep "^+"
```

---

## Ticket Linking Verification

```bash
# Extract ticket references from PR body
gh pr view $PR --json body | jq -r '.body' | \
  grep -oE "(PROJ-[0-9]+|[A-Z]+-[0-9]+|https://linear\.app/[^)\"]+)" | sort -u

# Verify Jira ticket exists (requires JIRA_API_TOKEN)
TICKET="PROJ-123"
curl -s -u "user@company.com:$JIRA_API_TOKEN" \
  "https://your-org.atlassian.net/rest/api/3/iss

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
