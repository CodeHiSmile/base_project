import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';

abstract class ProductListEvent extends BaseBlocEvent {
  const ProductListEvent();
}

class InitialProductListDataEvent extends ProductListEvent {
  const InitialProductListDataEvent();
}