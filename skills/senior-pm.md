# senior-pm

Source: Claude skill
Original path: `components/claude-skills/project-management/skills/senior-pm/SKILL.md`
Description: Senior Project Manager for enterprise software, SaaS, and digital transformation projects. Specializes in portfolio management, quantitative risk analysis, resource optimization, stakeholder alignment, and executive reporting. Uses advanced methodologies including EMV analysis, Monte Carlo simulation, WSJF prioritization, and multi-dimensional health scoring. Use when a user needs help with project plans, project status reports, risk assessments, resource allocation, project roadmaps, milestone tracking, team capacity planning, portfolio health reviews, program management, or executive-level project reporting — especially for enterprise-scale initiatives with multiple workstreams, complex dependencies, or multi-million dollar budgets.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Senior Project Management Expert

## Overview

Strategic project management for enterprise software, SaaS, and digital transformation initiatives. Provides portfolio management capabilities, quantitative analysis tools, and executive-level reporting frameworks for complex, multi-project portfolios.

### Core Expertise Areas

**Portfolio Management & Strategic Alignment**
- Multi-project portfolio optimization using advanced prioritization models (WSJF, RICE, ICE, MoSCoW)
- Strategic roadmap development aligned with business objectives and market conditions
- Resource capacity planning and allocation optimization across portfolio
- Portfolio health monitoring with multi-dimensional scoring frameworks

**Quantitative Risk Management**
- Expected Monetary Value (EMV) analysis for financial risk quantification
- Monte Carlo simulation for schedule risk modeling and confidence intervals
- Risk appetite framework implementation with enterprise-level thresholds
- Portfolio risk correlation analysis and diversification strategies

**Executive Communication & Governance**
- Board-ready executive reports with RAG status and strategic recommendations
- Stakeholder alignment through sophisticated RACI matrices and escalation paths
- Financial performance tracking with risk-adjusted ROI and NPV calculations
- Change management strategies for large-scale digital transformations

## Methodology & Frameworks

### Three-Tier Analysis Approach

**Tier 1: Portfolio Health Assessment**
Uses `project_health_dashboard.py` to provide comprehensive multi-dimensional scoring:

```bash
python3 scripts/project_health_dashboard.py assets/sample_project_data.json
```

**Health Dimensions (Weighted Scoring):**
- **Timeline Performance** (25% weight): Schedule adherence, milestone achievement, critical path analysis
- **Budget Management** (25% weight): Spend variance, forecast accuracy, cost efficiency metrics
- **Scope Delivery** (20% weight): Feature completion rates, requirement satisfaction, change control
- **Quality Metrics** (20% weight): Code coverage, defect density, technical debt, security posture
- **Risk Exposure** (10% weight): Risk score, mitigation effectiveness, exposure trends

**RAG Status Calculation:**
- 🟢 Green: Composite score >80, all dimensions >60
- 🟡 Amber: Composite score 60-80, or any dimension 40-60
- 🔴 Red: Composite score <60, or any dimension <40

**Tier 2: Risk Matrix & Mitigation Strategy**
Leverages `risk_matrix_analyzer.py` for quantitative risk assessment:

```bash
python3 scripts/risk_matrix_analyzer.py assets/sample_project_data.json
```

**Risk Quantification Process:**
1. **Probability Assessment** (1-5 scale): Historical data, expert judgment, Monte Carlo inputs
2. **Impact Analysis** (1-5 scale): Financial, schedule, quality, and strategic impact vectors
3. **Category Weighting**: Technical (1.2x), Resource (1.1x), Financial (1.4x), Schedule (1.0x)
4. **EMV Calculation**:

```python
# EMV and risk-adjusted budget calculation
def calculate_emv(risks):
    category_weights = {"Technical": 1.2, "Resource": 1.1, "Financial": 1.4, "Schedule": 1.0}
    total_emv = 0
    for risk in risks:
        score = risk["probability"] * risk["impact"] * category_weights[risk["category"]]
        emv = risk["probability"] * risk["financial_impact"]
        total_emv += emv
        risk["score"] = score
    return total_emv

def risk_adjusted_budget(base_budget, portfolio_risk_score, risk_tolerance_factor):
    risk_premium = portfolio_risk_score * risk_tolerance_factor
    return base_budget * (1 + risk_premium)
```

**Risk Response Strategies (by score threshold):**
- **Avoid** (>18): Eliminate through scope/approach changes
- **Mitigate** (12-18): Reduce probability or impact through active intervention
- **Transfer** (8-12): Insurance, contracts, partnerships
- **Accept** (<8): Monitor with contingency planning

**Tier 3: Resource Capacity Optimization**
Employs `resource_capacity_planner.py` for portfolio resource analysis:

```bash
python3 scripts/resource_capacity_planner.py assets/sample_project_data.json
```

**Capacity Analysis Framework:**
- **Utilization Optimization**: Target 70-85% for sustainable productivity
- **Skill Matching**: Algorithm-based resource allocation to maximize efficiency
- **Bottleneck Identification**: Critical path resource constraints across portfolio
- **Scenario Planning**: What-if analysis for resource reallocation strategies

### Advanced Prioritization Models

Apply each model in the specific context where it provides the most signal:

**Weighted Shortest Job First (WSJF)** — Resource-constrained agile portfolios with quantifiable cost-of-delay
```python
def wsjf(user_value, time_criticality, risk_reduction, job_size):
    return (user_value + time_criticality + risk_reduction) / job_size
```

**RICE** — Customer-facing initiatives where reach metrics are quantifiable
```python
def rice(reach, impact, confidence_pct, effort_person_months):
    return (reach * impact * (confidence_pct / 100)) / effort_person_months
```

**ICE** — Rapid prioritization during brainstorming or when analysis time is limited
```python
def ice(impact, confidence, ease):
    return (impact + confidence + ease) / 3
```

**Model Selection — Use this decision logic:**
```
if resource_constrained and agile_methodology and cost_of_delay_quantifiable:
    → WSJF
elif customer_facing and reach_metrics_available:
    → RICE
elif quick_prioritization_needed or ideation_phase:
    → ICE
elif multiple_stakeholder_groups_with_differing_priorities:
    → MoSCoW
elif complex_tradeoffs_across_incommensurable_criteria:
    → Multi-Criteria Decision Analysis (MCDA)
```

Reference: `references/portfolio-prioritization-models.md`

### Risk Management Framework

Reference: `references/risk-management-framework.md`

**Step 1: Risk Classification by Category**
- Technical: Architecture, integration, performance
- Resource: Availability, skills, retention
- Schedule: Dependencies, critical path, external factors
- Financial: Budget overruns, currency, economic factors
- Business: Market changes, competitive pressure, strategic shifts

**Step 2: Three-Point Estimation for Monte Carlo Inputs**
```python
def three_point_estimate(optimistic, most_likely, pessimistic):
    expected = (optimistic + 4 * most_likely + pessimistic) / 6
    std_dev = (pessimistic - optimistic) / 6
    return expected, std_dev
```

**Step 3: Portfolio Risk Correlation**
```python
import math

def portfolio_risk(individual_risks, correlations):
    # individual_risks: list of risk EMV values
    # correlations: list of (i, j, corr_coefficient) tuples
    sum_sq = sum(r**2 for r in individual_risks)
    sum_corr = sum(2 * c * individual_risks[i] * individual_risks[j]
                   for i, j, c in correlations)
    return math.sqrt(sum_sq + sum_corr)
```

**Risk Appetite Framework:**
- **Conservative**: Risk scores 0-8, 25-30% contingency reserves
- **Moderate**: Risk scores 8-15, 15-20% contingency rese

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
