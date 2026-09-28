---
description: Implement feature/plan/fix có quy trình. Tự động chạy scout → research (nếu cần) → plan → code → test → review. Có flag để tùy chỉnh.
argument-hint: <task / plan-path> [--fast|--no-test|--auto]
allowed-tools: Read, Write, Edit, MultiEdit, Glob, Grep, Bash, AskUserQuestion
---

# /tk:cook - Implement feature có quy trình

End-to-end implementation. Khác `/tk:implement` ở chỗ: cook tự điều phối nhiều bước (scout → plan → code → test → review), `/tk:implement` chỉ là 1 bước trong đó.

<HARD-GATE>
TUYỆT ĐỐI KHÔNG được:
- Code khi chưa có plan rõ ràng (file plan.md hoặc plan inline trong chat)
- Skip test step trừ khi user đã add `--no-test`
- Tự ý refactor file không liên quan đến task
- Implement nhiều feature trong 1 lần cook (chỉ 1 feature / 1 plan / 1 phase)
- Mock data, fake implementation, "// TODO: implement later"

PHẢI:
- Có plan TRƯỚC khi code (gọi /tk:plan nếu chưa có)
- Compile/lint check sau mỗi file viết xong
- Báo cáo files changed + test result cuối session
</HARD-GATE>

## Cú pháp

```
/tk:cook <task mô tả tự nhiên>
/tk:cook <path/to/plan.md>
/tk:cook <path/to/plan.md> phase-02     # Chỉ implement phase 02
```

## Flags

| Flag | Tác dụng |
|------|----------|
| (không) | Interactive — hỏi confirm giữa các bước (default) |
| `--fast` | Skip research, đi thẳng scout → plan → code |
| `--no-test` | Skip test step (chỉ dùng khi test đã pass sẵn) |
| `--auto` | Auto-approve mọi bước (cho session nhanh, ít rủi ro) |

## Anti-Rationalization

| Suy nghĩ | Sự thật |
|----------|---------|
| "Task đơn giản, code luôn cho rồi" | Task đơn giản = nơi giả định sai gây hậu quả lớn nhất |
| "Bỏ qua scout, mình biết codebase" | Kiến thức codebase decay. Scout < 30s, code lệch chuẩn tốn 30 phút sửa |
| "Plan trong đầu được rồi" | Plan trong đầu = không tồn tại với người khác (và bản thân sau 2 ngày) |
| "Test sau" | "Sau" thường = không bao giờ. Test ngay khi code còn fresh |
| "Code 1 feature mà ghi 5 phase phí thời gian" | Đúng — vì vậy /tk:cook phân loại complexity: trivial chỉ 1-2 bước |

## Quy trình 6 bước

### Bước 1: Phân loại complexity

Đọc task / plan, phân loại:

| Mức | Đặc điểm | Bước skip |
|-----|----------|-----------|
| **Trivial** | Typo, đổi text, sửa 1 dòng | Skip plan + research |
| **Simple** | 1-2 file, logic rõ | Skip research, có plan inline |
| **Moderate** | 3-5 file, có nhánh edge case | Full workflow |
| **Complex** | Cross-module, design decision | Phải có /tk:plan trước, sau đó /tk:cook |

### Bước 2: Scout (nếu cần)

Áp dụng skill `tk:scout` để tìm:
- File liên quan (Glob theo keyword)
- Pattern tương tự đã có trong codebase (Grep)
- Convention naming/import của project

Bỏ qua nếu Trivial.

### Bước 3: Research (chỉ Moderate/Complex)

Áp dụng skill `research`:
- Check docs official của framework/lib liên quan
- Tìm pattern best practice
- Bỏ qua nếu `--fast`

### Bước 4: Plan

- Nếu user truyền `path/to/plan.md` → đọc file đó
- Nếu Simple → tạo plan inline trong chat (5-10 dòng)
- Nếu Moderate/Complex chưa có plan → DỪNG, gợi ý chạy `/tk:plan` trước

Plan PHẢI gồm:
- Files sẽ tạo/sửa (path cụ thể)
- Acceptance criteria verifiable
- Risk + mitigation (nếu có)

### Bước 5: Code

Thực thi plan:
- 1 file 1 lúc, compile-check sau mỗi file
- Tuân thủ convention từ Bước 2 (naming, import, structure)
- Comment tiếng Việt giải thích "vì sao" cho logic phức tạp
- Update plan status `⏸️ → 🔄 → ✅` nếu có file plan

**Sau mỗi file**: chạy compile / lint nhanh
- Python: `python -m py_compile <file>`
- TypeScript: `npx tsc --noEmit`
- Nếu lỗi → fix ngay, KHÔNG để dồn

### Bước 6: Test + Review

Trừ khi `--no-test`:
- Chạy test liên quan (`pytest tests/test_xxx.py`, `npm test`)
- Nếu fail → debug + fix (không skip)

Tự review nhanh:
- File < 200 dòng?
- Tên biến rõ ràng?
- Edge case xử lý?
- Comment giải thích "why"?

### Báo cáo kết thúc

```markdown
## ✅ Đã cook: [Task]

**Phases done**: 1/1 (hoặc 3/4 nếu multi-phase plan)

**Files changed**:
- `src/auth/login.ts` (mới, 87 dòng)
- `src/auth/oauth.ts` (mới, 54 dòng)
- `tests/test_login.ts` (mới, 42 dòng)

**Test**: 12 passed, 0 failed ✅

**Compile**: clean ✅

**Đề xuất tiếp theo**:
- /tk:ship beta (push + PR lên branch dev)
- /tk:cook plan.md phase-03 (tiếp phase tiếp theo)
- /tk:watzup (wrap up session)
```

## Khi nào KHÔNG dùng /tk:cook?

- **Brainstorm requirements** → /tk:brainstorm
- **Tạo plan đa phase** → /tk:plan
- **Sửa bug** → /tk:fix
- **Chỉ research** → /tk:research

## Anti-pattern (TRÁNH)

- ❌ Chạy /tk:cook khi requirements còn mơ hồ
- ❌ Skip Bước 2 (Scout) "vì biết codebase rồi"
- ❌ Skip test trừ khi cực kỳ chắc chắn
- ❌ Refactor "tiện thể" file không trong plan
- ❌ Implement nhiều phase 1 lần (làm xong 1, confirm, mới phase tiếp)
