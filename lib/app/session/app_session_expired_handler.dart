import 'package:base_project/app/app_bloc/app_bloc.dart';
import 'package:base_project/app/app_bloc/app_event.dart';
import 'package:base_project/data/api/session/session_expired_handler.dart';
import 'package:base_project/navigation/app_navigator.dart';
import 'package:base_project/navigation/routers/router_paths.dart';
import 'package:base_project/presentation/dialogs/app_dialog.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:router/router.dart';

/// UX hết phiên mặc định: một dialog chặn duy nhất → xoá token, đăng xuất, về màn đăng nhập.
///
/// Nhiều request 401 cùng lúc chỉ mở một dialog nhờ cờ `AppState.showErrorDialog`.
@LazySingleton(as: SessionExpiredHandler)
class AppSessionExpiredHandler implements SessionExpiredHandler {
  AppSessionExpiredHandler(this._deleteTokenUseCase);

  final DeleteTokenUseCase _deleteTokenUseCase;

  @override
  Future<void> onSessionExpired() async {
    final context = AppNavigator.currentContext;
    final appBloc = GetIt.instance.get<AppBloc>();
    if (context == null || !context.mounted || appBloc.state.showErrorDialog) {
      return;
    }

    appBloc.add(const ChangeShowErrorDialogEvent(true));

    await AppDialog.showBlockingDialog(
      context,
      title:
          'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại để tiếp tục sử dụng ứng dụng.',
      onTap: () async {
        await _deleteTokenUseCase.execute(DeleteTokenInput());
        await GetIt.instance.get<AuthService>().logout();

        appBloc.add(const ChangeShowErrorDialogEvent(false));
        appBloc.add(const ChangeMainPageIndexEvent(pageIndex: 0));

        AppNavigator.popUntilRoot();
        AppNavigator.push(RouterPaths.login);
      },
    );
  }
}
