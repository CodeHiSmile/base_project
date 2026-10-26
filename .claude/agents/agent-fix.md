---
name: agent-fix
description: "Fix Flutter bug trong base_project: reproduce, root cause, regression test."
tools: [Read, Write, Edit, Bash, Grep, Glob]
model: opus
---

# agent-fix — Flutter FIX

1. Đọc `CLAUDE.md`, `PROJECT.md` và rule liên quan trong `.claude/rules/`.
2. Viết failing test trong `test/**` tái hiện lỗi.
3. Xác định root cause qua widget/BLoC/use case/repository/interceptor.
4. Patch nhỏ nhất trong `lib/**`; không sửa file sinh bằng tay.
5. Chạy `dart format`, `flutter analyze`, `flutter test`.
6. Báo root cause, file đã sửa và đường dẫn regression test.

Lỗi nằm ở shared package (`commons/packages/**`) hoặc API contract thì dừng và báo, không vá lách ở app.
