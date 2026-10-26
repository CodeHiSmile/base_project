# Project Guide — base_project

Tài liệu này dành cho **mọi AI agent / coding assistant** (Cursor, Copilot, Claude, Codex, v.v.) khi làm việc với project. Đọc trước khi sinh hoặc sửa bất kỳ file nào.

Xem thêm: [`CLAUDE.md`](CLAUDE.md), [`.claude/rules/ARCHITECTURE.md`](.claude/rules/ARCHITECTURE.md), [`README.md`](README.md)

---

## Project context

- Flutter package: `base_project`.
- Dart SDK: `^3.10.8`.
- App source: `lib/`.
- Tests: `test/`.
- Localization source: `lib/l10n/`.
- Generated source: `lib/generated/`.
- Shared packages: `../commons/packages/{shared,domain,data,base_ui,router,alice,alice_dio}`.
- Không sửa shared package từ repo này nếu task không yêu cầu rõ.
- Không được commit hoặc push nếu user chưa yêu cầu.

---

## Kiến trúc bắt buộc

```text
presentation → domain ← data
```

```text
Page / Widget
  → BLoC (Event → State)
    → UseCase
      → Repository interface
        → RepositoryImpl
          → ApiService / client
```

- `lib/presentation/`: page, widget, BLoC, event, state.
- `lib/domain/`: entity, body, param, UseCase, repository interface.
- `lib/data/`: API, response model, mapper, RepositoryImpl.
- `lib/app/`: app lifecycle và global application state.
- `lib/di/`: GetIt/injectable.
- `lib/navigation/`: route paths và route configuration.
- Widget không gọi API hoặc RepositoryImpl trực tiếp.
- RepositoryImpl map data response sang domain entity trước khi trả lên presentation.
- Entity/response dùng chung nhiều app có thể nằm trong `commons/packages/`; không copy primitive đã có trong commons vào app.

### Cấu trúc thư mục

```
lib/
  main/               # Entrypoints: main_dev, main_stg, main_prod → main.dart (mainApp)
  app/                # MyApp widget + AppBloc (theme, language, debug overlay, cờ dialog lỗi)
    themes/           # AppColors, AppShadows — token tĩnh của app
    session/          # AppSessionExpiredHandler — UX hết phiên
  config/             # EnvironmentBase, AppConfig
  navigation/         # AppNavigator, router_paths.dart, app_router.dart
  di/                 # di.dart + di.config.dart (GENERATED — không sửa tay)
  domain/             # entity, body, param, UseCase, repository interface
  data/               # REST client, interceptor, session port, model, mapper
  presentation/
    features/         # Màn hình — xem "Tạo màn hình mới" (1 cấp hoặc domain/screen)
    dialogs/          # AppDialog
    bottom_sheets/    # AppBottomSheet + view của từng sheet
    snack_bar/        # AppSnackBar
    helpers/          # FocusTextFieldHelper, helper dùng chung
    widgets/          # Widget dùng chung
  l10n/               # *.arb — nguồn chuỗi UI
  generated/          # Do flutter gen/l10n sinh — không sửa tay
```

---

## Quy tắc đặt tên

| Loại | Quy tắc | Ví dụ |
|------|---------|-------|
| File | `snake_case.dart` | `profile_page.dart` |
| Class | `PascalCase` | `ProfilePage`, `ProfileBloc` |
| Use case | `<Verb><Noun>UseCase` | `GetProfileUseCase` |
| Entity | `<Name>Entity` | `ProfileEntity` |
| Response DTO | `<Name>Response` | `ProfileResponse` |
| Mapper | `<Name>Mapper` | `ProfileMapper` |
| Router path | const lowercase | `RouterPaths.profile = '/profile'` |
| BLoC event | `<Action><Name>Event` | `InitialProfileDataEvent`, `LoadMoreEvent` |

---

## BLoC

