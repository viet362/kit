# security-pen-testing

Source: Claude skill
Original path: `components/claude-skills/engineering-team/skills/security-pen-testing/SKILL.md`
Description: Use when the user asks to perform security audits, penetration testing, vulnerability scanning, OWASP Top 10 checks, or offensive security assessments. Covers static analysis, dependency scanning, secret detection, API security testing, and pen test report generation.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Security Penetration Testing

Hands-on offensive security testing skill for finding vulnerabilities before attackers do. This is NOT compliance checking (see senior-secops) or security policy writing (see senior-security) — this is about systematic vulnerability discovery through authorized testing.

---

## Table of Contents

- [Overview](#overview)
- [OWASP Top 10 Systematic Audit](#owasp-top-10-systematic-audit)
- [Static Analysis](#static-analysis)
- [Dependency Vulnerability Scanning](#dependency-vulnerability-scanning)
- [Secret Scanning](#secret-scanning)
- [API Security Testing](#api-security-testing)
- [Web Vulnerability Testing](#web-vulnerability-testing)
- [Infrastructure Security](#infrastructure-security)
- [Pen Test Report Generation](#pen-test-report-generation)
- [Responsible Disclosure Workflow](#responsible-disclosure-workflow)
- [Workflows](#workflows)
- [Anti-Patterns](#anti-patterns)
- [Cross-References](#cross-references)

---

## Overview

### What This Skill Does

This skill provides the methodology, checklists, and automation for **offensive security testing** — actively probing systems to discover exploitable vulnerabilities. It covers web applications, APIs, infrastructure, and supply chain security.

### Distinction from Other Security Skills

| Skill | Focus | Approach |
|-------|-------|----------|
| **security-pen-testing** (this) | Finding vulnerabilities | Offensive — simulate attacker techniques |
| senior-secops | Security operations | Defensive — monitoring, incident response, SIEM |
| senior-security | Security policy | Governance — policies, frameworks, risk registers |
| skill-security-auditor | CI/CD gates | Automated — pre-merge security checks |

### Prerequisites

All testing described here assumes **written authorization** from the system owner. Unauthorized testing is illegal under the CFAA and equivalent laws worldwide. Always obtain a signed scope-of-work or rules-of-engagement document before starting.

---

## OWASP Top 10 Systematic Audit

Use the vulnerability scanner tool for automated checklist generation:

```bash
# Generate OWASP checklist for a web application
python scripts/vulnerability_scanner.py --target web --scope full

# Quick API-focused scan
python scripts/vulnerability_scanner.py --target api --scope quick --json
```

### Quick Reference

| # | Category | Key Tests |
|---|----------|-----------|
| A01 | Broken Access Control | IDOR, vertical escalation, CORS, JWT claim manipulation, forced browsing |
| A02 | Cryptographic Failures | TLS version, password hashing, hardcoded keys, weak PRNG |
| A03 | Injection | SQLi, NoSQLi, command injection, template injection, XSS |
| A04 | Insecure Design | Rate limiting, business logic abuse, multi-step flow bypass |
| A05 | Security Misconfiguration | Default credentials, debug mode, security headers, directory listing |
| A06 | Vulnerable Components | Dependency audit (npm/pip/go), EOL checks, known CVEs |
| A07 | Auth Failures | Brute force, session cookie flags, session invalidation, MFA bypass |
| A08 | Integrity Failures | Unsafe deserialization, SRI checks, CI/CD pipeline integrity |
| A09 | Logging Failures | Auth event logging, sensitive data in logs, alerting thresholds |
| A10 | SSRF | Internal IP access, cloud metadata endpoints, DNS rebinding |

```bash
# Audit dependencies
python scripts/dependency_auditor.py --file package.json --severity high
python scripts/dependency_auditor.py --file requirements.txt --json
```

See [owasp_top_10_checklist.md](references/owasp_top_10_checklist.md) for detailed test procedures, code patterns to detect, remediation steps, and CVSS scoring guidance for each category.

---

## Static Analysis

**Recommended tools:** CodeQL (custom queries for project-specific patterns), Semgrep (rule-based scanning with auto-fix), ESLint security plugins (`eslint-plugin-security`, `eslint-plugin-no-unsanitized`).

Key patterns to detect: SQL injection via string concatenation, hardcoded JWT secrets, unsafe YAML/pickle deserialization, missing security middleware (e.g., Express without Helmet).

See [attack_patterns.md](references/attack_patterns.md) for code patterns and detection payloads across injection types.

---

## Dependency Vulnerability Scanning

**Ecosystem commands:** `npm audit`, `pip audit`, `govulncheck ./...`, `bundle audit check`

**CVE Triage Workflow:**
1. **Collect** — Run ecosystem audit tools, aggregate findings
2. **Deduplicate** — Group by CVE ID across direct and transitive deps
3. **Prioritize** — Critical + exploitable + reachable = fix immediately
4. **Remediate** — Upgrade, patch, or mitigate with compensating controls
5. **Verify** — Rerun audit to confirm fix, update lock files

```bash
python scripts/dependency_auditor.py --file package.json --severity critical --json
```

---

## Secret Scanning

**Tools:** TruffleHog (git history + filesystem), Gitleaks (regex-based with custom rules).

```bash
# Scan git history for verified secrets
trufflehog git file://. --only-verified --json

# Scan filesystem
trufflehog filesystem . --json
```

**Integration points:** Pre-commit hooks (gitleaks, trufflehog), CI/CD gates (GitHub Actions with `trufflesecurity/trufflehog@main`). Configure `.gitleaks.toml` for custom rules (AWS keys, API keys, private key headers) and allowlists for test fixtures.

---

## API Security Testing

### Authentication Bypass

- **JWT manipulation:** Change `alg` to `none`, RS256-to-HS256 confusion, claim modification (`role: "admin"`, `exp: 9999999999`)
- **Session fixation:** Check if session ID changes after authentication

### Authorization Flaws

- **IDOR/BOLA:** Change resource IDs in every endpoint — test read, update, delete across users
- **BFLA:** Regular user tries admin endpoints (expect 403)
- **Mass assignment:** Add privileged fields (`role`, `is_admin`) to update requests

### Rate Limiting & GraphQL

- **Rate limiting:** Rapid-fire requests to auth endpoints; expect 429 after threshold
- **GraphQL:** Test introspection (should be disabled in prod), query depth attacks, batch mutations bypassing rate limits

See [attack_patterns.md](references/attack_patterns.md) for complete JWT manipulation payloads, IDOR testing methodology, BFLA endpoint lists, GraphQL introspection/depth/batch attack patterns, and rate limiting bypass techniques.

---

## Web Vulnerability Testing

| Vulnerability | Key Tests |
|--------------|-----------|
| **XSS** | Reflected (script/img/svg payloads), Stored (persistent fields), DOM-based (innerHTML + location.hash) |
| **CSRF** | Replay without token (expect 403), cross-session token replay, check SameSite cookie attribute |
| **SQL Injection** | Error-based (`' OR 1=1--`), union-based enumeration, time-based blind (`SLEEP(5)`), boolean-based blind |
| **SSRF** | Internal IPs, cloud metadata endpoints (AWS/GCP/Azure), IPv6/hex/decimal encoding bypasses |
| **Path Traversal** | `../../../etc/passwd`, URL encoding, double encoding bypasses |

See

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
