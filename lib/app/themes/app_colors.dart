import 'package:flutter/material.dart';

/// Bảng màu tĩnh của app — token semantic dùng chung cho widget core.
///
/// Đây là palette mặc định của base (lấy theo smart_toy_mobile). Dự án fork từ base đổi giá trị
/// theo Design System của mình, giữ nguyên TÊN token để widget core không phải sửa. Màu riêng của
/// một tính năng khai thêm ở đây, có comment nguồn thiết kế.
class AppColors {
  AppColors._();

  static const Color transparent = Color(0x00000000);

  static const Color primary = Color(0xFF8680FF);

  static const Color neutral50 = Color(0xFFF7F7FC);
  static const Color neutral100 = Color(0xFFEBEDFF);
  static const Color neutral200 = Color(0xFFDDDFF2);
  static const Color neutral300 = Color(0xFFD6D3E8);
  static const Color neutral400 = Color(0xFFAFADC9);
  static const Color neutral500 = Color(0xFF9B96B6);
  static const Color neutral600 = Color(0xFF5C538A);
  static const Color neutral700 = Color(0xFFAFADC9);
  static const Color neutral800 = Color(0xFF211C57);
  static const Color neutral900 = Color(0xFF171342);
  static const Color textPrimary = Color(0xFF211C57);
  static const Color navy900 = Color(0xFF03294C);

  static const Color homeBackground = Color(0xFFF5F5FF);

  static const Color info = Color(0xFF3561FF);
  static const Color success = Color(0xFF4AAF57);
  static const Color warning = Color(0xFFFACC15);
  static const Color error = Color(0xFFF54336);
}
