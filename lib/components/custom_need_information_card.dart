import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_images.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_typography.dart';
import 'app_text.dart';
import 'buttons/primary_button.dart';

/// Shipment request card shown when more information is needed to proceed.
///
/// Pass localized labels and the current progress state from the parent screen.
class CustomNeedInformationCard extends StatelessWidget {
  const CustomNeedInformationCard({
    super.key,
    required this.requestNumber,
    required this.requestType,
    required this.statusLabel,
    required this.title,
    required this.description,
    required this.progressSteps,
    required this.activeStepIndex,
    required this.amountLabel,
    required this.amount,
    required this.actionLabel,
    required this.onAction,
  })  : assert(progressSteps.length > 1),
        assert(activeStepIndex >= 0 && activeStepIndex < progressSteps.length);

  final String requestNumber;
  final String requestType;
  final String statusLabel;
  final String title;
  final String description;

  /// Ordered from the logical start to end; RTL locales render the first step
  /// at the right, matching the Arabic shipment workflow.
  final List<String> progressSteps;
  final int activeStepIndex;
  final String amountLabel;
  final String amount;
  final String actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    const radius = BorderRadius.all(Radius.circular(AppRadius.token2Xl));

    return AspectRatio(
      aspectRatio: 426 / 258,
      child: ClipRRect(
        borderRadius: radius,
        child: Material(
          color: colors.primary.shade500,
          child: Stack(
            children: <Widget>[
              PositionedDirectional(
                start: -AppSpacing.tokenM,
                top: -AppSpacing.tokenXl,
                child: IgnorePointer(
                  child: Opacity(
                    opacity: 0.12,
                    child: SvgPicture.asset(
                      AppImages.logo,
                      width: 132,
                      height: 132,
                      colorFilter: ColorFilter.mode(
                        colors.primary.shade100,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.tokenM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _NeedInformationStatus(label: statusLabel),
                        const Spacer(),
                        AppText(
                          '$requestType $requestNumber',
                          variant: AppTextVariant.bodySmall,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppTypography.buyerMobile.bodySmall.toTextStyle(
                            color: colors.primary.shade100,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.tokenS),
                    AppText(
                      title,
                      variant: AppTextVariant.titleLarge,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.buyerMobile.h4.toTextStyle(
                        color: colors.neutral.shade100,
                      ),
                    ),
                    AppText(
                      description,
                      variant: AppTextVariant.bodySmall,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                        color: colors.neutral.shade100,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenM),
                    _NeedInformationProgress(
                      steps: progressSteps,
                      activeStepIndex: activeStepIndex,
                    ),
                    const Spacer(),
                    Row(
                      children: <Widget>[
                        PrimaryButton(
                          label: actionLabel,
                          onPressed: onAction,
                          fullWidth: false,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.neutral.shade100,
                            foregroundColor: colors.primary.shade500,
                            disabledBackgroundColor: colors.primary.shade200,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.tokenM,
                              vertical: AppSpacing.tokenS,
                            ),
                            minimumSize: const Size(0, 40),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: const StadiumBorder(),
                            textStyle:
                                AppTypography.buyerMobile.button.toTextStyle(),
                          ),
                        ),
                        const Spacer(),
                        Flexible(
                          child: _RequestAmount(
                            label: amountLabel,
                            amount: amount,
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
      ),
    );
  }
}

class _NeedInformationStatus extends StatelessWidget {
  const _NeedInformationStatus({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primitives.neutral.shade100,
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
              Icons.assignment_late_outlined,
              size: 14,
              color: AppColors.primitives.primary.shade500,
            ),
            const SizedBox(width: AppSpacing.tokenXs),
            AppText(
              label,
              variant: AppTextVariant.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.buyerMobile.caption.toTextStyle(
                color: AppColors.primitives.primary.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NeedInformationProgress extends StatelessWidget {
  const _NeedInformationProgress({
    required this.steps,
    required this.activeStepIndex,
  });

  final List<String> steps;
  final int activeStepIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(steps.length, (index) {
        final isReached = index <= activeStepIndex;

        return Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: index == 0 ? 0 : AppSpacing.tokenXs,
              end: index == steps.length - 1 ? 0 : AppSpacing.tokenXs,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: AppSpacing.tokenXs,
                  decoration: BoxDecoration(
                    color: isReached
                        ? AppColors.primitives.neutral.shade100
                        : AppColors.primitives.primary.shade300,
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
                        ? AppColors.primitives.neutral.shade100
                        : AppColors.primitives.primary.shade200,
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

class _RequestAmount extends StatelessWidget {
  const _RequestAmount({required this.label, required this.amount});

  final String label;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.tokenXs,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        AppText(
          label,
          variant: AppTextVariant.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.bodySmall.toTextStyle(
            color: AppColors.primitives.neutral.shade100,
          ),
        ),
        AppText(
          amount,
          variant: AppTextVariant.titleSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.h6.toTextStyle(
            color: AppColors.primitives.neutral.shade100,
          ),
        ),
      ],
    );
  }
}
