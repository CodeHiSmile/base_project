import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState extends BaseBlocState with _$HomeState {
  const HomeState._();

  const factory HomeState({
      @Default(LoadingStatus.initial) LoadingStatus? loadStatus,
      }) = _HomeState;
}