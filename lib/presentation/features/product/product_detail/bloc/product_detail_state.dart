import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_detail_state.freezed.dart';

@freezed
abstract class ProductDetailState extends BaseBlocState with _$ProductDetailState {
  const ProductDetailState._();

  const factory ProductDetailState({
      @Default(LoadingStatus.initial) LoadingStatus? loadStatus,
      }) = _ProductDetailState;
}