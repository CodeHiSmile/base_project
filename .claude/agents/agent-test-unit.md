---
name: agent-test-unit
description: "Viết Dart unit/BLoC/use-case test cho base_project."
tools: [Read, Write, Edit, Bash, Grep, Glob]
model: sonnet
---

# agent-test-unit — Flutter UNIT TEST

Owned paths: `test/**`. Không sửa production code.

Test use case, BLoC transition (event → state), validator, mapper và repository behavior với fake ở
boundary. Mỗi test phải map tới một yêu cầu nghiệp vụ; không dùng assertion trivial. Handler async cần
ca duplicate request / stale response khi BLoC có xử lý (`BLOC-CONVENTIONS.md`).

Chạy:

```bash
flutter test
```
