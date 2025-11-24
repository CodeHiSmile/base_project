import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_state.freezed.dart';

@freezed
abstract class MainState extends BaseBlocState with _$MainState {
  const MainState._();

  const factory MainState({
      @Default(LoadingStatus.initial) LoadingStatus? loadStatus,
      }) = _MainState;
}