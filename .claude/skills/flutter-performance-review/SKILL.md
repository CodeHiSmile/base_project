---
name: flutter-performance-review
description: >-
  Review tĩnh code Flutter để phát hiện vấn đề performance: rebuild thừa, const,
  list/scroll, image, memory leak, async trong build, state scope, paint/render cost,
  animation, database, network. Trả về findings có severity, WHY, impact định tính
  và ví dụ fix theo convention repo (BLoC + base_ui). Use when the user asks to
  review Flutter performance, đánh giá perf, check jank/rebuild/memory leak, hoặc
  sau khi implement UI/animation cần rà soát trước khi verify bằng runtime.
---

# Flutter Performance Review (Project)

Bản **repo-specific** của skill `flutter-performance-review`. Trong repo này, **ưu tiên bản này** hơn bản global tại `~/.cursor/skills/flutter-performance-review/`.

Skill **review tĩnh** (đọc code) để tìm rủi ro performance. Không tự rewrite code trước — nhiệm vụ đầu tiên là **phát hiện → giải thích WHY → ước lượng impact định tính → đề xuất fix**.

Ưu tiên cải thiện có thể đo được hơn là thẩm mỹ code. Ưu tiên best practices của Flutter và convention repo (xem `AGENTS.md`).

> Skill này chỉ review tĩnh. Muốn **đo runtime thật** (jank, PSS, CPU) dùng kèm skill `perf-agent`. Xem [Verification](#verification).

---

## Convention repo (bắt buộc — override bản global)

So với bản global (stack-agnostic), bản này **ép convention của `base_flutter_project`**:

- State management: **chỉ BLoC** (`BaseBloc`), **không tạo Cubit mới**. Không đề xuất Provider/Riverpod/InheritedWidget.
- Giảm rebuild: `BlocSelector`, `context.select`, tách widget con `const`, `BlocBuilder` với `buildWhen`.
- Màu: `AppColors`; text style: `context.textStyles` từ `base_ui`. Không hardcode.
- BLoC không navigate.
- Fix đề xuất phải map đúng layer: presentation → domain ← data.

---

## Workflow

### Bước 1 — Scope
Không phải lúc nào cũng duyệt đủ mọi nhóm. Chọn scope theo yêu cầu:

| Trigger | Scope |
|---------|-------|
| User chỉ định (vd. "check rebuild") | Chỉ nhóm liên quan |
| Review 1 diff / 1 màn hình | Chỉ nhóm liên quan tới file đã đổi |
| "Full performance review" | Duyệt đủ 13 nhóm theo thứ tự |
| Không rõ | Hỏi user |

### Bước 2 — Rà soát theo checklist
Duyệt các nhóm trong [Checklist](#checklist) thuộc scope. Với mỗi vấn đề, ghi: **rebuild/leak source · widget/file bị ảnh hưởng · WHY · impact định tính**.

### Bước 3 — Báo cáo
Theo [Output Format](#output-format). Nếu không có vấn đề → nói rõ code đạt best practices.

### Bước 4 — (Tùy chọn) Verify runtime
Đề xuất đo bằng DevTools / `perf-agent` để xác nhận giả thuyết. Xem [Verification](#verification).

---

## Checklist

### 1. Widget Rebuild
Rebuild nhiều hơn cần thiết.
- `BlocBuilder` rebuild cả page thay vì phần nhỏ → `BlocSelector` / `buildWhen`.
- `AnimatedBuilder` / `StreamBuilder` bọc cây widget không liên quan → thu hẹp `child`, tách `const`.
- `FutureBuilder` tạo `Future` mới mỗi build (Future khởi tạo inline) → tạo Future 1 lần (initState / field).
- Không truyền callback/`Object` mới mỗi build làm con rebuild.

### 2. Const Optimization
Widget tĩnh nên `const` để bỏ qua rebuild qua canonicalization: `Text`, `Icon`, `SizedBox`, `Padding`, `EdgeInsets`, `Divider`, `Spacer`.
- Impact định tính, thường thấp–trung bình; đáng làm ở subtree rebuild thường xuyên.

### 3. List & Scroll Performance
- `Column`/`ListView(children:)`/`GridView(children:)`/`SingleChildScrollView` chứa nhiều item → `ListView.builder` / `GridView.builder` / `SliverList` / `SliverGrid`.
- `shrinkWrap: true` + `NeverScrollableScrollPhysics` cho list dài → lazy build.
- Nested scroll (list trong list cùng trục) → `CustomScrollView` + slivers.
- Thiếu pagination cho list lớn → load thêm theo trang.

### 4. Image Performance
- `Image.network` không cache / tải lặp → `CachedNetworkImage`.
- Ảnh lớn hơn kích thước hiển thị → set `cacheWidth`/`cacheHeight`, resize.
- Ảnh critical → `precacheImage`.

### 5. Memory / Dispose (dễ thành Critical)
Controller/subscription phải `dispose()`/`cancel()` trong `dispose()`:
`AnimationController`, `TabController`, `PageController`, `ScrollController`, `FocusNode`, `TextEditingController`, `Ticker`, `StreamSubscription`, `Timer`, `ChangeNotifier`.
- Tìm: thiếu dispose, giữ reference thừa, closure bắt `context`/state gây leak.

### 6. Async trong build
- Tạo `Future`/gọi API/query DB/đọc file **bên trong `build()`** → chuyển ra `initState`/BLoC event, cache ở repository.
- API/DB gọi lặp cho cùng dữ liệu → memoize / cache.

### 7. State Scope
- State quá rộng khiến cả màn rebuild → tách state, dùng `BlocSelector`/`context.select` chỉ đọc field cần.
- Business/shared state qua BLoC; local UI state dùng controller.

### 8. Paint / Render Cost
Widget đắt — giải thích WHY (tạo layer riêng, saveLayer, đo intrinsic 2 lần):
- `Opacity` (dùng `AnimatedOpacity`/`Color.withOpacity` trên paint khi được, hoặc `FadeTransition`).
- `ClipPath`/nhiều clip lồng, `BackdropFilter`, `ShaderMask` (giới hạn vùng, cân nhắc bỏ).
- `IntrinsicHeight`/`IntrinsicWidth`/`FittedBox` (layout đắt → thay bằng constraint cố định).
- Shadow/blur/gradient phức tạp, repaint region lớn → `RepaintBoundary`, decoration đơn giản hơn, giảm số layer.

### 9. Animation
- Animation chạy khi offscreen / animation vô hạn không dừng → stop/dispose theo lifecycle.
- `AnimatedBuilder` rebuild subtree nặng → tách phần tĩnh ra `child`.

### 10. Database
`Hive`/`Isar`/`SQLite`/`ObjectBox`:
- Query trong `build()`, đọc lặp, deserialize object lớn → cache, đọc 1 lần, chọn field cần.

### 11. Network
- Request lặp, thiếu debounce/throttle (search/scroll), thiếu pagination → thêm debounce/throttle, cache, phân trang.

---

## Severity Levels
Dùng đúng các mức sau:

| Mức | Nghĩa |
|-----|-------|
| **Critical** | Gây freeze, crash, memory leak, jank nặng |
| **High** | Suy giảm performance rõ rệt |
| **Medium** | Sẽ thành vấn đề khi app lớn lên |
| **Low** | Tối ưu nhỏ |
| **Info** | Chỉ là gợi ý |

---

## Output Format

```markdown
## Summary
- Critical: X  ·  High: X  ·  Medium: X  ·  Low: X

## Findings

### [Severity] <tiêu đề ngắn>
- **Location**: file:line
- **Vấn đề**: ...
- **WHY**: tại sao ảnh hưởng performance
- **Impact**: định tính (thấp / trung bình / cao) + trục ảnh hưởng (rebuild / memory / frame time)
- **Recommendation**: fix theo convention repo
- **Example Fix**: snippet before/after (nếu áp dụng được)

## Positive Findings
- Các practice tốt đã có sẵn.

## Overall Assessment
- Tình trạng performance hiện tại.
- Top 3 cải thiện impact cao nhất.
- (Nếu cần) Cách verify bằng runtime.
```

> **Không** dùng "score X/100". **Không** bịa số tuyệt đối kiểu "giảm 15MB / rebuild -40%" khi chỉ review tĩnh — dùng impact định tính, hoặc yêu cầu đo runtime để có số thật.

---

## Ví dụ fix

**Rebuild cả page → BlocSelector**
```dart
// Before: mọi thay đổi state đều rebuild toàn bộ
BlocBuilder<ProfileBloc, ProfileState>(
  builder: (context, state) => ExpensiveTree(name: state.name),
);

// After: chỉ rebuild khi `name` đổi
BlocSelector<ProfileBloc, ProfileState, String?>(
  selector: (state) => state.name,
  builder: (context, name) => ExpensiveTree(name: name),
);
```

**List không lazy → builder**
```dart
// Before
ListView(children: items.map((e) => ItemTile(e)).toList());

// After
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, i) => ItemTile(items[i]),
);
```

**Thiếu dispose (memory leak)**
```dart
late final _controller = ScrollController();

@override
void dispose() {
  _controller.dispose(); // bắt buộc
  super.dispose();
}
```

---

## Verification

Review tĩnh chỉ nêu **giả thuyết**. Xác nhận bằng runtime trước khi kết luận impact bằng số:

- `flutter run --profile` + **Flutter DevTools**: Performance/Timeline (jank), CPU profiler, Memory (leak/allocation).
- Bật **Performance overlay** để thấy frame chart.
- `debugProfileBuildsEnabled` / DevTools rebuild counter để đo rebuild thật.
- Đo device thật (jank, PSS, CPU) → dùng skill **`perf-agent`** (ADB: gfxinfo, meminfo, top).

---

## Rules
- Không premature optimization.
- Không đề xuất thay đổi mà không giải thích WHY.
- Ưu tiên readability trừ khi lợi ích performance đáng kể.
- Không đổi package/dependency trừ khi có lợi ích đo được.
- Impact ước lượng ở mức **định tính**; số tuyệt đối chỉ khi có dữ liệu runtime.
- Không có vấn đề → nói rõ code đạt Flutter performance best practices.