- Feature/business state dùng BLoC; không tạo Cubit mới.
- BLoC kế thừa `BaseBloc<Event, State>` từ `base_ui`.
- Async UseCase trong BLoC phải chạy qua `runBlocCatching` theo pattern feature hiện có.
- State immutable; ưu tiên Freezed theo feature hiện có, hoặc Equatable với đầy đủ props.
- Event dùng named parameters.
- Field event bắt buộc phải non-nullable và có `required`; chỉ optional khi event vẫn hợp lệ nếu thiếu giá trị.
- Code mới ưu tiên tên event mô tả hành động như `LoginSubmitted`, `ProfileRefreshed`; không thêm prefix `On` nếu không cần tương thích code cũ.
- Chỉ dùng chung BLoC khi các màn cùng workflow, lifecycle và nguồn dữ liệu.
- `setState`, `ValueNotifier`, controller và `StatefulWidget` được phép cho local UI state; không thay BLoC cho business/shared state.
- Với `Completer`, luôn kiểm tra `isCompleted` trước `complete` hoặc `completeError`.
- Handler async phải xem xét duplicate request, cancellation và stale response.
- **BLoC không bao giờ navigate.** Emit state → page lắng nghe qua `BlocListener` và gọi `AppNavigator`.
- Navigate: `AppNavigator.go(RouterPaths.profile)` (replace stack) hoặc `AppNavigator.push(...)`.
- DI: `@Injectable()` cho BLoC, `@LazySingleton()` cho service. Sau khi thêm: `dart run build_runner build --delete-conflicting-outputs`.

---

## Domain

- Body: `lib/domain/models/body/<feature>/`.
- Param: `lib/domain/models/param/<feature>/`.
- Entity: `lib/domain/models/entity/<feature>/` (hoặc `commons/packages/domain/lib/domain/models/entity/<feature>/` nếu dùng chung).
- UseCase: `lib/domain/usecases/<feature>/`.
- Repository interface: `lib/domain/repositories/`.
- Body/Param đi xuyên layer phải có typed model; không dùng `Map<String, dynamic>`.
- Nullability phản ánh contract và nghiệp vụ; field bắt buộc dùng `required`.
- UseCase kế thừa base UseCase phù hợp từ shared `domain` package.
- Chỉ tạo Input/Output class khi cần boundary rõ ràng, nhiều tham số hoặc khả năng mở rộng.
- Repository trả `Future<T>` hoặc `Future<T?>` theo semantics; không dùng `Future<T>?`.
- Không dùng `null` để đại diện cho network/server/parsing error.
- **Không có JSON annotation trong entity.** Chỉ Dart primitive / enum / entity khác.

Ví dụ entity:

```dart

class ProfileEntity {
  final int? id;
  final String? name;
  final String? avatarUrl;

  ProfileEntity({
    this.id,
    this.name,
    this.avatarUrl,
  })
}
```

---

## Data

- Response model: `lib/data/models/<feature>/` (hoặc `commons/packages/data/lib/data/models/<feature>/` nếu dùng chung).
- Mapper: `lib/data/mapper/<feature>/`.
- RepositoryImpl: `lib/data/repository_impls/<feature>/`.
- API service/client: `lib/data/api/`.
- Response model phải bám API contract; dùng `@JsonKey(name: ...)` khi wire name khác Dart name.
- Một response/model/mapper chính trên mỗi file.
- RepositoryImpl chỉ trả `null` khi “không có dữ liệu” là kết quả nghiệp vụ hợp lệ.
- Error phải đi qua error model hiện có; không catch rồi trả `null`.
- Presentation không import data response hoặc generated API type.
- Các response wrapper dùng chung nằm trong shared package `data`:
  - Object có envelope: `DataResponse<T>`.
  - List thường có envelope: `DataListResponse<T>`.
  - List phân trang có envelope: `DataResponse<Pagination<T>>`.
- Chỉ dùng wrapper phù hợp với API contract; không bọc thêm nếu endpoint không trả envelope tương ứng.
- `DataResponse<T>` và `DataListResponse<T>` chứa `status`, `data`, `meta`; `Pagination<T>` chứa `pageNumber`, `pageSize`, `totalElements`, `content`.

