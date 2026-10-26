---
paths:
  - "lib/domain/**/*.dart"
  - "lib/data/**/*.dart"
  - "lib/presentation/**/*.dart"
---

# Quy ước triển khai danh sách phân trang

Áp dụng khi API trả `DataResponse<Pagination<ObjectResponse>>?`.

## Repository implementation

- Hàm repository implementation trả `Future<PagedList<ObjectResponse>>`.
- Map từng response sang domain entity trước khi tạo `PagedList`.
- `next` là `null` khi số item trả về nhỏ hơn page size; nếu còn dữ liệu, tăng page hiện tại thêm
  một.

```dart
return PagedList(
  data: items
      .map((item) => ApiListRestaurantMapper.mapToEntity(item))
      .toList(),
  next: items.length < (body.size ?? 20)
      ? null
      : (body.page ?? 0) + 1,
  total: data?.data?.totalElements,
);
```

## Use case

Use case phân trang kế thừa `BaseLoadMoreUseCase<Input, ObjectResponse>`:

```dart
class GetListRestaurantUseCase
    extends BaseLoadMoreUseCase<GetListRestaurantInput, ObjectResponse> {
  // Implementation theo form use case hiện có của project.
}
```

## State

Khai báo output phân trang trong `*_state.dart`:

```dart
@Default(LoadMoreOutput(data: []))
LoadMoreOutput<ObjectResponse> items,
```

Tên field phải thể hiện đúng dữ liệu nghiệp vụ, ví dụ `orders`, `restaurants` hoặc `members`.

## Page và paging controller

Khai báo controller trong page state:

```dart
final CommonPagingController<ObjectResponse> pagingController =
    CommonPagingController<ObjectResponse>();
```

Đăng ký tải thêm trong `initState`:

```dart
@override
void initState() {
  super.initState();
  pagingController.listen(
    onLoadMore: () {
      bloc.add(
        const GetListAbcEvent(
          isRefresh: false,
        ),
      );
    },
  );
}
```

## Đồng bộ BLoC state vào paging controller

Page phải override `buildPageListeners` và chỉ append khi field phân trang thay đổi:

```dart
@override
Widget buildPageListeners({
  required Widget child,
}) {
  return MultiBlocListener(
    listeners: [
      BlocListener<ListOrderBloc, ListOrderState>(
        listenWhen: (previous, current) =>
            previous.orders != current.orders,
        listener: (context, state) {
          pagingController.appendLoadMoreOutput(state.orders);
        },
      ),
    ],
    child: child,
  );
}
```

Thay `ListOrderBloc`, `ListOrderState` và `orders` bằng type/field thật của feature; không sử dụng
BLoC của màn hình khác.

## Vẽ danh sách

- Dùng `RefreshIndicatorWidget` cho refresh.
- Dùng `CommonPagedListView` với `CommonPagingController` cho tải thêm.
- Refresh phải phát event reload/refresh qua BLoC, không gọi API trực tiếp từ widget.
- Empty state dùng widget chuẩn của project.

```dart
RefreshIndicatorWidget(
  onRefresh: () async {
    bloc.add(const ReloadPageEvent());
  },
  child: CommonPagedListView<ObjectResponse>(
    pagingController: pagingController,
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
    separatorBuilder: (_, __) => const SizedBox(height: 12),
    itemBuilder: (context, item, index) {
      return FeatureItemWidget(item: item);
    },
    noItemsFoundIndicator: EmptyListWidget(
      title: 'Bạn không có dữ liệu nào',
      onRefresh: () async {
        bloc.add(const ReloadPageEvent());
      },
    ),
  ),
)
```

## Lifecycle

- Dispose `pagingController` theo API/lifecycle chuẩn của base page nếu controller yêu cầu dispose.
- Không tạo lại controller trong `buildPage`.
- Loading, refresh, load-more, empty và error phải đi qua BLoC state/output chuẩn.
