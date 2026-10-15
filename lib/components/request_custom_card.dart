import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_images.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_typography.dart';
import 'app_text.dart';
import 'buttons/primary_button.dart';

class RequestCustomCard extends StatelessWidget {
  const RequestCustomCard({
    super.key,
    required this.requestNumber,
    required this.requestType,
    required this.remainingTimeLabel,
    required this.title,
    required this.description,
    required this.progressSteps,
    required this.activeStepIndex,
    required this.amountLabel,
    required this.amount,
    required this.actionLabel,
    required this.onTap,
  })  : assert(progressSteps.length > 1),
        assert(activeStepIndex >= 0 && activeStepIndex < progressSteps.length);

  final String requestNumber;
  final String requestType;
  final String remainingTimeLabel;
  final String title;
  final String description;
  final List<String> progressSteps;
  final int activeStepIndex;
  final String amountLabel;
  final String amount;
  final String actionLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    const cardRadius = BorderRadius.all(
      Radius.circular(AppRadius.token2Xl),
    );

    return ClipRRect(
      borderRadius: cardRadius,
      child: Material(
        color: colors.accent01.shade500,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: -AppSpacing.tokenM,
              top: -AppSpacing.tokenXl,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.12,
                  child: SvgPicture.asset(
                    AppImages.logo,
                    width: 132,
                    height: 132,
                    colorFilter: ColorFilter.mode(
                      colors.accent01.shade700,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.tokenM),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _RemainingTimePill(label: remainingTimeLabel),
                      const Spacer(),
                      AppText(
                        '$requestType $requestNumber',
                        variant: AppTextVariant.bodySmall,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                          color: AppColors.semantic.text.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.tokenM),
                  AppText(
                    title,
                    variant: AppTextVariant.titleLarge,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.buyerMobile.h4.toTextStyle(
                      color: colors.neutral.shade500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.tokenXs),
                  AppText(
                    description,
                    variant: AppTextVariant.bodySmall,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                      color: AppColors.semantic.text.secondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.tokenL),
                  _RequestProgress(
                    steps: progressSteps,
                    activeStepIndex: activeStepIndex,
                  ),
                  const SizedBox(height: AppSpacing.tokenL),
                  Row(
                    children: <Widget>[
                      _ClaimAmount(label: amountLabel, amount: amount),
                      const Spacer(),
                      PrimaryButton(
                        label: actionLabel,
                        onPressed: onTap,
                        fullWidth: false,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.neutral.shade500,
                          foregroundColor: colors.accent01.shade500,
                          disabledBackgroundColor: colors.neutral.shade300,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.tokenM,
                            vertical: AppSpacing.tokenS,
                          ),
                          minimumSize: const Size(0, 40),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: const StadiumBorder(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RemainingTimePill extends StatelessWidget {
  const _RemainingTimePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primitives.neutral.shade500,
        borderRadius: BorderRadius.circular(AppRadius.tokenFull),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenS,
          vertical: AppSpacing.tokenXs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.access_time_rounded,
              size: 14,
              color: AppColors.primitives.accent01.shade500,
            ),
            const SizedBox(width: AppSpacing.tokenXs),
            AppText(
              label,
              variant: AppTextVariant.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.buyerMobile.caption.toTextStyle(
                color: AppColors.primitives.accent01.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestProgress extends StatelessWidget {
  const _RequestProgress({
    required this.steps,
    required this.activeStepIndex,
  });

  final List<String> steps;
  final int activeStepIndex;

  @override
  Widget build(BuildContext context) {
    final completedColor = AppColors.primitives.neutral.shade500;
    final pendingColor = AppColors.primitives.accent01.shade600;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(steps.length, (index) {
        final isReached = index <= activeStepIndex;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.tokenXs,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: AppSpacing.tokenXs,
                  decoration: BoxDecoration(
                    color: isReached ? completedColor : pendingColor,
                    borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                AppText(
                  steps[index],
                  variant: AppTextVariant.labelSmall,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.caption.toTextStyle(
                    color: isReached
                        ? completedColor
                        : AppColors.semantic.text.tertiary,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _ClaimAmount extends StatelessWidget {
  const _ClaimAmount({required this.label, required this.amount});

  final String label;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppText(
          label,
          variant: AppTextVariant.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.bodySmall.toTextStyle(
            color: AppColors.semantic.text.secondary,
          ),
        ),
        const SizedBox(width: AppSpacing.tokenXs),
        AppText(
          amount,
          variant: AppTextVariant.titleSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.h6.toTextStyle(
            color: AppColors.primitives.neutral.shade500,
          ),
        ),
      ],
    );
  }
}
