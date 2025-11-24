import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_list_state.freezed.dart';

@freezed
abstract class ProductListState extends BaseBlocState with _$ProductListState {
  const ProductListState._();

  const factory ProductListState({
      @Default(LoadingStatus.initial) LoadingStatus? loadStatus,
      }) = _ProductListState;
}