import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState extends BaseBlocState with _$LoginState {
  const LoginState._();

  const factory LoginState({
      @Default(LoadingStatus.initial) LoadingStatus? loadStatus,
      }) = _LoginState;
}