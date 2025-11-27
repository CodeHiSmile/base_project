import 'package:base_project/navigation/app_navigator.dart';
import 'package:base_project/navigation/routers/router_paths.dart';
import 'package:base_project/presentation/dialogs/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:base_ui/base_ui.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@LazySingleton(as: BaseExceptionDelegate)
class AppExceptionDelegateImpl extends BaseExceptionDelegate {
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

        switch (exception.kind) {
          case RemoteExceptionKind.refreshTokenFailed:
            AppDialog.showBlockingDialog(
              context,
              onTap: () {
                AppNavigator.popUntilRoot();
                AppNavigator.push(RouterPaths.login);
              },
            );
            break;
          case RemoteExceptionKind.noInternet:
          case RemoteExceptionKind.network:
            //Note2 important
            AppDialog.showConfirmDialog(
              context,
              barrierDismissible: false,
              cancelButtonText: "Huỷ",
              confirmButtonText: "Thử lại",
              title: "Không có kết nối internet",
              message: "Vui lòng kiểm tra kết nối của bạn và thử lại",
              onConfirm: () {
                AppNavigator.pop();
              },
              onCancel: () {
                AppNavigator.pop();
              },
            );
            break;
          case RemoteExceptionKind.timeout:
            await _showErrorDialogWithRetry(
              context,
              message: message,
              onRetryPressed: Func0(() async {
                AppNavigator.pop();
                await appExceptionWrapper.doOnRetry?.call();
              }),
            );
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
        await _showErrorDialog(context, message: message);
        break;
    }
  }

  void _showErrorSnackBar(
    BuildContext context, {
    required String message,
    Duration duration = DurationConstants.defaultErrorVisibleDuration,
  }) {
    BaseSnackBar.showSnackBar(
      context,
      snackBarStatus: SnackBarStatus.error,
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
