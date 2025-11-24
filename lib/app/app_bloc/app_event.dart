import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';

abstract class AppEvent extends BaseBlocEvent {
  const AppEvent();
}

class AppInitiated extends AppEvent {
  const AppInitiated();
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

class ChangeMainPageIndexEvent extends AppEvent {
  final int pageIndex;

  const ChangeMainPageIndexEvent({required this.pageIndex});
}
