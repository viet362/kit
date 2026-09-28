# release-manager

Source: Claude skill
Original path: `components/claude-skills/engineering/skills/release-manager/SKILL.md`
Description: Use when the user asks to plan releases, manage changelogs, coordinate deployments, create release branches, or automate versioning.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Release Manager

**Tier:** POWERFUL  
**Category:** Engineering  
**Domain:** Software Release Management & DevOps

## Overview

The Release Manager skill provides comprehensive tools and knowledge for managing software releases end-to-end. From parsing conventional commits to generating changelogs, determining version bumps, and orchestrating release processes, this skill ensures reliable, predictable, and well-documented software releases.

## Core Capabilities

- **Automated Changelog Generation** from git history using conventional commits
- **Semantic Version Bumping** based on commit analysis and breaking changes
- **Release Readiness Assessment** with comprehensive checklists and validation
- **Release Planning & Coordination** with stakeholder communication templates
- **Rollback Planning** with automated recovery procedures
- **Hotfix Management** for emergency releases
- **Feature Flag Integration** for progressive rollouts

## Key Components

### Scripts

1. **changelog_generator.py** - Parses git logs and generates structured changelogs
2. **version_bumper.py** - Determines correct version bumps from conventional commits
3. **release_planner.py** - Assesses release readiness and generates coordination plans

### Documentation

- Comprehensive release management methodology
- Conventional commits specification and examples
- Release workflow comparisons (Git Flow, Trunk-based, GitHub Flow)
- Hotfix procedures and emergency response protocols

## Release Management Methodology

### Semantic Versioning (SemVer)

Semantic Versioning follows the MAJOR.MINOR.PATCH format where:

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backwards compatible manner  
- **PATCH** version when you make backwards compatible bug fixes

#### Pre-release Versions

Pre-release versions are denoted by appending a hyphen and identifiers:
- `1.0.0-alpha.1` - Alpha releases for early testing
- `1.0.0-beta.2` - Beta releases for wider testing
- `1.0.0-rc.1` - Release candidates for final validation

#### Version Precedence

Version precedence is determined by comparing each identifier:
1. `1.0.0-alpha` < `1.0.0-alpha.1` < `1.0.0-alpha.beta` < `1.0.0-beta`
2. `1.0.0-beta` < `1.0.0-beta.2` < `1.0.0-beta.11` < `1.0.0-rc.1`
3. `1.0.0-rc.1` < `1.0.0`

### Conventional Commits

Conventional Commits provide a structured format for commit messages that enables automated tooling:

#### Format
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

#### Types
- **feat**: A new feature (correlates with MINOR version bump)
- **fix**: A bug fix (correlates with PATCH version bump)
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **chore**: Changes to the build process or auxiliary tools
- **ci**: Changes to CI configuration files and scripts
- **build**: Changes that affect the build system or external dependencies
- **breaking**: Introduces a breaking change (correlates with MAJOR version bump)

#### Examples
```
feat(user-auth): add OAuth2 integration

fix(api): resolve race condition in user creation

docs(readme): update installation instructions

feat!: remove deprecated payment API
BREAKING CHANGE: The legacy payment API has been removed
```

### Automated Changelog Generation

Changelogs are automatically generated from conventional commits, organized by:

#### Structure
```markdown
# Changelog

## [Unreleased]
### Added
### Changed  
### Deprecated
### Removed
### Fixed
### Security

## [1.2.0] - 2024-01-15
### Added
- OAuth2 authentication support (#123)
- User preference dashboard (#145)

### Fixed
- Race condition in user creation (#134)
- Memory leak in image processing (#156)

### Breaking Changes
- Removed legacy payment API
```

#### Grouping Rules
- **Added** for new features (feat)
- **Fixed** for bug fixes (fix)
- **Changed** for changes in existing functionality
- **Deprecated** for soon-to-be removed features
- **Removed** for now removed features
- **Security** for vulnerability fixes

#### Metadata Extraction
- Link to pull requests and issues: `(#123)`
- Breaking changes highlighted prominently
- Scope-based grouping: `auth:`, `api:`, `ui:`
- Co-authored-by for contributor recognition

### Version Bump Strategies

Version bumps are determined by analyzing commits since the last release:

#### Automatic Detection Rules
1. **MAJOR**: Any commit with `BREAKING CHANGE` or `!` after type
2. **MINOR**: Any `feat` type commits without breaking changes
3. **PATCH**: `fix`, `perf`, `security` type commits
4. **NO BUMP**: `docs`, `style`, `test`, `chore`, `ci`, `build` only

#### Pre-release Handling
```python
# Alpha: 1.0.0-alpha.1 → 1.0.0-alpha.2
# Beta: 1.0.0-alpha.5 → 1.0.0-beta.1  
# RC: 1.0.0-beta.3 → 1.0.0-rc.1
# Release: 1.0.0-rc.2 → 1.0.0
```

#### Multi-package Considerations
For monorepos with multiple packages:
- Analyze commits affecting each package independently
- Support scoped version bumps: `@scope/package@1.2.3`
- Generate coordinated release plans across packages

### Release Branch Workflows

#### Git Flow
```
main (production) ← release/1.2.0 ← develop ← feature/login
                                           ← hotfix/critical-fix
```

**Advantages:**
- Clear separation of concerns
- Stable main branch
- Parallel feature development
- Structured release process

**Process:**
1. Create release branch from develop: `git checkout -b release/1.2.0 develop`
2. Finalize release (version bump, changelog)
3. Merge to main and develop
4. Tag release: `git tag v1.2.0`
5. Deploy from main

#### Trunk-based Development
```
main ← feature/login (short-lived)
    ← feature/payment (short-lived)  
    ← hotfix/critical-fix
```

**Advantages:**
- Simplified workflow
- Faster integration
- Reduced merge conflicts
- Continuous integration friendly

**Process:**
1. Short-lived feature branches (1-3 days)
2. Frequent commits to main
3. Feature flags for incomplete features
4. Automated testing gates
5. Deploy from main with feature toggles

#### GitHub Flow
```
main ← feature/login
    ← hotfix/critical-fix
```

**Advantages:**
- Simple and lightweight
- Fast deployment cycle
- Good for web applications
- Minimal overhead

**Process:**
1. Create feature branch from main
2. Regular commits and pushes
3. Open pull request when ready
4. Deploy from feature branch for testing
5. Merge to main and deploy

### Feature Flag Integration

Feature flags enable safe, progressive rollouts:

#### Types of Feature Flags
- **Release flags**: Control feature visibility in production
- **Experiment flags**: A/B testing and gradual rollouts
- **Operational flags**: Circuit breakers and performance toggles
- **Permission flags**: Role-based feature access

#### Impleme

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
