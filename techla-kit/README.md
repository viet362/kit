# Techla Kit

> Toolkit Claude Code tổng hợp dành cho học viên Techla AI Dev
> Kết hợp tinh hoa từ **SuperClaude Framework** + **Alireza claude-skills**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-blue)]()
[![Claude Code](https://img.shields.io/badge/Claude%20Code-compatible-purple)]()

---

## 📦 Techla Kit có gì?

Sau khi cài, Claude Code của bạn sẽ có thêm:

| Thành phần | Số lượng | Mô tả |
|------------|----------|-------|
| 🎯 **Skills** | 110+ | Kỹ năng tự kích hoạt khi gặp đúng tình huống |
| 🤖 **Agents** | 90+ | Trợ lý chuyên môn (planner, coder, tester, reviewer, debugger...) |
| ⚡ **Commands** | 80+ | Lệnh slash (`/tk:analyze`, `/tk:implement`, `/tk:test`, `/tk:prd`...) |
| 🎭 **Modes** | 7 | Chế độ làm việc (Brainstorming, DeepResearch, TokenEfficiency...) |
| 📜 **Rules** | 6 | Quy tắc engineering & business |
| 🪝 **Hooks** | 1 set | Tự động verify code sau Write/Edit |
| 🧠 **CLAUDE.md** | 1 file | 4 nguyên tắc Karpathy áp dụng toàn cục cho mọi project |
| 🎯 **Techla Flow** | `/tk:plan` + skill | Workflow chuẩn: brainstorm → plan → implement |

**Tổng cộng ~300 mục** sẵn sàng dùng.

---

## 🚀 Cài đặt nhanh

### Yêu cầu trước khi cài

1. **Claude Code CLI** đã được cài → [Hướng dẫn cài Claude Code](https://docs.claude.com/en/docs/claude-code)
2. **Terminal cơ bản** (Terminal trên macOS, PowerShell trên Windows, bash trên Linux)
3. **Git** (nếu cài qua GitHub)

### ⚡ Cách 1: One-line command (Khuyến nghị)

Chỉ cần copy-paste 1 dòng duy nhất.

**macOS / Linux**:
```bash
curl -fsSL https://raw.githubusercontent.com/techlaaidev/techla-kit/main/bootstrap.sh | bash
```

**Windows (PowerShell)**:
```powershell
iwr -useb https://raw.githubusercontent.com/techlaaidev/techla-kit/main/bootstrap.ps1 | iex
```

Bootstrap sẽ tự: clone repo vào `~/.techla-kit/` → chạy `install.sh --full`.

**Tùy chọn**:
```bash
# Cài minimal thay vì full
TK_MODE=minimal curl -fsSL https://raw.githubusercontent.com/techlaaidev/techla-kit/main/bootstrap.sh | bash

# Đổi nơi clone repo
TK_DIR=~/dev/techla-kit curl -fsSL https://raw.githubusercontent.com/techlaaidev/techla-kit/main/bootstrap.sh | bash
```

### Cách 2: Clone thủ công

```bash
# Bước 1: Clone repo
git clone https://github.com/techlaaidev/techla-kit.git
cd techla-kit

# Bước 2: Chạy installer (macOS / Linux)
bash install.sh

# Hoặc trên Windows (PowerShell)
.\install.ps1
```

### Cách 3: Cài từ file ZIP

1. Tải file ZIP do giảng viên gửi
2. Giải nén ra một thư mục (vd: `~/Downloads/techla-kit/`)
3. Mở Terminal/PowerShell, đi đến thư mục đó:
   ```bash
   cd ~/Downloads/techla-kit
   ```
4. Chạy installer:
   ```bash
   # macOS / Linux
   bash install.sh

   # Windows PowerShell
   .\install.ps1
   ```

> 💡 **Lưu ý cho Windows**: Nếu lỗi "running scripts is disabled", chạy lệnh sau trong PowerShell trước:
> ```powershell
> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

### Các chế độ cài đặt

| Lệnh | Mô tả | Số mục |
|------|-------|--------|
| One-line bootstrap | Auto clone + full install | ~300 |
| `bash install.sh` | **Tương tác** - menu chọn | tùy chọn |
| `bash install.sh --minimal` | Chỉ SuperClaude (gọn nhẹ) | ~70 |
| `bash install.sh --full` | Tất cả | ~300 |
| `bash install.sh --export-agents --tool codex --output ./exports/codex` | Migrate skills/agents sang Codex bundle | - |
| `bash install.sh --export-agents --tool all --output ./exports/all` | Migrate sang Codex + OpenCode + Pi | - |
| `bash install.sh --uninstall` | Gỡ tất cả | - |

### 🔁 Migrate sang Codex / OpenCode / Pi

Dùng khi bạn muốn mang **skills** và **agents** trong Techla Kit sang coding agent khác. Cách an toàn nhất là **export trước**, kiểm tra bundle, rồi mới copy vào tool đích.

#### Bước 1: Xem số lượng export được

```bash
bash install.sh --list-exportables
```

#### Bước 2: Export bundle portable

```bash
# Codex
bash install.sh --export-agents --tool codex --output ./exports/codex

# OpenCode
bash install.sh --export-agents --tool opencode --output ./exports/opencode

# Pi
bash install.sh --export-agents --tool pi --output ./exports/pi

# Tất cả target cùng lúc
bash install.sh --export-agents --tool all --output ./exports/all
```

Windows PowerShell:

```powershell
.\install.ps1 -ExportAgents -Tool codex -Output .\exports\codex
.\install.ps1 -ExportAgents -Tool opencode -Output .\exports\opencode
.\install.ps1 -ExportAgents -Tool pi -Output .\exports\pi
.\install.ps1 -ExportAgents -Tool all -Output .\exports\all
```

#### Bước 3: Cài bundle vào tool đích nếu muốn

```bash
bash install.sh --install-tool codex --target-dir ~/.codex/techla-kit
bash install.sh --install-tool opencode --target-dir ~/.config/opencode/techla-kit
bash install.sh --install-tool pi --target-dir ~/.pi/techla-kit
```

Windows PowerShell:

```powershell
.\install.ps1 -InstallTool codex -TargetDir $HOME\.codex\techla-kit
.\install.ps1 -InstallTool opencode -TargetDir $HOME\.config\opencode\techla-kit
.\install.ps1 -InstallTool pi -TargetDir $HOME\.pi\techla-kit
```

Bundle output gồm:

```text
AGENTS.md              # file chính cho Codex/OpenCode/Pi đọc
skills/                # từng skill đã chuyển thành markdown portable
agents/                # từng agent đã chuyển thành markdown portable
manifest.json          # số lượng + danh sách file generated
.codex/instructions.md # chỉ có với Codex
```

**Lưu ý giới hạn:** Slash commands `/tk:*` và hooks của Claude Code không migrate thành command native của Codex/OpenCode/Pi. Exporter chỉ chuyển skills/agents thành hướng dẫn portable. Xem chi tiết: [docs/HUONG-DAN-EXPORT-AGENTS.md](docs/HUONG-DAN-EXPORT-AGENTS.md).

### 🗑 Gỡ cài đặt

**macOS / Linux**:
```bash
cd ~/.techla-kit
bash install.sh --uninstall
```

**Windows (PowerShell)**:
```powershell
cd $HOME\.techla-kit
.\install.ps1 -Uninstall
```

Installer sẽ:
- Đọc manifest `~/.claude/.techla-installed.txt` (file ghi lại những gì đã cài)
- Hỏi xác nhận trước khi gỡ
- Xóa đúng các file đó (commands, agents, skills, rules, CLAUDE.md, hooks)
- **KHÔNG động** vào file khác trong `~/.claude/`

Backup cũ ở `~/.claude/.techla-backup-*` vẫn còn (xóa thủ công nếu cần):
```bash
rm -rf ~/.claude/.techla-backup-*
```

Xóa luôn repo đã clone:
```bash
rm -rf ~/.techla-kit
```

> 💡 Nếu repo clone ở thư mục khác (vd: `~/Documents/techla-kit`), `cd` vào thư mục đó thay vì `~/.techla-kit`.

---

## 🎓 Dùng như thế nào sau khi cài?

### 1. Mở terminal mới và chạy Claude

```bash
claude
```

### 2. Workflow chính Techla: Brainstorm → Plan → Implement

Đây là flow chuẩn cho mọi dự án/feature:

```
/tk:brainstorm "Tôi muốn xây bot Discord nhắc bài tập"
    ↓ (thống nhất requirements)
/tk:plan
    ↓ (tạo plans/{date}-{slug}/ với phases)
/tk:implement phase-01
    ↓ (làm xong, claude gợi ý phase tiếp)
/tk:implement phase-02
```

Sau mỗi bước Claude tự gợi ý bước tiếp theo. Học viên có thể quay lại điều chỉnh giữa các bước.

### 3. Các lệnh phổ biến khác

> ⚠️ **Tất cả commands dùng namespace `/tk:`** (techla-kit). Đây là design thống nhất, không có ngoại lệ.

```
# Engineering workflow
/tk:help                    # Xem trợ giúp
/tk:analyze code.py         # Phân tích code
/tk:implement "feature X"   # Implement feature
/tk:test                    # Chạy test
/tk:git "commit message"    # Hỗ trợ workflow git
/tk:karpathy-check          # Review code theo Karpathy

# Planning & Product
/tk:plan                    # Tạo implementation plan (file phases)
/tk:prd "Hệ thống X"        # Tạo Product Requirements Document
/tk:okr                     # Lập OKR
/tk:user-story              # Tạo user story
/tk:retro                   # Retrospective

# Specialized
/tk:competitive-matrix      # Ma trận cạnh tranh
/tk:financial-health        # Đánh giá tài chính
/tk:a11y-audit              # Accessibility audit
```

Xem đầy đủ 80+ commands: `ls ~/.claude/commands/tk/`

### 4. Gọi agent chuyên môn

Trong cuộc hội thoại với Claude, ví dụ:

> "Dùng `backend-architect` agent để thiết kế API cho hệ thống đặt vé"

> "Gọi `quality-engineer` agent review code này"

> "Dùng `deep-research-agent` để nghiên cứu về vector database"

### 5. Skills tự kích hoạt

Skills không cần gọi thủ công - chúng tự kích hoạt khi gặp đúng tình huống. Ví dụ:
- Khi bạn nói "code này có an toàn không?" → Skill bảo mật bật
- Khi bạn nói "brainstorm ý tưởng cho X" → Brainstorm mode bật
- Khi bạn yêu cầu phân tích lỗi → Debugging skill bật

---

## 📚 Tài liệu chi tiết

| Tài liệu | Nội dung |
|----------|----------|
| [HUONG-DAN-CAI-DAT.md](docs/HUONG-DAN-CAI-DAT.md) | Hướng dẫn cài đặt chi tiết + troubleshoot |
| [HUONG-DAN-SU-DUNG.md](docs/HUONG-DAN-SU-DUNG.md) | Cách dùng skills/agents/commands/modes |
| [HUONG-DAN-EXPORT-AGENTS.md](docs/HUONG-DAN-EXPORT-AGENTS.md) | Migrate skills/agents sang Codex/OpenCode/Pi |
| [DANH-SACH-COMPONENT.md](docs/DANH-SACH-COMPONENT.md) | Danh sách đầy đủ các component |
| [CAU-HOI-THUONG-GAP.md](docs/CAU-HOI-THUONG-GAP.md) | FAQ - giải đáp lỗi thường gặp |

---

## 🛠 Cấu trúc kit

```
techla-kit/
├── README.md                  # File này
├── install.sh                 # Installer cho macOS / Linux
├── install.ps1                # Installer cho Windows
├── manifest.json              # Cấu hình kit
├── LICENSE                    # Giấy phép MIT
├── ATTRIBUTION.md             # Ghi nhận tác giả gốc
├── components/                # Toàn bộ nội dung
│   ├── superclaude/           # Mirror từ SuperClaude Framework
│   │   ├── agents/            # 20 agents
│   │   ├── commands/          # 30 commands
│   │   ├── modes/             # 7 modes
│   │   ├── core/              # 6 rules
│   │   ├── skills/            # 6 skills
│   │   └── hooks/             # hooks.json
│   └── claude-skills/         # Mirror từ Alireza claude-skills
│       ├── engineering/       # Skills kỹ thuật
│       ├── product-team/      # Skills cho product
│       ├── marketing-skill/   # Skills marketing
│       ├── c-level-advisor/   # Skills cho executives
│       ├── finance/           # Skills tài chính
│       └── ...                # Nhiều domain khác
└── docs/                      # Tài liệu tiếng Việt
```

---

## ❓ Gặp vấn đề?

1. **Đọc trước**: [docs/CAU-HOI-THUONG-GAP.md](docs/CAU-HOI-THUONG-GAP.md)
2. **Hỏi giảng viên** Techla
3. **Mở issue** tại [GitHub Issues](https://github.com/techlaaidev/techla-kit/issues)

---

## 📜 Giấy phép & Ghi nhận

Techla Kit dưới giấy phép **MIT**.

Kit này **tổng hợp** từ 2 nguồn mã nguồn mở:

- **[SuperClaude Framework](https://github.com/SuperClaude-Org/SuperClaude_Framework)** (MIT License) - by SuperClaude-Org
- **[claude-skills](https://github.com/alirezarezvani/claude-skills)** (MIT License) - by Alireza Rezvani

Cảm ơn các tác giả đã chia sẻ tri thức công khai.

Chi tiết tại [ATTRIBUTION.md](ATTRIBUTION.md).

---

## 🎯 Về Techla AI Dev

Techla là cộng đồng học viên AI Developer tại Việt Nam. Kit này được phát triển để giúp học viên có ngay một "đội ngũ trợ lý AI" mạnh khi mới bắt đầu với Claude Code.

**Bắt đầu hôm nay**: `bash install.sh` rồi `claude` 🚀