Ví dụ response + mapper:

```dart
// lib/data/models/profile/profile_response.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_response.g.dart';
part 'profile_response.freezed.dart';

@freezed
abstract class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    int? id,
    @JsonKey(name: 'full_name') String? name,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}
```

```dart
// lib/data/mapper/profile/profile_mapper.dart
import '../../../domain/domain.dart';
import '../../models/profile/profile_response.dart';

class ProfileMapper {
  static ProfileEntity mapToEntity(ProfileResponse dto) {
    return ProfileEntity(
      id: dto.id,
      name: dto.name,
      avatarUrl: dto.avatarUrl,
    );
  }
}
```

---

## API

- API entry point chính: `lib/data/api/service/app_api_service.dart` — nơi duy nhất khai báo endpoint.
- Upload multipart: mixin `MultipartUploadApiClientMixin` (`lib/data/api/client/`) — giả định envelope `{ "data": … }`.
- Base chưa có GraphQL. Dự án nào thêm GraphQL thì service phải chuyển generated type thành response
  model của data layer; không trả generated type lên Repository interface, UseCase, BLoC hoặc Widget,
  và không sửa `*.graphql.dart` bằng tay.
- Khi thêm/sửa model, annotation hoặc DI, chạy:

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## Dependency injection

- Dùng GetIt + injectable tại `lib/di/di.dart`.
- Ưu tiên constructor injection cho BLoC, UseCase và RepositoryImpl.
- Không khởi tạo Repository hoặc UseCase trực tiếp trong Widget.
- Chỉ dùng `GetIt.instance` trực tiếp tại composition boundary hoặc khi pattern app hiện có yêu cầu.
- Dependency mới cần annotation/module injectable phù hợp và phải chạy codegen.
- Không sửa `lib/di/di.config.dart` bằng tay.

---

## Navigation

- Route path: `lib/navigation/routers/router_paths.dart`.
- Route registration: `lib/navigation/routers/app_router.dart`.
- Dùng abstraction từ shared package `router`; không tạo navigation stack song song.
- Route argument phức tạp phải có typed arguments class.
- Kiểm tra type trước khi cast `state.extra` nếu caller không bảo đảm type.
- Navigation, dialog, bottom sheet và snackbar nằm ở presentation layer.

---

## UI, theme, asset và localization

- Màu UI phải lấy từ `AppColors` tại `lib/app/themes/app_colors.dart`.
- Nếu thiếu màu, thêm token có tên semantic vào `AppColors`; không hardcode `Color(...)` trong Widget.
- Text style dùng `context.textStyles` từ `base_ui`.
- Tái sử dụng component và extension từ `base_ui`.
- Không tạo hệ design token song song nếu project hoặc `base_ui` đã có equivalent.
- Chuỗi UI đi qua l10n (`lib/l10n/*.arb` → `S.of(context)`). Dự án fork quyết khác (ví dụ chỉ tiếng Việt) thì ghi rõ quyết định vào `CLAUDE.md` của dự án đó.
- Asset dùng generated `MyAssets` khi có accessor tương ứng.
- Font chính hiện tại là Gilroy; dùng typography token thay vì khai font trực tiếp trong từng widget.
- Chỉ đặt `TextStyle.height` khi design/typography yêu cầu.
- UI mới phải xem xét loading, empty, success, error, text scaling và semantics.
- Tách widget theo responsibility và khả năng tái sử dụng, không chỉ theo số dòng.
- Page không quá 400 dòng chia UI bằng helper method trong `PageState`.
- Page trên 400 dòng phải tách widget con như list item hoặc card vào thư mục `widgets/` của màn.
- Widget dùng lại ở từ hai màn trở lên phải có file riêng dưới `lib/presentation/widgets/`.
- Extension enum phải nằm trong chính file định nghĩa enum, không đặt trong page/widget.

---

