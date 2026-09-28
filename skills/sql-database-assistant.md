# sql-database-assistant

Source: Claude skill
Original path: `components/claude-skills/engineering/skills/sql-database-assistant/SKILL.md`
Description: Use when the user asks to write SQL queries, optimize database performance, generate migrations, explore database schemas, or work with ORMs like Prisma, Drizzle, TypeORM, or SQLAlchemy.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# SQL Database Assistant - POWERFUL Tier Skill

## Overview

The operational companion to database design. While **database-designer** focuses on schema architecture and **database-schema-designer** handles ERD modeling, this skill covers the day-to-day: writing queries, optimizing performance, generating migrations, and bridging the gap between application code and database engines.

### Core Capabilities

- **Natural Language to SQL** — translate requirements into correct, performant queries
- **Schema Exploration** — introspect live databases across PostgreSQL, MySQL, SQLite, SQL Server
- **Query Optimization** — EXPLAIN analysis, index recommendations, N+1 detection, rewrite patterns
- **Migration Generation** — up/down scripts, zero-downtime strategies, rollback plans
- **ORM Integration** — Prisma, Drizzle, TypeORM, SQLAlchemy patterns and escape hatches
- **Multi-Database Support** — dialect-aware SQL with compatibility guidance

### Tools

| Script | Purpose |
|--------|---------|
| `scripts/query_optimizer.py` | Static analysis of SQL queries for performance issues |
| `scripts/migration_generator.py` | Generate migration file templates from change descriptions |
| `scripts/schema_explorer.py` | Generate schema documentation from introspection queries |

---

## Natural Language to SQL

### Translation Patterns

When converting requirements to SQL, follow this sequence:

1. **Identify entities** — map nouns to tables
2. **Identify relationships** — map verbs to JOINs or subqueries
3. **Identify filters** — map adjectives/conditions to WHERE clauses
4. **Identify aggregations** — map "total", "average", "count" to GROUP BY
5. **Identify ordering** — map "top", "latest", "highest" to ORDER BY + LIMIT

### Common Query Templates

**Top-N per group (window function)**
```sql
SELECT * FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rn
  FROM employees
) ranked WHERE rn <= 3;
```

**Running totals**
```sql
SELECT date, amount,
  SUM(amount) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM transactions;
```

**Gap detection**
```sql
SELECT curr.id, curr.seq_num, prev.seq_num AS prev_seq
FROM records curr
LEFT JOIN records prev ON prev.seq_num = curr.seq_num - 1
WHERE prev.id IS NULL AND curr.seq_num > 1;
```

**UPSERT (PostgreSQL)**
```sql
INSERT INTO settings (key, value, updated_at)
VALUES ('theme', 'dark', NOW())
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value, updated_at = EXCLUDED.updated_at;
```

**UPSERT (MySQL)**
```sql
INSERT INTO settings (key_name, value, updated_at)
VALUES ('theme', 'dark', NOW())
ON DUPLICATE KEY UPDATE value = VALUES(value), updated_at = VALUES(updated_at);
```

> See references/query_patterns.md for JOINs, CTEs, window functions, JSON operations, and more.

---

## Schema Exploration

### Introspection Queries

**PostgreSQL — list tables and columns**
```sql
SELECT table_name, column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;
```

**PostgreSQL — foreign keys**
```sql
SELECT tc.table_name, kcu.column_name,
  ccu.table_name AS foreign_table, ccu.column_name AS foreign_column
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage ccu ON tc.constraint_name = ccu.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY';
```

**MySQL — table sizes**
```sql
SELECT table_name, table_rows,
  ROUND(data_length / 1024 / 1024, 2) AS data_mb,
  ROUND(index_length / 1024 / 1024, 2) AS index_mb
FROM information_schema.tables
WHERE table_schema = DATABASE()
ORDER BY data_length DESC;
```

**SQLite — schema dump**
```sql
SELECT name, sql FROM sqlite_master WHERE type = 'table' ORDER BY name;
```

**SQL Server — columns with types**
```sql
SELECT t.name AS table_name, c.name AS column_name,
  ty.name AS data_type, c.max_length, c.is_nullable
FROM sys.columns c
JOIN sys.tables t ON c.object_id = t.object_id
JOIN sys.types ty ON c.user_type_id = ty.user_type_id
ORDER BY t.name, c.column_id;
```

### Generating Documentation from Schema

Use `scripts/schema_explorer.py` to produce markdown or JSON documentation:

```bash
python scripts/schema_explorer.py --dialect postgres --tables all --format md
python scripts/schema_explorer.py --dialect mysql --tables users,orders --format json --json
```

---

## Query Optimization

### EXPLAIN Analysis Workflow

1. **Run EXPLAIN ANALYZE** (PostgreSQL) or **EXPLAIN FORMAT=JSON** (MySQL)
2. **Identify the costliest node** — Seq Scan on large tables, Nested Loop with high row estimates
3. **Check for missing indexes** — sequential scans on filtered columns
4. **Look for estimation errors** — planned vs actual rows divergence signals stale statistics
5. **Evaluate JOIN order** — ensure the smallest result set drives the join

### Index Recommendation Checklist

- Columns in WHERE clauses with high selectivity
- Columns in JOIN conditions (foreign keys)
- Columns in ORDER BY when combined with LIMIT
- Composite indexes matching multi-column WHERE predicates (most selective column first)
- Partial indexes for queries with constant filters (e.g., `WHERE status = 'active'`)
- Covering indexes to avoid table lookups for read-heavy queries

### Query Rewriting Patterns

| Anti-Pattern | Rewrite |
|-------------|---------|
| `SELECT * FROM orders` | `SELECT id, status, total FROM orders` (explicit columns) |
| `WHERE YEAR(created_at) = 2025` | `WHERE created_at >= '2025-01-01' AND created_at < '2026-01-01'` (sargable) |
| Correlated subquery in SELECT | LEFT JOIN with aggregation |
| `NOT IN (SELECT ...)` with NULLs | `NOT EXISTS (SELECT 1 ...)` |
| `UNION` (dedup) when not needed | `UNION ALL` |
| `LIKE '%search%'` | Full-text search index (GIN/FULLTEXT) |
| `ORDER BY RAND()` | Application-side random sampling or `TABLESAMPLE` |

### N+1 Detection

**Symptoms:**
- Application loop that executes one query per parent row
- ORM lazy-loading related entities inside a loop
- Query log shows hundreds of identical SELECT patterns with different IDs

**Fixes:**
- Use eager loading (`include` in Prisma, `joinedload` in SQLAlchemy)
- Batch queries with `WHERE id IN (...)`
- Use DataLoader pattern for GraphQL resolvers

### Static Analysis Tool

```bash
python scripts/query_optimizer.py --query "SELECT * FROM orders WHERE status = 'pending'" --dialect postgres
python scripts/query_optimizer.py --query queries.sql --dialect mysql --json
```

> See references/optimization_guide.md for EXPLAIN plan reading, index types, and connection pooling.

---

## Migration Generation

### Zero-Downtime Migration Patterns

**Adding a column (safe)**
```sql
-- Up
ALTER TABLE users ADD COLUMN phone VARCHAR(20);

-- Down
ALTER TABLE users DROP COLUMN phone;
```

**Renaming a column (expand-contract)**
```sql
-- Step 1: Add new column
ALTE

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
