# senior-security

Source: Claude skill
Original path: `components/claude-skills/engineering-team/skills/senior-security/SKILL.md`
Description: Security engineering toolkit for threat modeling, vulnerability analysis, secure architecture, and penetration testing. Includes STRIDE analysis, OWASP guidance, cryptography patterns, and security scanning tools. Use when the user asks about security reviews, threat analysis, vulnerability assessments, secure coding practices, security audits, attack surface analysis, CVE remediation, or security best practices.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Senior Security Engineer

Security engineering tools for threat modeling, vulnerability analysis, secure architecture design, and penetration testing.

---

## Table of Contents

- [Threat Modeling Workflow](#threat-modeling-workflow)
- [Security Architecture Workflow](#security-architecture-workflow)
- [Vulnerability Assessment Workflow](#vulnerability-assessment-workflow)
- [Secure Code Review Workflow](#secure-code-review-workflow)
- [Incident Response Workflow](#incident-response-workflow)
- [Security Tools Reference](#security-tools-reference)
- [Tools and References](#tools-and-references)

---

## Threat Modeling Workflow

Identify and analyze security threats using STRIDE methodology.

### Workflow: Conduct Threat Model

1. Define system scope and boundaries:
   - Identify assets to protect
   - Map trust boundaries
   - Document data flows
2. Create data flow diagram:
   - External entities (users, services)
   - Processes (application components)
   - Data stores (databases, caches)
   - Data flows (APIs, network connections)
3. Apply STRIDE to each DFD element (see [STRIDE per Element Matrix](#stride-per-element-matrix) below)
4. Score risks using DREAD:
   - Damage potential (1-10)
   - Reproducibility (1-10)
   - Exploitability (1-10)
   - Affected users (1-10)
   - Discoverability (1-10)
5. Prioritize threats by risk score
6. Define mitigations for each threat
7. Document in threat model report
8. **Validation:** All DFD elements analyzed; STRIDE applied; threats scored; mitigations mapped

### STRIDE Threat Categories

| Category | Security Property | Mitigation Focus |
|----------|-------------------|------------------|
| Spoofing | Authentication | MFA, certificates, strong auth |
| Tampering | Integrity | Signing, checksums, validation |
| Repudiation | Non-repudiation | Audit logs, digital signatures |
| Information Disclosure | Confidentiality | Encryption, access controls |
| Denial of Service | Availability | Rate limiting, redundancy |
| Elevation of Privilege | Authorization | RBAC, least privilege |

### STRIDE per Element Matrix

| DFD Element | S | T | R | I | D | E |
|-------------|---|---|---|---|---|---|
| External Entity | X | | X | | | |
| Process | X | X | X | X | X | X |
| Data Store | | X | X | X | X | |
| Data Flow | | X | | X | X | |

See: [references/threat-modeling-guide.md](references/threat-modeling-guide.md)

---

## Security Architecture Workflow

Design secure systems using defense-in-depth principles.

### Workflow: Design Secure Architecture

1. Define security requirements:
   - Compliance requirements (GDPR, HIPAA, PCI-DSS)
   - Data classification (public, internal, confidential, restricted)
   - Threat model inputs
2. Apply defense-in-depth layers:
   - Perimeter: WAF, DDoS protection, rate limiting
   - Network: Segmentation, IDS/IPS, mTLS
   - Host: Patching, EDR, hardening
   - Application: Input validation, authentication, secure coding
   - Data: Encryption at rest and in transit
3. Implement Zero Trust principles:
   - Verify explicitly (every request)
   - Least privilege access (JIT/JEA)
   - Assume breach (segment, monitor)
4. Configure authentication and authorization:
   - Identity provider selection
   - MFA requirements
   - RBAC/ABAC model
5. Design encryption strategy:
   - Key management approach
   - Algorithm selection
   - Certificate lifecycle
6. Plan security monitoring:
   - Log aggregation
   - SIEM integration
   - Alerting rules
7. Document architecture decisions
8. **Validation:** Defense-in-depth layers defined; Zero Trust applied; encryption strategy documented; monitoring planned

### Defense-in-Depth Layers

```
Layer 1: PERIMETER
  WAF, DDoS mitigation, DNS filtering, rate limiting

Layer 2: NETWORK
  Segmentation, IDS/IPS, network monitoring, VPN, mTLS

Layer 3: HOST
  Endpoint protection, OS hardening, patching, logging

Layer 4: APPLICATION
  Input validation, authentication, secure coding, SAST

Layer 5: DATA
  Encryption at rest/transit, access controls, DLP, backup
```

### Authentication Pattern Selection

| Use Case | Recommended Pattern |
|----------|---------------------|
| Web application | OAuth 2.0 + PKCE with OIDC |
| API authentication | JWT with short expiration + refresh tokens |
| Service-to-service | mTLS with certificate rotation |
| CLI/Automation | API keys with IP allowlisting |
| High security | FIDO2/WebAuthn hardware keys |

See: [references/security-architecture-patterns.md](references/security-architecture-patterns.md)

---

## Vulnerability Assessment Workflow

Identify and remediate security vulnerabilities in applications.

### Workflow: Conduct Vulnerability Assessment

1. Define assessment scope:
   - In-scope systems and applications
   - Testing methodology (black box, gray box, white box)
   - Rules of engagement
2. Gather information:
   - Technology stack inventory
   - Architecture documentation
   - Previous vulnerability reports
3. Perform automated scanning:
   - SAST (static analysis)
   - DAST (dynamic analysis)
   - Dependency scanning
   - Secret detection
4. Conduct manual testing:
   - Business logic flaws
   - Authentication bypass
   - Authorization issues
   - Injection vulnerabilities
5. Classify findings by severity:
   - Critical: Immediate exploitation risk
   - High: Significant impact, easier to exploit
   - Medium: Moderate impact or difficulty
   - Low: Minor impact
6. Develop remediation plan:
   - Prioritize by risk
   - Assign owners
   - Set deadlines
7. Verify fixes and document
8. **Validation:** Scope defined; automated and manual testing complete; findings classified; remediation tracked

For OWASP Top 10 vulnerability descriptions and testing guidance, refer to [owasp.org/Top10](https://owasp.org/Top10).

### Vulnerability Severity Matrix

| Impact \ Exploitability | Easy | Moderate | Difficult |
|-------------------------|------|----------|-----------|
| Critical | Critical | Critical | High |
| High | Critical | High | Medium |
| Medium | High | Medium | Low |
| Low | Medium | Low | Low |

---

## Secure Code Review Workflow

Review code for security vulnerabilities before deployment.

### Workflow: Conduct Security Code Review

1. Establish review scope:
   - Changed files and functions
   - Security-sensitive areas (auth, crypto, input handling)
   - Third-party integrations
2. Run automated analysis:
   - SAST tools (Semgrep, CodeQL, Bandit)
   - Secret scanning
   - Dependency vulnerability check
3. Review authentication code:
   - Password handling (hashing, storage)
   - Session management
   - Token validation
4. Review authorization code:
   - Access control checks
   - RBAC implementation
   - Privilege boundaries
5. Review data handling:
   - Input validation
   - Output encoding
   - SQL query construction
   - File path handling
6. Review cryptographic code:
   - Algorithm selection
   - Key management
   - Random number generation
7. Document findings with severity
8. **Validation:** Automated scans passe

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
