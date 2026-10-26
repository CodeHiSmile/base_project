---
paths:
  - "lib/domain/**/*.dart"
  - "lib/data/**/*.dart"
---

# Quy ước Domain và Data

> Đây là project override. Các quy tắc nullable và repository trả `null` bên dưới được ưu tiên khi
> khác với skill Flutter dùng chung.

## Khai báo class

- Không sử dụng `final class` cho concrete class; luôn khai báo bằng `class` thông thường.
- Chỉ dùng modifier như `abstract`, `interface` hoặc `sealed` khi pattern kiến trúc thực sự yêu cầu;
  không thêm modifier chỉ để giới hạn kế thừa.

## Domain model

- Model domain đặt trong `lib/domain/models/`, phân loại theo `body/`, `entity/` hoặc `param/`.
- Mọi property của model phải nullable.
- Không dùng `required` trong constructor model.
- Mỗi model là một class riêng và mỗi public model nằm trong một file riêng.
- Khi chuyển đổi giữa các domain model/entity, viết instance method chuyển đổi ngay trong model
  nguồn, ví dụ `summary.toItem()`. Method phải dùng trực tiếp các property của model hiện tại;
  không viết helper bên ngoài model rồi truyền chính model đó vào như
  `_toItem(TournamentSummaryEntity summary)`.
- Khi map từ model/entity có field nullable, use case và mapper phải xử lý null tường minh và giữ
  null trong output nếu chưa đủ dữ liệu để derive. Không dùng `!` hoặc tự gán default chỉ để thoả
  kiểu dữ liệu, trừ khi domain contract quy định default đó.

```dart
class GetRestaurantParam {
  const GetRestaurantParam({
    this.page,
    this.size,
  });

  final int? page;
  final int? size;
}
```

## Enum

- Mọi enum của project phải đặt trong `lib/domain/enums/`.
- Mỗi enum phải nằm trong một file riêng; không khai báo enum bên trong file model, use case,
  repository, BLoC hoặc widget.
- Tên file enum dùng `snake_case`, khớp với tên enum.
- Khi cần chuyển đổi giữa enum và giá trị persistence/API (`String`, `int`, ...), tạo extension
  tương ứng trong cùng file với enum. Logic parse không được đặt rải rác trong use case, mapper,
  repository hoặc presentation.
- Không so sánh trực tiếp `String`/`int` đại diện cho enum, trạng thái, loại, role hoặc slot với
  literal. Phải parse giá trị persistence/API thành enum bằng extension rồi so sánh giữa các enum;
  raw value chỉ được giữ tại boundary đọc/ghi dữ liệu.
- Logic quyết định/derive một enum từ dữ liệu domain phải đặt trong extension của chính enum đó;
  không viết các hàm `_toStatus`, `_toType`, `_toProgressKind`,... bên trong use case hoặc mapper.
- Parser phải xử lý rõ giá trị không được hỗ trợ bằng typed fallback hoặc exception; không silently
  map sang một enum khác.

## Param và body

- Khi API cần body hoặc param, phải tạo typed model; không truyền `Map<String, dynamic>` qua các
  layer.
- Param class dùng annotation chính xác:

```dart
@JsonSerializable(
  includeIfNull: false,
  explicitToJson: true,
)
```

## Use case

- Use case đặt trong `lib/domain/usecases/<feature>/`.
- Viết theo form của `GetUserUseCase`.
- Use case phải kế thừa `BaseFutureUseCase` hoặc `BaseLoadMoreUseCase` tùy loại tác vụ.
- Mỗi use case phải có class `Input` và `Output` được định kiểu rõ ràng.
- Use case chỉ orchestration, validation và gọi repository; không chứa logic mapping/derive thuộc về
  enum.
- Nếu `Output` chứa item/model có cấu trúc nghiệp vụ (ví dụ một item trong danh sách), item đó phải
  là domain entity đặt tại `lib/domain/models/entity/<feature>/`, mỗi entity một file riêng. Không
  khai báo class kiểu `*ItemOutput` trực tiếp trong file use case; `Output` chỉ bọc entity hoặc danh
  sách entity.

