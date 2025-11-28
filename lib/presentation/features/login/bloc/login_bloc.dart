import 'dart:async';

import 'package:domain/domain.dart';
import 'package:base_ui/base_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

@Injectable()
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc(this._saveTokenUseCase) : super(const LoginState()) {
    on<InitialLoginDataEvent>(_onInitialDataEvent);
    on<OnLoginEvent>(_onLoginEvent);
  }

  final SaveTokenUseCase _saveTokenUseCase;

  FutureOr<void> _onInitialDataEvent(
    InitialLoginDataEvent event,
    Emitter<LoginState> emit,
  ) {}

  FutureOr<void> _onLoginEvent(
    OnLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    return runBlocCatching(
      handleError: true,
      action: () async {
        await _saveTokenUseCase.execute(
          SaveTokenInput(
            accessToken: event.account,
            refreshToken: event.password,
          ),
        );
      },
      doOnEventCompleted: () async {
        event.completer?.complete(true);
      },
    );
  }
}
