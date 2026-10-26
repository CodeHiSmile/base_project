---
paths:
  - "lib/app/themes/**/*.dart"
  - "lib/presentation/**/*.dart"
  - "lib/domain/enums/app_*.dart"
  - "test/presentation/**/*.dart"
---

# Quy ước UI, Design System và common component

## Theme token

- Widget đọc màu semantic qua `context.colors.<tokenName>`; chỗ đã dùng bảng màu tĩnh của app thì dùng
  `AppColors.<tokenName>`. Không tạo extension bọc lại `AppColorScheme`.
- Radius và padding/spacing cục bộ ghi trực tiếp giá trị số trong widget, không khai báo wrapper
  `AppRadius`/`AppSpacing`. Vẫn ưu tiên `AppTypography`, `AppOpacity` và `AppShadows` cho các token còn lại.
- Text dùng `AppTypography` không được gọi `copyWith(height: ...)`; phải giữ line-height từ typography
  token. Nếu cần line-height khác, chọn token phù hợp thay vì ghi đè `TextStyle.height` tại widget.
- Mọi shadow dùng chung phải được định nghĩa trong `lib/app/themes/app_shadows.dart`.
- Màu nằm trong `BoxShadow` được giữ trong `AppShadows` khi đó là thông số effect cố định của Design
  System; không ép lấy từ `AppColors` nếu shadow không phải semantic color theo theme.

## Icon và asset

- **Không dùng icon trực tiếp từ package `base_ui`** — cấm `BaseAssets.icons.*`, `BaseIconsLinear.*`,
  `BaseIconsBold.*` trong code app. Mọi icon nằm trong `assets/icons/` của project và gọi qua generated
  asset API `MyAssets.icons.<tên>.svg(...)` (`lib/generated/assets.gen.dart`).
- Cần một icon:
  1. Kiểm `assets/icons/` (hoặc accessor `MyAssets.icons.*`) xem project đã có chưa — có thì dùng luôn.
  2. Chưa có → copy SVG từ `base_ui` vào `assets/icons/`:
     - icon có sẵn ở `../commons/packages/base_ui/assets/icons/<tên>.svg` → giữ nguyên tên file;
     - glyph của bộ `BaseIconsLinear`/`BaseIconsBold` → lấy `../commons/packages/base_ui/assets/svgs/<linear|bold>/<tên>.svg`,
       đặt tên `icon_<tên>_<linear|bold>.svg` (ví dụ `icon_add_linear.svg` → `MyAssets.icons.iconAddLinear`).
  3. Chạy `dart run build_runner build --delete-conflicting-outputs` để sinh lại `assets.gen.dart`.
  4. Gọi `MyAssets.icons.<tên>.svg(width: …, height: …)`.
- `base_ui` không có icon thiết kế cần → xuất SVG từ thiết kế, đặt vào `assets/icons/` theo cùng quy trình.
- Đổi màu SVG bằng `colorFilter: ColorFilter.mode(<màu>, BlendMode.srcIn)`; không dùng tham số `color`
  (deprecated).
- Ảnh/logo/social provider cũng gọi qua `MyAssets.<path>`; không gọi trực tiếp
  `SvgPicture.asset('assets/...')`.
- Mọi logic `switch`/`if`/toán tử ba ngôi kiểm tra enum để trả về giá trị hiển thị như color, icon,
  text style, border, label hoặc asset phải đặt trong extension của enum đó. Widget chỉ gọi API của
  extension, không tự mapping enum sang giá trị hiển thị.
- Presentation không được so sánh raw `String`/`int` đại diện cho enum, trạng thái, loại, role hoặc
  slot với literal. Domain phải expose enum đã parse để widget chỉ so sánh giữa các enum.

## Bottom sheet

- **Mọi view của bottom sheet nằm dưới `lib/presentation/bottom_sheets/`**, không đặt trong
  `presentation/features/` hay `presentation/widgets/`. Áp cho cả sheet không có BLoC.
- Cấu trúc: `bottom_sheets/<nhóm>/<tên>/<tên>_view.dart`, BLoC (nếu có) nằm ở `<tên>/bloc/`,
  widget con riêng của sheet ở `<tên>/widgets/`. Nhóm là domain nghiệp vụ khi feature có từ hai
  sheet trở lên (`order/`, `profile/`, `payment/`); sheet lẻ thì đặt thẳng
  dưới `bottom_sheets/`.
- Tên class khớp tên file và kết thúc bằng `View`, ví dụ `order_items_view.dart` →
  `OrderItemsView`. Không đặt hậu tố `Sheet`.
- `features/<màn>/` chỉ chứa page của màn đó; widget dùng lại ở từ hai màn trở lên vẫn theo quy
  tắc `lib/presentation/widgets/` ở mục **Common component** — sheet thì không, sheet luôn về
  `bottom_sheets/`.

## Common component

- Với page không quá 400 dòng, các phần UI riêng của màn phải được dựng bằng helper method
  `_build...()` trong `PageState`.
- Khi page trên 400 dòng, phải tách các widget con như list item hoặc card thành file riêng trong
  thư mục `<screen>/widgets/`; không khai báo widget con ngay trong file page.
- Widget dùng lại ở từ hai màn hình trở lên phải nằm trong một file riêng dưới
  `lib/presentation/widgets/`, không đặt trong thư mục của riêng một màn.
