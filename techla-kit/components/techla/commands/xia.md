---
description: Lấy, so sánh, port hoặc adapt feature từ GitHub repo hoặc local repo path vào project hiện tại. Kích hoạt skill xia với challenge gate trước khi plan/implement.
argument-hint: <github-url-or-owner/repo|local-path> [feature] [--compare|--copy|--improve|--port] [--auto|--fast]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion
---

# /tk:xia - Lấy feature từ repo khác

Lấy, so sánh, port hoặc adapt feature từ GitHub repo/local repo path vào project hiện tại theo đúng style. Command này là front-door cho skill `xia`.

<HARD-GATE>
TUYỆT ĐỐI KHÔNG được:
- Copy code mà KHÔNG đọc project hiện tại trước (sẽ ra naming/import sai chuẩn)
- Copy đè lên file hiện có mà chưa hỏi user
- Lấy feature có dependency lớn (npm package, env var, DB schema) mà KHÔNG báo cáo
- Lấy bí mật (.env, credentials, API key) — ngay cả khi user paste path đó
- Copy nhiều feature cùng lúc khi user chỉ hỏi 1

CHỈ extract sau khi:
- Đã đọc convention của project hiện tại (tên file, naming, import style)
- Đã xác định scope feature (file nào, dependency nào)
- User đã confirm feature cụ thể muốn lấy
- Đã liệt kê dependency sẽ cần thêm vào project
</HARD-GATE>

## Cú pháp

```
/tk:xia <github-url|owner/repo|local-path> [feature-description] [--compare|--copy|--improve|--port] [--auto|--fast]
```

Ví dụ:
```
/tk:xia ~/Downloads/cool-project                              # liệt kê features
/tk:xia ~/Downloads/cool-project "login form Google OAuth"    # extract thẳng
/tk:xia owner/repo "toast system" --compare                   # so sánh trước
/tk:xia https://github.com/org/app "billing flow" --port      # port idiomatic
```

## Mode auto-detect

| Input | Mode | Hành vi |
|-------|------|---------|
| Path + mô tả feature | **Extract thẳng** | Search trong source → extract đúng feature đó |
| Path không kèm mô tả | **List & pick** | Scan source → liệt kê 5-15 features → user chọn |
| Path là 1 file cụ thể | **File mode** | Đọc + adapt file đó |

## Quy trình legacy/local nhanh

Nếu cần workflow đầy đủ với Recon → Map → Analyze → Challenge → Plan → Deliver, dùng skill `xia` trong `components/techla/skills/xia/SKILL.md`.

## Quy trình 6 bước

### Bước 1: Kiểm tra source path

- Validate path tồn tại (`ls`, Read)
- Nếu là file → File mode
- Nếu là folder → tiếp tục
- Check nhanh `.env`, `secrets/`, `credentials.json` → CẢNH BÁO nếu có, skip những file đó

Nếu path không tồn tại:
```
❌ Không thấy path: <path>
→ Kiểm tra lại đường dẫn?
```

### Bước 2: Scan source

Với folder:
- Đọc `README.md`, `package.json`, `pyproject.toml` để hiểu source là project gì
- Glob: `*.tsx`, `*.ts`, `*.py`, `*.js`, `*.vue` → đếm file mỗi loại
- Glob structure: src/, app/, components/, features/

**Identify candidates**: tìm folder/file có vẻ là 1 feature độc lập:
- `components/Modal/`, `features/auth/`, `routes/login.tsx`
- Khoanh vùng 5-15 ứng cử viên

### Bước 3: Mode branching

#### Nếu Extract thẳng (có mô tả feature):

- Grep source theo keyword từ mô tả ("login", "OAuth", "form")
- Tìm files match
- Nếu nhiều match → hỏi user pick file/folder cụ thể
- Nếu 0 match → báo "Không thấy feature này trong source. Mô tả lại?"

#### Nếu List & pick (không có mô tả):

Hiển thị danh sách dạng:
```
📦 Tìm thấy các feature trong <source>:

1. **Authentication** (`src/features/auth/`)
   - Email/password login
   - Google OAuth integration
   - 4 files, ~300 dòng

2. **Modal system** (`src/components/Modal/`)
   - Reusable modal với animation
   - 2 files, ~80 dòng

3. **Toast notifications** (`src/lib/toast.ts`)
   - Singleton toast manager
   - 1 file, ~50 dòng

...

📍 User pick: gõ số (1, 2, 3) hoặc tên feature cần lấy.
```

DỪNG ở đây, chờ user confirm.

### Bước 4: Đọc project hiện tại

Trước khi adapt code, đọc:
- `package.json` / `pyproject.toml` → version framework, dependency hiện có
- `tsconfig.json` / `.eslintrc` → strict mode? path alias?
- 1-2 file existing tương tự (vd: nếu lấy component → đọc 1 component có sẵn)

