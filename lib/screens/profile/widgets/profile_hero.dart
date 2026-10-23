import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';
import 'package:shipments/screens/shipments/widgets/shipments_dot_marks.dart';

import 'profile_hero_background.dart';

class ProfileHero extends StatelessWidget {
  const ProfileHero({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  static double heightForWidth(double width) =>
      math.max(248.0, width * .62).toDouble();

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const ProfileHeroBackground(),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            AppSpacing.tokenXl,
            topInset + AppSpacing.token2Xl,
            AppSpacing.tokenXl,
            AppSpacing.token4Xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const ShipmentDotsMark(),
              const SizedBox(height: AppSpacing.tokenL),
              AppText(
                title,
                variant: AppTextVariant.headlineLarge,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.display.toTextStyle(
                  color: AppColors.primitives.neutral.shade100,
                ),
              ),
              const SizedBox(height: AppSpacing.tokenS),
              AppText(
                subtitle,
                variant: AppTextVariant.bodySmall,
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.label.toTextStyle(
                  color: AppColors.primitives.neutral.shade100.withValues(
                    alpha: .82,
                  ),
                ).copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
