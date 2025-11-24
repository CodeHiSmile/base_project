import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';

abstract class ProfileEvent extends BaseBlocEvent {
  const ProfileEvent();
}

class InitialProfileDataEvent extends ProfileEvent {
  const InitialProfileDataEvent();
}