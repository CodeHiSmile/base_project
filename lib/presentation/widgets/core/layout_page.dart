import 'package:base_project/app/themes/app_colors.dart';
import 'package:base_project/presentation/widgets/core/app_bar_custom.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';

class LayoutPage extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? action;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final bool isNeedAppBar;
  final bool? resizeToAvoidBottomInset;

  /// Thay hành vi nút quay lại của app bar mặc định (mặc định: `Navigator.pop`).
  final Function? backFunction;

  const LayoutPage({
    super.key,
    this.title,
    this.action,
    this.padding = EdgeInsets.zero,
    this.backgroundColor,
    this.bottomNavigationBar,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.isNeedAppBar = true,
    this.resizeToAvoidBottomInset,
    this.backFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isNeedAppBar
          ? appBar ??
                AppBarCustom(
                  backgroundColor: context.colors.backgroundWhite,
                  title: title ?? "",
                  titleTextStyle: context.textStyles.heading3SemiBold.copyWith(
                    color: AppColors.neutral900,
                  ),
                  actionWidget: action,
                  backFunction: backFunction,
                )
          : null,
      backgroundColor: backgroundColor ?? AppColors.homeBackground,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: bottomNavigationBar,
      body: body,
      // body: Container(
      //   decoration: BoxDecoration(
      //     gradient: backgroundColor != null
      //         ? null
      //         : LinearGradient(
      //             begin: Alignment.topCenter,
      //             end: Alignment.bottomCenter,
      //             colors: [Colors.white, AppColors.homeBackground],
      //           ),
      //   ),
      //   child: body,
      // ),
      floatingActionButton: floatingActionButton,
    );
  }
}
