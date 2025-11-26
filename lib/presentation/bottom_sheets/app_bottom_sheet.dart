import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AppBottomSheet {
  AppBottomSheet._();

  static final _service = GetIt.I<BaseBottomSheet>();

  static Future show(
    BuildContext context, {
    required BottomSheetOptions options,
  }) {
    return _service.show(
      context,
      title: options.title,
      child: options.child,
      enableDrag: options.enableDrag,
      isDismissible: options.isDismissible,
      radius: options.radius,
      height: options.height,
      isFlexible: options.isFlexible,
      isScrollControlled: options.isScrollControlled,
      subTitlePadding: options.subTitlePadding,
      leftButton: options.leftButton,
      rightButton: options.rightButton,
      widgetChild: options.widgetChild,
    );
  }
}

class BottomSheetOptions {
  final String? title;
  final Widget? child;
  final bool enableDrag;
  final bool isDismissible;
  final double? radius;
  final double? height;
  final bool isFlexible;
  final bool isScrollControlled;
  final EdgeInsets subTitlePadding;
  final Widget? leftButton;
  final Widget? rightButton;
  final Widget? widgetChild;

  const BottomSheetOptions({
    this.child,
    this.title,
    this.enableDrag = true,
    this.isDismissible = true,
    this.radius,
    this.height,
    this.isFlexible = false,
    this.isScrollControlled = true,
    this.subTitlePadding = const EdgeInsets.only(
      top: 12.0,
      left: 16,
      right: 16,
    ),
    this.leftButton,
    this.rightButton,
    this.widgetChild,
  });
}
