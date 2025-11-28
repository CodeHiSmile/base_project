import 'dart:async';

import 'package:domain/domain.dart';
import 'package:base_ui/base_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

@Injectable()
class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._deleteTokenUseCase) : super(const ProfileState()) {
    on<InitialProfileDataEvent>(_onInitialDataEvent);
    on<LogoutEvent>(_logoutEvent);
  }

  final DeleteTokenUseCase _deleteTokenUseCase;

  FutureOr<void> _onInitialDataEvent(
    InitialProfileDataEvent event,
    Emitter<ProfileState> emit,
  ) {}

  FutureOr<void> _logoutEvent(
    LogoutEvent event,
    Emitter<ProfileState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        await _deleteTokenUseCase.execute(
          DeleteTokenInput(accessToken: '', refreshToken: ''),
        );

        emit(state.copyWith(loadStatus: LoadingStatus.success));
      },
      doOnEventCompleted: () async {
        event.completer?.complete(true);
      },
    );
  }
}
