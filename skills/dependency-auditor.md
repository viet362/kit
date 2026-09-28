# dependency-auditor

Source: Claude skill
Original path: `components/claude-skills/engineering/skills/dependency-auditor/SKILL.md`
Description: Audit and manage dependencies across multi-language projects. Identifies vulnerabilities, license conflicts, transitive dependency risks, and safe-upgrade paths. Use when auditing third-party packages before release, investigating a CVE, planning a major version bump, or running a license-compliance review.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Dependency Auditor

> **Skill Type:** POWERFUL  
> **Category:** Engineering  
> **Domain:** Dependency Management & Security  

## Overview

The **Dependency Auditor** is a comprehensive toolkit for analyzing, auditing, and managing dependencies across multi-language software projects. This skill provides deep visibility into your project's dependency ecosystem, enabling teams to identify vulnerabilities, ensure license compliance, optimize dependency trees, and plan safe upgrades.

In modern software development, dependencies form complex webs that can introduce significant security, legal, and maintenance risks. A single project might have hundreds of direct and transitive dependencies, each potentially introducing vulnerabilities, license conflicts, or maintenance burden. This skill addresses these challenges through automated analysis and actionable recommendations.

## Core Capabilities

### 1. Vulnerability Scanning & CVE Matching

**Comprehensive Security Analysis**
- Scans dependencies against built-in vulnerability databases
- Matches Common Vulnerabilities and Exposures (CVE) patterns
- Identifies known security issues across multiple ecosystems
- Analyzes transitive dependency vulnerabilities
- Provides CVSS scores and exploit assessments
- Tracks vulnerability disclosure timelines
- Maps vulnerabilities to dependency paths

**Multi-Language Support**
- **JavaScript/Node.js**: package.json, package-lock.json, yarn.lock
- **Python**: requirements.txt, pyproject.toml, Pipfile.lock, poetry.lock
- **Go**: go.mod, go.sum
- **Rust**: Cargo.toml, Cargo.lock
- **Ruby**: Gemfile, Gemfile.lock
- **Java/Maven**: pom.xml, gradle.lockfile
- **PHP**: composer.json, composer.lock
- **C#/.NET**: packages.config, project.assets.json

### 2. License Compliance & Legal Risk Assessment

**License Classification System**
- **Permissive Licenses**: MIT, Apache 2.0, BSD (2-clause, 3-clause), ISC
- **Copyleft (Strong)**: GPL (v2, v3), AGPL (v3)
- **Copyleft (Weak)**: LGPL (v2.1, v3), MPL (v2.0)
- **Proprietary**: Commercial, custom, or restrictive licenses
- **Dual Licensed**: Multi-license scenarios and compatibility
- **Unknown/Ambiguous**: Missing or unclear licensing

**Conflict Detection**
- Identifies incompatible license combinations
- Warns about GPL contamination in permissive projects
- Analyzes license inheritance through dependency chains
- Provides compliance recommendations for distribution
- Generates legal risk matrices for decision-making

### 3. Outdated Dependency Detection

**Version Analysis**
- Identifies dependencies with available updates
- Categorizes updates by severity (patch, minor, major)
- Detects pinned versions that may be outdated
- Analyzes semantic versioning patterns
- Identifies floating version specifiers
- Tracks release frequencies and maintenance status

**Maintenance Status Assessment**
- Identifies abandoned or unmaintained packages
- Analyzes commit frequency and contributor activity
- Tracks last release dates and security patch availability
- Identifies packages with known end-of-life dates
- Assesses upstream maintenance quality

### 4. Dependency Bloat Analysis

**Unused Dependency Detection**
- Identifies dependencies that aren't actually imported/used
- Analyzes import statements and usage patterns
- Detects redundant dependencies with overlapping functionality
- Identifies oversized packages for simple use cases
- Maps actual vs. declared dependency usage

**Redundancy Analysis**
- Identifies multiple packages providing similar functionality
- Detects version conflicts in transitive dependencies
- Analyzes bundle size impact of dependencies
- Identifies opportunities for dependency consolidation
- Maps dependency overlap and duplication

### 5. Upgrade Path Planning & Breaking Change Risk

**Semantic Versioning Analysis**
- Analyzes semver patterns to predict breaking changes
- Identifies safe upgrade paths (patch/minor versions)
- Flags major version updates requiring attention
- Tracks breaking changes across dependency updates
- Provides rollback strategies for failed upgrades

**Risk Assessment Matrix**
- Low Risk: Patch updates, security fixes
- Medium Risk: Minor updates with new features
- High Risk: Major version updates, API changes
- Critical Risk: Dependencies with known breaking changes

**Upgrade Prioritization**
- Security patches: Highest priority
- Bug fixes: High priority
- Feature updates: Medium priority
- Major rewrites: Planned priority
- Deprecated features: Immediate attention

### 6. Supply Chain Security

**Dependency Provenance**
- Verifies package signatures and checksums
- Analyzes package download sources and mirrors
- Identifies suspicious or compromised packages
- Tracks package ownership changes and maintainer shifts
- Detects typosquatting and malicious packages

**Transitive Risk Analysis**
- Maps complete dependency trees
- Identifies high-risk transitive dependencies
- Analyzes dependency depth and complexity
- Tracks influence of indirect dependencies
- Provides supply chain risk scoring

### 7. Lockfile Analysis & Deterministic Builds

**Lockfile Validation**
- Ensures lockfiles are up-to-date with manifests
- Validates integrity hashes and version consistency
- Identifies drift between environments
- Analyzes lockfile conflicts and resolution strategies
- Ensures deterministic, reproducible builds

**Environment Consistency**
- Compares dependencies across environments (dev/staging/prod)
- Identifies version mismatches between team members
- Validates CI/CD environment consistency
- Tracks dependency resolution differences

## Technical Architecture

### Scanner Engine (`dep_scanner.py`)
- Multi-format parser supporting 8+ package ecosystems
- Built-in vulnerability database with 500+ CVE patterns
- Transitive dependency resolution from lockfiles
- JSON and human-readable output formats
- Configurable scanning depth and exclusion patterns

### License Analyzer (`license_checker.py`)
- License detection from package metadata and files
- Compatibility matrix with 20+ license types
- Conflict detection engine with remediation suggestions
- Risk scoring based on distribution and usage context
- Export capabilities for legal review

### Upgrade Planner (`upgrade_planner.py`)
- Semantic version analysis with breaking change prediction
- Dependency ordering based on risk and interdependence
- Migration checklists with testing recommendations
- Rollback procedures for failed upgrades
- Timeline estimation for upgrade cycles

## Use Cases & Applications

### Security Teams
- **Vulnerability Management**: Continuous scanning for security issues
- **Incident Response**: Rapid assessment of vulnerable dependencies
- **Supply Chain Monitoring**: Tracking third-party security posture
- **Compliance Reporting**: Automated security compliance documentation

### Legal & Compliance Teams
- **License Auditing**: Comprehensive license compliance verification
- **Risk Assessment**: Legal risk analysis for soft

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
