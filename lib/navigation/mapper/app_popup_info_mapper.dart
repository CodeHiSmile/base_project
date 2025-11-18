import 'package:base_project/generated/l10n.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

@LazySingleton(as: BasePopupInfoMapper)
class AppPopupInfoMapper extends BasePopupInfoMapper {
  @override
  Widget map(AppPopupInfo appPopupInfo, AppNavigator navigator) {
    return appPopupInfo.when(
      confirmDialog: (message, onPressed) {
        return CommonDialog(
          actions: [
            PopupButton(
              text: AppStrings.current.ok,
              onPressed: onPressed ?? Func0(() => navigator.pop()),
            ),
          ],
          message: message,
        );
      },
      errorWithRetryDialog: (message, onRetryPressed) {
        return CommonDialog(
          actions: [
            PopupButton(
              text: AppStrings.current.cancel,
              onPressed: Func0(() => navigator.pop()),
            ),
            PopupButton(
              text: AppStrings.current.retry,
              onPressed: onRetryPressed ?? Func0(() => navigator.pop()),
              isDefault: true,
            ),
          ],
          message: message,
        );
      },
      requiredLoginDialog: () => CommonDialog.adaptive(
        title: AppStrings.current.login,
        message: AppStrings.current.login,
        actions: [
          PopupButton(
            text: AppStrings.current.cancel,
            onPressed: Func0(() => navigator.pop()),
          ),
          PopupButton(
            text: AppStrings.current.login,
            onPressed: Func0(() async {
              navigator.pop();
              await navigator.push(const AppRouteInfo.login());
            }),
          ),
        ],
      ),
      alertDialog:
          (
            String title,
            String message,
            String positive,
            String? negative,
            void Function()? onPositiveClick,
            void Function()? onNegativeClick,
            Color? positiveColor,
            bool isVertical,
            Widget? icon,
          ) {
            return SizedBox();

            /* return AppAlertDialog(
              title: title,
              message: message,
              positive: positive,
              negative: negative,
              positiveColor: positiveColor,
              isVertical: isVertical,
              icon: icon,
              positiveClick: () async {
                navigator.pop();
                if (onPositiveClick != null) onPositiveClick();
              },
              negativeClick: () async {
                navigator.pop();
                if (onNegativeClick != null) onNegativeClick();
              },
            );*/
          },
      messageWithTitleDialog:
          (
            String title,
            String message,
            String? buttonText,
            void Function()? onConfirm,
            Color? buttonColor,
            bool isSuccess,
            Widget? icon,
            bool showIcon,
          ) {
            return SizedBox();

            /* return MessageWithTitleDialog(
              icon: icon,
              title: title,
              message: message,
              isSuccess: isSuccess,
              buttonText: buttonText,
              buttonColor: buttonColor,
              showIcon: showIcon,
              onConfirm: () {
                navigator.pop();
                if (onConfirm != null) onConfirm();
              },
            );*/
          },
    );
  }
}
