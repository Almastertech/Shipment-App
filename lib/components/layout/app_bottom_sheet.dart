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
  });

  final Widget child;
  final bool showHandle;
  final EdgeInsets padding;
  final double maxWidth;

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
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      barrierColor: barrierColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.sheet),
        ),
      ),
      builder: (_) {
        return AppBottomSheet(
          showHandle: showHandle,
          padding: padding,
          maxWidth: maxWidth,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSpacing.sm,
        bottom: padding.bottom + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Align(
        alignment: Alignment.topCenter,
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
                      margin: const EdgeInsets.only(bottom: AppSpacing.md),
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
