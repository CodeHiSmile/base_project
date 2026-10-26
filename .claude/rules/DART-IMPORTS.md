---
paths:
  - "lib/**/*.dart"
---

# Quy ước import Dart

- Mọi import nội bộ trong `lib/` phải dùng package import với đường dẫn đầy đủ từ package root,
  ví dụ `package:base_project/domain/models/entity/user/user_entity.dart`.
- Không dùng import tương đối như `foo.dart`, `./foo.dart`, `../foo.dart`,
  `../../foo.dart` hoặc `../../../foo.dart`.
- Không dùng đường dẫn tuyệt đối theo filesystem như `/Users/.../foo.dart` hoặc URI `file://...`.
- Các chỉ thị `part` và `part of` vẫn tuân theo yêu cầu của Dart và không đổi thành package URI.
- Không sửa file generated bằng tay; nếu generator tạo import thì giữ nguyên output của generator.
