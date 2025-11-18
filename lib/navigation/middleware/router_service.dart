import 'package:base_project/di/di.dart';
import 'package:base_project/navigation/middleware/entry.dart';
import 'package:base_project/navigation/middleware/route_guard.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

/// Router Service quản lý toàn bộ navigation trong app
@LazySingleton()
class RouterService extends ChangeNotifier {
  final List<RouteEntry> _routes = [];
  late GoRouter _router;

  /// GlobalKey để truy cập NavigatorState từ bất kỳ đâu trong app
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Callback được gọi khi cần restore route sau khi login
  static void Function()? _onAuthStateChanged;

  /// Cấu hình auto-restore khi auth state thay đổi
  static void configureAutoRestore({void Function()? onAuthStateChanged}) {
    _onAuthStateChanged = onAuthStateChanged;
  }

  static Set<String> protectedRoutes = {};

  RouterService() {
    _updateRouter();
  }

  void registerRoute(RouteEntry entry) {
    _routes.add(entry);
    _updateRouter();
    notifyListeners(); // Thông báo UI cập nhật
  }

  void registerRoutes(List<RouteEntry> entries) {
    _routes.addAll(entries);
    _updateRouter();
  }

  void _updateRouter() {
    protectedRoutes = _routes
        .where((element) => element.protected)
        .map((e) => e.path)
        .toSet();

    _router = GoRouter(
      navigatorKey: RouterService.navigatorKey,
      initialLocation: '/',
      redirect: getIt<AppRouterGuard>().guard,
      debugLogDiagnostics: false,
      routes: _routes.map((entry) {
        return GoRoute(
          path: entry.path,
          builder: (context, state) => entry.builder(context, state),
        );
      }).toList(),
      observers: [AppNavigatorObserver()],
    );
  }

  GoRouter get router => getIt<RouterService>()._router;

  /// Lấy RouterService instance từ GetIt
  static RouterService get instance => getIt<RouterService>();

  /// Lấy NavigatorState hiện tại từ GlobalKey
  static NavigatorState? get currentNavigator => navigatorKey.currentState;

  /// Lấy BuildContext hiện tại từ NavigatorState
  static BuildContext? get currentContext => navigatorKey.currentContext;

  /// Navigate đến route mới mà không cần BuildContext
  static void navigateTo(String path, {Object? extra}) {
    if (currentContext != null) {
      GoRouter.of(currentContext!).go(path, extra: extra);
    }
  }

  /// Push route mới mà không cần BuildContext
  static void pushTo(String path, {Object? extra}) {
    if (currentContext != null) {
      GoRouter.of(currentContext!).push(path, extra: extra);
    }
  }

  /// Pop route hiện tại mà không cần BuildContext
  static void pop([Object? result]) {
    currentNavigator?.pop(result);
  }

  /// Push và replace route hiện tại mà không cần BuildContext
  static void pushReplacement(String path, {Object? extra}) {
    if (currentContext != null) {
      GoRouter.of(currentContext!).pushReplacement(path, extra: extra);
    }
  }

  /// Khôi phục route đã lưu sau khi đăng nhập thành công
  static void restoreSavedRoute() {
    AppRouterGuard.restoreRouteWithData();
  }

  /// Tự động restore route và trigger callback
  static void autoRestoreAfterLogin() {
    AppRouterGuard.restoreRouteWithData();
    _onAuthStateChanged?.call();
  }

  /// Lấy thông tin về route đã lưu
  static Map<String, dynamic>? getSavedRouteInfo() {
    return AppRouterGuard.getSavedRouteInfo();
  }

  /// Xóa route đã lưu
  static void clearSavedRoute() {
    AppRouterGuard.clearSavedRoute();
  }
}
