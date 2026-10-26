---
paths:
  - "lib/presentation/**/*.dart"
---

# Quy ước BLoC của Hoop Sync

> Đây là convention riêng của project và được ưu tiên khi khác với skill Flutter dùng chung.

## Event

- Mọi field trong file `*_event.dart` phải được khai báo trong constructor bằng named parameters
  `({ ... })`; không dùng positional parameters.
- Event không có field vẫn phải có `const` constructor.

```dart
class GetListAbcEvent extends AbcEvent {
  const GetListAbcEvent({
    required this.isRefresh,
  });

  final bool isRefresh;
}
```

## Đăng ký event handler

- Constructor của BLoC chỉ đăng ký event bằng **method reference**:
  `on<LoadDataEvent>(_onLoadData)`. Không viết business/state-update logic trực tiếp trong
  constructor.
- Cấm cả inline block `on<Event>((event, emit) { ... })` và inline arrow
  `on<Event>((event, emit) => ...)`, kể cả khi thân chỉ có một dòng.
- Mỗi event phải có một private handler được định kiểu đầy đủ ở dưới phần constructor/dependency.
  Handler có thể chuyển tiếp vào helper dùng chung nếu nhiều event chỉ khác tham số nghiệp vụ.
- Tên handler phải là `_on` + **đầy đủ tên event**, chỉ bỏ hậu tố `Event` nếu event có hậu tố đó.
  Ví dụ: `LoadOrderReturnQueue` → `_onLoadOrderReturnQueue`,
  `SubmitShippingPricingFormEvent` → `_onSubmitShippingPricingForm`.
- Cấm tên handler rút gọn hoặc mất ngữ cảnh như `_load`, `_submit`, `_change`, `_complete`, `_handle`,
  `_onInitialDataEvent`. Giữ nguyên danh từ nghiệp vụ và số ít/số nhiều để reviewer hiểu handler mà
  không phải dò ngược lên dòng đăng ký event.

```dart
FeatureBloc() : super(const FeatureState()) {
  on<LoadDataEvent>(_onLoadData);
}

Future<void> _onLoadData(
  LoadDataEvent event,
  Emitter<FeatureState> emit,
) async {
  // Xử lý event ở đây.
}
```

## Sở hữu BLoC theo màn hình

- Mỗi màn hình chỉ sử dụng BLoC thuộc chính màn hình đó.
- Không đọc, gọi event hoặc phụ thuộc trực tiếp vào BLoC của màn hình khác.
- Nếu nhiều màn hình cần cùng nghiệp vụ, đưa nghiệp vụ vào use case/repository hoặc thiết kế một
  coordinator/shared state rõ ràng; không tái sử dụng chéo screen BLoC.

## State và cập nhật UI

- Không sử dụng `setState`.
- Mọi dữ liệu hoặc trạng thái làm thay đổi UI phải được khai báo trong file `*_state.dart` và cập
  nhật bằng BLoC event/state.
- Widget chỉ render state và phát intent; không giữ business state cục bộ trong page/widget.

## Form nhập liệu và submit

- Với giá trị `TextField`/`TextFormField` chỉ được dùng khi submit, Page/Drawer sở hữu
  `TextEditingController`; không phát `Change...Event` theo từng phím chỉ để sao chép text vào state.
- Callback submit phải validate `Form`, đọc `controller.text` và truyền từng giá trị qua named field
  của `Submit...Event`.
- BLoC nhận giá trị form từ submit event, validate lại khi cần rồi dựng typed body/param cho use case.
  BLoC không được truy cập controller hoặc BuildContext.

## Gọi use case và API

- Dependency use case trong BLoC phải dùng tên private field đầy đủ theo đúng class và giữ nguyên số
  ít/số nhiều, ví dụ `GetOrderReturnsUseCase _getOrderReturnsUseCase` và
  `ActOnOrderReturnUseCase _actOnOrderReturnUseCase`.
- Cấm tên rút gọn hoặc mơ hồ như `_get`, `_act`, `_create`, `_useCase`, hoặc dùng tên số ít cho một
  use case số nhiều. Constructor dùng đúng cùng tên field để call site DI tự giải thích được.
- Mọi handler gọi use case có truy cập API phải chạy bên trong `runBlocCatching`.
- Bám đúng cách xử lý loading/error của `home_bloc`; không tự thêm `try/catch` song song để bỏ qua
  cơ chế lỗi chuẩn của base BLoC.

```dart
Future<void> _onLoadData(
  LoadDataEvent event,
  Emitter<FeatureState> emit,
) async {
  await runBlocCatching(
    action: () async {
      final output = await _getDataUseCase.execute(
        const GetDataInput(),
      );
      emit(state.copyWith(data: output.data));
    },
  );
}
```