Note xuống:
- **Naming**: camelCase / snake_case / kebab-case
- **Import style**: relative / alias / absolute
- **Framework version**: React 18 vs 19, Vue 2 vs 3
- **Structure**: `src/components/` hay `app/`?

### Bước 5: Extract + Adapt

Cho mỗi file lấy:

1. **Đọc nguyên gốc** từ source
2. **Adapt**:
   - Đổi naming convention cho khớp project hiện tại
   - Sửa import path (alias, relative)
   - Replace dependency nếu project hiện tại dùng version khác
   - Bỏ comments / TODO không liên quan
   - Thêm comment tiếng Việt giải thích "lấy từ X, adapt cho Y"
3. **Ghi file mới** ở vị trí phù hợp project hiện tại
4. **Skip overwrite**: nếu file đích đã tồn tại → hỏi user

### Bước 6: Báo cáo

```markdown
## ✅ Đã lấy feature: [Tên]

**Nguồn**: `<source-path>` (project: <project-name>)

**Files đã tạo**:
- `src/features/auth/login.tsx` (mới, ~120 dòng)
- `src/features/auth/oauth.ts` (mới, ~60 dòng)

**Adapt đã làm**:
- Đổi `useUser` → `useAuth` (khớp convention hiện tại)
- Đổi import từ `@/lib/api` → `~/services/api` (alias project)
- Update React 18 → 19 syntax (bỏ defaultProps)

**Dependency cần thêm**:
- `npm install @google-cloud/oauth2 zod`
- ENV: `GOOGLE_CLIENT_ID`, `GOOGLE_CLIENT_SECRET`

**Đề xuất tiếp theo**:
- Chạy test: `npm test src/features/auth`
- Hoặc gõ `/tk:test` để Claude verify
- Hoặc gõ `/tk:fix` nếu có lỗi compile
```

## Nguyên tắc

- **Đọc convention TRƯỚC khi viết code mới** — non-negotiable
- **Hỏi confirm** khi: file đích đã tồn tại, dependency thêm > 3 package, scope > 5 file
- **Không lấy bí mật**: `.env`, `*.key`, `secrets/`, `credentials*` → auto-skip
- **Tôn trọng license**: nếu source có LICENSE, note vào báo cáo (vd: MIT/Apache - cần attribution)
- **YAGNI**: chỉ lấy đúng feature user yêu cầu, không "tiện thể" lấy thêm

## Anti-pattern (TRÁNH)

- ❌ Copy file y nguyên không adapt → naming/import lệch chuẩn
- ❌ Overwrite file hiện có không hỏi → mất code user
- ❌ Lấy 1 file nhưng feature thật ra cần 5 file → broken
- ❌ Không báo cáo dependency cần thêm → npm install lỗi
- ❌ Copy `.env` / credentials → leak bí mật của project gốc

## Ví dụ hoàn chỉnh

### Case 1: List & pick

```
USER: /tk:xia ~/Downloads/friend-startup

CLAUDE:
🔍 **Scan source**: Next.js 14 project, TypeScript

📦 **5 feature ứng viên**:

1. **Auth + OAuth** (`app/(auth)/`)
   Email + Google + GitHub OAuth, 6 files

2. **Dashboard layout** (`app/dashboard/layout.tsx`)
   Sidebar + topbar + dark mode toggle, 3 files

3. **Stripe billing** (`app/api/billing/` + `lib/stripe.ts`)
   Subscription + webhook, 4 files

4. **Email service** (`lib/email/`)
   Resend wrapper, templates React Email, 5 files

5. **Database schema** (`prisma/schema.prisma`)
   User, Subscription, Project models

📍 Em muốn lấy cái nào? Gõ số.

USER: 4

CLAUDE: [Bước 4-5: đọc project hiện tại, adapt code]
        ✅ Đã lấy Email service. 5 files mới...
        Cần install: resend @react-email/render
        ENV cần: RESEND_API_KEY
```

### Case 2: Extract thẳng

```
USER: /tk:xia ~/Downloads/cool-app "modal có animation"

CLAUDE:
🔍 **Tìm thấy match**: `src/components/Modal/` (3 files)
   - Modal.tsx (main component)
   - Modal.module.css (animation styles)
   - useModal.ts (hook)

📖 **Đọc project hiện tại**:
   - Convention: components ở `app/components/`, không có `.module.css` (dùng Tailwind)

🔧 **Adapt**:
   - Convert CSS module → Tailwind classes
   - Update path: `app/components/Modal/`

✅ Đã lấy xong. 3 files mới + hướng dẫn dùng trong báo cáo.
```
