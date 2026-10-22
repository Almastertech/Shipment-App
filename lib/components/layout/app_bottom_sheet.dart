import 'package:flutter/material.dart';

import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.child,
    this.showHandle = true,
    this.padding = AppSpacing.cardLarge,
    this.maxWidth = 720,
    this.topPadding = AppSpacing.sm,
    this.handleBottomSpacing = AppSpacing.md,
  });

  final Widget child;
  final bool showHandle;
  final EdgeInsets padding;
  final double maxWidth;
  final double topPadding;
  final double handleBottomSpacing;

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool isScrollControlled = true,
    bool useSafeArea = true,
    bool enableDrag = true,
    bool isDismissible = true,
    Color? barrierColor,
    bool showHandle = true,
    EdgeInsets padding = AppSpacing.cardLarge,
    double maxWidth = 720,
    double topRadius = AppRadius.sheet,
    Color? backgroundColor,
    double topPadding = AppSpacing.sm,
    double handleBottomSpacing = AppSpacing.md,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      barrierColor: barrierColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(topRadius)),
      ),
      backgroundColor: backgroundColor,
      builder: (_) {
        return AppBottomSheet(
          showHandle: showHandle,
          padding: padding,
          maxWidth: maxWidth,
          topPadding: topPadding,
          handleBottomSpacing: handleBottomSpacing,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: padding.bottom + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: EdgeInsets.only(
              left: padding.left,
              right: padding.right,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (showHandle)
                  Center(
                    child: Container(
                      width: 42,
                      height: 4,
                      margin: EdgeInsets.only(bottom: handleBottomSpacing),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.outline,
                        borderRadius: BorderRadius.circular(AppRadius.circle),
                      ),
                    ),
                  ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
