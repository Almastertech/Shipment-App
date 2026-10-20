import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../components/buttons/icon_circle_button.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import 'demand_progress.dart';

class DemandEvidenceHeader extends StatelessWidget {
  const DemandEvidenceHeader({
    super.key,
    required this.title,
    required this.steps,
    required this.heading,
    required this.description,
    required this.locationMessage,
    required this.locationUnavailable,
    required this.onBack,
    required this.backTooltip,
    this.activeStepIndex = 1,
    this.showLocationStatus = true,
  });

  final String title;
  final List<String> steps;
  final String heading;
  final String description;
  final String locationMessage;
  final bool locationUnavailable;
  final VoidCallback onBack;
  final String backTooltip;
  final int activeStepIndex;
  final bool showLocationStatus;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final statusColor =
        locationUnavailable ? colors.warning.shade800 : colors.success.shade700;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          AppImages.boxFocus,
          fit: BoxFit.cover,
          alignment: const Alignment(.15, -.2),
          errorBuilder: (context, error, stackTrace) => ColoredBox(
            color: colors.primary.shade700,
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                colors.primary.shade900.withValues(alpha: .62),
                colors.primary.shade900.withValues(alpha: .74),
                colors.primary.shade900.withValues(alpha: .98),
              ],
              stops: const <double>[0, .56, 1],
            ),
          ),
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenXl,
              AppSpacing.tokenXs,
              AppSpacing.tokenXl,
              AppSpacing.token4Xl,
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
                  activeStepIndex: activeStepIndex,
                  steps: <String>[
                    for (var index = 0; index < steps.length; index++)
                      '${index + 1} ${steps[index]}',
                  ],
                  activeColor: colors.accent01.shade300,
                  completedColor: colors.accent01.shade300,
                  inactiveColor: Colors.white.withValues(alpha: .28),
                  activeLabelColor: colors.neutral.shade100,
                  completedLabelColor: colors.neutral.shade100,
                  inactiveLabelColor: colors.neutral.shade300,
                ),
                const Spacer(),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List<Widget>.generate(7, (index) {
                      final isGold = index.isEven;
                      return Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: AppSpacing.token2Xs,
                        ),
                        child: Icon(
                          Icons.diamond,
                          size: 10,
                          color: isGold
                              ? colors.accent01.shade300
                              : colors.neutral.shade400,
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                AppText(
                  heading,
                  variant: AppTextVariant.headlineSmall,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.h2.toTextStyle(
                    color: colors.neutral.shade100,
                  ),
                ),
                const SizedBox(height: AppSpacing.token2Xs),
                AppText(
                  description,
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: colors.neutral.shade200,
                  ),
                ),
                if (showLocationStatus) ...<Widget>[
                  const SizedBox(height: AppSpacing.tokenS),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: locationUnavailable
                            ? colors.warning.shade100
                            : colors.success.shade100,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.tokenM,
                          vertical: AppSpacing.tokenS,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              locationUnavailable
                                  ? Icons.location_on_outlined
                                  : Icons.location_on_rounded,
                              size: 18,
                              color: statusColor,
                            ),
                            const SizedBox(width: AppSpacing.tokenS),
                            AppText(
                              locationMessage,
                              variant: AppTextVariant.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.buyerMobile.bodySmall
                                  .toTextStyle(color: statusColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
