---
description: Wrap up session - tổng hợp commit gần đây trên branch hiện tại, đánh giá impact, đề xuất bước tiếp theo. Dùng cuối session làm việc.
argument-hint: [số commit muốn xem, default 10]
allowed-tools: Read, Bash, Glob, Grep
---

# /tk:watzup - Wrap up session

Tổng hợp những gì đã làm trong session, đánh giá chất lượng, đề xuất bước tiếp theo.

<HARD-GATE>
TUYỆT ĐỐI KHÔNG được:
- Implement code mới khi user gõ /tk:watzup
- Tự ý commit / push (chỉ tổng hợp, không action)
- Sửa file để "cleanup" giữa lúc tổng hợp
- Suggest gay gắt — đây là wrap up, không phải review chỉ trích

CHỈ:
- Đọc git log / git diff
- Đọc file changed nếu cần hiểu context
- Tổng hợp + đề xuất nhẹ
</HARD-GATE>

## Cú pháp

```
/tk:watzup            # Tổng hợp 10 commit gần nhất
/tk:watzup 5          # 5 commit gần nhất
/tk:watzup today      # Commit hôm nay
```

## Hành vi

### Bước 1: Thu thập

```bash
git log --oneline -10
git status -s
git diff --stat HEAD~10
```

Xác định:
- Branch hiện tại
- Số commit chưa push (nếu có)
- Files có uncommitted changes
- Phạm vi thay đổi (LOC, files)

### Bước 2: Phân tích từng commit

Cho mỗi commit gần đây:
- Loại (feat / fix / refactor / docs / chore)
- Scope (module / feature nào)
- File chính bị động
- Ảnh hưởng (LOC, có break behavior không)

### Bước 3: Tổng hợp

```markdown
## 🎯 Session Wrap Up

**Branch**: `feature/xxx` (5 commit ahead of main)

**Đã làm trong session**:
- ✅ feat(auth): thêm Google OAuth (3 files, +245 -12)
- ✅ fix(login): sửa null check redirect (1 file, +8 -3)
- ✅ test(auth): unit test cho OAuth flow (2 files, +120)
- ✅ docs(auth): cập nhật README (1 file, +30)

**Tổng**: 4 commit, 7 files, +403 -15 dòng

**Trạng thái**:
- ✅ Tests pass (12/12)
- ⚠️ 2 files uncommitted: `src/utils/temp.ts`, `notes.md`
- 📤 5 commit chưa push lên origin

**Đánh giá nhanh**:
- Scope hợp lý, focus đúng vào auth
- Commit message conventional, rõ ràng
- Test coverage cho feature mới

**⚠️ Cần lưu ý**:
- `notes.md` không nên commit lên repo (thêm vào .gitignore?)
- `temp.ts` có vẻ là file tạm, xóa hay commit?

**📍 Đề xuất tiếp theo**:
- Cleanup uncommitted: `git restore src/utils/temp.ts` hoặc commit
- Push branch: `/tk:ship beta` hoặc `git push`
- Tạo PR: `/tk:ship official`
- Lưu journal: `/tk:journal` (nếu có skill)
- Bắt đầu task mới: `/tk:brainstorm`
```

### Đặc biệt: nếu phát hiện vấn đề

Cảnh báo (không sửa) nếu:
- File `.env`, `*.key`, `credentials.json` đã commit → ⚠️ SECURITY
- Có debug `console.log` / `print()` sót lại
- Có `// TODO` / `// FIXME` mới thêm
- Có file > 500 dòng (gợi ý chia nhỏ)

## Khi nào dùng

- Cuối session làm việc, trước khi tắt máy
- Trước khi push/PR (review lần cuối)
- Khi quay lại branch sau vài ngày → hiểu mình đang dở đâu
- Trước khi handoff cho người khác

## Khi nào KHÔNG dùng

- Còn task chưa xong → tiếp tục làm trước
- Muốn commit/push → dùng `/tk:ship` hoặc `/tk:git cp`
- Muốn analyze chi tiết code quality → `/tk:karpathy-check`

## Anti-pattern (TRÁNH)

- ❌ Tự cleanup file uncommitted khi user chưa hỏi
- ❌ Tự push thay user
- ❌ Đánh giá gay gắt — đây là wrap up, không phải code review
- ❌ Suggest implement thêm feature mới → đó là việc của brainstorm
