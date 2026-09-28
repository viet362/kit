# Danh sách đầy đủ các component

> Liệt kê tất cả skills, agents, commands, modes có sẵn trong Techla Kit. Dùng làm tài liệu tra cứu nhanh.

---

## 🎭 Modes (7)

Behavioral modes - thay đổi cách Claude làm việc.

| Mode | Mục đích |
|------|----------|
| `Brainstorming` | Khám phá ý tưởng, requirements chưa rõ |
| `Business_Panel` | Nhiều persona business cùng tham gia |
| `DeepResearch` | Nghiên cứu sâu một topic |
| `Introspection` | Reflection về cách Claude làm việc |
| `Orchestration` | Điều phối nhiều agent |
| `Task_Management` | Quản lý nhiều task song song |
| `Token_Efficiency` | Tiết kiệm token, response ngắn gọn |

---

## 🤖 Agents từ SuperClaude (20)

### Engineering
- `backend-architect` - Thiết kế backend, API, database
- `frontend-architect` - Thiết kế frontend, UI, UX
- `devops-architect` - CI/CD, hạ tầng, deployment
- `system-architect` - Kiến trúc hệ thống tổng thể
- `python-expert` - Chuyên Python (data, web, ML)
- `quality-engineer` - QA, testing, code quality
- `security-engineer` - Bảo mật, audit, OWASP
- `performance-engineer` - Tối ưu hiệu năng
- `refactoring-expert` - Refactor code an toàn
- `root-cause-analyst` - Debug, tìm nguyên nhân gốc

### Research & Analysis
- `deep-research-agent` - Nghiên cứu sâu nhiều nguồn
- `deep-research` - Variant của agent trên
- `requirements-analyst` - Phân tích yêu cầu
- `business-panel-experts` - Panel business advisors
- `repo-index` - Index codebase

### Communication & Learning
- `technical-writer` - Viết docs kỹ thuật
- `learning-guide` - Hướng dẫn học từng bước
- `socratic-mentor` - Mentor theo phương pháp Socratic
- `pm-agent` - Project management
- `self-review` - Tự review code của Claude

---

## 🤖 Agents từ claude-skills (90+)

Phân theo domain. Một số agent nổi bật:

### Engineering (50+ agents)
- `karpathy-reviewer` - Review theo nguyên tắc Karpathy
- `code-tour-guide` - Dẫn tour codebase
- `security-guidance-agent` - Hướng dẫn bảo mật
- `slo-architect` - Thiết kế SLO/SLI
- `chaos-orchestrator` - Chaos engineering
- `feature-flag-architect` - Thiết kế feature flags
- `kubernetes-operator-builder` - Build K8s operators
- `terraform-patterns-expert` - Patterns Terraform
- `helm-chart-builder` - Build Helm charts
- `llm-cost-optimizer` - Tối ưu chi phí LLM
- `prompt-governance-officer` - Quản trị prompt
- `statistical-analyst` - Phân tích thống kê
- `data-quality-auditor` - Audit chất lượng data
- ...

### C-Level Advisors
- `chief-ai-officer-advisor` - Cố vấn CAIO
- `chief-customer-officer-advisor` - Cố vấn CCO
- `chief-data-officer-advisor` - Cố vấn CDO
- `general-counsel-advisor` - Cố vấn pháp lý
- `vpe-advisor` - Cố vấn VP Engineering
- `executive-mentor` - Executive mentor

### Product Team
- Multiple product-focused agents

### Research
- `dossier-agent` - Tạo dossier
- `litreview-agent` - Literature review
- `patent-researcher` - Nghiên cứu patent
- `grants-researcher` - Nghiên cứu grants
- ...

### Marketing
- Nhiều agent cho content, SEO, social media...

> 💡 Xem đầy đủ danh sách:
> ```bash
> ls ~/.claude/agents/
> ```

---

## ⚡ Commands từ SuperClaude (30)

> ⚠️ Tất cả dùng prefix `/tk:` (do cài trong subfolder `~/.claude/commands/tk/`).

### Workflow & Implementation
- `/tk:agent` - Quản lý agents
- `/tk:analyze` - Phân tích code/project
- `/tk:brainstorm` - Brainstorming mode
- `/tk:build` - Build dự án
- `/tk:business-panel` - Business panel discussion
- `/tk:cleanup` - Dọn dẹp code
- `/tk:design` - Thiết kế hệ thống
- `/tk:document` - Viết documentation
- `/tk:estimate` - Ước lượng effort
- `/tk:explain` - Giải thích code
- `/tk:git` - Git workflow
- `/tk:help` - Trợ giúp SuperClaude
- `/tk:implement` - Implement feature
- `/tk:improve` - Cải thiện code
- `/tk:index-repo` - Tạo index repo
- `/tk:index` - Quản lý index
- `/tk:load` - Load context
- `/tk:pm` - Project management
- `/tk:recommend` - Đề xuất giải pháp
- `/tk:reflect` - Reflection
- `/tk:research` - Research
- `/tk:save` - Save state
- `/tk:sc` - SuperClaude utilities
- `/tk:select-tool` - Chọn tool
- `/tk:spawn` - Spawn agent
- `/tk:spec-panel` - Spec panel review
- `/tk:task` - Quản lý task
- `/tk:test` - Chạy test
- `/tk:troubleshoot` - Troubleshoot
- `/tk:workflow` - Workflow management

---

## ⚡ Commands từ claude-skills (50+)

> Đều dùng namespace `/tk:` thống nhất.

