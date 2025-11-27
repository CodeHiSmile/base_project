import 'package:base_project/presentation/widgets/core/app_bar_custom.dart';
import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({
    super.key,
    this.title,
    this.action,
    this.padding = EdgeInsets.zero,
    this.backgroundColor = CoreColors.white,
    this.bottomNavigationBar,
    required this.body,
    this.appbar,
    this.floatingActionButton,
  });

  final String? title;
  final Widget body;
  final List<Widget>? action;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final PreferredSizeWidget? appbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar ?? AppBarCustom(title: title ?? ""),
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
