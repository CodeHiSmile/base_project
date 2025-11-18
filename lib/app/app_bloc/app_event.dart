import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';

abstract class AppEvent extends BaseBlocEvent {
  const AppEvent();
}

class AppInitiated extends AppEvent {
  const AppInitiated();
}

class IsLoggedInStatusChanged extends AppEvent {
  final bool isLoggedIn;

  const IsLoggedInStatusChanged({required this.isLoggedIn});
}

class AppThemeChanged extends AppEvent {
  final bool isDarkTheme;

  const AppThemeChanged({required this.isDarkTheme});
}

class AppLanguageChanged extends AppEvent {
  final LanguageCode languageCode;

  const AppLanguageChanged({required this.languageCode});
}

class ChangeDebugSettingEvent extends AppEvent {
  final bool? debugNotify;
  final bool? debugButtonOverlay;

  const ChangeDebugSettingEvent({this.debugNotify, this.debugButtonOverlay});
}
