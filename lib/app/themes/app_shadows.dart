import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:base_project/app/themes/app_colors.dart';

/// Shadow dùng chung của app.
///
/// Màu trong `BoxShadow` là thông số effect cố định của Design System, không phải
/// semantic color theo theme — nên giữ ở đây thay vì tra qua `AppColorScheme`.
class AppShadows {
  AppShadows._();

  /// Bóng đổ mềm dưới thẻ nội dung.
  static final List<BoxShadow> card = [
    BoxShadow(
      color: AppColors.primary.withValues(alpha: 0.035),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  /// Viền trên của thanh nút cố định đáy màn — nội dung cuộn dưới nó đọc được là *đi xuống dưới*
  /// thay vì *bị cắt ngang giữa dòng chữ*.
  static final List<BoxShadow> bottomBar = [
    BoxShadow(
      color: AppColors.navy900.withOpacitySafe(0.08),
      blurRadius: 16,
      offset: Offset(0, 3),
    ),
  ];
}
