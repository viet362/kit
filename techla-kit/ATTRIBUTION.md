# Ghi nhận tác giả (Attribution)

Techla Kit là bản tổng hợp (mirror + curate) từ 2 dự án mã nguồn mở. Toàn bộ nội dung trong `components/` thuộc bản quyền của tác giả gốc, được phân phối lại dưới giấy phép MIT.

## 1. SuperClaude Framework

- **Repository**: https://github.com/SuperClaude-Org/SuperClaude_Framework
- **License**: MIT
- **Mirror tại**: `components/superclaude/`
- **Nội dung được copy**:
  - `agents/` (20 agents) - personas chuyên môn
  - `commands/` (30 commands) - slash commands
  - `modes/` (7 modes) - behavioral modes
  - `core/` (6 rules) - flags, principles, rules
  - `skills/` (6 skills) - core skills
  - `hooks/hooks.json` - hooks configuration

Cảm ơn team **SuperClaude-Org** đã xây dựng framework chất lượng cao.

## 2. Alireza Claude Skills

- **Repository**: https://github.com/alirezarezvani/claude-skills
- **Author**: Alireza Rezvani (https://alirezarezvani.com)
- **License**: MIT
- **Mirror tại**: `components/claude-skills/`
- **Nội dung được copy**:
  - 13 domains: engineering, engineering-team, c-level-advisor, marketing-skill, product-team, ra-qm-team, finance, productivity, project-management, research, compliance-os, business-growth, marketing
  - 315+ SKILL.md files
  - 156+ agent .md files
  - 24+ nested command files
  - Top-level commands & agents

Cảm ơn **Alireza Rezvani** vì bộ thư viện skills đồ sộ và chỉn chu.

---

## Cam kết tuân thủ giấy phép

- Mọi file nguyên bản trong `components/` được giữ nguyên (không sửa đổi).
- Header license & metadata trong các file SKILL.md / agent / command được bảo toàn.
- README và docs của Techla Kit (tiếng Việt) là nội dung mới do Techla AI Dev viết.
- Mọi cải tiến/đóng góp nên được gửi ngược lên repo gốc tương ứng nếu phù hợp.

## Cập nhật mirror

Để cập nhật mirror từ upstream:

```bash
# Pull upstream
cd /tmp && rm -rf superclaude claude-skills
git clone --depth=1 https://github.com/SuperClaude-Org/SuperClaude_Framework.git superclaude
git clone --depth=1 https://github.com/alirezarezvani/claude-skills.git

# Re-mirror vào techla-kit
cd /path/to/techla-kit
rm -rf components/superclaude components/claude-skills
mkdir -p components/superclaude components/claude-skills
cp -R /tmp/superclaude/plugins/superclaude/* components/superclaude/
# Copy các domain từ claude-skills (xem install.sh để biết danh sách)
```

## Liên hệ

Nếu bạn là tác giả của một trong 2 repo và muốn:
- Cập nhật thông tin attribution
- Yêu cầu gỡ bỏ một phần nội dung
- Đề xuất cộng tác

Vui lòng mở issue tại: https://github.com/techlaaidev/techla-kit/issues
