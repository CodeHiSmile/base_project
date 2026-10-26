# base_project

flutter pub get
flutter pub run intl_utils:generate
flutter pub run build_runner build --delete-conflicting-outputs

Hướng dẫn cho người và AI agent: [CLAUDE.md](CLAUDE.md) · [PROJECT.md](PROJECT.md) · `.claude/rules/`.

## Chạy

```bash
flutter run -t lib/main/main_dev.dart     # main_stg.dart / main_prod.dart
# đổi server dev không sửa code:
flutter run -t lib/main/main_dev.dart --dart-define=API_BASE_URL=http://<host>:<port>
```

## Hành động cần đăng nhập

```dart
onTap: () async {
  final authService = GetIt.instance.get<AuthService>();
  authService.runAfterLogin(
    action: () {
      setState(() {
        isFavorite = !isFavorite;
      });
    },
  );
},
```

Chưa đăng nhập → mở màn login, đăng nhập xong mới chạy `action`; người dùng back ra thì huỷ.
