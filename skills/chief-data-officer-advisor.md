# chief-data-officer-advisor

Source: Claude skill
Original path: `components/claude-skills/c-level-advisor/skills/chief-data-officer-advisor/SKILL.md`
Description: Chief Data Officer advisory for startups: AI training data rights and consent provenance, data product strategy (warehouse vs lakehouse vs mesh, build-vs-buy), B2B customer-data-as-asset valuation and M&A readiness, data team org evolution. Use when deciding whether to train models on customer data, choosing data architecture, valuing data for fundraising or M&A, sequencing data hires, or when user mentions CDO, chief data officer, data strategy, data mesh, lakehouse, training data, data product, data monetization, or customer data asset. NOT a tactical data engineering skill — strategic decisions only.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Chief Data Officer Advisor

Strategic data leadership for startup CDOs and founders without one. **Four decisions, no surveys:**

1. **Can we train our model on this data?** — origin × consent × use-case matrix
2. **Warehouse, lakehouse, or mesh — and what do we build vs buy?** — stage-driven architecture
3. **What is our customer data worth?** — strategic value + M&A multiplier + productization paths
4. **What data role do we hire next?** — stage-to-role map, centralize-vs-embed trigger

This skill does **not** cover tactical data engineering. For schema design, observability, query optimization, RAG, or ML platform implementation, see `engineering/database-designer/`, `engineering/observability-designer/`, `engineering/data-quality-auditor/`, `engineering/sql-database-assistant/`, `engineering/rag-architect/`, `engineering/llm-cost-optimizer/`.

## Keywords

CDO, chief data officer, AI training data, consent provenance, training rights, GDPR Article 6 lawful basis, GDPR Article 22, EU AI Act high-risk, ePrivacy, copyright fair use, hiQ v. LinkedIn, scraped data, synthetic data, data product, data mesh, lakehouse, medallion architecture, dbt, Snowflake, BigQuery, Databricks, Fivetran, Airbyte, reverse ETL, feature store, customer data as asset, data monetization, data productization, anonymization, k-anonymity, differential privacy, M&A data diligence, data org, analytics engineer, data engineer, data scientist, data product manager, centralize vs embed, hub and spoke

## Quick Start

```bash
# Audit data sources for AI training eligibility
python scripts/ai_training_data_audit.py                              # uses embedded sample
python scripts/ai_training_data_audit.py path/to/sources.json

# Pick data architecture + build-vs-buy + sequencing
python scripts/data_product_strategy_picker.py                        # uses embedded Series A SaaS
python scripts/data_product_strategy_picker.py path/to/profile.json

# Value the customer data corpus + productization viability
python scripts/data_asset_valuator.py                                 # uses embedded B2B sample
python scripts/data_asset_valuator.py path/to/corpus.json
```

## Key Questions (ask these first)

- **What decision does this data drive?** (If none, why are we collecting it?)
- **What's the consent provenance of every source we want to train on?** (TOS-only is not the same as explicit opt-in.)
- **Who are the internal data consumers, and how many distinct domains do they span?** (Drives centralize-vs-embed and warehouse-vs-mesh.)
- **In an M&A scenario, is our data a moat or a liability?** (Customer carve-outs in MSAs can flip the answer.)
- **Are we hiring an analytics engineer or a data scientist next?** (They solve different problems; founders confuse them.)
- **Have we run an anonymization audit before any external sharing?** (k-anonymity ≥ 5 is the floor, not the ceiling.)

## Core Responsibilities

### 1. AI Training Data Rights

The 2026 question every startup is facing: **can we use customer data to train our model?**

The answer is rarely binary. It depends on three independent dimensions:

| Dimension | Values |
|---|---|
| **Origin** | 1st-party-explicit-opt-in / 1st-party-TOS-only / partner-licensed / scraped / synthetic |
| **Data class** | Anonymous aggregate / behavioral / PII / 3rd-party content / regulated (PHI, PCI, kids) |
| **Use case** | In-product personalization / fine-tune our model / train foundation model / external sharing |

Each combination produces GO / MITIGATE / NO-GO. **Run** `ai_training_data_audit.py` on a JSON inventory of sources.

See `references/ai_training_data_rights.md` for the full matrix + GDPR Art. 6 lawful basis decision tree + EU AI Act high-risk triggers.

### 2. Data Product Strategy

**Architecture choice (warehouse vs lakehouse vs mesh) is stage-driven, not preference-driven:**

- **Warehouse only** (Snowflake / BigQuery / Postgres): ≤5 data consumers, <2TB, no ML use cases
- **Lakehouse** (warehouse + object storage, often Databricks or Snowflake-with-Iceberg): 5–25 data consumers, 2TB–1PB, 1–3 ML use cases
- **Data mesh**: 25+ data consumers across 4+ domains, federated ownership culture in place

**Build vs buy is decided per layer:**

| Layer | Buy unless | Build only if |
|---|---|---|
| Storage / warehouse | Never build | (You’re a data infra company) |
| ELT / ingest | Never build | Source isn’t supported by Fivetran/Airbyte |
| Modeling (dbt) | Always build | This is your IP |
| BI / dashboards | Buy at <100 consumers | Embedded analytics for customers |
| Feature store | Defer until 3+ prod models | Then build OR buy Tecton/Hopsworks |
| ML platform | Defer until 5+ prod models | Then buy SageMaker/Vertex/Databricks |

**Run** `data_product_strategy_picker.py` for a stage-specific recommendation. See `references/data_product_strategy.md` for kill criteria per architecture and the build-vs-buy decision tree.

### 3. B2B Customer-Data-as-Asset

**The shift:** at Series B+, customer data is no longer just operational — it’s an asset that can be:
- A defensibility moat (replicating requires years of customer cohort)
- An M&A multiplier (1.2x–2x ARR uplift for strategic buyers)
- A direct revenue stream (anonymized industry benchmarks, embedding endpoints, licensing)

But it can also be a **liability**:
- 47/380 customers with MSA carve-outs makes productization legally infeasible
- Anonymization audits often reveal re-identification risk above tolerable thresholds
- Regulatory exposure increases linearly with productization (GDPR Art. 28 processors vs Art. 26 joint controllers)

**Run** `data_asset_valuator.py` with corpus characteristics to get strategic value score + productization paths + risk-adjusted value.

See `references/customer_data_as_asset.md` for the valuation framework, M&A diligence prep checklist, and contractual constraint audit pattern.

### 4. Data Team Org Evolution

**The wrong question:** "Should we hire a data scientist?"
**The right question:** "What’s the next decision we can’t make because we lack data, and what role unblocks that?"

Stage-to-role map (B2B SaaS baseline):

| Stage | First hire | Then | Then |
|---|---|---|---|
| Pre-seed / seed | Founder-as-analyst (SQL + spreadsheets) | — | — |
| Series A (Series A) | Analyst | Analytics engineer (dbt) | — |
| Series B | Data engineer | Senior analyst (embedded in GTM) | Data PM (if 3+ teams need data) |
| Growth | Manager of analytics | ML engineer (if model is core) | Head of Data |
| Late-stage | Head of Data → CDO | Specialized: BI, MLE, DPO | Federated owners per domain (mesh) |

**Centralize-vs-embed trigger:** when 3+ functional areas (sales, marketing, product, ops, CS) need bespoke data weekly, the central team becomes the bottleneck. Move to hub-and-spoke (central platform + embedded analysts) before that becomes a hiring crisis.

See `references/data_team_org_evolution.md`.

## Workflows

### Workflow 1: AI Training Decision (1 hour)
**Goal:** Decide whether

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