## PDF và Marionette

- **Xem PDF**: `AppNavigator.push(RouterPaths.pdfViewer, extra: PdfViewerArguments(title: …, pdfSource: PdfSource.network, url: …))`.
  PDF trong app (`PdfSource.asset`) thì khai thư mục asset (ví dụ `assets/pdf/`) trong `pubspec.yaml` trước.
- **Marionette** (debug): `main.dart` khởi tạo `MarionetteBinding` khi `kDebugMode` để agent/MCP đọc widget
  tree, tap theo key và đọc log. Máy chạy thiết bị cần `dart pub global activate marionette_mcp`
  (`~/.pub-cache/bin` trong `PATH`). `flutter run` ở debug in **VM Service URI** — gọi `connect` tới URI
  đó trước mọi tool khác. Control custom phải có `Semantics(identifier: …)` hoặc khai trong
  `MarionetteConfiguration` (`isInteractiveWidget`/`extractText`) thì Marionette mới thấy.
  Release dùng binding Flutter thường — không ảnh hưởng bản phát hành.

---

## Tạo màn hình mới

Mọi màn hình đều có **5 file BLoC bắt buộc**. Cách đặt folder phụ thuộc độ phức tạp của app.

### Cấu trúc tối thiểu (base / màn đơn giản)

Dùng khi app nhỏ hoặc màn độc lập — **1 cấp** dưới `features/`:

```
lib/presentation/features/
  splash/
    bloc/
      bloc.dart                ← re-export 3 file bên dưới
      splash_bloc.dart
      splash_event.dart
      splash_state.dart
    splash_page.dart

  login/
    bloc/ ...
    login_page.dart
```

Ví dụ trong base: `splash/`, `login/`, `main/`.

### Cấu trúc app lớn (parent / tutor)

Khi nhiều màn cùng domain — **2 cấp**: `features/<domain>/<screen>/`:

```
lib/presentation/features/
  order/                         ← domain (nhóm nghiệp vụ)
    order_detail/
      bloc/
        bloc.dart
        order_detail_bloc.dart
        order_detail_event.dart
        order_detail_state.dart
      order_detail_page.dart
    order_list/
      bloc/ ...
      order_list_page.dart

  personal/
    my_profile/
      bloc/ ...
      my_profile_page.dart
      profile_completion_calculator.dart   ← helper local (tùy màn)
      widgets/                             ← widget con của màn này
        profile_header.dart
        ...

  authentication/
    login/
      bloc/ ...
      login_page.dart
      widgets/
```

Quy tắc chọn cấp folder:

| Tình huống | Đặt ở |
|------------|--------|
| Màn đơn, ít liên quan màn khác | `features/<screen>/` |
| Nhiều màn cùng domain (order, profile, calendar…) | `features/<domain>/<screen>/` |
| UI riêng khi page không quá 400 dòng | Helper method `_build...()` trong `PageState` |
| Widget con khi page trên 400 dòng | File riêng trong `<screen>/widgets/` |
| Widget dùng từ 2 màn trở lên | File riêng trong `lib/presentation/widgets/` |
| Model/helper chỉ phục vụ 1 màn | Cùng folder `<screen>/` (không đưa vào commons) |

> BLoC convention **không đổi** giữa base và parent/tutor: `bloc.dart` re-export + bloc/event/state + page.

### Ví dụ scaffold: `profile/` (1 cấp)

```
profile/
  bloc/
    bloc.dart
    profile_bloc.dart
    profile_event.dart
    profile_state.dart
  profile_page.dart
```

### `profile_page.dart`

```dart
import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/bloc.dart';

class ProfileArguments {
  const ProfileArguments();
}

class ProfilePage extends StatefulWidget {
  final ProfileArguments? arguments;
  const ProfilePage({super.key, this.arguments});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfilePage, ProfileBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const InitialProfileDataEvent());
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.loadStatus == LoadingStatus.loading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          appBar: AppBar(title: Text(AppStrings.of(context).profileTitle)),
          body: const SizedBox(), // TODO: real UI
        );
      },
    );
  }
}
```

