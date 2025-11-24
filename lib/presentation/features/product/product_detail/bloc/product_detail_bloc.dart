import 'dart:async';

import 'package:domain/domain.dart';
import 'package:base_ui/base_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';

@Injectable()
class ProductDetailBloc extends BaseBloc<ProductDetailEvent, ProductDetailState> {
ProductDetailBloc(
     )
      : super(const ProductDetailState()) {
      on<InitialProductDetailDataEvent>(_onInitialDataEvent);
  }

  FutureOr<void> _onInitialDataEvent(
    InitialProductDetailDataEvent event,
    Emitter<ProductDetailState> emit,
  ) {}

}
