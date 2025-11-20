import 'dart:async';

import 'package:domain/domain.dart';
import 'package:base_ui/base_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '{{name.snakeCase()}}_event.dart';
import '{{name.snakeCase()}}_state.dart';

@Injectable()
class {{name.pascalCase()}}Bloc extends BaseBloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
{{name.pascalCase()}}Bloc(
     )
      : super(const {{name.pascalCase()}}State()) {
      on<InitialDataEvent>(_onInitialDataEvent);
  }

  FutureOr<void> _onInitialDataEvent(
    InitialDataEvent event,
    Emitter<LoginState> emit,
  ) {}

}
