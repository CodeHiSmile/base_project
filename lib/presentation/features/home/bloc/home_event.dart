import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';

abstract class HomeEvent extends BaseBlocEvent {
  const HomeEvent();
}

class InitialHomeDataEvent extends HomeEvent {
  const InitialHomeDataEvent();
}