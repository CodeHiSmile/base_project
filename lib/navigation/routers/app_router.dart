import 'package:base_project/navigation/middleware/entry.dart';
import 'package:base_project/navigation/routers/router_paths.dart';
import 'package:base_project/presentation/features/create_order/create_order_page.dart';
import 'package:base_project/presentation/features/home/home_page.dart';
import 'package:base_project/presentation/features/login/login_page.dart';
import 'package:base_project/presentation/features/main/main_page.dart';
import 'package:base_project/presentation/features/product/product_detail/product_detail_page.dart';
import 'package:base_project/presentation/features/product/product_list/product_list_page.dart';
import 'package:base_project/presentation/features/splash/splash_page.dart';

class AppRouter {
  /// Danh sách tất cả routes của app
  static List<RouteEntry> routerConfiguration() {
    return [
      RouteEntry(
        path: RouterPaths.splash,
        builder: (context, state) => SplashPage(),
      ),
      RouteEntry(
        path: RouterPaths.login,
        builder: (context, state) => LoginPage(),
      ),
      RouteEntry(
        path: RouterPaths.main,
        builder: (context, state) => MainPage(),
      ),
      RouteEntry(
        protected: true,
        path: RouterPaths.profile,
        builder: (context, state) => HomePage(),
      ),
      RouteEntry(
        path: RouterPaths.productList,
        builder: (context, state) => ProductListPage(),
      ),
      RouteEntry(
        path: RouterPaths.productDetail,
        builder: (context, state) => ProductDetailPage(),
      ),
      RouteEntry(
        protected: true,
        path: RouterPaths.createOrder,
        builder: (context, state) {
          return CreateOrderPage(
            arguments: state.extra as CreateOrderArguments?,
          );
        },
      ),
    ];
  }
}
