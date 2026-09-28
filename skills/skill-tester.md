# skill-tester

Source: Claude skill
Original path: `components/claude-skills/engineering/skills/skill-tester/SKILL.md`
Description: Validate, test, and score the quality of skills within the claude-skills ecosystem. Comprehensive meta-skill: structure validation, Python script testing (syntax + imports + runtime + output format), multi-dimensional quality scoring with letter grades and tier classification (BASIC/STANDARD/POWERFUL). Use when authoring a new skill, auditing existing skills for tier promotion, setting up pre-commit hooks for skill quality, or integrating skill QA into CI.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Skill Tester

---

**Name**: skill-tester
**Tier**: POWERFUL
**Category**: Engineering Quality Assurance
**Dependencies**: None (Python Standard Library Only)
**Author**: Claude Skills Engineering Team
**Version**: 1.0.0
**Last Updated**: 2026-02-16

---

## Description

The Skill Tester is a comprehensive meta-skill designed to validate, test, and score the quality of skills within the claude-skills ecosystem. This powerful quality assurance tool ensures that all skills meet the rigorous standards required for BASIC, STANDARD, and POWERFUL tier classifications through automated validation, testing, and scoring mechanisms.

As the gatekeeping system for skill quality, this meta-skill provides three core capabilities:
1. **Structure Validation** - Ensures skills conform to required directory structures, file formats, and documentation standards
2. **Script Testing** - Validates Python scripts for syntax, imports, functionality, and output format compliance  
3. **Quality Scoring** - Provides comprehensive quality assessment across multiple dimensions with letter grades and improvement recommendations

This skill is essential for maintaining ecosystem consistency, enabling automated CI/CD integration, and supporting both manual and automated quality assurance workflows. It serves as the foundation for pre-commit hooks, pull request validation, and continuous integration processes that maintain the high-quality standards of the claude-skills repository.

## Core Features

### Comprehensive Skill Validation
- **Structure Compliance**: Validates directory structure, required files (SKILL.md, README.md, scripts/, references/, assets/, expected_outputs/)
- **Documentation Standards**: Checks SKILL.md frontmatter, section completeness, minimum line counts per tier
- **File Format Validation**: Ensures proper Markdown formatting, YAML frontmatter syntax, and file naming conventions

### Advanced Script Testing
- **Syntax Validation**: Compiles Python scripts to detect syntax errors before execution
- **Import Analysis**: Enforces standard library only policy, identifies external dependencies
- **Runtime Testing**: Executes scripts with sample data, validates argparse implementation, tests --help functionality
- **Output Format Compliance**: Verifies dual output support (JSON + human-readable), proper error handling

### Multi-Dimensional Quality Scoring
- **Documentation Quality (25%)**: SKILL.md depth and completeness, README clarity, reference documentation quality
- **Code Quality (25%)**: Script complexity, error handling robustness, output format consistency, maintainability
- **Completeness (25%)**: Required directory presence, sample data adequacy, expected output verification
- **Usability (25%)**: Example clarity, argparse help text quality, installation simplicity, user experience

### Tier Classification System
Automatically classifies skills based on complexity and functionality:

#### BASIC Tier Requirements
- Minimum 100 lines in SKILL.md
- At least 1 Python script (100-300 LOC)
- Basic argparse implementation
- Simple input/output handling
- Essential documentation coverage

#### STANDARD Tier Requirements  
- Minimum 200 lines in SKILL.md
- 1-2 Python scripts (300-500 LOC each)
- Advanced argparse with subcommands
- JSON + text output formats
- Comprehensive examples and references
- Error handling and edge case management

#### POWERFUL Tier Requirements
- Minimum 300 lines in SKILL.md
- 2-3 Python scripts (500-800 LOC each)
- Complex argparse with multiple modes
- Sophisticated output formatting and validation
- Extensive documentation and reference materials
- Advanced error handling and recovery mechanisms
- CI/CD integration capabilities

## Architecture & Design

### Modular Design Philosophy
The skill-tester follows a modular architecture where each component serves a specific validation purpose:

- **skill_validator.py**: Core structural and documentation validation engine
- **script_tester.py**: Runtime testing and execution validation framework  
- **quality_scorer.py**: Multi-dimensional quality assessment and scoring system

### Standards Enforcement
All validation is performed against well-defined standards documented in the references/ directory:
- **Skill Structure Specification**: Defines mandatory and optional components
- **Tier Requirements Matrix**: Detailed requirements for each skill tier
- **Quality Scoring Rubric**: Comprehensive scoring methodology and weightings

### Integration Capabilities
Designed for seamless integration into existing development workflows:
- **Pre-commit Hooks**: Prevents substandard skills from being committed
- **CI/CD Pipelines**: Automated quality gates in pull request workflows
- **Manual Validation**: Interactive command-line tools for development-time validation
- **Batch Processing**: Bulk validation and scoring of existing skill repositories

## Implementation Details

### skill_validator.py Core Functions
```python
# Primary validation workflow
validate_skill_structure() -> ValidationReport
check_skill_md_compliance() -> DocumentationReport  
validate_python_scripts() -> ScriptReport
generate_compliance_score() -> float
```

Key validation checks include:
- SKILL.md frontmatter parsing and validation
- Required section presence (Description, Features, Usage, etc.)
- Minimum line count enforcement per tier
- Python script argparse implementation verification
- Standard library import enforcement
- Directory structure compliance
- README.md quality assessment

### script_tester.py Testing Framework
```python
# Core testing functions
syntax_validation() -> SyntaxReport
import_validation() -> ImportReport
runtime_testing() -> RuntimeReport
output_format_validation() -> OutputReport
```

Testing capabilities encompass:
- Python AST-based syntax validation
- Import statement analysis and external dependency detection
- Controlled script execution with timeout protection
- Argparse --help functionality verification
- Sample data processing and output validation
- Expected output comparison and difference reporting

### quality_scorer.py Scoring System
```python
# Multi-dimensional scoring
score_documentation() -> float  # 25% weight
score_code_quality() -> float   # 25% weight
score_completeness() -> float   # 25% weight
score_usability() -> float      # 25% weight
calculate_overall_grade() -> str # A-F grade
```

Scoring dimensions include:
- **Documentation**: Completeness, clarity, examples, reference quality
- **Code Quality**: Complexity, maintainability, error handling, output consistency
- **Completeness**: Required files, sample data, expected outputs, test coverage  
- **Usability**: Help text quality, example clarity, installation simplicity

## Usage Scenarios

### Development Workflow Integration
```bash
# Pre-commit hook validation
skill_validator.py path/to/skill --tier POWERFUL --json

# Comprehensive skill testing
script_tester.py path/to/skill --timeout 30 --sample-data

# Quality assessment

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
