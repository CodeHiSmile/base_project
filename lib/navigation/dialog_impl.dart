import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BaseDialog)
class AppDialogImpl extends BaseDialog {
  @override
  Future<void> showDefaultDialog(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => child,
    );
  }

  @override
  Future<void> showSettingDialog(
    BuildContext context, {
    String? title,
    String? message,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => OpenSettingDialog(title: title, message: message),
    );
  }

  @override
  Future<void> showStatusDialog(
    BuildContext context, {
    required String message,
    required DialogStatus status,
    Function? onConfirm,
    bool barrierDismissible = true,
  }) async {
    showDialog(
      context: context,
      barrierColor: Colors.black12,
      barrierDismissible: barrierDismissible,
      builder: (_) =>
          StatusDialog(status: status, message: message, onConfirm: onConfirm),
    );
  }

  @override
  Future<void> showInfoDialog(
    BuildContext context, {
    String? title,
    String? message,
    String? confirmButtonText,
    Function? onConfirm,
    double? height,
    Widget? widgetContent,
    bool barrierDismissible = true,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => InfoDialog(
        title: title,
        message: message,
        confirmButtonText: confirmButtonText,
        onConfirm: onConfirm,
        height: height,
        widgetContent: widgetContent,
      ),
    );
  }

  @override
  Future<void> showConfirmDialog(
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
  }) async {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => ConfirmDialog(
        title: title,
        message: message,
        cancelButtonText: cancelButtonText,
        confirmButtonText: confirmButtonText,
        onCancel: onCancel,
        onConfirm: onConfirm,
        height: height,
        widgetContent: widgetContent,
      ),
    );
  }

  @override
  Future<void> showBlockingDialog(
    BuildContext context, {
    String? title,
    Widget? icon,
    String? textButton,
    required Function onTap,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlockingDialog(
        title: title,
        icon: icon,
        textButton: textButton,
        onTap: onTap,
      ),
    );
  }
}
