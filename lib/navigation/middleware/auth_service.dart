import 'dart:async';

import 'package:base_project/navigation/middleware/route_guard.dart';
import 'package:base_project/navigation/middleware/router_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthService {
  static String loginPath = '/login';

  static String mainPagePath = '/';

  bool _isLoggedIn = false;

  /// Stream để theo dõi auth state changes
  final StreamController<bool> _authStateController =
      StreamController<bool>.broadcast();

  Stream<bool> get authStateStream => _authStateController.stream;

  AuthService() {
    // Listen to auth state changes và notify router
    authStateStream.listen((isLoggedIn) {
      RouterGuard.notifyAuthStateChanged(isLoggedIn);
    });
  }

  void changeLoginPath(String path) {
    if (loginPath != path) {
      loginPath = path;
    }
  }

  void changeMainPagePath(String path) {
    if (mainPagePath != path) {
      mainPagePath = path;
    }
  }

  /// Kiểm tra trạng thái đăng nhập
  Future<bool> isLoggedIn() async {
    return _isLoggedIn;
  }

  /// Đăng nhập - phiên bản AUTO-RESTORE
  Future<bool> loginWithAutoRestore() async {
    print('🔐 Đang đăng nhập với auto-restore...');

    _isLoggedIn = true;

    // ✨ Chỗ này là magic! Chỉ cần notify auth state changed
    // Router sẽ tự động restore route với toàn bộ data
    _authStateController.add(true);

    print('✅ Login thành công! Router sẽ tự động restore...');

    return true;
  }

  /// Đăng nhập - phiên bản MANUAL (cách cũ)
  Future<bool> loginWithManualRestore({bool canPushToPage = true}) async {
    print('🔐 Đăng nhập với manual restore...');

    _isLoggedIn = true;

    // Cách cũ: phải tự gọi restore
    RouterService.restoreSavedRoute(canPushToPage: canPushToPage);

    print('✅ Login thành công! Đã manual restore route.');

    return true;
  }

  /// Đăng xuất
  Future<void> logout() async {
    print('🚪 Đang đăng xuất...');

    _isLoggedIn = false;

    // Clear saved route khi logout
    RouterService.clearSavedRoute();

    // Notify auth state changed
    _authStateController.add(false);

    // Navigate to login
    RouterService.navigateTo('/login');

    print('✅ Đã đăng xuất và clear saved route.');
  }

  /// Login với custom behavior
  Future<bool> loginWithCustomRestore({
    bool shouldAutoRestore = true,
    void Function()? onRestoreComplete,
  }) async {
    _isLoggedIn = true;

    if (shouldAutoRestore) {
      // Configure callback trước khi restore
      if (onRestoreComplete != null) {
        RouterService.configureAutoRestore(
          onAuthStateChanged: onRestoreComplete,
        );
      }
      // Trigger auto-restore
      _authStateController.add(true);
    } else {
      // Skip auto-restore
      print('⏭️ Skip auto-restore theo yêu cầu');
    }

    return true;
  }

  /// Get thông tin về route sẽ được restore
  Map<String, dynamic>? getRestorePreview() {
    return RouterService.getSavedRouteInfo();
  }

  void dispose() {
    _authStateController.close();
  }
}
