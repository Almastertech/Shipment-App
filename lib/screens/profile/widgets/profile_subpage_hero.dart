import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import '../../shipments/widgets/shipments_dot_marks.dart';
import 'profile_hero_background.dart';

class ProfileSubpageHero extends StatelessWidget {
  const ProfileSubpageHero({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onBack,
    required this.backLabel,
    this.titleSubtitleSpacing = AppSpacing.token2Xs,
  });

  final String title;
  final String subtitle;
  final VoidCallback onBack;
  final String backLabel;
  final double titleSubtitleSpacing;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final textColor = AppColors.primitives.neutral.shade100;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const ProfileHeroBackground(),
        Positioned(
          top: topInset + AppSpacing.token2Xs,
          right: AppSpacing.tokenXl,
          child: _GlassBackButton(onPressed: onBack, label: backLabel),
        ),
        Positioned(
          top: topInset + AppSpacing.token7Xl,
          left: AppSpacing.tokenXl,
          right: AppSpacing.tokenXl,
          child: Column(
            textDirection: TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const ShipmentDotsMark(),
              const SizedBox(height: AppSpacing.tokenS),
              AppText(
                title,
                variant: AppTextVariant.headlineLarge,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.display.toTextStyle(
                  color: textColor,
                ),
              ),
              SizedBox(height: titleSubtitleSpacing),
              AppText(
                subtitle,
                variant: AppTextVariant.bodySmall,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.label
                    .toTextStyle(color: textColor.withValues(alpha: .82))
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GlassBackButton extends StatelessWidget {
  const _GlassBackButton({required this.onPressed, required this.label});

  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: Colors.white.withValues(alpha: .16),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: const SizedBox(
            width: 44,
            height: 44,
            child: Icon(
              Icons.chevron_left_rounded,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
