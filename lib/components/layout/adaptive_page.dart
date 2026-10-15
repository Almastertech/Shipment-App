import 'package:flutter/material.dart';

import '../../core/resources/adaptive_layout.dart';

typedef AdaptivePageBuilder = Widget Function(
  BuildContext context,
  AdaptiveLayoutData adaptive,
);

class AdaptivePage extends StatelessWidget {
  const AdaptivePage({
    super.key,
    required this.builder,
    this.maxWidth,
    this.padding,
  });

  final AdaptivePageBuilder builder;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final adaptive = context.adaptiveLayout;
    final pagePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: adaptive.horizontalPadding,
          vertical: adaptive.verticalPadding,
        );

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: maxWidth ?? adaptive.maxContentWidth),
        child: Padding(
          padding: pagePadding,
          child: builder(context, adaptive),
        ),
      ),
    );
  }
}
