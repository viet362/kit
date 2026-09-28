---
description: Sửa bug / error / test fail / lint / UI bug có hệ thống. Quy trình 5 bước Scout → Diagnose → Fix → Verify → Prevent. KHÔNG đoán mò, KHÔNG band-aid.
argument-hint: [mô tả lỗi / paste error / file path]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, AskUserQuestion
---

# /tk:fix - Sửa lỗi có hệ thống

<HARD-GATE>
TUYỆT ĐỐI KHÔNG được:
- Đề xuất fix khi CHƯA hoàn thành Bước 1-2 (Scout + Diagnose)
- Sửa symptom thay vì root cause
- Đoán mò "có lẽ là X, thử fix xem"
- Tự thử fix 3+ lần liên tiếp khi đều fail → DỪNG, đặt câu hỏi về architecture
- Bypass test/validation chỉ để "code chạy"
- Comment out test fail để build pass

CHỈ được fix sau khi đã:
- Xác định ROOT CAUSE (không phải symptom)
- Có giải thích vì sao bug xảy ra
- Hiểu blast radius (fix có ảnh hưởng phần nào khác?)

Override duy nhất: nếu user nói "trivial" hoặc lỗi quá rõ (vd: thiếu dấu `;`),
có thể skip diagnosis sâu — nhưng VẪN PHẢI giải thích nguyên nhân.
</HARD-GATE>

## Cú pháp

```
/tk:fix [mô tả lỗi / error message / file path]
```

## Anti-Rationalization (Tự kiểm trước khi fix)

| Suy nghĩ | Sự thật |
|----------|---------|
| "Em thấy lỗi rồi, fix luôn" | Thấy symptom ≠ hiểu root cause. Scout trước. |
| "Fix tạm thời, sau quay lại" | "Sau" không bao giờ đến. Fix đúng ngay từ đầu. |
| "Thử đổi X xem" | Đổi đại = waste time + sinh bug mới. Diagnose trước. |
| "Chắc do X" | "Chắc" = đoán. Verify bằng evidence. |
| "Fix thêm 1 lần nữa thôi" (sau 2 lần fail) | 3 lần fail = approach sai. Quay lại đặt câu hỏi. |
| "Gấp lắm, không có thời gian theo quy trình" | Diagnose có hệ thống NHANH HƠN đoán-rồi-thử. |
| "Em biết codebase rồi mà" | Kiến thức decay. Scout verify lại trước khi action. |
| "Test pass rồi, fix xong" | Không có prevention → cùng class bug sẽ tái xuất. |

## Quy trình 5 bước (BẮT BUỘC)

### Bước 1: Scout — Hiểu context

Trước khi nghĩ giải pháp:
- Đọc nguyên văn error message / log / stack trace
- Đọc file gây lỗi (Read tool) — ít nhất phần liên quan
- Glob/Grep tìm các call site của hàm/biến liên quan
- Xác định **scope**: bug ở 1 file? nhiều file? cross-module?

**Output Scout**: 3-5 dòng tóm tắt context.

### Bước 2: Diagnose — Tìm root cause

KHÔNG nhảy thẳng đến giải pháp. Trả lời các câu hỏi:

1. **Symptom là gì?** (exception / sai output / crash / silent failure)
2. **Trigger là gì?** (input nào? môi trường nào? timing?)
3. **Nguyên nhân TRỰC TIẾP?** (dòng nào, biến nào, hàm nào)
4. **Nguyên nhân SÂU XA?** (vì sao code lại như vậy? design flaw? missing validation? wrong assumption?)
5. **Vì sao chưa bị bắt sớm?** (test thiếu? validation gap? race condition?)

Đưa ra **2-3 giả thuyết** sắp xếp theo khả năng, kèm cách verify mỗi giả thuyết.

### Bước 3: Phân loại độ phức tạp + chọn workflow

| Mức | Đặc điểm | Workflow |
|-----|----------|----------|
| **Trivial** | Typo, thiếu dấu, sai import 1 dòng | Fix thẳng + giải thích |
| **Simple** | Bug 1 file, root cause rõ | Scout → Diagnose → Fix → Test |
| **Moderate** | Bug 2-3 file, cần refactor nhỏ | + Update test, kiểm side effect |
| **Complex** | Cross-module, design flaw | Đề xuất `/tk:plan` trước khi fix |

