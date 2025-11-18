import 'dart:async';

import 'package:base_project/navigation/middleware/route_guard.dart';
import 'package:base_project/navigation/middleware/router_service.dart';
import 'package:injectable/injectable.dart';

/// Example AuthService với Auto-Restore integration.
@LazySingleton()
class AuthService {
  static const String loginRouter = '/login';

  bool _isLoggedIn = false;
  String? lastAttemptedRoute;
  String? loginSuccessAttemptedRoute;

  /// Stream để theo dõi auth state changes
  final StreamController<bool> _authStateController =
      StreamController<bool>.broadcast();

  Stream<bool> get authStateStream => _authStateController.stream;

  AuthService() {
    // Listen to auth state changes và notify router
    authStateStream.listen((isLoggedIn) {
      AppRouterGuard.notifyAuthStateChanged(isLoggedIn);
    });
  }

  /// Kiểm tra trạng thái đăng nhập
  Future<bool> isLoggedIn() async {
    // Simulate async check (có thể từ SharedPreferences, SecureStorage, etc.)
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
  Future<bool> loginWithManualRestore() async {
    print('🔐 Đăng nhập với manual restore...');

    _isLoggedIn = true;

    // Cách cũ: phải tự gọi restore
    RouterService.restoreSavedRoute();

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
  Future<bool> loginWithCustomRestore(
    String username,
    String password, {
    bool shouldAutoRestore = true,
    void Function()? onRestoreComplete,
  }) async {
    bool success = username.isNotEmpty && password.isNotEmpty;

    if (success) {
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
    }

    return success;
  }

  /// Get thông tin về route sẽ được restore
  Map<String, dynamic>? getRestorePreview() {
    return RouterService.getSavedRouteInfo();
  }

  void dispose() {
    _authStateController.close();
  }
}