- Extension của enum phải được khai báo trong chính file định nghĩa enum đó; không đặt extension
  enum trong file page/widget hoặc trong file event/state/bloc.
- Màn hình dùng `TextInput` hoặc `TextArea` phải bọc `body` bằng `GestureDetector` và gọi
  `FocusTextFieldHelper.unFocus(context)` trong `onTap` để tắt bàn phím khi chạm ra ngoài.
- Trạng thái load failure của màn hình phải dùng `EmptyListWidget`. Empty state không có thiết kế
  custom cũng phải dùng `EmptyListWidget`; chỉ dựng UI empty riêng khi design yêu cầu rõ ràng.
- Khi dùng `EmptyListWidget`, phải truyền `imageView` phù hợp với ngữ cảnh và dùng semantic color của
  app; không dùng illustration mặc định của `base_ui` nếu màu sắc không phù hợp với app.
- Mọi snackbar trong app phải hiển thị qua `AppSnackBar`; không gọi trực tiếp
  `ScaffoldMessenger.of(context).showSnackBar(...)` trong page/widget.
- `AppSnackBar` dùng `FlushbarRoute`, còn `AppBottomSheet.show`, `showAppModalDialog` và các API
  `Navigator` cũng thay đổi route. Không được `show`/`push`/`pop`/`replace` từ hai nguồn này trên cùng
  một Navigator trong cùng callback hoặc cùng frame; việc này có thể gây assertion
  `Navigator !_debugLocked` hoặc pop nhầm transient route thay vì page.
- Khi một action thành công vừa phải đóng page vừa phải hiện thông báo, page con chỉ được
  `Navigator.pop(result)`. Page cha phải `await` kết quả navigation, refresh dữ liệu nếu cần, rồi mới
  gọi `AppSnackBar` bằng context của page cha. Tuyệt đối không gọi `AppSnackBar.show...` rồi
  `Navigator.pop(...)` trên page hiện tại.
- `WidgetsBinding.instance.addPostFrameCallback` hoặc delay cố định không được dùng để che lỗi xung
  đột route. Phải sắp xếp route mutation theo thứ tự bằng `await`/navigation result, kiểm tra
  `mounted` sau mỗi khoảng `await`, và bảo đảm mỗi kết quả thành công chỉ phát một lệnh navigation.
- Với luồng vừa đóng page vừa trả kết quả, phải có widget/navigation test xác nhận đúng page được
  đóng, thông báo được hiển thị ở page nhận kết quả và `tester.takeException()` trả về `null` sau khi
  pump hoàn tất transition.
- Common widget phải expose các property tùy chọn cho những phần tử có thể ẩn/hiện trong thiết kế,
  ví dụ leading/trailing icon, close button, action button và shadow. Không hard-code rằng các phần tử
  này luôn tồn tại.
- Nếu component hỗ trợ nhiều số lượng action theo thiết kế, API phải biểu diễn được các case đó, ví
  dụ dialog có một hoặc hai button.
- Trạng thái loading của button dùng `CircularProgressIndicator`; kích thước indicator phải bằng
  đúng icon slot của button.
- Với controlled component như tabs, radio hoặc dropdown, page/BLoC sở hữu giá trị đang chọn;
  common widget nhận value và phát callback, không tự giữ business state lâu dài.

## Text input và form submit

- Mọi `TextField`/`TextFormField` trong form phải nhận `TextEditingController`; không dùng
  `initialValue` làm nguồn dữ liệu song song với controller.
- Page/Drawer `State` sở hữu controller, đồng bộ dữ liệu tải về có chủ đích và gọi `dispose()`.
  Không đồng bộ lại text trên mọi lần BLoC emit vì sẽ ghi đè nội dung người dùng đang nhập.
- Không dùng `addListener` hoặc `onChanged` chỉ để sao chép từng phím vào BLoC state. Nếu field chỉ
  được dùng khi submit, callback submit validate form, đọc `controller.text` rồi truyền giá trị qua
  named field của `Submit...Event`; BLoC validate và dựng typed body/param từ event đó.
- `onChanged` chỉ được dùng khi giao diện/nghiệp vụ thật sự phải phản ứng **trước submit** như tìm kiếm,
  tính toán tức thời hoặc bật/tắt thành phần phụ thuộc; không dùng như cơ chế lưu form mặc định.

```dart
TextFormField(
  controller: _nameController,
  validator: _validateName,
);

void _submit() {
  if (!(_formKey.currentState?.validate() ?? false)) return;
  bloc.add(SubmitFormEvent(name: _nameController.text));
}
```

## Đối chiếu Figma

- Khi user cung cấp một node/screen Figma cụ thể, node đó là nguồn sự thật cho layout và variant của
  instance cần triển khai. Tài liệu component và Design System dùng để bổ sung token/anatomy; không
  ép instance theo mô tả generic khi hình cụ thể khác.
- Phải đối chiếu đủ variant, state, visibility và kích thước có trong node thay vì chỉ làm default
  case.
- Frame thiết kế màn hình không bị giới hạn ở `375×812`. Nếu nội dung dài, tăng height thành
  `375×980` hoặc dài hơn để hiển thị đủ item; khi code Flutter, page chịu trách nhiệm scroll.