### Engineering
- `/tk:karpathy-check` - Check code theo Karpathy
- `/tk:a11y-audit` - Accessibility audit
- `/tk:chaos-experiment` - Chaos experiment
- `/tk:flag-cleanup` - Cleanup feature flags
- `/tk:pipeline` - Phân tích pipeline
- `/tk:plugin-audit` - Audit plugin
- `/tk:tech-debt` - Phân tích tech debt
- `/tk:slo-design` - Thiết kế SLO

### Product Management
- `/tk:prd` - Tạo PRD
- `/tk:user-story` - Tạo user story
- `/tk:okr` - Lập OKR
- `/tk:rice` - Tính RICE score
- `/tk:code-to-prd` - Convert code → PRD
- `/tk:sprint-plan` - Sprint planning
- `/tk:sprint-health` - Sprint health
- `/tk:project-health` - Project health
- `/tk:retro` - Retrospective

### Business & Finance
- `/tk:financial-health` - Đánh giá tài chính
- `/tk:saas-health` - Đánh giá SaaS
- `/tk:competitive-matrix` - Ma trận cạnh tranh
- `/tk:operator-audit` - Operator audit
- `/tk:persona` - Persona development

### Content & Marketing
- `/tk:seo-auditor` - SEO audit
- `/tk:cs-aeo` - Customer success AEO
- `/tk:changelog` - Tạo changelog
- `/tk:google-workspace` - Google Workspace integration

### Development Workflow
- `/tk:tdd` - TDD workflow
- `/tk:tc` - Test cases
- `/tk:focused-fix` - Focused fix
- `/tk:wiki-init` / `/tk:wiki-ingest` / `/tk:wiki-lint` / `/tk:wiki-log` / `/tk:wiki-query` - Wiki management

---

## 🎯 Skills (110+ unique)

### Từ SuperClaude (6)
- `brainstorm` - Brainstorming methodology
- `confidence-check` - Check confidence level
- `deep-research` - Research methodology
- `pm` - Project management
- `token-efficiency` - Token-efficient responses
- `troubleshoot` - Troubleshooting methodology

### Từ claude-skills - Engineering Domain
Lấy từ 25 plugin:
- `agenthub`, `autoresearch-agent`, `behuman`, `caveman`
- `chaos-engineering`, `code-tour`, `data-quality-auditor`
- `demo-video`, `docker-development`, `feature-flags-architect`
- `grill-me`, `grill-with-docs`, `handoff`, `helm-chart-builder`
- `karpathy-coder`, `kubernetes-operator`, `llm-cost-optimizer`
- `llm-wiki`, `prompt-governance`, `security-guidance`, `skills`
- `slo-architect`, `statistical-analyst`, `terraform-patterns`, `write-a-skill`

### Từ claude-skills - Engineering Team
- `a11y-audit`, `google-workspace-cli`, `playwright-pro`
- `self-improving-agent`, `skills`, `snowflake-development`

### Từ claude-skills - C-Level
- `c-level-agents`, `chief-ai-officer-advisor`
- `chief-customer-officer-advisor`, `chief-data-officer-advisor`
- `executive-mentor`, `general-counsel-advisor`, `vpe-advisor`

### Từ claude-skills - Product Team
- 5 plugins cho product management

### Từ claude-skills - Research
- `dossier`, `grants`, `litreview`, `notebooklm`
- `patent`, `pulse`, `research`, `syllabus`

### Từ claude-skills - Marketing
- Bộ skill cho content, SEO, ads, social

### Từ claude-skills - Finance, Compliance, Productivity, RA-QM
- Nhiều skill chuyên ngành

> 💡 Xem đầy đủ:
> ```bash
> ls ~/.claude/skills/
> ```

---

## 📜 Rules (6)

Từ SuperClaude `core/`:
- `BUSINESS_PANEL_EXAMPLES.md` - Ví dụ business panel
- `BUSINESS_SYMBOLS.md` - Symbols dùng trong business mode
- `FLAGS.md` - Hệ thống flags (--brainstorm, --research...)
- `PRINCIPLES.md` - Nguyên tắc cốt lõi
- `RESEARCH_CONFIG.md` - Cấu hình research mode
- `RULES.md` - Quy tắc tổng

Cài tại: `~/.claude/rules/`

---

## 🪝 Hooks

Cấu hình tại `~/.claude/settings.json` (hoặc `techla-hooks.json` nếu đã có settings):

```json
{
  "hooks": {
    "SessionStart": [...],
    "Stop": [...],
    "PostToolUse": [{"matcher": "Write|Edit", ...}]
  }
}
```

---

## 🔍 Tra cứu nhanh

### Tìm tất cả lệnh có từ khóa
```bash
ls ~/.claude/commands/ | grep -i "tu-khoa"

# Vd: tìm về test
ls ~/.claude/commands/ | grep -i test
```

### Tìm skill có description match
```bash
grep -l "security" ~/.claude/skills/*/SKILL.md
```

### Đếm thành phần đã cài
```bash
echo "Skills: $(ls ~/.claude/skills/ | wc -l)"
echo "Agents: $(ls ~/.claude/agents/*.md 2>/dev/null | wc -l)"
echo "Commands: $(ls ~/.claude/commands/*.md 2>/dev/null | wc -l)"
echo "Modes: $(ls ~/.claude/modes/*.md 2>/dev/null | wc -l)"
echo "Rules: $(ls ~/.claude/rules/*.md 2>/dev/null | wc -l)"
```

### Đọc nội dung component
```bash
cat ~/.claude/agents/backend-architect.md
cat ~/.claude/commands/implement.md
cat ~/.claude/skills/karpathy-coder/SKILL.md
```

---

## Bước tiếp theo

➡️ Quay lại [HUONG-DAN-SU-DUNG.md](HUONG-DAN-SU-DUNG.md) để học cách dùng.
