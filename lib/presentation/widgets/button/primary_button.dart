import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends BaseButton {
  const PrimaryButton({
    super.key,
    required super.text,
    super.leftIcon,
    super.rightIcon,
    super.backgroundColor,
    super.borderColor,
    super.disableBorderColor,
    super.isEnable = true,
    super.onTap,
    super.insertPadding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 30,
    ),
    super.decoration,
    super.textStyle,
    super.fontWeight = FontWeight.w500,
    super.fontSize = 16,
    super.textColor,
    super.disableTextColor,
    super.disableBackgroundColor,
    super.constraints = const BoxConstraints.tightFor(),
    super.borderRadius = const BorderRadius.all(Radius.circular(10)),
    super.alignment,
    super.colorType,
    super.spaceBetween,
    super.isLoading,
    super.borderWidth = 1,
    super.width,
    super.height = 48,
  }) : super();

  /// Outline variant
  PrimaryButton.outline({
    super.key,
    required super.text,
    super.leftIcon,
    super.rightIcon,
    super.enabledBackgroundColor,
    super.disabledBackgroundColor,
    super.disabledLineColor,
    super.lineColor,
    super.radius,
    super.borderWith,
    super.isEnable = true,
    super.onTap,
    super.textColor,
    super.fontWeight = FontWeight.w600,
    super.fontSize = 16,
    super.insertPadding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 30,
    ),
    super.alignment,
    super.textStyle,
    super.constraints = const BoxConstraints.tightFor(),
    super.colorType = ColorType.normal,
    super.isLoading,
    super.width,
    super.height = 48,
  }) : super.outline();
}
