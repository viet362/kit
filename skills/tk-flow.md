# tk-flow

Source: Claude skill
Original path: `components/techla/skills/tk-flow/SKILL.md`
Description: Áp dụng workflow Techla brainstorm → plan → implement. Tự động gợi ý bước tiếp theo sau khi hoàn thành mỗi giai đoạn. Kích hoạt khi học viên dùng /tk:brainstorm, /tk:plan, /tk:implement hoặc khi vừa thống nhất requirements.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Techla Flow - Workflow brainstorm → plan → implement

Skill này định hình cách Claude điều phối 3 giai đoạn phát triển: brainstorm (khám phá), plan (kế hoạch), implement (thực thi).

## Triết lý

Học viên thường bỏ qua bước plan, nhảy thẳng từ ý tưởng sang code. Kết quả: code lan man, refactor liên tục, không có Definition of Done. Flow này ép có check-point giữa các bước.

## Khi nào kích hoạt

- Học viên dùng `/tk:brainstorm`, `/tk:plan`, hoặc `/tk:implement`
- Học viên vừa thống nhất requirements với Claude
- Học viên vừa hoàn thành 1 phase trong plan
- Học viên paste ý tưởng dự án và hỏi "làm thế nào"

## 3 giai đoạn

### Giai đoạn 1: Brainstorm (khám phá)

**Mục đích**: Biến ý tưởng mơ hồ thành requirements rõ ràng.

**Trigger**: Học viên gõ `/tk:brainstorm` HOẶC nói "tôi muốn làm X nhưng chưa biết bắt đầu từ đâu".

**Hoạt động**: SuperClaude Brainstorming mode tự xử lý (Socratic dialogue, đặt câu hỏi mở).

**Output**: Brief tóm tắt requirements thống nhất.

**Khi nào XONG**:
- Đã thống nhất mục tiêu cuối
- Đã thống nhất scope (in/out)
- Đã thống nhất ràng buộc (tech stack, deadline)

**Khi xong, Claude PHẢI nói**:
```
✅ Brief đã sẵn sàng.

**Tóm tắt requirements**:
- Mục tiêu: ...
- Scope: ...
- Tech: ...

📍 **Bước tiếp theo**: Bạn muốn tôi tạo implementation plan không?
→ Gõ `/tk:plan` để chuyển sang lập kế hoạch
→ Hoặc tiếp tục brainstorm nếu cần làm rõ thêm
```

### Giai đoạn 2: Plan (kế hoạch)

**Mục đích**: Biến requirements thành các phase + task verifiable.

**Trigger**: Học viên gõ `/tk:plan`.

**Hoạt động**: Xem command file `/tk:plan` để biết chi tiết. Tạo `plans/{date}-{slug}/` với plan.md + phase-XX-*.md.

**Output**: Folder plan + summary trong chat.

**Khi xong, Claude PHẢI nói**:
```
📋 Plan đã sẵn sàng tại plans/{path}/

**4 phases**:
1. ⏸️ Setup ...
2. ⏸️ Core ...
3. ⏸️ Test ...
4. ⏸️ Polish ...

📍 **Bước tiếp theo**: Bắt đầu Phase 1?
→ Gõ `/tk:implement phase-01` để Claude thực thi
→ Hoặc điều chỉnh plan trước
→ Hoặc xem chi tiết phase: `cat plans/{path}/phase-01-*.md`
```

### Giai đoạn 3: Implement (thực thi)

**Mục đích**: Code theo plan, từng phase, có check-point.

**Trigger**: Học viên gõ `/tk:implement` HOẶC `/tk:implement phase-XX`.

**Hoạt động**: SuperClaude `/tk:implement` tự xử lý. Áp dụng skill code-quality (karpathy-coder, viet-coding-style nếu có).

**Quy tắc khi implement**:
- Làm 1 phase đến **xong hoàn toàn** trước khi chuyển phase tiếp theo
- Sau mỗi phase: chạy test + verify Definition of Done
- Update status trong plan.md: `⏸️ Chưa bắt đầu` → `🔄 Đang làm` → `✅ Xong`

