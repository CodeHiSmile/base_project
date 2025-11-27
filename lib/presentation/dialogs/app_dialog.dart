import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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

  ///Các dialog custom không theo base thì viết dưới đây
}
