import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order_state.freezed.dart';

@freezed
abstract class CreateOrderState extends BaseBlocState with _$CreateOrderState {
  const CreateOrderState._();

  const factory CreateOrderState({
      @Default(LoadingStatus.initial) LoadingStatus? loadStatus,
      }) = _CreateOrderState;
}