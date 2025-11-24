import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';

abstract class LoginEvent extends BaseBlocEvent {
  const LoginEvent();
}

class InitialLoginDataEvent extends LoginEvent {
  const InitialLoginDataEvent();
}