# env-secrets-manager

Source: Claude skill
Original path: `components/claude-skills/engineering/skills/env-secrets-manager/SKILL.md`
Description: Manage environment-variable hygiene and secrets safety across local development and production. Practical auditing, drift awareness, rotation readiness. Use when auditing .env files for committed secrets, planning a credential rotation, debugging missing-env-var production incidents, or hardening a new project against secrets leakage.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Env & Secrets Manager

**Tier:** POWERFUL
**Category:** Engineering
**Domain:** Security / DevOps / Configuration Management

---

## Overview

Manage environment-variable hygiene and secrets safety across local development and production workflows. This skill focuses on practical auditing, drift awareness, and rotation readiness.

## Core Capabilities

- `.env` and `.env.example` lifecycle guidance
- Secret leak detection for repository working trees
- Severity-based findings for likely credentials
- Operational pointers for rotation and containment
- Integration-ready outputs for CI checks

---

## When to Use

- Before pushing commits that touched env/config files
- During security audits and incident triage
- When onboarding contributors who need safe env conventions
- When validating that no obvious secrets are hardcoded

---

## Quick Start

```bash
# Scan a repository for likely secret leaks
python3 scripts/env_auditor.py /path/to/repo

# JSON output for CI pipelines
python3 scripts/env_auditor.py /path/to/repo --json
```

---

## Recommended Workflow

1. Run `scripts/env_auditor.py` on the repository root.
2. Prioritize `critical` and `high` findings first.
3. Rotate real credentials and remove exposed values.
4. Update `.env.example` and `.gitignore` as needed.
5. Add or tighten pre-commit/CI secret scanning gates.

---

## Reference Docs

- `references/validation-detection-rotation.md`
- `references/secret-patterns.md`

---

## Common Pitfalls

- Committing real values in `.env.example`
- Rotating one system but missing downstream consumers
- Logging secrets during debugging or incident response
- Treating suspected leaks as low urgency without validation

## Best Practices

1. Use a secret manager as the production source of truth.
2. Keep dev env files local and gitignored.
3. Enforce detection in CI before merge.
4. Re-test application paths immediately after credential rotation.

---

## Cloud Secret Store Integration

Production applications should never read secrets from `.env` files or environment variables baked into container images. Use a dedicated secret store instead.

### Provider Comparison

| Provider | Best For | Key Feature |
|----------|----------|-------------|
| **HashiCorp Vault** | Multi-cloud / hybrid | Dynamic secrets, policy engine, pluggable backends |
| **AWS Secrets Manager** | AWS-native workloads | Native Lambda/ECS/EKS integration, automatic RDS rotation |
| **Azure Key Vault** | Azure-native workloads | Managed HSM, Azure AD RBAC, certificate management |
| **GCP Secret Manager** | GCP-native workloads | IAM-based access, automatic replication, versioning |

### Selection Guidance

- **Single cloud provider** — use the cloud-native secret manager. It integrates tightly with IAM, reduces operational overhead, and costs less than self-hosting.
- **Multi-cloud or hybrid** — use HashiCorp Vault. It provides a uniform API across environments and supports dynamic secret generation (database credentials, cloud IAM keys) that expire automatically.
- **Kubernetes-heavy** — combine External Secrets Operator with any backend above to sync secrets into K8s `Secret` objects without hardcoding.

### Application Access Patterns

1. **SDK/API pull** — application fetches secret at startup or on-demand via provider SDK.
2. **Sidecar injection** — a sidecar container (e.g., Vault Agent) writes secrets to a shared volume or injects them as environment variables.
3. **Init container** — a Kubernetes init container fetches secrets before the main container starts.
4. **CSI driver** — secrets mount as a filesystem volume via the Secrets Store CSI Driver.

> **Cross-reference:** See `engineering/secrets-vault-manager` for production vault infrastructure patterns, HA deployment, and disaster recovery procedures.

---

## Secret Rotation Workflow

Stale secrets are a liability. Rotation ensures that even if a credential leaks, its useful lifetime is bounded.

### Phase 1: Detection

- Track secret creation and expiry dates in your secret store metadata.
- Set alerts at 30, 14, and 7 days before expiry.
- Use `scripts/env_auditor.py` to flag secrets with no recorded rotation date.

### Phase 2: Rotation

1. **Generate** a new credential (API key, database password, certificate).
2. **Deploy** the new credential to all consumers (apps, services, pipelines) in parallel.
3. **Verify** each consumer can authenticate using the new credential.
4. **Revoke** the old credential only after all consumers are confirmed healthy.
5. **Update** metadata with the new rotation timestamp and next rotation date.

### Phase 3: Automation

- **AWS Secrets Manager** — use built-in Lambda-based rotation for RDS, Redshift, and DocumentDB.
- **HashiCorp Vault** — configure dynamic secrets with TTLs; credentials are generated on-demand and auto-expire.
- **Azure Key Vault** — use Event Grid notifications to trigger rotation functions.
- **GCP Secret Manager** — use Pub/Sub notifications tied to Cloud Functions for rotation logic.

### Emergency Rotation Checklist

When a secret is confirmed leaked:

1. **Immediately revoke** the compromised credential at the provider level.
2. Generate and deploy a replacement credential to all consumers.
3. Audit access logs for unauthorized usage during the exposure window.
4. Scan git history, CI logs, and artifact registries for the leaked value.
5. File an incident report documenting scope, timeline, and remediation steps.
6. Review and tighten detection controls to prevent recurrence.

---

## CI/CD Secret Injection

Secrets in CI/CD pipelines require careful handling to avoid exposure in logs, artifacts, or pull request contexts.

### GitHub Actions

- Use **repository secrets** or **environment secrets** via `${{ secrets.SECRET_NAME }}`.
- Prefer **OIDC federation** (`aws-actions/configure-aws-credentials` with `role-to-assume`) over long-lived access keys.
- Environment secrets with required reviewers add approval gates for production deployments.
- GitHub automatically masks secrets in logs, but avoid `echo` or `toJSON()` on secret values.

### GitLab CI

- Store secrets as **CI/CD variables** with the `masked` and `protected` flags enabled.
- Use **HashiCorp Vault integration** (`secrets:vault`) for dynamic secret injection without storing values in GitLab.
- Scope variables to specific environments (`production`, `staging`) to enforce least privilege.

### Universal Patterns

- **Never echo or print** secret values in pipeline output, even for debugging.
- **Use short-lived tokens** (OIDC, STS AssumeRole) instead of static credentials wherever possible.
- **Restrict PR access** — do not expose secrets to pipelines triggered by forks or untrusted branches.
- **Rotate CI secrets** on the same schedule as application secrets; pipeline credentials are attack vectors too.
- **Audit pipeline logs** periodically for accidental secret exposure that masking may have missed.

---

## Pre-Commit Secret Detection

Catching secrets before the

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
