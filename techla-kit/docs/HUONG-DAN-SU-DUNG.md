# Hướng dẫn sử dụng Techla Kit

> Sau khi đã cài đặt (xem [HUONG-DAN-CAI-DAT.md](HUONG-DAN-CAI-DAT.md)), tài liệu này hướng dẫn bạn dùng skills, agents, commands trong công việc hàng ngày.

---

## 📋 Mục lục

- [Hiểu 4 khái niệm cốt lõi](#hiểu-4-khái-niệm-cốt-lõi)
- [1. Skills - Tự kích hoạt](#1-skills---tự-kích-hoạt)
- [2. Agents - Trợ lý chuyên môn](#2-agents---trợ-lý-chuyên-môn)
- [3. Commands - Lệnh slash](#3-commands---lệnh-slash)
- [4. Modes - Chế độ làm việc](#4-modes---chế-độ-làm-việc)
- [5. Hooks - Tự động hóa](#5-hooks---tự-động-hóa)
- [Workflow mẫu](#workflow-mẫu)
- [Mẹo hay](#mẹo-hay)

---

## Hiểu 4 khái niệm cốt lõi

Trước khi đi sâu, bạn cần phân biệt:

| Khái niệm | Cách kích hoạt | Mục đích |
|-----------|---------------|----------|
| **Skill** | Tự động khi gặp đúng trigger | Hành vi/kiến thức nền |
| **Agent** | Gọi qua Task tool hoặc nhắc tên | Trợ lý chuyên môn isolated context |
| **Command** | Bạn gõ `/tên-lệnh` | Hành động cụ thể, có cấu trúc |
| **Mode** | Bạn kích hoạt qua flag hoặc Claude tự bật | Thay đổi cách Claude làm việc |

---

## 1. Skills - Tự kích hoạt

**Skills không cần gọi**. Claude tự đọc danh sách skill có trong `~/.claude/skills/` và tự kích hoạt khi context phù hợp.

### Cách hoạt động

Mỗi skill có metadata `description:` mô tả khi nào nên dùng. Claude đọc description, gặp tình huống match → tự áp dụng nguyên tắc trong skill.

### Ví dụ

Bạn có skill `karpathy-coder` (từ claude-skills). Description:
> "Use when writing, reviewing, or committing code to enforce Karpathy's 4 coding principles..."

Khi bạn nói:
> "Review giúp tôi đoạn code này"

Claude tự đọc skill này và áp dụng 4 nguyên tắc của Karpathy vào review.

### Xem danh sách skills đã cài

```bash
ls ~/.claude/skills/
```

Hoặc trong Claude:
```
/help
```

Cuộn xuống section "Skills".

### Các skill nổi bật sau khi cài full

| Skill | Khi nào kích hoạt |
|-------|-------------------|
| `brainstorm` | Khi bạn nói "chưa biết bắt đầu từ đâu", "ý tưởng cho X" |
| `deep-research` | Khi cần research sâu một topic |
| `karpathy-coder` | Khi review/commit code |
| `code-tour` | Khi muốn hiểu codebase |
| `feature-flags-architect` | Khi thiết kế feature flag |
| `security-guidance` | Khi nói về bảo mật |
| `prd` | Khi viết Product Requirements Document |
| `okr` | Khi lập OKR |
| `competitive-matrix` | Khi phân tích đối thủ |

---

## 2. Agents - Trợ lý chuyên môn

Agent là một "Claude con" có vai trò chuyên môn. Khác với skill ở chỗ:
- Skill = nguyên tắc/kiến thức, áp dụng vào Claude chính
- Agent = một entity riêng, có context window riêng, làm xong báo cáo lại

### Cách gọi agent

**Cách 1**: Nói tên agent trong cuộc hội thoại

> "Dùng `backend-architect` agent để thiết kế REST API cho hệ thống quản lý đơn hàng"

> "Gọi `security-engineer` agent kiểm tra file auth.js"

**Cách 2**: Để Claude tự quyết định

Khi bạn yêu cầu một task lớn, Claude tự gọi các agent phù hợp.

### Danh sách agent quan trọng (đã cài)

**Engineering**:
- `backend-architect` - Thiết kế backend
- `frontend-architect` - Thiết kế frontend
- `devops-architect` - Hạ tầng & CI/CD
- `system-architect` - Kiến trúc hệ thống tổng thể
- `quality-engineer` - QA & testing
- `security-engineer` - Bảo mật
- `performance-engineer` - Tối ưu hiệu năng
- `python-expert` - Chuyên Python
- `refactoring-expert` - Refactor code
- `root-cause-analyst` - Debug & tìm nguyên nhân
- `technical-writer` - Viết docs kỹ thuật
- `requirements-analyst` - Phân tích yêu cầu
- `deep-research-agent` - Nghiên cứu sâu
- `pm-agent` - Project management
- `learning-guide` - Hướng dẫn học
- `socratic-mentor` - Mentor theo phương pháp Socratic

**Product & Business** (từ claude-skills):
- Nhiều agent cho marketing, finance, c-level...

### Khi nào KHÔNG dùng agent?

- Task nhỏ, đơn giản → Claude chính làm là đủ
- Cần liên tục trao đổi context → agent isolated context không phù hợp

---

## 3. Commands - Lệnh slash

Commands là lệnh bạn gõ trong Claude chat, bắt đầu bằng `/`.

### Cú pháp

```
/tên-lệnh [tham số]
```

### Commands phổ biến (sau khi cài full)

> ⚠️ **Quan trọng**: Commands từ **SuperClaude** dùng namespace `/tk:` (vd: `/tk:help`, `/tk:implement`) để tránh xung đột với lệnh built-in của Claude Code. Commands từ **claude-skills** dùng tên trực tiếp (vd: `/prd`, `/okr`).

**Workflow (SuperClaude)** - prefix `/tk:`:
- `/tk:brainstorm` - Bắt đầu brainstorming
- `/tk:analyze` - Phân tích code/project
- `/tk:implement` - Implement một feature
- `/tk:test` - Chạy test
- `/tk:improve` - Cải thiện code
- `/tk:document` - Viết documentation
- `/tk:explain` - Giải thích code
- `/tk:cleanup` - Dọn dẹp code
- `/tk:design` - Thiết kế hệ thống
- `/tk:estimate` - Ước lượng effort
- `/tk:git` - Hỗ trợ git workflow
- `/tk:help` - Trợ giúp SuperClaude
- `/tk:index-repo` - Tạo index codebase
- `/tk:load` - Load context dự án
- `/tk:recommend` - Đề xuất giải pháp
- `/tk:reflect` - Reflection sau task
- `/tk:research` - Nghiên cứu sâu
- `/tk:save` - Lưu trạng thái
- `/tk:spawn` - Spawn agent
- `/tk:task` - Quản lý tasks
- `/tk:workflow` - Quản lý workflow

**Business/PM** (từ claude-skills):
- `/prd` - Tạo Product Requirements Document
- `/okr` - Lập OKR
- `/changelog` - Tạo changelog
- `/competitive-matrix` - Ma trận cạnh tranh
- `/project-health` - Đánh giá sức khỏe dự án
- `/retro` - Retrospective
- `/rice` - Tính điểm RICE
- `/karpathy-check` - Check code theo Karpathy principles
- `/a11y-audit` - Audit accessibility
- `/chaos-experiment` - Chaos engineering experiment
- `/flag-cleanup` - Cleanup feature flags
- `/financial-health` - Đánh giá tài chính
- `/pipeline` - Phân tích pipeline
- `/plugin-audit` - Audit plugin
- `/code-to-prd` - Convert code thành PRD

### Xem chi tiết một command

Đọc file md trực tiếp:
```bash
# SuperClaude command (trong subfolder sc/)
cat ~/.claude/commands/tk/implement.md

# claude-skills command (flat)
cat ~/.claude/commands/prd.md
```

---

## 4. Modes - Chế độ làm việc

Modes thay đổi **cách Claude suy nghĩ và phản hồi**.

### 7 modes có sẵn

| Mode | Khi nào dùng | Flag |
|------|--------------|------|
| **Brainstorming** | Khám phá ý tưởng, requirements chưa rõ | `--brainstorm` hoặc `--bs` |
| **DeepResearch** | Nghiên cứu sâu một chủ đề | `--research` |
| **Task Management** | Quản lý nhiều task | `--task` |
| **Token Efficiency** | Tiết kiệm token, response ngắn gọn | `--efficient` |
| **Orchestration** | Điều phối nhiều agent | `--orchestrate` |
| **Introspection** | Reflection về cách Claude làm việc | `--introspect` |
| **Business Panel** | Có nhiều persona kinh doanh tham gia | `--panel` |

### Cách kích hoạt mode

**Cách 1**: Dùng flag

```
--brainstorm Em muốn xây hệ thống quản lý lớp học, chưa biết bắt đầu từ đâu
```

**Cách 2**: Claude tự bật khi gặp trigger

Nói "em chưa biết bắt đầu từ đâu", Claude sẽ tự bật Brainstorming mode.

---

## 5. Hooks - Tự động hóa

Hooks là các script chạy tự động trên sự kiện cụ thể. Techla Kit cài 1 set hooks từ SuperClaude:

### Hooks có sẵn

| Hook | Khi nào chạy | Tác dụng |
|------|--------------|----------|
| `SessionStart` | Mỗi khi bắt đầu Claude session | Init context |
| `Stop` | Trước khi kết thúc session | Nhắc check uncommitted changes |
| `PostToolUse Write\|Edit` | Sau khi Claude sửa file | Tự verify code |

### Xem hooks đang active

```bash
cat ~/.claude/settings.json
```

### Tự thêm hook mới

Sửa `~/.claude/settings.json`. Format:
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          { "type": "prompt", "prompt": "Check for syntax errors" }
        ]
      }
    ]
  }
}
```

### Merge thủ công nếu đã có `settings.json`

Khi installer thấy `~/.claude/settings.json` đã tồn tại, nó tạo file `~/.claude/techla-hooks.json` riêng. Bạn cần:

1. Mở 2 file trong editor:
   ```bash
   code ~/.claude/settings.json ~/.claude/techla-hooks.json
   ```

2. Copy phần `"hooks"` từ `techla-hooks.json` vào `settings.json`.

3. Nếu `settings.json` cũng có `"hooks"`, merge 2 mảng vào nhau.

4. Xóa file `techla-hooks.json` sau khi merge xong:
   ```bash
   rm ~/.claude/techla-hooks.json
   ```

---

## Workflow mẫu

### Workflow 1: Techla Flow (CHUẨN) - Brainstorm → Plan → Implement

Flow chính thức cho mọi dự án/feature Techla:

```
1. /tk:brainstorm "Tôi muốn thêm tính năng đăng nhập Google"
   → Claude vào brainstorming mode, hỏi requirements
   → Output: brief tóm tắt

2. /tk:plan
   → Đọc brief từ brainstorm
   → Tạo plans/{date}-{slug}/ với plan.md + phase-XX-*.md
   → Output: 3-7 phases có Definition of Done verifiable

3. /tk:implement phase-01
   → Thực thi phase 1 đến hoàn thành
   → Update status: ⏸️ → 🔄 → ✅
   → Claude gợi ý: tiếp /tk:implement phase-02?

4. /tk:implement phase-02 ... (lặp đến hết)

5. /karpathy-check    (review tổng thể)
6. /tk:git "feat: ..."  (commit theo conventional commits)
```

**Đặc điểm**:
- Skill `tk-flow` tự gợi ý bước tiếp theo sau mỗi giai đoạn
- Có check-point giữa các bước → học viên có thể điều chỉnh
- Plan files lưu trong `plans/` để theo dõi tiến độ
- Mỗi phase có DoD verifiable, không "code chạy được" mơ hồ

### Workflow 1B: Implement nhanh (không cần plan)

Cho task nhỏ, không cần file plan:

```
1. /tk:brainstorm hoặc bỏ qua nếu task rõ ràng
2. /tk:implement "feature X"
3. /tk:test
4. /karpathy-check
5. /tk:git "feat: ..."
```

### Workflow 2: Debug một bug

```
1. (Paste error message)
2. Claude tự gọi root-cause-analyst agent
3. /tk:test       (chạy test để tái hiện bug)
4. Sau khi fix: /tk:test lại
5. /tk:improve    (cải thiện code sau fix)
```

### Workflow 3: Viết PRD cho feature

```
1. /prd "Hệ thống đăng nhập SSO"
2. Skill prd kích hoạt, hỏi qua các phần
3. Output: file PRD.md đầy đủ
```

### Workflow 4: Nghiên cứu công nghệ mới

```
1. /research "vector database for RAG"
2. Skill deep-research kích hoạt
3. Output: bản report tổng hợp từ nhiều nguồn
```

---

## Mẹo hay

### 🎯 Biết tên agent/skill = mạnh hơn

Khi bạn biết có agent `security-engineer`, bạn có thể nói trực tiếp:
> "Gọi security-engineer review file login.py"

→ Claude dùng đúng agent chuyên môn thay vì tự xử lý generic.

### 📚 Đọc skill files để học

Mỗi skill là một bài học gold. Đọc 5-10 skills bạn quan tâm để học cách chuyên gia tiếp cận vấn đề:

```bash
# Vd: học cách audit security
cat ~/.claude/skills/security-guidance/SKILL.md

# Học karpathy principles
cat ~/.claude/skills/karpathy-coder/SKILL.md
```

### 🔍 Tìm command nhanh

```bash
ls ~/.claude/commands/ | grep -i "tu khoa"

# Vd: tìm command về test
ls ~/.claude/commands/ | grep -i test
```

### 💾 Lưu workflow của bạn

Nếu bạn dùng một chuỗi lệnh lặp đi lặp lại, tạo file `~/.claude/commands/{your-name}.md` để định nghĩa command riêng.

### 🚀 Update kit định kỳ

```bash
cd ~/Documents/techla-kit
git pull
bash install.sh --full   # Cài đè (backup tự động)
```

### ⚠️ Cẩn thận với token

Cài full = nhiều skill = mỗi session Claude load nhiều context. Nếu thấy chậm/tốn token:
1. Gỡ skill không dùng: `rm -rf ~/.claude/skills/{skill-không-dùng}`
2. Hoặc cài lại minimal: `bash install.sh --uninstall && bash install.sh --minimal`

---

## Bước tiếp theo

➡️ Xem [DANH-SACH-COMPONENT.md](DANH-SACH-COMPONENT.md) để biết đầy đủ skills/agents/commands có gì.

➡️ Gặp lỗi? Đọc [CAU-HOI-THUONG-GAP.md](CAU-HOI-THUONG-GAP.md).