### `profile_bloc.dart`

```dart
import 'dart:async';
import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'profile_event.dart';
import 'profile_state.dart';

@Injectable()
class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<InitialProfileDataEvent>(_onInitialDataEvent);
  }

  FutureOr<void> _onInitialDataEvent(
    InitialProfileDataEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(loadStatus: LoadingStatus.loading));
    await runBlocCatching(
      action: () async {
        // TODO: gọi use case inject qua constructor
        emit(state.copyWith(loadStatus: LoadingStatus.success));
      },
      doOnError: (_) async {
        emit(state.copyWith(loadStatus: LoadingStatus.failure));
      },
    );
  }
}
```

### `profile_state.dart`

```dart
import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState extends BaseBlocState with _$ProfileState {
  const ProfileState._();
  const factory ProfileState({
    @Default(LoadingStatus.initial) LoadingStatus? loadStatus,
  }) = _ProfileState;
}
```

### `profile_event.dart`

```dart
import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';

abstract class ProfileEvent extends BaseBlocEvent {
  const ProfileEvent();
}

class InitialProfileDataEvent extends ProfileEvent {
  const InitialProfileDataEvent();
}
```

### `bloc/bloc.dart`

```dart
export 'profile_bloc.dart';
export 'profile_event.dart';
export 'profile_state.dart';
```

### Sau khi tạo màn hình

1. Thêm route vào `router_paths.dart`: `static const String profile = '/profile';`
2. Đăng ký route trong `app_router.dart`.
3. Chạy `dart run build_runner build --delete-conflicting-outputs` để rebuild `di.config.dart`.

---

## Generated files

Không sửa tay:

- `*.g.dart`
- `*.freezed.dart`
- `lib/di/di.config.dart`
- file trong `lib/generated/`

Phải sửa source, ARB, annotation hoặc schema rồi chạy generator tương ứng.

---

## Môi trường / Env

Sửa `lib/config/environment.dart` — `EnvironmentBase.dev` / `.staging` / `.prod`.

Mỗi môi trường có một entrypoint `main_<env>.dart` (`main_dev` · `main_stg` · `main_prod`). Base chưa
khai flavor native (Android `productFlavors`, iOS scheme) — chọn môi trường bằng `-t`.

Dev đổi server không cần sửa code: `--dart-define=API_BASE_URL=http://<host>:<port>`.

Đọc giá trị: `GetIt.instance.get<EnvironmentConfig>().getBaseUrl()`

---

## Verification

Verify mặc định:

```bash
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

- Thay đổi business logic cần unit/BLoC test khi infrastructure cho phép.
- Widget có interaction hoặc nhiều trạng thái quan trọng nên có widget test.
- Bug fix nên có regression test.
- Nếu repo có lỗi tồn đọng, báo riêng lỗi có trước và lỗi do thay đổi mới.
- Nếu thay đổi source sinh code, chạy `dart run build_runner build --delete-conflicting-outputs` rồi verify lại.

---

## Security và dependency

- Không log token, password, PII hoặc raw API response nhạy cảm.
- Không commit secret, signing credential hoặc environment value nhạy cảm.
- Validate dữ liệu từ route, deep link, storage và API tại boundary phù hợp.
- Trước khi thêm dependency, kiểm tra package/shared package hiện có và nêu tradeoff.
- Không tự thay đổi dependency override nếu task không liên quan.

---

## Lệnh thường dùng

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # codegen: freezed + injectable + flutter_gen
flutter run -t lib/main/main_dev.dart                      # stg / prod: main_stg.dart / main_prod.dart
flutter analyze
flutter test

# Tạo màn hình / feature bằng mason (cài: dart pub global activate mason_cli)
./bricks/shell_scripts/create_screen_with_feature.sh
./bricks/shell_scripts/create_feature.sh
```

Chi tiết mason/brick: `bricks/shell_scripts/README.md`.