**Khi xong 1 phase, Claude PHẢI nói**:
```
✅ Phase XX hoàn thành.

**Đã làm**:
- Files tạo: ...
- Files sửa: ...
- Tests: pass / fail

**Definition of Done**:
- [x] Tiêu chí 1
- [x] Tiêu chí 2
- [x] Tests pass

📍 **Bước tiếp theo**: Bắt đầu Phase {XX+1}?
→ Gõ `/tk:implement phase-{XX+1}` để tiếp tục
→ Hoặc review code đã làm: `/karpathy-check`
→ Hoặc commit: `/tk:git "feat: {phase XX summary}"`
```

**Khi xong toàn bộ plan**:
```
🎉 Toàn bộ plan đã hoàn thành!

**Tổng kết**:
- 4 phases xong
- N files tạo
- M tests pass

📍 **Bước tiếp theo**:
→ `/tk:reflect` để rút kinh nghiệm
→ `/tk:git` để commit + tạo PR
→ `/karpathy-check` để review tổng thể
```

## Nguyên tắc

### Không skip bước

- **Không nhảy thẳng** từ brainstorm sang implement (bỏ qua plan)
- **Không plan** mà chưa brainstorm đủ (sẽ thiếu info)
- **Không implement** mà không có plan (sẽ lan man)

### Cho phép quay lại

Nếu trong khi implement phát hiện vấn đề → có thể quay lại plan:
- Update plan.md với insight mới
- Note risk/blocker vào plan
- Có thể split 1 phase thành nhiều phase nhỏ hơn

### Không tự ý chain

Sau mỗi bước, Claude PHẢI hỏi confirm trước khi chuyển bước tiếp theo. KHÔNG tự động:
- Brainstorm xong → tự gọi plan
- Plan xong → tự gọi implement

Lý do: học viên cần có cơ hội điều chỉnh giữa các bước.

### Ngôn ngữ

- Hướng dẫn cho học viên: tiếng Việt
- Files (plan.md, code): tiếng Việt cho comments, tiếng Anh cho code identifiers

## Anti-pattern (TRÁNH)

- ❌ Claude tự chạy cả 3 bước mà không hỏi user
- ❌ Plan có quá nhiều phase (>7) hoặc quá ít (<3)
- ❌ Definition of Done mơ hồ ("code chạy được", "OK")
- ❌ Implement không update status trong plan.md
- ❌ Mark phase "xong" khi tests fail hoặc chưa verify

## Ví dụ hoàn chỉnh

```
USER: /tk:brainstorm Em muốn xây bot Discord nhắc nộp bài tập

CLAUDE: [Brainstorming mode]
        🤔 Để hiểu rõ hơn:
        - Bot này dành cho server nào? Lớp em hay chung?
        - Nhắc kiểu gì - ping tag mọi người hay DM riêng?
        - Lưu danh sách bài tập ở đâu?
        ...
        ✅ Brief đã sẵn sàng:
        - Mục tiêu: Bot Discord ping nhắc deadline bài tập 1 ngày trước
        - Tech: Python + discord.py + SQLite
        - Scope: chỉ 1 server, owner add bài tập qua slash command

        📍 Tạo plan tiếp? Gõ /tk:plan

USER: /tk:plan

CLAUDE: [Tạo plans/260518-1735-discord-homework-bot/]
        📋 Plan đã tạo với 4 phases:
        1. Setup bot + connect Discord
        2. Slash command thêm bài tập + SQLite
        3. Scheduler ping 1 ngày trước deadline
        4. Test + deploy

        📍 Bắt đầu Phase 1? Gõ /tk:implement phase-01

USER: /tk:implement phase-01

CLAUDE: [Thực thi phase 1]
        ✅ Phase 1 xong:
        - bot.py created
        - .env config done
        - Test connect: pass

        📍 Tiếp Phase 2? /tk:implement phase-02
```

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
