import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppNavigator {
  AppNavigator._();

  static final BaseNavigator _service = GetIt.I<BaseNavigator>();

  static GlobalKey<NavigatorState> get navigatorKey => _service.navigatorKey;

  static NavigatorState? get currentNavigator => _service.currentNavigator;

  static BuildContext? get currentContext => _service.currentContext;

  static void go(String path, {Object? extra}) =>
      _service.navigateTo(path, extra: extra);

  static Future<dynamic> push(String path, {Object? extra}) =>
      _service.pushTo(path, extra: extra);

  static Future<void> pop([Object? result]) => _service.pop(result);

  static Future<void> pushReplacement(String path, {Object? extra}) =>
      _service.pushReplacement(path, extra: extra);

  static Future<void> replace(String path, {Object? extra}) =>
      _service.replace(path, extra: extra);

  static bool canPop() => _service.canPop();

  static String getCurrentPath() => _service.getCurrentPath();

  static void popUntilRoot() => _service.popUntilRoot();

  static void popUntil(String routeName) =>
      _service.popUntilRouteName(routeName);
}
