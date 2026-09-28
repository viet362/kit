---
description: Ship pipeline 1 lệnh - test, review, commit, push, tạo PR. Auto-detect official (main/master) vs beta (dev). Dùng khi feature đã sẵn sàng release.
argument-hint: [official|beta] [--skip-tests|--skip-review|--dry-run]
allowed-tools: Read, Edit, Bash, Glob, Grep, AskUserQuestion
---

# /tk:ship - Ship 1 lệnh

Pipeline tự động: test → review → commit → push → PR. Từ feature branch ra link PR.

<HARD-GATE>
TUYỆT ĐỐI KHÔNG được:
- Push lên main/master TRỰC TIẾP (luôn qua PR)
- Force push (--force, --force-with-lease) trừ khi user gõ `--force` rõ ràng
- Skip test khi có file `.test.` / `.spec.` thay đổi
- Commit `.env`, `credentials*`, `*.key`, secrets
- Push khi review tìm thấy 🔴 CRITICAL bug

PHẢI:
- Verify branch hiện tại không phải main/master
- Chạy security scan (grep secrets) trước khi commit
- Tests pass (trừ khi `--skip-tests` explicit)
- Conventional commit message
</HARD-GATE>

## Cú pháp

```
/tk:ship                  # Auto-detect mode từ branch name
/tk:ship official         # Ship lên main/master qua PR
/tk:ship beta             # Ship lên dev/beta branch (lighter)
/tk:ship --dry-run        # Show plan, không thực thi
```

## Auto-detect mode

| Branch hiện tại | Ship mode | Target |
|-----------------|-----------|--------|
| `feature/*`, `fix/*`, `hotfix/*` | official | main / master |
| `dev/*`, `beta/*`, `experiment/*` | beta | dev / beta |
| `main`, `master` | ❌ Cấm — không ship từ default branch | - |
| Khác | Hỏi user | - |

## Flags

| Flag | Tác dụng |
|------|----------|
| `--skip-tests` | Bỏ test step (chỉ khi tests vừa pass) |
| `--skip-review` | Bỏ review step |
| `--skip-docs` | Bỏ update docs |
| `--dry-run` | In ra plan, không action |

## Quy trình

### Bước 1: Pre-flight check

- `git status` → check uncommitted
- `git branch` → verify không phải main/master
- Đọc `.gitignore` → confirm secrets không commit
- Detect default branch (main vs master) qua `git symbolic-ref refs/remotes/origin/HEAD`

Nếu branch là main/master:
```
❌ Đang ở main. Không ship từ branch mặc định.
→ Tạo branch trước: git checkout -b feature/<tên>
```

### Bước 2: Security scan

```bash
git diff --cached | grep -iE "(api[_-]?key|token|password|secret|credential|aws_access)"
git diff | grep -iE "(api[_-]?key|token|password|secret|credential|aws_access)"
```

Nếu match → DỪNG, list file vi phạm, gợi ý `.gitignore`.

### Bước 3: Test (trừ khi --skip-tests)

Detect test framework:
- `package.json` có `"test"` script → `npm test`
- `pytest.ini` / `pyproject.toml` có pytest → `pytest`
- `Cargo.toml` → `cargo test`
- Khác → hỏi user

Test FAIL → DỪNG, báo cáo lỗi, gợi ý `/tk:fix`.

### Bước 4: Review (trừ khi --skip-review)

Self-review nhanh:
- 🔴 CRITICAL: bug, security, broken behavior
- 🟡 IMPROVEMENT: code smell, missing edge case
- 🔵 SUGGESTION: style, comment

🔴 → DỪNG, ép fix trước khi ship.
🟡 → cảnh báo, cho phép ship.
🔵 → note vào PR description.

### Bước 5: Commit

Nếu có uncommitted changes:
- Phân tích diff → đề xuất conventional commit message
- Split nếu cần (>10 file unrelated, mixed types)
- User confirm message → commit

Format: `type(scope): description`
- `feat`: feature mới
- `fix`: sửa bug
- `refactor`: refactor không thay behavior
- `test`: thêm/sửa test
- `docs`: docs (KHÔNG dùng cho file `.claude/`)
- `chore`: build/deps/config

### Bước 6: Push

```bash
git push -u origin <branch>
```

Lỗi rejected → gợi ý `git pull --rebase` trước (KHÔNG tự force push).

### Bước 7: Tạo PR (chỉ mode official)

Dùng `gh pr create`:
- Title: copy từ commit chính
- Body: liệt kê commit + summary + checklist test
- Base: main/master
- Head: branch hiện tại

Mode `beta`: chỉ push, không tạo PR (developer tự merge dev branch sau).

### Báo cáo

```markdown
## ✅ Đã ship!

**Mode**: official (→ main)
**Branch**: feature/auth-google-oauth

**Pipeline**:
- ✅ Pre-flight: clean, không secrets
- ✅ Tests: 24 passed
- ✅ Review: 0 critical, 2 improvements (note vào PR)
- ✅ Commit: feat(auth): add Google OAuth (4 files, +287 -15)
- ✅ Push: origin/feature/auth-google-oauth
- ✅ PR created: https://github.com/owner/repo/pull/42

**PR URL**: https://github.com/owner/repo/pull/42

**Tiếp theo**:
- Đợi review từ teammate
- Hoặc /tk:brainstorm task mới
```

## Khi nào KHÔNG dùng

- Commit nhỏ giữa session → dùng `/tk:git cp`
- Còn debug → dùng `/tk:fix` trước
- Chỉ muốn review chưa muốn push → `/tk:karpathy-check`

## Anti-pattern (TRÁNH)

- ❌ `git push --force origin main` (cực nguy hiểm)
- ❌ Ship khi test đỏ "để fix sau" — bug sẽ vào production
- ❌ Commit `.env` "tạm để teammate xem" — dùng `.env.example`
- ❌ PR description rỗng — không ai review nổi
- ❌ Bypass review để ship gấp — kỹ thuật debt tích lũy nhanh

## Ví dụ

```
USER: /tk:ship beta

CLAUDE:
🔍 **Pre-flight**:
   Branch: dev/new-dashboard (auto-detect: beta mode → target dev)
   Uncommitted: 2 files
   Default branch: main

🔒 **Security scan**: clean ✅

🧪 **Tests**: npm test → 18 passed ✅

📋 **Review**: 1 improvement (component > 200 dòng, gợi ý chia)
   → ship được nhưng note vào commit

💾 **Commit**:
   feat(dashboard): add chart widget with 7-day range filter
   Files: src/components/Dashboard/ChartWidget.tsx + tests
   Confirm? [Y/n]

USER: y

CLAUDE:
✅ Committed: a3f4d2c
✅ Pushed: origin/dev/new-dashboard

**Beta ship xong**. Branch dev đã có code mới. Skip PR (mode beta).
Khi nào ready merge dev → main, chạy /tk:ship official từ dev branch.
```
