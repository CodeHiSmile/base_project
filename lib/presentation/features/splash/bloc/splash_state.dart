import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
abstract class SplashState extends BaseBlocState with _$SplashState {
  const SplashState._();

  const factory SplashState({
    @Default(LoadingStatus.initial) LoadingStatus? loadStatus,
  }) = _SplashState;
}