## Repository contract

- Repository interface đặt trong `lib/domain/repositories/<feature>/`.
- Repository mặc định dùng `Future`.
- Kiểu dữ liệu nằm trong `Future` phải nullable, ví dụ `Future<UserEntity?>`.
- Không dùng `Map<String, dynamic>` thay cho body/param model.
- Tên method phải mô tả đầy đủ thao tác và đối tượng nghiệp vụ. Cấm tên chung chung như `list`,
  `get`, `create`, `update`, `act` khi đọc call site không biết đang thao tác gì.
- Giữ đúng số ít/số nhiều và đặt tên ID theo đối tượng, ví dụ `getOrderReturns`,
  `getOrderReturnDetail`, `performOrderReturnAction`, `returnRequestId`; không dùng `get` hoặc `id`
  mơ hồ trong contract có nhiều loại định danh.

## Response model

- Response model phải khớp tài liệu API 100%: không thêm/bớt field và không tự đổi tên biến.
- Response model đặt trong `lib/data/models/<feature>/`.
- Mọi property phải nullable và không dùng `required` trong constructor.
- Class dùng `@freezed` phải khai báo là `abstract class`.
- Mỗi response class nằm trong một file riêng; không gộp nhiều response class vào cùng file.

## Mapper

- Mapper đặt trong `lib/data/mapper/<feature>/`.
- Mỗi mapper nằm trong một file riêng.
- Mapper chịu trách nhiệm chuyển response model sang domain entity; presentation không dùng raw
  response model.

## Repository implementation

- Repository implementation đặt trong `lib/data/repository_impls/<feature>/`.
- Kiểu dữ liệu nằm trong `Future` phải nullable.
- Khi không lấy được dữ liệu theo convention hiện tại của project, repository implementation trả
  về `null`.
- Dependency API dùng tên đầy đủ như `_appApiService`, khai báo field trước constructor; không dùng
  tên rút gọn như `_api` khi project có nhiều client/service.
- Mỗi method khai báo `final response = await ...`, kiểm dữ liệu response rồi mới gọi mapper và trả
  `null` theo contract. Không nhét `await` + API call + mapper vào một expression một dòng khó đọc.
- Refactor style không được tự thêm `try/catch` để nuốt lỗi hoặc đổi error propagation hiện hữu.

```dart
@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final AppApiService _appApiService;

  ProductRepositoryImpl(this._appApiService);

  @override
  Future<ProductEntity?> getProductDetail(int productId) async {
    final response = await _appApiService.getProductDetail(productId);

    if (response?.data != null) {
      return ProductMapper.mapToEntity(response!.data);
    }

    return null;
  }
}
```

## Kiểu trả về của `app_api_service`

- API trả object:

```dart
Future<DataResponse<ObjectResponse>?>
```

- API trả list thông thường:

```dart
Future<DataListResponse<ObjectResponse>?>
```

- API trả list có phân trang:

```dart
Future<DataResponse<Pagination<ObjectResponse>>?>
```

## Nơi duy nhất khai báo endpoint API của ứng dụng

- Mọi endpoint mới của app phải được khai báo thành method trong
  `lib/data/api/service/app_api_service.dart`, thuộc class `AppApiService`.
- Không tạo API service theo feature như `OrderOperationsApiService`,
  `OrderCustomerApiService` hoặc file `*_api_service.dart` mới để định nghĩa endpoint.
  Không lách bằng extension/part/wrapper ở file khác để chứa path hoặc lời gọi HTTP.
- Repository implementation inject `AppApiService` bằng field `_appApiService`.
  Giữ typed body/param/response, mapper và repository/use case riêng theo các quy tắc ở trên.
- Widget và BLoC không gọi HTTP/API service trực tiếp; BLoC chỉ gọi use case qua
  `runBlocCatching`.
- Khi chuyển endpoint về `AppApiService`, xoá service cũ và chạy generator để cập nhật DI;
  không sửa `di.config.dart` bằng tay.
