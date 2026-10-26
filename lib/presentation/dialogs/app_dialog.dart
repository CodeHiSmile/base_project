import 'package:base_ui/base_ui.dart';
import 'package:base_project/generated/assets.gen.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:base_project/app/themes/app_colors.dart';
import 'package:base_project/presentation/widgets/button/primary_button.dart';

class AppDialog {
  AppDialog._();

  static final BaseDialog _service = GetIt.I<BaseDialog>();

  static Future<void> showDefaultDialog(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
  }) => _service.showDefaultDialog(
    context,
    child: child,
    barrierDismissible: barrierDismissible,
  );

  static Future<void> showSettingDialog(
    BuildContext context, {
    String? title,
    String? message,
  }) => _service.showSettingDialog(context, title: title, message: message);

  static Future<void> showStatusDialog(
    BuildContext context, {
    required String message,
    required DialogStatus status,
    Function? onConfirm,
    bool barrierDismissible = true,
  }) => _service.showStatusDialog(
    context,
    message: message,
    status: status,
    onConfirm: onConfirm,
    barrierDismissible: barrierDismissible,
  );

  static Future<void> showInfoDialog(
    BuildContext context, {
    String? title,
    String? message,
    String? confirmButtonText,
    Function? onConfirm,
    double? height,
    Widget? widgetContent,
    bool barrierDismissible = true,
  }) => _service.showInfoDialog(
    context,
    title: title,
    message: message,
    confirmButtonText: confirmButtonText,
    onConfirm: onConfirm,
    height: height,
    widgetContent: widgetContent,
    barrierDismissible: barrierDismissible,
  );

  static Future<void> showConfirmDialog(
    BuildContext context, {
    String? title,
    String? message,
    String? cancelButtonText,
    String? confirmButtonText,
    Function? onCancel,
    Function? onConfirm,
    double? height,
    Widget? widgetContent,
    bool barrierDismissible = true,
  }) => _service.showConfirmDialog(
    context,
    title: title,
    message: message,
    cancelButtonText: cancelButtonText,
    confirmButtonText: confirmButtonText,
    onCancel: onCancel,
    onConfirm: onConfirm,
    height: height,
    widgetContent: widgetContent,
    barrierDismissible: barrierDismissible,
  );

  static Future<void> showBlockingDialog(
    BuildContext context, {
    String? title,
    Widget? icon,
    String? textButton,
    required Function onTap,
  }) => _service.showBlockingDialog(
    context,
    title: title,
    icon: icon,
    textButton: textButton,
    onTap: onTap,
  );

  /// Dialog nội dung riêng **trả kết quả** khi đóng (`Navigator.pop(result)`) — page `await` kết quả rồi
  /// mới điều hướng / hiện thông báo (luật UI: không đổi route hai nguồn trong cùng callback).
  static Future<T?> showResultDialog<T>(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) => Dialog(
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: dialogContext.colors.backgroundWhite,
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }

  static Future<void> showDestructiveConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String? excerpt,
    String cancelButtonText = 'Hủy bỏ',
    String confirmButtonText = 'Xoá',
    VoidCallback? onConfirm,
  }) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        insetPadding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: dialogContext.colors.backgroundWhite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: dialogContext.textStyles.heading2SemiBold.copyWith(
                  color: dialogContext.colors.textTitle,
                ),
              ),
              if (excerpt != null && excerpt.trim().isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.neutral50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                      left: BorderSide(color: AppColors.neutral300, width: 3),
                    ),
                  ),
                  child: Text(
                    excerpt.trim(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: dialogContext.textStyles.body2Regular.copyWith(
                      color: AppColors.neutral600,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: dialogContext.textStyles.body2Regular,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: cancelButtonText,
                      height: 44,
                      fontSize: 14,
                      backgroundColor: AppColors.neutral100,
                      textColor: AppColors.textPrimary,
                      borderRadius: BorderRadius.circular(8),
                      insertPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      onTap: () => Navigator.of(dialogContext).pop(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PrimaryButton(
                      text: confirmButtonText,
                      height: 44,
                      fontSize: 14,
                      backgroundColor: AppColors.error,
                      textColor: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      insertPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      onTap: () {
                        Navigator.of(dialogContext).pop();
                        onConfirm?.call();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showDialogOverlay(
    BuildContext context, {
    required String message,
    required DialogStatus status,
    int? milliseconds,
  }) {
    final GlobalKey key = GlobalKey();

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        Future.delayed(Duration(milliseconds: milliseconds ?? 4000), () {
          if (key.currentContext != null) {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          }
        });

        Widget buildIcon;
        if (status == DialogStatus.success) {
          buildIcon = MyAssets.icons.iconSuccess.svg();
        } else if (status == DialogStatus.error) {
          buildIcon = MyAssets.icons.iconWarning.svg();
        } else {
          buildIcon = MyAssets.icons.iconWarning.svg();
        }

        return Dialog(
          key: key,
          insetPadding: const EdgeInsets.symmetric(horizontal: 100),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.backgroundBlack.withOpacitySafe(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildIcon,
                const SizedBox(height: 10),
                Text(
                  message,
                  style: context.textStyles.body2Medium.copyWith(
                    color: context.colors.backgroundWhite,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
