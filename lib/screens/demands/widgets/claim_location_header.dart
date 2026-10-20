import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/components/buttons/icon_circle_button.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_images.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';
import 'package:shipments/screens/demands/widgets/demand_progress.dart';

class ClaimLocationHeader extends StatelessWidget {
  const ClaimLocationHeader({
    super.key,
    required this.title,
    required this.heading,
    required this.description,
    required this.steps,
    required this.onBack,
    required this.backTooltip,
  });

  final String title;
  final String heading;
  final String description;
  final List<String> steps;
  final VoidCallback onBack;
  final String backTooltip;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          AppImages.boxesStack,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                colors.primary.shade900.withValues(alpha: .60),
                colors.primary.shade900.withValues(alpha: .75),
                colors.primary.shade900.withValues(alpha: .96),
              ],
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenM,
              AppSpacing.tokenXs,
              AppSpacing.tokenM,
              AppSpacing.token6Xl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 44,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      AppText(
                        title,
                        variant: AppTextVariant.titleMedium,
                        textAlign: TextAlign.center,
                        style: AppTypography.buyerMobile.h6.toTextStyle(
                          color: colors.neutral.shade100,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: IconCircleButton(
                          icon: Icons.chevron_left_rounded,
                          tooltip: backTooltip,
                          onPressed: onBack,
                          backgroundColor: Colors.white.withValues(alpha: .14),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenS),
                DemandProgress(
                  steps: steps,
                  activeColor: colors.accent01.shade300,
                  inactiveColor: Colors.white.withValues(alpha: .32),
                  activeLabelColor: colors.neutral.shade100,
                  inactiveLabelColor: colors.neutral.shade300,
                ),
                const Spacer(),
                AppText(
                  heading,
                  variant: AppTextVariant.headlineSmall,
                  textAlign: TextAlign.start,
                  style: AppTypography.buyerMobile.h2.toTextStyle(
                    color: colors.neutral.shade100,
                  ),
                ),
                const SizedBox(height: AppSpacing.token2Xs),
                AppText(
                  description,
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: colors.neutral.shade200,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
