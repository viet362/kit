---
description: Tạo implementation plan với file plan.md + phase-XX-*.md trong plans/. Bước thứ 2 sau /tk:brainstorm trong flow Techla.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# /tk:plan - Tạo implementation plan

## Vị trí trong flow Techla

```
/tk:brainstorm  →  /tk:plan  →  /tk:implement
   (khám phá)        (kế hoạch)       (thực thi)
```

## Cú pháp

```
/tk:plan [tên dự án / yêu cầu / link đến brainstorm output]
```

## Hành vi

### 1. Đọc context

- Nếu user vừa làm `/tk:brainstorm` xong → đọc requirements đã thống nhất từ đó
- Nếu user gõ thẳng `/tk:plan "X"` → coi như requirements là X
- Nếu thiếu thông tin → HỎI user trước khi tạo plan, không đoán

Các câu hỏi cần làm rõ trước khi plan:
- **Mục tiêu cuối**: Sản phẩm/feature phải làm được gì?
- **Phạm vi**: Có gì PHẢI làm, có gì KHÔNG cần làm trong scope này?
- **Ràng buộc**: Deadline, công nghệ bắt buộc, giới hạn?
- **Trình độ học viên**: Đây là dự án học hay sản phẩm thật?

### 2. Tạo cấu trúc file

Tạo thư mục `plans/{YYMMDD-HHMM}-{slug}/` với:

```
plans/{YYMMDD-HHMM}-{slug}/
├── plan.md                       # Overview, dưới 80 dòng
├── phase-01-{slug}.md            # Setup / Foundation
├── phase-02-{slug}.md            # Core implementation
├── phase-03-{slug}.md            # Testing
└── phase-04-{slug}.md            # Polish / Deployment
```

**slug**: kebab-case ngắn (3-5 từ), bằng tiếng Anh, mô tả core của dự án.
**YYMMDD-HHMM**: ngày giờ hiện tại theo timezone Asia/Saigon.

### 3. Format plan.md (overview)

```markdown
# Kế hoạch: [Tên dự án]

**Tạo lúc**: {ISO datetime}
**Loại**: [Dự án học / Sản phẩm thật / Bài tập]

## Mục tiêu
[1-2 câu mô tả kết quả cuối cùng]

## Phạm vi
**Trong scope**:
- ...

**Ngoài scope** (sẽ không làm trong plan này):
- ...

## Ràng buộc
- Công nghệ: [stack]
- Thời gian: [deadline / không có]
- Khác: [nếu có]

## Các phase

| # | Tên | Status | Ước tính | File |
|---|-----|--------|----------|------|
| 1 | Setup | ⏸️ Chưa bắt đầu | 1-2h | [phase-01](phase-01-setup.md) |
| 2 | Core | ⏸️ Chưa bắt đầu | 3-4h | [phase-02](phase-02-core.md) |
| 3 | Test | ⏸️ Chưa bắt đầu | 1h | [phase-03](phase-03-test.md) |
| 4 | Polish | ⏸️ Chưa bắt đầu | 1h | [phase-04](phase-04-polish.md) |

## Phụ thuộc
- Phase 2 phụ thuộc Phase 1
- Phase 3 phụ thuộc Phase 2

## Risks
- [Risk 1]: [Mitigation]
- [Risk 2]: [Mitigation]
```

### 4. Format mỗi phase file

```markdown
# Phase XX: [Tên phase]

## Mục tiêu
[Output cụ thể của phase này]

## Phụ thuộc
- Không / Phase {N}

## Files sẽ tạo/sửa
- `path/to/file1.py` (tạo mới)
- `path/to/file2.py` (sửa)

## Implementation steps
1. [Step cụ thể]
2. [Step cụ thể]
3. ...

## Todo list
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

## Definition of Done
- [ ] Tiêu chí 1 (verifiable)
- [ ] Tiêu chí 2 (verifiable)
- [ ] Tests pass

## Risks
- [Risk]: [Mitigation]
```

### 5. Output inline trong chat

Sau khi tạo file, hiển thị tóm tắt trong chat:

```
📋 **Plan đã tạo**: plans/{YYMMDD-HHMM}-{slug}/

**Mục tiêu**: [1 câu]

**4 phases**:
1. ⏸️ Setup (1-2h) - [mục đích ngắn]
2. ⏸️ Core (3-4h) - [mục đích ngắn]
3. ⏸️ Test (1h) - [mục đích ngắn]
4. ⏸️ Polish (1h) - [mục đích ngắn]

**Tổng ước tính**: 6-8h

**Risks chính**:
- [Top 1-2 risks]

---

✅ **Bước tiếp theo**: Bắt đầu Phase 1?
→ Gõ `/tk:implement phase-01` để Claude thực thi
→ Hoặc xem chi tiết: `cat plans/{YYMMDD-HHMM}-{slug}/phase-01-*.md`
→ Hoặc điều chỉnh plan trước khi bắt đầu
```

## Nguyên tắc

- **3-7 phases tối đa**. Nhiều hơn → user overwhelmed. Ít hơn → không đủ chi tiết
- **Mỗi phase có Definition of Done verifiable** (không "code chạy được" mơ hồ)
- **YAGNI**: chỉ plan cho scope đã thống nhất, không thêm "phòng hờ"
- **KISS**: phase đơn giản hơn vẫn tốt hơn phase phức tạp
- **Phải đọc** repo context trước khi plan (Glob, Grep) — không plan trong chân không
- **Ngôn ngữ**: tiếng Việt là chính, từ khóa kỹ thuật giữ tiếng Anh

## Ví dụ chain với /tk:brainstorm

```
USER: /tk:brainstorm Tôi muốn xây CLI tool quản lý todo list

CLAUDE: (chế độ brainstorming, hỏi requirements)
        ...
        ✅ Brief đã sẵn sàng. Gõ /tk:plan để chuyển sang lập kế hoạch.

USER: /tk:plan

CLAUDE: (đọc brief từ brainstorm, tạo plans/260518-1735-todo-cli/)
        📋 Plan đã tạo với 4 phases...

USER: /tk:implement phase-01

CLAUDE: (thực thi phase 1)
```
