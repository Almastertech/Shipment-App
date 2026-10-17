import 'package:flutter/material.dart';

import '../../core/resources/app_colors.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';

/// Overlays the authentication form as a rounded sheet on the photo header.
class AuthScreenShell extends StatelessWidget {
  const AuthScreenShell({
    super.key,
    required this.hero,
    required this.content,
    this.heroHeight = 252,
    this.sheetOverlap = AppSpacing.tokenM,
  });

  final Widget hero;
  final Widget content;
  final double heroHeight;
  final double sheetOverlap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PositionedDirectional(
          top: 0,
          start: 0,
          end: 0,
          height: heroHeight,
          child: hero,
        ),
        PositionedDirectional(
          top: heroHeight - sheetOverlap,
          start: 0,
          end: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primitives.neutral.shade100,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.token2Xl),
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: content,
          ),
        ),
      ],
    );
  }
}
