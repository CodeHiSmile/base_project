import 'dart:async';

import 'package:base_ui/base_ui.dart';

abstract class LoginEvent extends BaseBlocEvent {
  const LoginEvent();
}

class InitialLoginDataEvent extends LoginEvent {
  const InitialLoginDataEvent();
}

class OnLoginEvent extends LoginEvent {
  final Completer? completer;
  final String account;
  final String password;

  const OnLoginEvent({
    this.completer,
    required this.account,
    required this.password,
  });
}
