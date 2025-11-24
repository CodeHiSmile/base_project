import 'package:base_project/app/app_bloc/app_event.dart';
import 'package:base_project/app/app_bloc/app_state.dart';
import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart' hide Environment;
import 'package:shared/shared.dart';

@LazySingleton()
class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc(this._getInitialAppDataUseCase)
    : super(
        AppState(
          languageCode: LanguageCode.vi,
          debugOverlayButton:
              !(GetIt.instance.get<EnvironmentConfig>().getEnvironment() ==
                  Environment.production),
        ),
      ) {
    on<AppInitiated>(_onAppInitiated, transformer: log());
    on<ChangeMainPageIndexEvent>(_onChangeMainPageIndex, transformer: log());
  }

  final GetInitialAppDataUseCase _getInitialAppDataUseCase;

  Future<void> _onAppInitiated(
    AppInitiated event,
    Emitter<AppState> emit,
  ) async {
    await runBlocCatching(
      action: () async {
        final output = _getInitialAppDataUseCase.execute(
          const GetInitialAppDataInput(),
        );

        _updateThemeSetting(output.isDarkMode);
        emit(state.copyWith(isDarkTheme: output.isDarkMode));
      },
    );
  }

  void _updateThemeSetting(bool isDarkTheme) {
    AppThemeSetting.currentAppTheme = isDarkTheme
        ? AppThemeType.dark
        : AppThemeType.light;
  }

  void _onChangeMainPageIndex(
    ChangeMainPageIndexEvent event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(mainPageIndex: event.pageIndex));
  }
}
