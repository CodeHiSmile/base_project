import 'package:base_project/navigation/middleware/entry.dart';
import 'package:base_project/navigation/routers/router_paths.dart';
import 'package:base_project/presentation/features/home_page.dart';
import 'package:base_project/presentation/features/login_page.dart';
import 'package:base_project/presentation/features/profile_page.dart';
import 'package:base_project/presentation/features/setting_page.dart';
import 'package:base_project/presentation/features/splash_page.dart';

class AppRouter {
  /// Danh sách tất cả routes của app
  static List<RouteEntry> routerConfiguration() {
    return [
      RouteEntry(
        path: RouterPaths.splash,
        builder: (context, state) => SplashPage(),
      ),
      RouteEntry(
        path: RouterPaths.setting,
        builder: (context, state) => SettingPage(),
      ),
      RouteEntry(
        path: RouterPaths.home,
        builder: (context, state) => HomePage(),
      ),
      RouteEntry(
        path: RouterPaths.login,
        builder: (context, state) => LoginPage(),
      ),
      RouteEntry(
        path: RouterPaths.profile,
        builder: (context, state) =>
            ProfilePage(arguments: state.extra as ProfileArguments),
        protected: true,
      ),
    ];
  }
}