Nếu **Complex** → dừng `/tk:fix`, gợi ý:
```
🚨 Bug này có scope rộng (cross-module / design issue).
Đề xuất: /tk:plan để lập kế hoạch refactor có hệ thống thay vì patch.
```

### Bước 4: Fix

Fix tối thiểu:
- **Chỉ sửa cái cần sửa** (surgical). KHÔNG refactor "tiện thể".
- **Comment giải thích** nếu fix có vẻ không rõ ràng
- **Cập nhật test** nếu fix làm thay đổi behavior
- **KHÔNG xóa code dead** không liên quan đến fix này

### Bước 5: Verify + Prevent

Sau khi fix:

**Verify**:
- Chạy test liên quan (Bash: `pytest tests/test_xxx.py`, `npm test`...)
- Tái hiện scenario bug → confirm không còn lỗi
- Nếu có test cũ liên quan → confirm vẫn pass

**Prevent**:
- Có cần thêm test case để bug class này không tái xuất?
- Có cần input validation ở boundary?
- Có cần update docs / type hint?

### Bước 6: Báo cáo

```markdown
## ✅ Fixed: [Mô tả ngắn lỗi]

**Root cause**: [1 câu]

**Files changed**:
- `path/to/file.py` (+N -M dòng)

**Verification**:
- Tests pass: pytest xxx ✅
- Manual repro: không còn reproduce ✅

**Prevention added**:
- [Test case mới / validation / docs nếu có]

**Liên quan**:
- [Bug class tương tự có thể có ở đâu? File nào nên review thêm?]
```

## Các pattern lỗi thường gặp

### Python
- `IndentationError` → kiểm tra mix tab/space, indent không đều
- `NameError` → biến chưa định nghĩa hoặc scope sai
- `TypeError` → loại dữ liệu không khớp (vd: cộng str + int)
- `IndexError` → index vượt độ dài list
- `KeyError` → key không có trong dict
- `AttributeError` → đối tượng None hoặc thiếu method

### JavaScript / TypeScript
- `Cannot read property 'X' of undefined` → đối tượng chưa khởi tạo / async chưa await
- `is not a function` → gọi sai tên / import sai
- `Unexpected token` → syntax (thiếu dấu, sai ngoặc)
- TS errors (TS2322, TS2345...) → type mismatch

### Common pitfalls
- **Off-by-one**: `<` vs `<=`, index từ 0 vs 1
- **Race condition**: async không await đúng
- **Mutation**: vô tình thay đổi shared state
- **Edge case**: rỗng, null, undefined, số âm, unicode

## Khi nào KHÔNG dùng /tk:fix?

- **Build feature mới** → dùng `/tk:brainstorm` → `/tk:plan` → `/tk:implement`
- **Refactor lớn không vì bug** → dùng `/tk:plan`
- **Performance optimization** không phải bug → dùng `/tk:improve`

## Ví dụ hoàn chỉnh

```
USER: /tk:fix
TypeError: 'NoneType' object is not subscriptable
File "user_service.py", line 47, in get_user_email
    return user['email']

CLAUDE:
🔍 **Bước 1 - Scout**:
[Read user_service.py]
- Hàm get_user_email(user_id) → query DB → return user['email']
- Caller: 3 chỗ (handlers/login.py, jobs/email_blast.py, tests/test_user.py)

🩺 **Bước 2 - Diagnose**:

Symptom: `user` là None khi truy cập `user['email']`.

Trigger: user_id không tồn tại trong DB.

Giả thuyết:
1. **(Khả năng cao)** Query trả về None khi không tìm thấy, code không handle case này.
2. (Khả năng vừa) DB connection timeout → trả về None.

Verify: đọc dòng query → confirm hypothesis 1.

Root cause sâu: hàm không tuân design "fail loudly" — silent None thay vì raise.
Chưa bị bắt sớm vì test chỉ test happy path, thiếu test case "user not found".

📋 **Bước 3**: Simple (1 file, root cause rõ).

🔧 **Bước 4 - Fix**:
[Edit user_service.py]
- Thêm check `if user is None: raise UserNotFoundError(user_id)`
- Cập nhật signature với raises clause

✅ **Bước 5 - Verify**:
- pytest tests/test_user_service.py → pass
- Thêm test case test_get_user_email_not_found → pass
- Manual: gọi với user_id không tồn tại → raise đúng UserNotFoundError

🛡️ **Prevention**: Thêm pre-commit hook check tất cả DB query có None handling.
```
