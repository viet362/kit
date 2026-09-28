# Câu hỏi thường gặp (FAQ)

> Tổng hợp các vấn đề học viên hay gặp khi dùng Techla Kit.

---

## 📋 Mục lục

- [Cài đặt](#cài-đặt)
- [Sử dụng](#sử-dụng)
- [Lỗi & Troubleshoot](#lỗi--troubleshoot)
- [Cập nhật & Gỡ bỏ](#cập-nhật--gỡ-bỏ)
- [Khái niệm](#khái-niệm)

---

## Cài đặt

### Tôi cần cài Claude Code trước hay Techla Kit trước?

**Claude Code trước**. Techla Kit chỉ là một bộ skill/agent/command thêm vào, không phải standalone app.

Cài Claude Code theo: https://docs.claude.com/en/docs/claude-code

### Tôi có thể cài lên Windows không?

**Có**. Dùng PowerShell (không phải Command Prompt cũ):
```powershell
.\install.ps1
```

### Tôi không có quyền admin có cài được không?

**Được**. Installer chỉ ghi vào thư mục home (`~/.claude/`), không cần quyền admin/sudo.

### Cài có an toàn không? Có vào file hệ thống không?

An toàn. Installer chỉ:
- Copy file vào `~/.claude/`
- Tạo backup ở `~/.claude/.techla-backup-{timestamp}/` nếu có file trùng tên
- Tạo manifest `~/.claude/.techla-installed.txt` để uninstall biết file nào cần gỡ

KHÔNG động vào file ngoài `~/.claude/`.

### Tôi đã có `~/.claude/` với file của mình rồi, có ghi đè không?

**Không ghi đè trực tiếp**. Installer backup file cũ vào `.techla-backup-*/` trước khi copy mới.

Riêng `settings.json`: nếu đã tồn tại, installer **không ghi đè**, mà tạo file `techla-hooks.json` riêng và yêu cầu bạn merge thủ công.

### Cài full mất nhiều disk space không?

Không nhiều. Toàn bộ ~25MB sau khi cài. Đây chỉ là file text (markdown), không có binary nặng.

### Tôi đã có SuperClaude cài rồi, cài Techla Kit có conflict không?

Có thể conflict nếu có cùng tên file. Installer dùng nguyên tắc "first wins" — nếu file đã tồn tại, bỏ qua. Nên gỡ SuperClaude cũ trước nếu muốn dùng bản trong Techla Kit.

### Tôi muốn chỉ cài một vài skill cụ thể?

Hiện installer chỉ hỗ trợ Minimal / Full / Custom (chọn nhóm lớn). Để chọn từng skill, bạn copy thủ công:

```bash
# Vd: chỉ cài karpathy-coder
cp -R components/claude-skills/engineering/karpathy-coder/skills/karpathy-coder ~/.claude/skills/
```

---

## Sử dụng

### Sau khi cài, cần làm gì để Claude nhận?

**Restart Claude Code**. Đóng terminal Claude đang chạy, mở terminal mới, chạy `claude` lại.

### Làm sao biết skill nào đang active?

Skills không có khái niệm "active". Tất cả skill trong `~/.claude/skills/` đều được Claude đọc khi session start. Skill nào match với context sẽ được áp dụng.

Xem danh sách:
```bash
ls ~/.claude/skills/
```

### Tôi gõ `/tk:help` (hoặc `/tk:implement`) nhưng không hoạt động?

Có 2 nguyên nhân:

**1. Bạn cài bằng bản cũ (trước fix namespace)**:
Bản cũ copy commands vào `~/.claude/commands/` flat, conflict với `/help` built-in. Update:
```bash
cd ~/Documents/techla-kit
git pull
bash install.sh --uninstall
bash install.sh --full
```

**2. Bạn gõ thiếu prefix**:
- ❌ `/help` - đây là Claude Code built-in
- ✅ `/tk:help` - command SuperClaude

Kiểm tra cài đúng:
```bash
ls ~/.claude/commands/tk/   # phải có file .md trong đây
```

### Tôi gõ `/implement` nhưng Claude không hiểu?

3 lý do thường gặp:

1. **Chưa restart Claude**: Đóng, mở lại.
2. **Cài chưa thành công**:
   ```bash
   ls ~/.claude/commands/implement.md
   ```
   Phải thấy file. Nếu không, cài lại.
3. **Cài Minimal, chưa có lệnh đó**: Lệnh `/implement` thuộc SuperClaude (có trong Minimal), nhưng các lệnh từ claude-skills (vd `/prd`, `/karpathy-check`) chỉ có khi cài Full.

### Skill `karpathy-coder` không tự kích hoạt?

Skill kích hoạt dựa trên trigger keywords trong description. Nếu bạn không nói trigger words (như "review", "commit", "complexity"), Claude không bật skill này.

Có thể **kích hoạt thủ công**:
> "Dùng skill karpathy-coder để review code này"

### Tôi có thể gọi 2 agent cùng lúc không?

Có. Trong Claude:
> "Đồng thời gọi `backend-architect` thiết kế API và `security-engineer` review bảo mật"

Claude sẽ dùng Task tool gọi 2 agent song song.

### Mode `Brainstorming` vs Command `/brainstorm` khác nhau ra sao?

- **Command `/brainstorm`**: bạn chủ động gõ → Claude vào brainstorming flow.
- **Mode `Brainstorming`**: Claude **tự bật** khi gặp trigger (vd: bạn nói "chưa biết bắt đầu từ đâu").

Cả 2 cùng dẫn về hành vi giống nhau, chỉ khác cách kích hoạt.

### Có thể dùng tiếng Việt với Claude không?

**Hoàn toàn được**. Skills/agents/commands viết tiếng Anh nhưng Claude hiểu và trả lời tiếng Việt. Bạn cứ hỏi tiếng Việt bình thường.

### Tốt nhất nên dùng kit này thế nào để học hiệu quả?

1. **Đọc 5-10 skill** bạn quan tâm để học cách chuyên gia approach vấn đề
2. **Thử workflow mẫu** trong [HUONG-DAN-SU-DUNG.md](HUONG-DAN-SU-DUNG.md)
3. **Khi gặp task thật**, thử dùng đúng agent/command chuyên môn
4. **So sánh** kết quả với khi không dùng agent/command đặc thù — sẽ thấy khác biệt

---

## Lỗi & Troubleshoot

### Lỗi: `permission denied: ./install.sh`

```bash
chmod +x install.sh
bash install.sh
```

Hoặc đơn giản:
```bash
bash install.sh   # bash xử lý quyền execute hộ
```

### Lỗi Windows: `cannot be loaded because running scripts is disabled`

Chạy **một lần** trong PowerShell (chọn `A` nếu hỏi):
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Lỗi: `command not found: claude`

Claude Code chưa cài hoặc PATH chưa update:

```bash
# Kiểm tra
which claude          # macOS/Linux
where.exe claude      # Windows

# Nếu thấy path → restart terminal
# Nếu không → cài lại Claude Code
```

### Lỗi: `bash: command not found` (Windows)

Trên Windows, bạn cần dùng `install.ps1` chứ không phải `install.sh`:

```powershell
.\install.ps1
```

Hoặc dùng Git Bash / WSL nếu muốn chạy `install.sh`.

### Sau khi cài, `/help` không thấy command mới

1. **Restart Claude** (đóng, mở lại session)
2. Kiểm tra:
   ```bash
   ls ~/.claude/commands/ | wc -l
   ```
   Phải ra số > 0.
3. Nếu rỗng → cài lại:
   ```bash
   bash install.sh --full
   ```

### Claude trả lời chậm / tốn nhiều token hơn trước

Cài full = nhiều context. Để giảm:

**Cách 1**: Gỡ skill không dùng
```bash
rm -rf ~/.claude/skills/{skill-không-dùng}
```

**Cách 2**: Cài lại Minimal
```bash
bash install.sh --uninstall
bash install.sh --minimal
```

### Tôi xóa nhầm file trong `~/.claude/`

Kiểm tra backup:
```bash
ls ~/.claude/.techla-backup-*/
```

Hoặc cài lại:
```bash
bash install.sh --full
```

### Khi cài, một số file bị skip (thấy thông báo)

Đây là **bình thường**. Nếu có cùng tên file đã tồn tại (vd: skill cùng tên ở 2 nguồn), installer giữ bản đầu tiên gặp. Đây là behavior cố ý để tránh ghi đè.

### Symbol `❌` `✅` hiển thị thành ô vuông trong terminal

Terminal của bạn không hỗ trợ emoji. Vẫn chạy được bình thường, chỉ là hiển thị xấu. Đề xuất:
- macOS: dùng Terminal built-in (đã hỗ trợ)
- Windows: dùng Windows Terminal (Microsoft Store, miễn phí)
- Linux: cài font emoji (`fonts-noto-color-emoji`)

### Windows: Tiếng Việt hiển thị mojibake (kiểu `CÃ i Äáº·t`)

Đây là lỗi encoding PowerShell 5.1 (default Win 10/11). Bản v1.0.1 trở lên đã fix bằng cách:
- Thêm UTF-8 BOM vào `install.ps1`
- Script tự `chcp 65001` + set `[Console]::OutputEncoding = UTF-8` ngay đầu

Nếu vẫn lỗi (chạy bản cũ), 2 cách fix:

**Cách 1**: Dùng PowerShell 7 (PS Core, mặc định UTF-8):
```powershell
winget install Microsoft.PowerShell
pwsh .\install.ps1
```

**Cách 2**: Set UTF-8 thủ công trước khi chạy:
```powershell
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001
.\install.ps1
```

Hoặc dùng Windows Terminal (Microsoft Store) - mặc định UTF-8.

---

## Cập nhật & Gỡ bỏ

### Làm sao cập nhật khi có version mới?

```bash
cd ~/Documents/techla-kit
git pull
bash install.sh --full   # Hoặc --minimal nếu trước đó cài minimal
```

Installer tự backup bản cũ trước khi ghi mới.

### Cập nhật bản ZIP

1. Tải bản mới (file ZIP)
2. Giải nén đè lên thư mục cũ
3. Chạy lại `bash install.sh --full`

### Gỡ hoàn toàn

```bash
bash install.sh --uninstall
```

Installer đọc manifest `~/.claude/.techla-installed.txt` và xóa đúng các file đã cài. KHÔNG động vào file của bạn hoặc của tool khác.

### Sau khi gỡ, vẫn còn folder `.techla-backup-*`

Đây là backup mà installer tự tạo lúc cài. Bạn có thể xóa thủ công sau khi chắc chắn không cần restore:

```bash
rm -rf ~/.claude/.techla-backup-*
```

---

## Khái niệm

### "Skill" vs "Agent" vs "Command" khác gì?

| | Skill | Agent | Command |
|---|---|---|---|
| Kích hoạt | Tự động khi gặp trigger | Bạn gọi tên hoặc Claude tự gọi | Bạn gõ `/tên-lệnh` |
| Context | Áp dụng vào Claude chính | Isolated context riêng | Áp dụng vào Claude chính |
| Mục đích | Behavior, knowledge nền | Trợ lý chuyên môn | Hành động cụ thể |

### "Mode" khác gì "Skill"?

- **Mode**: Thay đổi cách Claude **suy nghĩ** (mindset). Vd: Brainstorming mode = Claude hỏi nhiều hơn nói.
- **Skill**: Cung cấp kiến thức/quy trình **cụ thể**. Vd: skill `karpathy-coder` = áp dụng 4 nguyên tắc Karpathy khi review code.

### "Hook" để làm gì?

Hook = script tự chạy khi có event. Vd:
- Sau khi Claude sửa file (Write/Edit), hook tự nhắc verify
- Trước khi Stop session, hook nhắc check uncommitted changes

Hook giúp tự động hóa các check lặp đi lặp lại.

### Tại sao Techla Kit mirror cả 2 repo thay vì pick best?

**Pros của Mirror**:
- ✅ Đầy đủ, không miss skill nào
- ✅ Dễ cập nhật khi upstream có version mới
- ✅ Tôn trọng bản gốc (không tự chỉnh sửa nội dung)

**Cons**:
- ❌ Nhiều file → context Claude lớn hơn
- ❌ Có thể có overlap skills

→ Đó là lý do có cả option `--minimal` để cài gọn nhẹ.

### Cài kit này có ảnh hưởng workflow Claude hiện tại của tôi?

**Có thể**. Nếu trước đó bạn đã set CLAUDE.md, hooks, hoặc skill riêng, Techla Kit có thể conflict với một số file. Installer luôn backup, nhưng:

- Nên đọc kỹ output installer xem có file nào bị backup
- Nếu có thể, cài thử với `CLAUDE_HOME` khác trước:
  ```bash
  CLAUDE_HOME=/tmp/test-claude bash install.sh --full
  ```

### Tôi muốn đóng góp / báo lỗi

- **Mở issue**: https://github.com/techlaaidev/techla-kit/issues
- **Pull request**: Fork repo, gửi PR
- **Hỏi giảng viên Techla** trực tiếp

---

## Bước tiếp theo

➡️ Quay lại [README.md](../README.md)
➡️ Đọc [HUONG-DAN-SU-DUNG.md](HUONG-DAN-SU-DUNG.md) để dùng kit hiệu quả hơn
