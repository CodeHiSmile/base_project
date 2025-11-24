import 'dart:async';

import 'package:base_project/navigation/middleware/router_service.dart';
import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@LazySingleton(as: AppNavigator)
class AppNavigatorImpl extends AppNavigator {
  AppNavigatorImpl(this._appRouter, this._appPopupInfoMapper);

  final RouterService _appRouter;
  final BasePopupInfoMapper _appPopupInfoMapper;
  final _shownPopups = <AppPopupInfo, Completer<dynamic>>{};

  m.BuildContext get _rootRouterContext =>
      RouterService.navigatorKey.currentContext!;

  @override
  bool removeLast() {
    if (LogConfig.enableNavigatorObserverLog) {
      LogUtils.d('removeLast');
    }

    return true;

    // return _appRouter.removeLast();
  }

  @override
  void showErrorSnackBar(String message, {Duration? duration}) {
    // ViewUtils.showAppSnackBar(
    //   _rootRouterContext,
    //   message,
    //   duration: duration,
    //   // backgroundColor: AppColors.current.primaryColor,
    // );
  }

  @override
  void showSuccessSnackBar(String message, {Duration? duration}) {
    // ViewUtils.showAppSnackBar(
    //   _rootRouterContext,
    //   message,
    //   duration: duration,
    // );
  }

  @override
  // TODO: implement currentBottomTab
  int get currentBottomTab => throw UnimplementedError();

  @override
  // TODO: implement canPopSelfOrChildren
  bool get canPopSelfOrChildren => throw UnimplementedError();

  @override
  String getCurrentRouteName({bool useRootNavigator = false}) {
    // TODO: implement getCurrentRouteName
    throw UnimplementedError();
  }

  @override
  void navigateToBottomTab(int index, {bool notify = true}) {
    // TODO: implement navigateToBottomTab
  }

  @override
  void pop<T extends Object?>({T? result, bool useRootNavigator = false}) {
    // TODO: implement pop
  }

  @override
  Future<T?> popAndPush<T extends Object?, R extends Object?>(
    AppRouteInfo appRouteInfo, {
    R? result,
    bool useRootNavigator = false,
  }) {
    // TODO: implement popAndPush
    throw UnimplementedError();
  }

  @override
  Future<void> popAndPushAll(
    List<AppRouteInfo> listAppRouteInfo, {
    bool useRootNavigator = false,
  }) {
    // TODO: implement popAndPushAll
    throw UnimplementedError();
  }

  @override
  void popUntilRoot({bool useRootNavigator = false}) {
    // TODO: implement popUntilRoot
  }

  @override
  void popUntilRootOfCurrentBottomTab() {
    // TODO: implement popUntilRootOfCurrentBottomTab
  }

  @override
  void popUntilRouteName(String routeName) {
    // TODO: implement popUntilRouteName
  }

  @override
  Future<T?> push<T extends Object?>(
    AppRouteInfo appRouteInfo, {
    bool deleteSameRoute = false,
  }) {
    // TODO: implement push
    throw UnimplementedError();
  }

  @override
  Future<void> pushAll(List<AppRouteInfo> listAppRouteInfo) {
    // TODO: implement pushAll
    throw UnimplementedError();
  }

  @override
  bool removeAllRoutesWithName(String routeName) {
    // TODO: implement removeAllRoutesWithName
    throw UnimplementedError();
  }

  @override
  bool removeUntilRouteName(String routeName) {
    // TODO: implement removeUntilRouteName
    throw UnimplementedError();
  }

  @override
  Future<T?> replace<T extends Object?>(AppRouteInfo appRouteInfo) {
    // TODO: implement replace
    throw UnimplementedError();
  }

  @override
  Future<void> replaceAll(List<AppRouteInfo> listAppRouteInfo) {
    // TODO: implement replaceAll
    throw UnimplementedError();
  }

  @override
  Future<T?> showDialog<T extends Object?>(
    AppPopupInfo appPopupInfo, {
    bool barrierDismissible = true,
    bool useSafeArea = false,
    bool useRootNavigator = true,
  }) {
    // TODO: implement showDialog
    throw UnimplementedError();
  }

  @override
  Future<T?> showGeneralDialog<T extends Object?>(
    AppPopupInfo appPopupInfo, {
    m.Widget Function(
      m.BuildContext,
      m.Animation<double>,
      m.Animation<double>,
      m.Widget,
    )?
    transitionBuilder,
    Duration transitionDuration =
        DurationConstants.defaultGeneralDialogTransitionDuration,
    bool barrierDismissible = true,
    m.Color barrierColor = const Color(0x80000000),
    bool useRootNavigator = true,
    String? barrierLabel,
  }) {
    // TODO: implement showGeneralDialog
    throw UnimplementedError();
  }

  @override
  Future<T?> showModalBottomSheet<T extends Object?>(
    AppPopupInfo appPopupInfo, {
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    m.Color barrierColor = Colors.black54,
    m.Color? backgroundColor,
  }) {
    // TODO: implement showModalBottomSheet
    throw UnimplementedError();
  }
}
