import 'package:flutter/material.dart';

import '../core/resources/app_spacing.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = AppSpacing.card,
    this.onTap,
    this.margin = EdgeInsets.zero,
    this.clipBehavior = Clip.antiAlias,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry margin;
  final Clip clipBehavior;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      color: color,
      clipBehavior: clipBehavior,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
