import 'package:base_project/di/di.dart';
import 'package:base_project/navigation/middleware/entry.dart';
import 'package:base_project/navigation/middleware/route_guard.dart';
import 'package:base_project/navigation/middleware/router_logger.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

/// Router Service quản lý toàn bộ navigation trong app
@LazySingleton()
class RouterService extends ChangeNotifier {
  final List<RouteEntry> _routes = [];
  late GoRouter _router;

  static String initialPath = '/';

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

  void changeInitialPath(String path) {
    if (initialPath != path) {
      initialPath = path;
    }
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
      initialLocation: initialPath,
      redirect: getIt<RouterGuard>().guard,
      debugLogDiagnostics: false,
      navigatorKey: RouterService.navigatorKey,
      routes: _routes.map(mapEntryToGoRoute).toList(),
      observers: [AppNavigatorObserver()],
    );
  }

  GoRoute mapEntryToGoRoute(RouteEntry entry) {
    return GoRoute(
      path: entry.path,
      builder: (context, state) => entry.builder(context, state),
      routes: entry.routes?.map(mapEntryToGoRoute).toList() ?? [],
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

  static void replace(String path, {Object? extra}) {
    if (currentContext != null) {
      GoRouter.of(currentContext!).replace(path, extra: extra);
    }
  }

  static bool canPop() {
    return GoRouter.of(currentContext!).canPop();
  }

  static String getCurrentRouteName({bool useRootNavigator = false}) {
    if (currentContext != null) {
      final router = GoRouter.of(currentContext!);
      final path = router.state.path ?? "";

      RouterLogger.info(path);
      return path;
    }

    return '';
  }

  static void popUntilRoot() {
    //Cách 1:
    // if (currentContext != null) {
    //   while (currentContext!.canPop()) {
    //     currentContext!.pop();
    //   }
    // }

    //Cách 2: Nên dùng
    currentNavigator?.popUntil((route) => route.isFirst);
  }

  static void popUntilRouteName(String routeName) {
    currentNavigator?.popUntil((route) {
      return route.settings.name == routeName;
    });
  }

  /// Khôi phục route đã lưu sau khi đăng nhập thành công
  static void restoreSavedRoute() {
    RouterGuard.restoreRouteWithData();
  }

  /// Khôi phục route đã lưu và navigate qua MainPage sau khi đăng nhập thành công
  static void restoreRouteAfterLogin() {
    RouterGuard.restoreSavedRouteViaMainPage();
  }

  /// Tự động restore route và trigger callback
  static void autoRestoreAfterLogin() {
    RouterGuard.restoreRouteWithData();
    _onAuthStateChanged?.call();
  }

  /// Lấy thông tin về route đã lưu
  static Map<String, dynamic>? getSavedRouteInfo() {
    return RouterGuard.getSavedRouteInfo();
  }

  /// Xóa route đã lưu
  static void clearSavedRoute() {
    RouterGuard.clearSavedRoute();
  }
}
