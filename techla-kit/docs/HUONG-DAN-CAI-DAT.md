# Hướng dẫn cài đặt chi tiết

> Dành cho học viên Techla AI Dev. Đọc kỹ phần dành cho hệ điều hành của bạn.

---

## 📋 Mục lục

- [Bước 1: Cài Claude Code](#bước-1-cài-claude-code)
- [Bước 2: Tải Techla Kit](#bước-2-tải-techla-kit)
  - [Cách 0: One-line bootstrap (nhanh nhất)](#cách-0-one-line-bootstrap-nhanh-nhất)
  - [Cách A: Clone từ GitHub](#cách-a-clone-từ-github)
  - [Cách B: Giải nén file ZIP](#cách-b-giải-nén-file-zip)
- [Bước 3: Chạy installer](#bước-3-chạy-installer)
  - [macOS](#macos)
  - [Linux](#linux)
  - [Windows](#windows)
- [Bước 4: Kiểm tra cài đặt](#bước-4-kiểm-tra-cài-đặt)
- [Gỡ cài đặt](#gỡ-cài-đặt)
- [Khắc phục sự cố](#khắc-phục-sự-cố)

---

## Bước 1: Cài Claude Code

Techla Kit cần **Claude Code CLI** đã được cài trước.

### macOS / Linux

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

### Windows

Theo hướng dẫn chính thức tại: https://docs.claude.com/en/docs/claude-code

Hoặc dùng npm (nếu đã có Node.js):
```bash
npm install -g @anthropic-ai/claude-code
```

### Kiểm tra Claude Code đã cài

```bash
claude --version
```

Nếu thấy version → OK, qua bước 2.
Nếu lỗi "command not found" → cần khởi động lại terminal hoặc cài lại.

---

## Bước 2: Tải Techla Kit

### Cách 0: One-line bootstrap (nhanh nhất)

Chỉ copy-paste 1 dòng duy nhất, bootstrap tự lo phần còn lại.

**macOS / Linux**:
```bash
curl -fsSL https://raw.githubusercontent.com/techlaaidev/techla-kit/main/bootstrap.sh | bash
```

**Windows (PowerShell)**:
```powershell
iwr -useb https://raw.githubusercontent.com/techlaaidev/techla-kit/main/bootstrap.ps1 | iex
```

Bootstrap sẽ:
1. Kiểm tra git có sẵn không
2. Clone repo vào `~/.techla-kit/` (mặc định) hoặc cập nhật nếu đã có
3. Chạy `install.sh --full` tự động
4. Báo cáo kết quả

**Tùy chọn nâng cao** (set env vars trước):

| Env | Mặc định | Mô tả |
|-----|----------|-------|
| `TK_DIR` | `~/.techla-kit` | Nơi clone repo |
| `TK_MODE` | `full` | `minimal` / `full` |
| `TK_BRANCH` | `main` | Branch nào |
| `TK_REPO` | github.com/techlaaidev/techla-kit | URL repo |

Ví dụ:
```bash
# Cài minimal vào ~/dev/techla-kit
TK_DIR=~/dev/techla-kit TK_MODE=minimal curl -fsSL https://raw.githubusercontent.com/techlaaidev/techla-kit/main/bootstrap.sh | bash
```

**Sau khi bootstrap xong**: muốn cập nhật, chạy lại 1 dòng đó hoặc `cd ~/.techla-kit && git pull && bash install.sh --full`.

---

### Cách A: Clone từ GitHub

> ⭐ **Khuyến nghị**: dễ cập nhật về sau, chỉ cần `git pull`.

**Yêu cầu**: Bạn đã được thêm làm **collaborator** vào repo `techlaaidev/techla-kit`.

```bash
# Di chuyển đến thư mục bạn muốn lưu kit (vd: Documents)
cd ~/Documents

# Clone repo
git clone https://github.com/techlaaidev/techla-kit.git

# Đi vào thư mục
cd techla-kit
```

**Nếu lần đầu dùng GitHub trên máy này**, cần đăng nhập:

```bash
# Cài GitHub CLI
brew install gh        # macOS
# hoặc
sudo apt install gh    # Ubuntu/Debian

# Đăng nhập
gh auth login
```

### Cách B: Giải nén file ZIP

> Dùng khi giảng viên gửi file ZIP trực tiếp.

1. Tải file `techla-kit.zip` từ link giảng viên gửi.

2. Giải nén:
   - **macOS**: Double-click file ZIP → tự giải nén ra thư mục cùng cấp.
   - **Linux**: `unzip techla-kit.zip`
   - **Windows**: Chuột phải → **Extract All...**

3. Đổi tên thư mục thành `techla-kit` (nếu chưa có).

4. Di chuyển thư mục đó vào nơi bạn muốn (vd: `~/Documents/`).

5. Mở Terminal/PowerShell và di chuyển vào thư mục:
   ```bash
   cd ~/Documents/techla-kit
   ```

---

## Bước 3: Chạy installer

### macOS

```bash
bash install.sh
```

Hoặc nếu muốn cài tất cả ngay (không hỏi):
```bash
bash install.sh --full
```

### Linux

Giống macOS:
```bash
bash install.sh
```

### Windows

Mở **PowerShell** (không phải Command Prompt cũ):

```powershell
.\install.ps1
```

**Nếu gặp lỗi `running scripts is disabled`**, chạy lệnh sau **một lần duy nhất**:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Rồi chạy lại installer.

### Menu cài đặt

Khi chạy lệnh `install.sh` không kèm tham số, bạn sẽ thấy:

```
Chọn nhóm muốn cài
  1) Minimal  → Chỉ SuperClaude (~50 mục, gọn nhẹ)
  2) Full     → Tất cả (SuperClaude + claude-skills, 400+ mục)
  3) Custom   → Chọn từng nhóm

Lựa chọn [1/2/3]:
```

- **Mới bắt đầu** → chọn `1` (Minimal). Sau này có thể chạy lại để thêm.
- **Muốn đầy đủ** → chọn `2` (Full).
- **Người dùng nâng cao** → chọn `3` để tùy chỉnh từng nhóm.

---

## Bước 4: Kiểm tra cài đặt

### Cách 1: Kiểm tra thư mục

```bash
# macOS / Linux
ls ~/.claude/skills/ | head
ls ~/.claude/agents/ | head
ls ~/.claude/commands/ | head

# Windows
ls $HOME\.claude\skills\ | Select-Object -First 10
```

Nếu thấy nhiều file/folder bên trong → cài thành công.

### Cách 2: Mở Claude Code

```bash
claude
```

Trong Claude, gõ:
```
/help
```

Bạn sẽ thấy danh sách các lệnh slash. Tìm các lệnh quen thuộc:
- `/brainstorm` - chế độ brainstorming
- `/analyze` - phân tích code
- `/implement` - implement feature
- `/review` - review code
- `/test` - chạy test

### Cách 3: Xem manifest

```bash
cat ~/.claude/.techla-installed.txt | wc -l
```

Sẽ in ra số mục đã cài (~70 cho minimal, ~300 cho full).

---

## Gỡ cài đặt

Để gỡ tất cả mục Techla Kit đã cài (KHÔNG động vào file khác trong ~/.claude/):

```bash
# macOS / Linux
bash install.sh --uninstall

# Windows
.\install.ps1 -Uninstall
```

Installer dùng file manifest `~/.claude/.techla-installed.txt` để biết file nào do nó cài → chỉ gỡ đúng các file đó.

---

## Khắc phục sự cố

### ❓ Lỗi "permission denied" khi chạy install.sh

```bash
chmod +x install.sh
bash install.sh
```

### ❓ Lỗi "command not found: claude"

Claude Code chưa cài hoặc chưa restart terminal.
1. Đóng terminal, mở terminal mới.
2. Kiểm tra: `which claude` (macOS/Linux) hoặc `where.exe claude` (Windows).
3. Nếu vẫn không có, cài lại Claude Code theo Bước 1.

### ❓ Windows: "running scripts is disabled on this system"

Đây là chính sách bảo mật của PowerShell. Chạy:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### ❓ Đã có `settings.json` trong `~/.claude/` từ trước

Installer **KHÔNG ghi đè** file này. Nó tạo file `~/.claude/techla-hooks.json` riêng và cảnh báo bạn merge thủ công. Xem [HUONG-DAN-SU-DUNG.md](HUONG-DAN-SU-DUNG.md#hooks).

### ❓ Khi cài Full, một số skill bị skip (no error)

Đây là **đúng**. Installer dùng nguyên tắc "first wins": nếu một skill cùng tên đã tồn tại (vd: do SuperClaude đã cài), nó sẽ giữ bản đó, không ghi đè bằng bản từ claude-skills.

### ❓ Không có git, chỉ có ZIP, vẫn cài được không?

Hoàn toàn được. Chỉ cần giải nén ZIP và chạy `bash install.sh` từ thư mục đã giải nén.

### ❓ Cài xong nhưng không thấy lệnh slash mới

1. Restart Claude Code (`exit` rồi `claude` lại).
2. Kiểm tra `ls ~/.claude/commands/` có file không.
3. Trong Claude, gõ `/help` rồi cuộn xuống xem.

### ❓ Tôi đang dùng Macbook M1/M2 (Apple Silicon)

Hoàn toàn tương thích. Installer chỉ dùng bash + cp + mkdir, không phụ thuộc kiến trúc CPU.

### ❓ Tôi muốn cài lại từ đầu

```bash
# Gỡ trước
bash install.sh --uninstall

# Cài lại
bash install.sh --full
```

### ❓ Tôi muốn dùng custom CLAUDE_HOME

```bash
# Cài vào thư mục khác
CLAUDE_HOME=/path/to/custom bash install.sh --full
```

---

## Bước tiếp theo

➡️ Đọc [HUONG-DAN-SU-DUNG.md](HUONG-DAN-SU-DUNG.md) để biết cách dùng skills, agents, commands.

➡️ Có lỗi không liệt kê ở đây? Xem [CAU-HOI-THUONG-GAP.md](CAU-HOI-THUONG-GAP.md) hoặc hỏi giảng viên.
