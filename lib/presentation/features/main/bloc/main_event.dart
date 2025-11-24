import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';

abstract class MainEvent extends BaseBlocEvent {
  const MainEvent();
}

class InitialMainDataEvent extends MainEvent {
  const InitialMainDataEvent();
}