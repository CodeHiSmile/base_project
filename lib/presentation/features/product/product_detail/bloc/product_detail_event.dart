import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';

abstract class ProductDetailEvent extends BaseBlocEvent {
  const ProductDetailEvent();
}

class InitialProductDetailDataEvent extends ProductDetailEvent {
  const InitialProductDetailDataEvent();
}