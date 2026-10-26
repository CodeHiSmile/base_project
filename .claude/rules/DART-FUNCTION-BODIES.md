---
paths:
  - "lib/**/page/**/*.dart"
  - "lib/**/pages/**/*.dart"
  - "lib/**/view/**/*.dart"
  - "lib/**/views/**/*.dart"
  - "lib/**/bloc/**/*.dart"
  - "lib/**/*_page.dart"
  - "lib/**/*_view.dart"
  - "lib/**/*_bloc.dart"
---

# Thân hàm trong page, view và BLoC

- Trong các file thuộc thư mục `page/`, `pages/`, `view/`, `views/`, `bloc/`
  và các file `*_page.dart`, `*_view.dart`, `*_bloc.dart`, luôn viết thân hàm
  bằng khối `{ ... }`; không dùng cú pháp thân hàm rút gọn `=>`.
- Áp dụng cho method, getter, hàm cục bộ và callback/closure, kể cả khi chỉ có một dòng.
- Hàm có giá trị trả về phải dùng `return` trong khối. Hàm hoặc callback `void`
  thực hiện câu lệnh trong khối, không thêm `return` trả về giá trị.
- Giữ các callback đang truyền tham chiếu hàm và quy ước handler BLoC trong
  `BLOC-CONVENTIONS.md`; không bọc thêm closure chỉ để có khối lệnh.
- Không sửa các file generated bằng tay (`*.freezed.dart`, `*.g.dart`, v.v.).
  Quy ước này áp dụng cho mã nguồn viết tay.

```dart
@override
Widget buildPageListeners({required Widget child}) {
  return BlocListener<EventOtherToyBloc, EventOtherToyState>(
    listenWhen: (previous, current) {
      return previous.result == null && current.result != null;
    },
    listener: (context, state) {
      Navigator.of(context).pop(state.result);
    },
    child: child,
  );
}
```
