# Hướng dẫn migrate skills/agents sang Codex, OpenCode, Pi

Techla Kit có thể export Claude skills và agents thành bundle portable cho coding agents khác.

## Export tạo gì?

Mỗi bundle có:

```text
AGENTS.md
skills/
agents/
manifest.json
```

Riêng Codex có thêm:

```text
.codex/instructions.md
```

`AGENTS.md` là router/index. `skills/` và `agents/` giữ hướng dẫn chi tiết từng skill/agent.

## Export không cài

```bash
bash install.sh --export-agents --tool codex --output ./exports/codex
bash install.sh --export-agents --tool opencode --output ./exports/opencode
bash install.sh --export-agents --tool pi --output ./exports/pi
bash install.sh --export-agents --tool all --output ./exports/all
```

Windows:

```powershell
.\install.ps1 -ExportAgents -Tool codex -Output .\exports\codex
.\install.ps1 -ExportAgents -Tool all -Output .\exports\all
```

## Cài vào tool cụ thể

Luôn truyền target dir rõ ràng để tránh ghi nhầm:

```bash
bash install.sh --install-tool codex --target-dir ~/.codex/techla-kit
bash install.sh --install-tool opencode --target-dir ~/.config/opencode/techla-kit
bash install.sh --install-tool pi --target-dir ~/.pi/techla-kit
```

Windows:

```powershell
.\install.ps1 -InstallTool codex -TargetDir $HOME\.codex\techla-kit
.\install.ps1 -InstallTool opencode -TargetDir $HOME\.config\opencode\techla-kit
.\install.ps1 -InstallTool pi -TargetDir $HOME\.pi\techla-kit
```

## Xem số lượng export được

```bash
bash install.sh --list-exportables
```

Hoặc chạy trực tiếp:

```bash
python3 scripts/export-agents.py --list-exportables
```

## Chạy trực tiếp exporter

```bash
python3 scripts/export-agents.py --tool codex --output ./exports/codex --clean
python3 scripts/export-agents.py --tool all --output ./exports/all --clean
```

## Giới hạn MVP

- Slash commands `/tk:*` không migrate thành command native của Codex/OpenCode/Pi.
- Hooks Claude không migrate.
- Tool names như `Read`, `Edit`, `Task` chỉ là hướng dẫn tham khảo; target tool phải tự map sang tool tương ứng.
- Một số skill có references/scripts/assets riêng; exporter giữ text guidance, không đảm bảo mọi script phụ chạy được ngoài Claude Code.

## Cách dùng trong target tool

1. Trỏ target tool vào folder bundle.
2. Đọc `AGENTS.md` trước.
3. Khi task cần skill cụ thể, mở file trong `skills/`.
4. Khi task cần persona/role, mở file trong `agents/`.

Ví dụ prompt:

```text
Read AGENTS.md in this folder. Use backend/security guidance if relevant, but follow current project conventions.
```
