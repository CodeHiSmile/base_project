import 'package:base_project/app/app_bloc/app_bloc.dart';
import 'package:base_project/app/app_bloc/app_event.dart';
import 'package:base_project/navigation/app_navigator.dart';
import 'package:base_project/presentation/dialogs/app_dialog.dart';
import 'package:base_project/presentation/snack_bar/app_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@LazySingleton(as: BaseExceptionDelegate)
class AppExceptionImpl extends BaseExceptionDelegate {
  @override
  void handleException(
    BuildContext context,
    String commonExceptionMessage,
    AppExceptionWrapper appExceptionWrapper,
  ) async {
    final message =
        appExceptionWrapper.overrideMessage ?? commonExceptionMessage;

    switch (appExceptionWrapper.appException.appExceptionType) {
      case AppExceptionType.remote:
        final exception = appExceptionWrapper.appException as RemoteException;
        final appBloc = GetIt.instance.get<AppBloc>();

        // Hết phiên do `SessionExpiredHandler` xử lý (gọi từ RefreshTokenInterceptor). Request bị
        // reject vì refresh thất bại tới đây dưới dạng lỗi mạng bọc DioException — bỏ qua, không
        // hiện thêm thông báo đè lên dialog hết phiên.
        if (exception.kind == RemoteExceptionKind.refreshTokenFailed ||
            _isRefreshTokenFailure(exception)) {
          return;
        }

        switch (exception.kind) {
          case RemoteExceptionKind.noInternet:
          case RemoteExceptionKind.network:
            if (!context.mounted || appBloc.state.showErrorDialog) {
              return;
            }
            _showErrorSnackBar(
              context,
              title: "Không có kết nối internet",
              message: "Vui lòng kiểm tra kết nối của bạn và thử lại",
            );
            break;
          case RemoteExceptionKind.timeout:
            if (!context.mounted || appBloc.state.showErrorDialog) {
              return;
            }
            appBloc.add(const ChangeShowErrorDialogEvent(true));
            await _showErrorDialogWithRetry(
              context,
              message: message,
              onRetryPressed: Func0(() async {
                appBloc.add(const ChangeShowErrorDialogEvent(false));
                AppNavigator.pop();
                await appExceptionWrapper.doOnRetry?.call();
              }),
            );
            break;
          case RemoteExceptionKind.serverUndefined:
          case RemoteExceptionKind.serverDefined:
            _showErrorSnackBar(context, message: message);
            break;
          default:
            await _showErrorDialog(context, message: message);
            break;
        }
        break;
      case AppExceptionType.parse:
        return _showErrorSnackBar(context, message: message);
      case AppExceptionType.remoteConfig:
        return _showErrorSnackBar(context, message: message);
      case AppExceptionType.uncaught:
        return;
      case AppExceptionType.validation:
        _showErrorSnackBar(context, message: message);
        break;
    }
  }

  bool _isRefreshTokenFailure(RemoteException exception) {
    final root = exception.rootException;
    if (root is! DioException) return false;
    final cause = root.error;
    return cause is RemoteException &&
        cause.kind == RemoteExceptionKind.refreshTokenFailed;
  }

  void _showErrorSnackBar(
    BuildContext context, {
    String? title,
    required String message,
    Duration duration = DurationConstants.defaultErrorVisibleDuration,
  }) {
    AppSnackBar.showError(
      context,
      title: title ?? "Thông báo",
      duration: duration,
      message: message,
    );
  }

  Future<void> _showErrorDialog(
    BuildContext context, {
    required String message,
    Func0<void>? onPressed,
  }) async {
    AppDialog.showStatusDialog(
      context,
      status: DialogStatus.error,
      message: message,
      onConfirm: () {
        onPressed?.call();
      },
    );
  }

  Future<void> _showErrorDialogWithRetry(
    BuildContext context, {
    required String message,
    required Func0<void>? onRetryPressed,
  }) async {
    AppDialog.showInfoDialog(
      context,
      message: message,
      confirmButtonText: "Thử lại",
      onConfirm: () {
        if (onRetryPressed != null) {
          onRetryPressed.call();
        }
      },
    );
  }
}
