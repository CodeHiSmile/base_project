import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BaseBottomSheet)
class BottomSheetImpl extends BaseBottomSheet {
  @override
  Future<dynamic> show(
    BuildContext context, {
    String? title,
    Widget? child,
    bool enableDrag = true,
    bool isDismissible = true,
    double? radius,
    double? height,
    bool isFlexible = false,
    bool isScrollControlled = true,
    EdgeInsets subTitlePadding = const EdgeInsets.only(
      top: 12.0,
      left: 16,
      right: 16,
    ),
    Widget? leftButton,
    Widget? rightButton,
    Widget? widgetChild,
  }) async {
    return showModalBottomSheet(
      context: context,
      enableDrag: enableDrag,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(radius ?? 16),
          topLeft: Radius.circular(radius ?? 16),
        ),
      ),
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      builder: (context) {
        final bottom = MediaQuery.of(context).viewInsets.bottom;

        return Container(
          width: double.infinity,
          color: Colors.transparent,
          height: widgetChild != null ? height : null,
          padding: EdgeInsets.only(bottom: bottom),
          child:
              widgetChild ??
              NormalBottomSheet(
                title: title ?? "",
                isFlexible: isFlexible,
                height: height,
                subTitlePadding: subTitlePadding,
                rightButton: rightButton,
                leftButton: leftButton,
                child: child ?? const SizedBox.shrink(),
              ),
        );
      },
    );
  }
}
