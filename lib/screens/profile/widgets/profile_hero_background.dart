import 'package:flutter/material.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';

/// Shared image treatment used by the profile and its account flows.
class ProfileHeroBackground extends StatelessWidget {
  const ProfileHeroBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        DecoratedBox(decoration: BoxDecoration(color: primary.shade900)),
        Image.asset(
          AppImages.profile,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: primary.shade900.withValues(alpha: .38),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                primary.shade900.withValues(alpha: .28),
                primary.shade800.withValues(alpha: .18),
                primary.shade900.withValues(alpha: .92),
              ],
              stops: const <double>[0, .45, 1],
            ),
          ),
        ),
      ],
    );
  }
}
