# base_project — Flutter base cho các app HiSmile

> Base để fork app mới (đã fork: `smart_toy_mobile`). Đọc [`PROJECT.md`](PROJECT.md) trước khi sinh/sửa
> code; rule chi tiết theo đường dẫn nằm ở `.claude/rules/` (tự nạp khi sửa file khớp `paths`).

## Identity

| Field | Value |
|---|---|
| Kind | mobile app base / template |
| Platform | mobile (Android, iOS) |
| Stack | Flutter + Dart, BLoC, GetIt/injectable, freezed |
| Shared packages | `../commons/packages/{shared,domain,data,base_ui,router,alice,alice_dio}` |

## Layout và quyền sở hữu

- `lib/**`: Flutter/Dart code của app.
- `test/**`: unit, BLoC và widget tests.
- `bricks/**`: mason brick + `bricks/shell_scripts/*.sh` để tạo màn/feature.
- `android/**`, `ios/**`: chỉ sửa khi yêu cầu cần platform configuration.
- `../commons/packages/**`: dùng chung nhiều app — không sửa từ repo này nếu task không yêu cầu rõ.
- File sinh (`*.g.dart`, `*.freezed.dart`, `lib/di/di.config.dart`, `lib/generated/**`): không sửa tay.

## Architecture invariants

- Presentation dùng BLoC; business rule nằm trong use case/domain, không đặt trong widget. BLoC không navigate.
- Data access qua repository interface; endpoint chỉ khai trong `AppApiService`.
- Tầng data không mở dialog/không navigate: hết phiên đi qua `SessionExpiredHandler` (`lib/data/api/session/`)
  do `lib/app/session/AppSessionExpiredHandler` implement.
- Màu qua `AppColors` (`lib/app/themes/`) hoặc `context.colors`; icon trong `assets/icons/` gọi qua `MyAssets.icons` (không dùng icon trực tiếp từ `base_ui`); snackbar qua `AppSnackBar`.
- Chuỗi hiển thị qua localization; accessibility hỗ trợ VoiceOver/TalkBack (Semantics cho control custom).
- Trong các file UI (`lib/presentation/**` và `test/presentation/**`), dùng `.toList()` và không truyền `growable: false`.
- Page không quá 400 dòng dùng helper method; page trên 400 dòng phải tách widget con vào thư mục `widgets/` của màn.
- Widget dùng từ 2 màn trở lên phải có file riêng dưới `lib/presentation/widgets/`.
- Enum extension phải nằm trong file định nghĩa enum.

## Commands

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter run -t lib/main/main_dev.dart        # main_stg.dart / main_prod.dart
```

Trước khi handoff: format, analyze và test phải xanh (`.claude/rules/VERIFICATION.md`).

Dùng thử app bằng agent: bản debug có Marionette (`PROJECT.md` mục *PDF và Marionette*).

## Workflow

1. Đọc `PROJECT.md` và rule liên quan trong `.claude/rules/`.
2. Lập kế hoạch nhỏ theo yêu cầu; quyết định kỹ thuật không hiển nhiên thì ghi rõ trong báo cáo.
3. Implement trong `lib/**` cùng test tương ứng; màn mới tạo bằng mason brick.
4. Chạy build_runner (nếu đổi model/DI/freezed) rồi toàn bộ command gate.
5. Không commit/push khi chưa được yêu cầu.

Subagent sẵn có: `.claude/agents/agent-{dev,fix,review,test-unit,test-component,test-contract}.md`,
gọi qua `/spawn-<tên>`.
