import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
abstract class AppState extends BaseBlocState with _$AppState {
  const AppState._();

  const factory AppState({
    @Default(LanguageCode.vi) LanguageCode languageCode,
    @Default(false) bool isLoggedIn,
    @Default(false) bool isDarkTheme,
    @Default(false) bool debugNotify,
    @Default(false) bool debugOverlayButton,
    @Default(null) bool? shouldRequestLocation,
    @Default(false) bool navigateToHome,
  }) = _AppState;
}
