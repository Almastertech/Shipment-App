import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_images.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';

/// Shared dusk photo header used by the first row of authentication screens.
class AuthHero extends StatelessWidget {
  const AuthHero({
    super.key,
    required this.helpLabel,
    required this.title,
    required this.subtitle,
    required this.onBack,
    this.onHelp,
  });

  final String helpLabel;
  final String title;
  final String subtitle;
  final VoidCallback onBack;
  final VoidCallback? onHelp;

  @override
  Widget build(BuildContext context) {
    final purple = AppColors.primitives.primary.shade900;
    return SizedBox(
      height: 252,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.splash,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  purple.withValues(alpha: .18),
                  purple.withValues(alpha: .62),
                ],
              ),
            ),
          ),
          PositionedDirectional(
            start: AppSpacing.tokenL,
            end: AppSpacing.tokenL,
            top: 0,
            child: SafeArea(
              bottom: false,
              child: SizedBox(
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: onBack,
                      icon: Icon(
                        Icons.arrow_back_rounded,
                      ),
                      color: Colors.white,
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: .16),
                        fixedSize: const Size(40, 40),
                      ),
                    ),
                    if (onHelp != null)
                      TextButton(
                        onPressed: onHelp,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.white.withValues(alpha: .16),
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.tokenM,
                          ),
                        ),
                        child: AppText(
                          helpLabel,
                          variant: AppTextVariant.labelSmall,
                          style: AppTypography.buyerMobile.label
                              .toTextStyle(color: Colors.white),
                        ),
                      )
                    else
                      const SizedBox(width: 44),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: AppSpacing.tokenL,
            end: AppSpacing.tokenL,
            bottom: AppSpacing.tokenXl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final color in [
                        AppColors.primitives.accent01.shade300,
                        AppColors.primitives.neutral.shade300,
                        AppColors.primitives.primary.shade300,
                        AppColors.primitives.accent01.shade300,
                        AppColors.primitives.neutral.shade300,
                      ])
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 5),
                          child: Transform.rotate(
                            angle: .785,
                            child: Container(width: 8, height: 8, color: color),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenS),
                AppText(
                  title,
                  variant: AppTextVariant.headlineMedium,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: AppTypography.buyerMobile.h2.toTextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.token2Xs),
                AppText(
                  subtitle,
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: Colors.white.withValues(alpha: .82),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
