# SKILL.md — Flutter/Dart shared rules

Trước khi làm việc, đọc `PROJECT.md` ở root repo. Khi có khác biệt, ưu tiên convention của project.

## 1. Safety và phạm vi

1. Không commit hoặc push nếu user chưa yêu cầu rõ.
2. Không sửa generated file, dependency lockfile hoặc cấu hình native ngoài scope.
3. Đọc code liên quan và convention hiện có trước khi sửa.
4. Giữ scope tối thiểu; không refactor phần không liên quan.
5. Requirement thiếu thông tin có thể thay đổi hành vi, dữ liệu hoặc kiến trúc → hỏi trước.
6. Khi có nhiều hướng xử lý, nêu lợi ích, thiệt hại, rủi ro và phạm vi ảnh hưởng.

## 2. Workflow

### Hiểu yêu cầu

- Xác định mục tiêu, acceptance criteria và hành vi không được thay đổi.
- Đọc page/widget, state management, model, service/repository và test liên quan.
- Kiểm tra convention project trước khi chọn kiến trúc hoặc package.

### Plan tương xứng

- Task nhỏ, rõ ràng, ảnh hưởng 1–2 file → plan ngắn trong chat và triển khai.
- Task nhiều file, có migration, tradeoff hoặc rủi ro → trình bày plan và chờ xác nhận.
- Chỉ tạo file plan khi user yêu cầu hoặc plan cần team theo dõi lâu dài.
- Khi tạo file mới, nêu path và trách nhiệm dự kiến.

### Implement

- Bám pattern đang có trong cùng feature.
- Tránh duplicate logic và abstraction chưa cần thiết.
- Không thay đổi public API nếu không cần.
- Side effect như navigation, dialog và snackbar nằm tại presentation layer.

### Verify

Chọn lệnh phù hợp với scope và project:

```bash
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

- Với task nhỏ, có thể chạy analyze/test theo target trước rồi chạy toàn project khi rủi ro yêu cầu.
- Nếu thay đổi source sinh code, chạy codegen của project rồi verify lại.
- Nếu repo có lỗi tồn đọng, phân biệt lỗi có sẵn với lỗi do thay đổi mới.
- Không tuyên bố hoàn thành nếu chưa báo rõ phần chưa verify.

## 3. Architecture

- Tôn trọng architecture và dependency direction của project.
- Widget chỉ render UI, nhận input và phát intent; không gọi network trực tiếp.
- Business rule không nằm trong widget hoặc API model.
- Dependency được inject theo cơ chế của project; không tự khởi tạo repository/service trong widget.
- Không để presentation phụ thuộc raw response hoặc generated client type nếu project có domain boundary.
- Chỉ tạo layer, UseCase, Repository hoặc abstraction khi project sử dụng hoặc khi có giá trị rõ ràng.

## 4. State management

- Dùng BLoC, Cubit, Riverpod, Provider hoặc cơ chế khác theo convention project; không tự đưa thêm hệ state management song song.
- Business/shared/async state thuộc state-management layer.
- Không đẩy UI state ngắn hạn vào global/business state nếu không cần chia sẻ hoặc kiểm thử nghiệp vụ.
- State phải immutable hoặc được quản lý theo pattern an toàn của framework.
- Async state phải biểu diễn rõ loading, success, empty và error khi các trạng thái đó có ý nghĩa.

## 5. Dart type safety và model

- Nullability phản ánh đúng contract và nghiệp vụ.
- Field bắt buộc dùng non-nullable và `required`.
- Không làm mọi field nullable để tránh validation.
- Không dùng `dynamic` khi có thể mô hình hóa type rõ ràng.
- Không dùng `Map<String, dynamic>` xuyên nhiều layer nếu typed model phù hợp hơn.
- Không dùng `null` để đại diện chung cho lỗi.
- Một file nên có một public class chính; private helper nhỏ có thể đặt cùng file.
- File/folder dùng `snake_case`, type dùng `PascalCase`, member dùng `camelCase`.

## 6. Async và error handling

- Không nuốt exception hoặc chuyển mọi lỗi thành `null`.
- Dùng error model, exception hoặc `Result`/`Failure` theo convention project.
- Xem xét duplicate request, cancellation, debounce/throttle và stale response.
- Với `Completer`, kiểm tra `isCompleted` trước khi complete.
- Dispose controller, stream, timer, listener và animation đúng lifecycle.
- Không giữ `BuildContext` qua async gap nếu widget có thể unmount; kiểm tra `mounted` khi cần.

## 7. UI quality

- Tái sử dụng design token, theme và component hiện có.
- Dùng `const` khi là compile-time constant.
- Không hardcode user-facing string khi project có localization.
- Tách widget theo responsibility, khả năng tái sử dụng và nhu cầu kiểm thử; không chỉ dựa vào số dòng.
- Xem xét text scaling, semantics, contrast, touch target và keyboard/focus khi phù hợp.
- Không hardcode kích thước hoặc typography làm vỡ responsive layout nếu design không yêu cầu.
- Không dùng `print`/`debugPrint` trên production path; dùng logger của project.

## 8. Generated code và dependency

- Không sửa `*.g.dart`, `*.freezed.dart`, generated localization, generated API client hoặc file DI sinh tự động.
- Sửa source/annotation/schema rồi chạy generator tương ứng.
- Trước khi thêm package, kiểm tra dependency hiện có và đánh giá maintenance, license, build size, native impact.
- Không tự nâng version hàng loạt hoặc sửa dependency override ngoài scope.

## 9. Testing

- Thay đổi business logic cần unit test hoặc state-management test tương ứng khi infrastructure cho phép.
- Widget có interaction hoặc nhiều trạng thái quan trọng nên có widget test.
- Bug fix nên có regression test nếu có thể tái hiện ổn định.
- Test hành vi public, tránh phụ thuộc implementation detail không cần thiết.
- Không bỏ qua test chỉ vì feature cũ chưa có test.

## 10. Security

- Không log hoặc commit token, password, PII, credential hay raw response nhạy cảm.
- Không đưa secret vào source, fixtures hoặc file cấu hình được commit.
- Validate dữ liệu từ API, route, deep link, storage và platform channel tại boundary phù hợp.
- Không vô hiệu hóa certificate validation, auth check hoặc security control để xử lý nhanh.

## 11. Báo cáo hoàn thành

Báo cáo ngắn gọn:

- Đã thay đổi gì và vì sao.
- Tradeoff/rủi ro đã chọn.
- Đã chạy format/analyze/test nào và kết quả.
- Phần chưa làm hoặc cần user quyết định.
- Không commit/push nếu user chưa yêu cầu.
