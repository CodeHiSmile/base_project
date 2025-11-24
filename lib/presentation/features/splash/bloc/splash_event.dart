import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';

abstract class SplashEvent extends BaseBlocEvent {
  const SplashEvent();
}

class InitialSplashDataEvent extends SplashEvent {
  const InitialSplashDataEvent();
}
