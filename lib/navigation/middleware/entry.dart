import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Auth @quocht5
/// Định nghĩa RouteEntry cho từng Micro Frontend
///
class RouteEntry {
  final String path;
  final Widget Function(BuildContext, GoRouterState) builder;
  final bool protected;

  RouteEntry({
    required this.path,
    required this.builder,
    this.protected = false,
  });
}
