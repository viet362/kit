---
description: Khám phá ý tưởng & thống nhất requirements qua Socratic dialogue. Bước 1 trong flow Techla. KẾT THÚC BẰNG /tk:plan, KHÔNG nhảy thẳng implement.
argument-hint: [ý tưởng / vấn đề / câu hỏi]
allowed-tools: Read, Glob, Grep, WebSearch, AskUserQuestion
---

# /tk:brainstorm - Khám phá requirements

<HARD-GATE>
TUYỆT ĐỐI KHÔNG được:
- Viết code mẫu / scaffold project / chạy implement skill nào
- Đề xuất tech stack cụ thể NGAY khi user vừa nói ý tưởng
- Gọi /tk:implement, /tk:build, /tk:design hay bất kỳ skill triển khai nào
- Tự ý chuyển bước sang plan/implement mà user chưa confirm

CHỈ được làm các việc sau trong /tk:brainstorm:
- Hỏi câu hỏi bằng AskUserQuestion tool (Socratic dialogue)
- Đọc file (Read, Glob, Grep) để hiểu context HIỆN HỮU
- Web search nếu cần verify giải pháp đã có
- Cuối session: tổng hợp Brief Requirements
- Sau Brief: BẮT BUỘC gợi ý "/tk:plan" làm bước tiếp theo

Quy tắc áp dụng cho MỌI session brainstorm, kể cả task có vẻ đơn giản.
</HARD-GATE>

## Vị trí trong flow Techla

```
[/tk:brainstorm]  →  /tk:plan  →  /tk:implement
   (khám phá)        (kế hoạch)       (thực thi)
```

## Cú pháp

```
/tk:brainstorm [ý tưởng / vấn đề]
```

## Quy trình BẮT BUỘC

### Bước 1: Kích hoạt mindset brainstorming

- KHÔNG đưa giải pháp ngay
- KHÔNG khoe kiến thức tech
- KHÔNG tự assume requirements
- Mục tiêu: HIỂU sâu, không phải GIẢI quyết

### Bước 2: Hỏi qua 4 chiều (Socratic dialogue)

Dùng `AskUserQuestion` tool để hỏi. Mỗi lượt 1-3 câu, KHÔNG overload:

**Why (Mục đích)**:
- Vấn đề gì? Của ai?
- Tại sao cần giải pháp này thay vì cách hiện tại?
- Thành công trông như thế nào?

**Who (Người dùng)**:
- Ai dùng? Bao nhiêu người?
- Họ làm gì trước/sau khi dùng?
- Họ kỳ vọng gì?

**What (Phạm vi)**:
- Phải có (must)?
- Nên có (nice)?
- Rõ ràng KHÔNG cần làm?

**How (Ràng buộc)**:
- Tech stack có sẵn / bắt buộc?
- Deadline?
- Budget (token/server/người)?
- Trình độ team / user?

### Bước 3: Đọc context nếu có

Trước khi hỏi tech-related, đọc:
- README của repo hiện tại (nếu có)
- package.json / requirements.txt / pyproject.toml
- File config liên quan

→ Tránh hỏi cái user đã có sẵn.

### Bước 4: Anti-Rationalization (Tự kiểm)

Trước khi nghĩ "đủ thông tin rồi, code thôi", check bảng:

| Suy nghĩ | Sự thật |
|----------|---------|
| "Task đơn giản, không cần brief" | Task đơn giản = nơi giả định sai gây tốn nhiều thời gian nhất |
| "Mình biết user muốn gì rồi" | Vậy viết brief mất 30 giây. Làm đi. |
| "User muốn action chứ không nói nhiều" | Code sai tốn thời gian hơn brainstorm |
| "Để khám phá codebase trước" | Brainstorm xong mới biết khám phá CÁI GÌ |
| "Prototype nhanh cho rồi" | Prototype thường biến thành production. Design trước. |

### Bước 5: Tổng hợp Brief Requirements

Khi đủ thông tin 4 chiều, viết:

```markdown
## ✅ Brief Requirements

**Vấn đề & Mục tiêu**:
- ...

**Người dùng chính**:
- ...

**Scope - PHẢI làm**:
- ...

**Scope - KHÔNG làm (giai đoạn này)**:
- ...

**Tech stack**:
- ...

**Ràng buộc**:
- ...

**Rủi ro lớn nhất**:
- ...
```

### Bước 6: Kết thúc (BẮT BUỘC format này)

```
📍 **Bước tiếp theo**: Bạn muốn tôi tạo implementation plan không?

→ Gõ `/tk:plan` để chuyển sang lập kế hoạch
   (sẽ tạo plans/{date}-{slug}/ với 3-7 phases, mỗi phase có DoD)
→ Hoặc tiếp tục brainstorm nếu cần làm rõ thêm điểm nào
→ Hoặc lưu brief để plan sau
```

DỪNG TẠI ĐÂY. KHÔNG được tự gọi `/tk:plan`. PHẢI chờ user.

## Khi nào skip brainstorm?

Chỉ skip khi:
- Task quá nhỏ (vd: "fix typo dòng 42")
- Requirements quá rõ (vd: "implement hàm sort theo spec X")
- Bug fix có reproducer rõ ràng

→ Trong trường hợp này, đề xuất user dùng:
- `/tk:implement` (cho task nhỏ rõ ràng)
- `/tk:troubleshoot` (cho debug)

## Anti-pattern (TUYỆT ĐỐI TRÁNH)

- ❌ "Để mình thử implement ngay xem sao"
- ❌ "Dùng [tech stack] là phù hợp đó" (chưa hỏi user constraints)
- ❌ "Code mẫu thế này..." (chưa có brief)
- ❌ Hỏi 10 câu một lúc → user bị overload
- ❌ Brainstorm xong tự gọi /tk:plan mà chưa hỏi

## Ví dụ hoàn chỉnh

```
USER: /tk:brainstorm Em muốn xây CLI tool quản lý todo list

CLAUDE: 🤔 Để hiểu rõ hơn, anh hỏi em vài câu:

[Dùng AskUserQuestion]
1. Em xây cho ai dùng? (Chỉ em hay nhiều người?)
2. Em đã thử dùng tool nào trước đó? Thiếu gì khiến em muốn tự xây?

USER: [trả lời]

CLAUDE: [hỏi tiếp 1-2 câu nữa về tech/scope/constraint]

...

CLAUDE: ✅ Đủ thông tin. Brief đây:

## ✅ Brief Requirements
**Vấn đề**: [...]
**Scope - PHẢI làm**: [...]
**Tech**: [...]
**Rủi ro**: [...]

---

📍 **Bước tiếp theo**: Bạn muốn tôi tạo implementation plan không?
→ Gõ `/tk:plan` để chuyển sang lập kế hoạch
→ Hoặc tiếp tục brainstorm
→ Hoặc lưu brief để plan sau

USER: /tk:plan

CLAUDE: [BÂY GIỜ MỚI bắt đầu plan]
```
