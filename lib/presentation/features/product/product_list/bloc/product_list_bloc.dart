import 'dart:async';

import 'package:domain/domain.dart';
import 'package:base_ui/base_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';

@Injectable()
class ProductListBloc extends BaseBloc<ProductListEvent, ProductListState> {
ProductListBloc(
     )
      : super(const ProductListState()) {
      on<InitialProductListDataEvent>(_onInitialDataEvent);
  }

  FutureOr<void> _onInitialDataEvent(
    InitialProductListDataEvent event,
    Emitter<ProductListState> emit,
  ) {}

}
