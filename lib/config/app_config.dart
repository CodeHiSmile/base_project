import 'package:base_ui/base_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../di/di.dart' as di;

class AppConfig extends ApplicationConfig {
  factory AppConfig.getInstance() {
    return _instance;
  }

  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  @override
  Future<void> config() async {
    di.configureInjection();
    Bloc.observer = AppBlocObserver();
    await SystemUtils.setPreferredOrientations(
      DeviceUtils.deviceType == DeviceType.mobile
          ? UiConstants.mobileOrientation
          : UiConstants.tabletOrientation,
    );
    SystemUtils.setSystemUIOverlayStyle(UiConstants.systemUiOverlay);
  }
}
