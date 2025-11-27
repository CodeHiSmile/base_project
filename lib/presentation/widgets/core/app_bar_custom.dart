import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class AppBarCustom extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleTextStyle;
  final bool isShowNavigation;
  final bool centerTitle;
  final AppBar? appBar;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actionWidget;
  final Function? backFunction;
  final Color? backgroundColor;
  final Widget? leadingWidget;
  final double? elevation;
  final double? padding;
  final int? maxLines;
  final bool isMiddleEllipsisText;

  const AppBarCustom({
    super.key,
    required this.title,
    this.titleTextStyle,
    this.isShowNavigation = true,
    this.centerTitle = true,
    this.appBar,
    this.actionWidget,
    this.backFunction,
    this.backgroundColor,
    this.leadingWidget,
    this.elevation,
    this.bottom,
    this.padding,
    this.maxLines,
    this.isMiddleEllipsisText = false,
  });

  @override
  AppBarCustomState createState() => AppBarCustomState();

  @override
  Size get preferredSize =>
      Size.fromHeight((appBar ?? AppBar()).preferredSize.height);
}

class AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor ?? context.colors.primary,
      automaticallyImplyLeading: false,
      leading: widget.isShowNavigation
          ? InkWellWidget(
              borderRadius: BorderRadius.circular(40),
              onTap: () {
                if (widget.backFunction != null) {
                  widget.backFunction!.call();
                } else {
                  Navigator.of(context).pop();
                }

                ShowLoadingUtils.instance.turnOff();
              },
              child: Padding(
                padding: EdgeInsets.all(widget.padding ?? 16),
                child: widget.leadingWidget ?? BaseAssets.icons.iconBack.svg(),
              ),
            )
          : null,
      elevation: widget.elevation ?? 0.0,
      centerTitle: widget.centerTitle,
      title: widget.isMiddleEllipsisText
          ? MiddleEllipsisText(
              text: widget.title,
              style:
                  widget.titleTextStyle ??
                  context.textStyles.heading2SemiBold.copyWith(
                    color: context.colors.backgroundWhite,
                  ),
              maxWidth: widget.actionWidget != null
                  ? MediaQuery.of(context).size.width - 2 * kToolbarHeight - 32
                  : MediaQuery.of(context).size.width - kToolbarHeight - 32,
            )
          : Text(
              widget.title,
              style:
                  widget.titleTextStyle ??
                  context.textStyles.heading2SemiBold.copyWith(
                    color: context.colors.backgroundWhite,
                  ),
              maxLines: widget.maxLines,
            ),
      actions: widget.actionWidget,
      bottom: widget.bottom,
    );
  }
}
