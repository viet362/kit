---
description: Scout codebase nhanh - tìm file, locate feature, hiểu cấu trúc. Dùng trước khi implement/fix để gather context. Token-efficient với parallel search.
argument-hint: <search target> [path scope]
allowed-tools: Read, Glob, Grep, Bash
---

# /tk:scout - Scout codebase

Tìm file + hiểu cấu trúc codebase nhanh. Dùng trước khi `/tk:cook` hoặc `/tk:fix` để gather context, tránh action mù.

<HARD-GATE>
TUYỆT ĐỐI KHÔNG được:
- Sửa file trong khi scout (read-only operation)
- Suggest fix / implement trong report (đó là việc của /tk:fix /tk:cook)
- Đọc nguyên 1 file > 500 dòng (dùng Grep + Read offset)
- Spawn quá 3 parallel search cùng lúc (token budget)
- Trả về danh sách file trống mà không giải thích vì sao

PHẢI:
- Bắt đầu bằng Glob + Grep, KHÔNG bằng Read
- Báo cáo concise (path + 1-2 dòng mô tả mỗi file)
- Note rõ scope đã search (folder nào, pattern gì)
</HARD-GATE>

## Cú pháp

```
/tk:scout "user authentication"           # Tìm feature auth
/tk:scout "useFetch hook"                 # Tìm 1 hook/function cụ thể
/tk:scout "api error handling"            # Hiểu pattern xử lý lỗi API
/tk:scout "tests for login" tests/        # Search trong tests/ folder
```

## Khi nào dùng

✅ **Dùng khi**:
- Chuẩn bị implement feature → cần biết file/folder liên quan
- Debug bug → cần tìm tất cả call site của hàm
- Onboard repo mới → cần hiểu cấu trúc tổng thể
- Trước khi refactor → cần xác định blast radius
- User nói "tìm", "xem có chỗ nào", "ở đâu trong code"

❌ **KHÔNG dùng khi**:
- Đã biết file cần đọc → Read trực tiếp
- Cần đọc 1 file đã có path → Read
- Cần tìm trên web → WebSearch
- Cần answer "function này làm gì" → /tk:explain

## Quy trình 4 bước

### Bước 1: Phân tích target

Trích keyword từ user input:
- Specific identifier (function, hook, component name) → search literal
- Concept ("authentication", "error handling") → search nhiều keyword + variant
- File pattern → Glob

Ví dụ user nói "tìm authentication":
- Keywords: `auth`, `login`, `signin`, `oauth`, `session`, `token`, `jwt`
- File patterns: `*auth*`, `*login*`, `*session*`

### Bước 2: Phát hiện scale

Ước lượng codebase trước:
```bash
# Đếm file
find . -name "*.ts" -o -name "*.tsx" -o -name "*.py" 2>/dev/null | head -200 | wc -l
```

Nếu < 50 file → search sequential.
Nếu > 50 file → chia thành 2-3 batches parallel.
Nếu > 500 file → focus theo top-level folder (src/, app/, lib/).

### Bước 3: Search

Combine Glob + Grep:

**Tìm file theo tên**:
```bash
Glob: **/*auth*.{ts,tsx,js,py}
```

**Tìm trong content**:
```bash
Grep: "(login|signin|authenticate)" --type=ts
```

**Tìm call sites**:
```bash
Grep: "useAuth\(\)" --output_mode=files_with_matches
```

Skip auto:
- `node_modules/`, `.git/`, `dist/`, `build/`, `__pycache__/`
- File compiled (`.min.js`, `.bundle.js`)

### Bước 4: Báo cáo concise

Format:

```markdown
## 🔍 Scout: "user authentication"

**Scope**: src/, lib/ (Glob 47 file match, Grep narrowed to 8)

**Files chính** (entry points):
- `src/auth/login.ts` (87 dòng) — form login + validation
- `src/auth/oauth.ts` (54 dòng) — Google/GitHub OAuth flow
- `src/hooks/useAuth.ts` (42 dòng) — React hook đọc session

**Files phụ trợ**:
- `src/lib/jwt.ts` — encode/decode token
- `src/middleware/authMiddleware.ts` — guard routes
- `tests/auth.test.ts` — 12 test cases

**Pattern phát hiện**:
- Auth context dùng React Context API (`AuthContext.tsx`)
- JWT lưu localStorage (KHÔNG httpOnly cookie — note bảo mật)
- Session refresh via middleware

**Files KHÔNG liên quan dù tên có "auth"**:
- `package-lock.json` (skip — generated)
- `docs/old/auth-v1.md` (skip — outdated docs)

**📍 Tiếp theo**: Đọc các file chính, hoặc:
- /tk:fix nếu cần sửa bug auth
- /tk:cook nếu thêm feature auth
- /tk:karpathy-check src/auth/ nếu muốn review
```

## Nguyên tắc

- **Read-only**: scout KHÔNG sửa code
- **Concise**: 1-2 dòng/file, không paste nội dung file
- **Top 10 max**: nếu có > 10 file match → group, không list hết
- **Explain skip**: nếu skip file (vì test/docs/generated) → note rõ
- **Note pattern**: nhận ra design pattern (Context API, hook, middleware) và call out

## Tips cho học viên

- Scout TRƯỚC khi yêu cầu implement → Claude có context, code đúng convention
- Scout là cách nhanh nhất hiểu codebase mới (thay vì đọc tuần tự từ README)
- Output scout cô đọng → save token cho session implement tiếp theo

## Ví dụ

```
USER: /tk:scout "form validation"

CLAUDE:
🔍 Scout: "form validation"
   Scope: src/ (78 file .tsx, 23 file .ts)

**Pattern chính**: dùng `react-hook-form` + `zod` schema

**Schemas tập trung**: `src/schemas/`
- `loginSchema.ts`, `signupSchema.ts`, `profileSchema.ts`

**Form components**: `src/components/forms/`
- `<FormField>` wrapper chung
- `<FormError>` hiển thị Zod error

**Patterns**:
- Mỗi form: schema → useForm({resolver: zodResolver(schema)})
- Lỗi: error.errors[0].message
- Submit: handleSubmit(onSubmit)

**📍 Tiếp theo**: muốn thêm form mới? Pattern này có sẵn ở `src/components/forms/`.
```
