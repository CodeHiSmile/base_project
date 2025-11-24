import 'dart:async';

import 'package:domain/domain.dart';
import 'package:base_ui/base_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

@Injectable()
class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
ProfileBloc(
     )
      : super(const ProfileState()) {
      on<InitialProfileDataEvent>(_onInitialDataEvent);
  }

  FutureOr<void> _onInitialDataEvent(
    InitialProfileDataEvent event,
    Emitter<ProfileState> emit,
  ) {}

}
