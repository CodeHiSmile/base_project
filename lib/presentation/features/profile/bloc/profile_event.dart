import 'dart:async';

import 'package:base_ui/base_ui.dart';

abstract class ProfileEvent extends BaseBlocEvent {
  const ProfileEvent();
}

class InitialProfileDataEvent extends ProfileEvent {
  const InitialProfileDataEvent();
}

class LogoutEvent extends ProfileEvent {
  final Completer? completer;

  const LogoutEvent({this.completer});
}
