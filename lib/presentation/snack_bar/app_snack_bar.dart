import 'package:another_flushbar/flushbar.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';

/// Loại thông báo
enum NotificationType { success, error, warning, info }

/// Widget thông báo dạng snackbar từ trên xuống.
///
/// Hỗ trợ thay đổi [type], [icon], [title] và [message].
///
/// Sử dụng:
/// ```dart
/// AppNotificationBar.show(
///   context,
///   type: NotificationType.error,
///   title: 'Tài khoản bị tạm khoá',
///   message: 'Bạn đã nhập sai quá 5 lần. Vui lòng thử lại sau 15 phút',
/// );
/// ```
class AppSnackBar {
  AppSnackBar._();

  /// Hiển thị thông báo từ trên xuống
  static Flushbar show(
    BuildContext context, {
    required String title,
    String? message,
    NotificationType type = NotificationType.info,
    Widget? icon,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onTap,
    FlushbarDismissDirection dismissDirection =
        FlushbarDismissDirection.VERTICAL,
  }) {
    final config = _getConfig(context, type);

    return Flushbar(
      duration: duration,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      messageText: Semantics(
        identifier: 'app-snackbar',
        label: message == null ? title : '$title. $message',
        button: onTap != null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE4E4E7)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Padding(padding: const EdgeInsets.only(right: 12), child: icon),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      style: context.textStyles.body2Medium.copyWith(
                        color: config.titleColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (message != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: context.textStyles.caption1Regular.copyWith(
                          color: config.messageColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      dismissDirection: dismissDirection,
      onTap: (_) => onTap?.call(),
    )..show(context);
  }

  /// Hiển thị thông báo lỗi
  static Flushbar showError(
    BuildContext context, {
    required String title,
    String? message,
    Widget? icon,
    Duration duration = const Duration(seconds: 4),
  }) {
    return show(
      context,
      title: title,
      message: message,
      type: NotificationType.error,
      icon: icon,
      duration: duration,
    );
  }

  /// Hiển thị thông báo thành công
  static Flushbar showSuccess(
    BuildContext context, {
    required String title,
    String? message,
    Widget? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    return show(
      context,
      title: title,
      message: message,
      type: NotificationType.success,
      icon: icon,
      duration: duration,
    );
  }

  /// Hiển thị thông báo cảnh báo
  static Flushbar showWarning(
    BuildContext context, {
    required String title,
    String? message,
    Widget? icon,
    Duration duration = const Duration(seconds: 4),
  }) {
    return show(
      context,
      title: title,
      message: message,
      type: NotificationType.warning,
      icon: icon,
      duration: duration,
    );
  }

  /// Hiển thị thông báo thông tin
  static Flushbar showInfo(
    BuildContext context, {
    required String title,
    String? message,
    Widget? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    return show(
      context,
      title: title,
      message: message,
      type: NotificationType.info,
      icon: icon,
      duration: duration,
    );
  }

  static _NotificationConfig _getConfig(
    BuildContext context,
    NotificationType type,
  ) {
    switch (type) {
      case NotificationType.error:
        return _NotificationConfig(
          backgroundColor: context.colors.errorSurface,
          borderColor: context.colors.errorBorder,
          titleColor: context.colors.error,
          messageColor: Colors.black,
          icon: Icon(
            Icons.error_outline_rounded,
            color: context.colors.error,
            size: 24,
          ),
        );
      case NotificationType.success:
        return _NotificationConfig(
          backgroundColor: context.colors.successSurface,
          borderColor: context.colors.successGreenBorder,
          titleColor: context.colors.success,
          messageColor: Colors.black,
          icon: Icon(
            Icons.check_circle_outline_rounded,
            color: context.colors.success,
            size: 24,
          ),
        );
      case NotificationType.warning:
        return _NotificationConfig(
          backgroundColor: context.colors.warningSurface,
          borderColor: context.colors.warningOrangeBorder,
          titleColor: context.colors.warning,
          messageColor: Colors.black,
          icon: Icon(
            Icons.warning_amber_rounded,
            color: context.colors.warning,
            size: 24,
          ),
        );
      case NotificationType.info:
        return _NotificationConfig(
          backgroundColor: context.colors.infoSurface,
          borderColor: context.colors.infoBorder,
          titleColor: context.colors.info,
          messageColor: Colors.black,
          icon: Icon(
            Icons.info_outline_rounded,
            color: context.colors.info,
            size: 24,
          ),
        );
    }
  }
}

class _NotificationConfig {
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final Color messageColor;
  final Widget icon;

  const _NotificationConfig({
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    required this.messageColor,
    required this.icon,
  });
}
