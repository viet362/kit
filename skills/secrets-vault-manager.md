# secrets-vault-manager

Source: Claude skill
Original path: `components/claude-skills/engineering/skills/secrets-vault-manager/SKILL.md`
Description: Use when the user asks to set up secret management infrastructure, integrate HashiCorp Vault, configure cloud secret stores (AWS Secrets Manager, Azure Key Vault, GCP Secret Manager), implement secret rotation, or audit secret access patterns.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Secrets Vault Manager

**Tier:** POWERFUL
**Category:** Engineering
**Domain:** Security / Infrastructure / DevOps

---

## Overview

Production secret infrastructure management for teams running HashiCorp Vault, cloud-native secret stores, or hybrid architectures. This skill covers policy authoring, auth method configuration, automated rotation, dynamic secrets, audit logging, and incident response.

**Distinct from env-secrets-manager** which handles local `.env` file hygiene and leak detection. This skill operates at the infrastructure layer — Vault clusters, cloud KMS, certificate authorities, and CI/CD secret injection.

### When to Use

- Standing up a new Vault cluster or migrating to a managed secret store
- Designing auth methods for services, CI runners, and human operators
- Implementing automated credential rotation (database, API keys, certificates)
- Auditing secret access patterns for compliance (SOC 2, ISO 27001, HIPAA)
- Responding to a secret leak that requires mass revocation
- Integrating secrets into Kubernetes workloads or CI/CD pipelines

---

## HashiCorp Vault Patterns

### Architecture Decisions

| Decision | Recommendation | Rationale |
|----------|---------------|-----------|
| Deployment mode | HA with Raft storage | No external dependency, built-in leader election |
| Auto-unseal | Cloud KMS (AWS KMS / Azure Key Vault / GCP KMS) | Eliminates manual unseal, enables automated restarts |
| Namespaces | One per environment (dev/staging/prod) | Blast-radius isolation, independent policies |
| Audit devices | File + syslog (dual) | Vault refuses requests if all audit devices fail — dual prevents outages |

### Auth Methods

**AppRole** — Machine-to-machine authentication for services and batch jobs.

```hcl
# Enable AppRole
path "auth/approle/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Application-specific role
vault write auth/approle/role/payment-service \
  token_ttl=1h \
  token_max_ttl=4h \
  secret_id_num_uses=1 \
  secret_id_ttl=10m \
  token_policies="payment-service-read"
```

**Kubernetes** — Pod-native authentication via service account tokens.

```hcl
vault write auth/kubernetes/role/api-server \
  bound_service_account_names=api-server \
  bound_service_account_namespaces=production \
  policies=api-server-secrets \
  ttl=1h
```

**OIDC** — Human operator access via SSO provider (Okta, Azure AD, Google Workspace).

```hcl
vault write auth/oidc/role/engineering \
  bound_audiences="vault" \
  allowed_redirect_uris="https://vault.example.com/ui/vault/auth/oidc/oidc/callback" \
  user_claim="email" \
  oidc_scopes="openid,profile,email" \
  policies="engineering-read" \
  ttl=8h
```

### Secret Engines

| Engine | Use Case | TTL Strategy |
|--------|----------|-------------|
| KV v2 | Static secrets (API keys, config) | Versioned, manual rotation |
| Database | Dynamic DB credentials | 1h default, 24h max |
| PKI | TLS certificates | 90d leaf certs, 5y intermediate CA |
| Transit | Encryption-as-a-service | Key rotation every 90d |
| SSH | Signed SSH certificates | 30m for interactive, 8h for automation |

### Policy Design

Follow least-privilege with path-based granularity:

```hcl
# payment-service-read policy
path "secret/data/production/payment/*" {
  capabilities = ["read"]
}

path "database/creds/payment-readonly" {
  capabilities = ["read"]
}

# Deny access to admin paths explicitly
path "sys/*" {
  capabilities = ["deny"]
}
```

**Policy naming convention:** `{service}-{access-level}` (e.g., `payment-service-read`, `api-gateway-admin`).

---

## Cloud Secret Store Integration

### Comparison Matrix

| Feature | AWS Secrets Manager | Azure Key Vault | GCP Secret Manager |
|---------|--------------------|-----------------|--------------------|
| Rotation | Built-in Lambda | Custom logic via Functions | Cloud Functions |
| Versioning | Automatic | Manual or automatic | Automatic |
| Encryption | AWS KMS (default or CMK) | HSM-backed | Google-managed or CMEK |
| Access control | IAM policies + resource policy | RBAC + Access Policies | IAM bindings |
| Cross-region | Replication supported | Geo-redundant by default | Replication supported |
| Audit | CloudTrail | Azure Monitor + Diagnostic Logs | Cloud Audit Logs |
| Pricing model | Per-secret + per-API call | Per-operation + per-key | Per-secret version + per-access |

### When to Use Which

- **AWS Secrets Manager**: RDS/Aurora credential rotation out of the box. Best when fully on AWS.
- **Azure Key Vault**: Certificate management strength. Required for Azure AD integrated workloads.
- **GCP Secret Manager**: Simplest API surface. Best for GKE-native workloads with Workload Identity.
- **HashiCorp Vault**: Multi-cloud, dynamic secrets, PKI, transit encryption. Best for complex or hybrid environments.

### SDK Access Patterns

**Principle:** Always fetch secrets at startup or via sidecar — never bake into images or config files.

```python
# AWS Secrets Manager pattern
import boto3, json

def get_secret(secret_name, region="us-east-1"):
    client = boto3.client("secretsmanager", region_name=region)
    response = client.get_secret_value(SecretId=secret_name)
    return json.loads(response["SecretString"])
```

```python
# GCP Secret Manager pattern
from google.cloud import secretmanager

def get_secret(project_id, secret_id, version="latest"):
    client = secretmanager.SecretManagerServiceClient()
    name = f"projects/{project_id}/secrets/{secret_id}/versions/{version}"
    response = client.access_secret_version(request={"name": name})
    return response.payload.data.decode("UTF-8")
```

```python
# Azure Key Vault pattern
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient

def get_secret(vault_url, secret_name):
    credential = DefaultAzureCredential()
    client = SecretClient(vault_url=vault_url, credential=credential)
    return client.get_secret(secret_name).value
```

---

## Secret Rotation Workflows

### Rotation Strategy by Secret Type

| Secret Type | Rotation Frequency | Method | Downtime Risk |
|-------------|-------------------|--------|---------------|
| Database passwords | 30 days | Dual-account swap | Zero (A/B rotation) |
| API keys | 90 days | Generate new, deprecate old | Zero (overlap window) |
| TLS certificates | 60 days before expiry | ACME or Vault PKI | Zero (graceful reload) |
| SSH keys | 90 days | Vault-signed certificates | Zero (CA-based) |
| Service tokens | 24 hours | Dynamic generation | Zero (short-lived) |
| Encryption keys | 90 days | Key versioning (rewrap) | Zero (version coexistence) |

### Database Credential Rotation (Dual-Account)

1. Two database accounts exist: `app_user_a` and `app_user_b`
2. Application currently uses `app_user_a`
3. Rotation rotates `app_user_b` password, updates secret store
4. Application switches to `app_user_b` on next credential fetch
5. After grace period, `app_user_a` password is rotated
6. Cycle repeats

### API Key Rotati

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
