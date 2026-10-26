---
paths:
  - "lib/**/*.dart"
  - "test/**/*.dart"
  - "integration_test/**/*.dart"
---

# Kiểm tra bắt buộc sau khi sửa Dart

- Sau khi hoàn tất thay đổi, bắt buộc chạy `flutter analyze` và xử lý hết lỗi do thay đổi gây ra.
- Trước `flutter analyze`, format các file Dart đã sửa bằng formatter của project.
- Chạy test phù hợp với phạm vi thay đổi; business logic/BLoC mới phải có test khi test infrastructure
  hiện có hỗ trợ.
- Không tuyên bố hoàn thành nếu chưa báo rõ lệnh nào đã chạy, kết quả và phần chưa kiểm tra.

```bash
dart format --set-exit-if-changed .
flutter analyze
flutter test
```
