import 'dart:async';

import 'package:domain/domain.dart';
import 'package:base_ui/base_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_order_event.dart';
import 'create_order_state.dart';

@Injectable()
class CreateOrderBloc extends BaseBloc<CreateOrderEvent, CreateOrderState> {
CreateOrderBloc(
     )
      : super(const CreateOrderState()) {
      on<InitialCreateOrderDataEvent>(_onInitialDataEvent);
  }

  FutureOr<void> _onInitialDataEvent(
    InitialCreateOrderDataEvent event,
    Emitter<CreateOrderState> emit,
  ) {}

}
