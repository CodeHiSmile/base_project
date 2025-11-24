import 'dart:async';

import 'package:domain/domain.dart';
import 'package:base_ui/base_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'main_event.dart';
import 'main_state.dart';

@Injectable()
class MainBloc extends BaseBloc<MainEvent, MainState> {
MainBloc(
     )
      : super(const MainState()) {
      on<InitialMainDataEvent>(_onInitialDataEvent);
  }

  FutureOr<void> _onInitialDataEvent(
    InitialMainDataEvent event,
    Emitter<MainState> emit,
  ) {}

}
