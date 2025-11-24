import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState extends BaseBlocState with _$ProfileState {
  const ProfileState._();

  const factory ProfileState({
      @Default(LoadingStatus.initial) LoadingStatus? loadStatus,
      }) = _ProfileState;
}