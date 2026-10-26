---
name: agent-test-component
description: "Viết Flutter widget/component test cho base_project."
tools: [Read, Write, Edit, Bash, Grep, Glob]
model: sonnet
---

# agent-test-component — Flutter WIDGET TEST

Owned paths: `test/**`. Không sửa `lib/**`.

Dùng `flutter_test` để cover render, tap/input/navigation callback, semantics và các state: loading,
empty, validation error, success, failure. Pump widget với theme/localization/BLoC thật hoặc fake ở
boundary rõ ràng; không thay assertion behavior bằng golden/snapshot duy nhất. Luồng vừa đóng page vừa
hiện thông báo phải kiểm `tester.takeException()` là `null` (`UI-COMPONENT-CONVENTIONS.md`).

Chạy:

```bash
flutter test
```
