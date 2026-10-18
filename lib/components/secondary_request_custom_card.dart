import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_images.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_typography.dart';
import 'app_text.dart';
import 'buttons/secondary_button.dart';

/// White, compact claim card for following a request and its progress.
class SecondaryRequestCustomCard extends StatelessWidget {
  const SecondaryRequestCustomCard({
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
    this.productImage = AppImages.shipmentBackground,
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
  final String productImage;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.semantic.surface.primary,
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
        border: Border.all(color: colors.neutral.shade200),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .08),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.tokenS),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _ClaimHeader(
              requestNumber: requestNumber,
              requestType: requestType,
              remainingTimeLabel: remainingTimeLabel,
              title: title,
              productImage: productImage,
            ),
            const SizedBox(height: AppSpacing.tokenS),
            _ClaimProgress(
              steps: progressSteps,
              activeStepIndex: activeStepIndex,
            ),
            const SizedBox(height: AppSpacing.tokenS),
            _ClaimNote(description: description),
            const SizedBox(height: AppSpacing.tokenS),
            Row(
              children: <Widget>[
                _ClaimAmount(label: amountLabel, amount: amount),
                const Spacer(),
                SecondaryButton(
                  label: actionLabel,
                  onPressed: onTap,
                  fullWidth: false,
                  iconOnTrailing: true,
                  icon: const Icon(
                    Icons.chevron_right_rounded,
                    size: 16,
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.primary.shade500,
                    side: BorderSide(color: colors.primary.shade500),
                    minimumSize: const Size(0, 30),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.tokenS,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    shape: const StadiumBorder(),
                    textStyle: AppTypography.buyerMobile.labelSmall
                        .toTextStyle(color: colors.primary.shade500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ClaimHeader extends StatelessWidget {
  const _ClaimHeader({
    required this.requestNumber,
    required this.requestType,
    required this.remainingTimeLabel,
    required this.title,
    required this.productImage,
  });

  final String requestNumber;
  final String requestType;
  final String remainingTimeLabel;
  final String title;
  final String productImage;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.tokenL),
          child: Image.asset(
            productImage,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            alignment: const Alignment(-.4, 0),
            errorBuilder: (context, error, stackTrace) => ColoredBox(
              color: colors.neutral.shade200,
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.image_not_supported_outlined, size: 18),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.tokenS),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppText(
                '$requestType $requestNumber',
                variant: AppTextVariant.labelMedium,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.label.toTextStyle(
                  color: colors.neutral.shade900,
                ),
              ),
              AppText(
                title,
                variant: AppTextVariant.bodySmall,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.caption.toTextStyle(
                  color: colors.neutral.shade600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.tokenXs),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.primary.shade100,
            borderRadius: BorderRadius.circular(AppRadius.tokenFull),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.tokenXs,
              vertical: AppSpacing.token2Xs,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset(
                  AppImages.timeQuarterTo,
                  width: 12,
                  height: 12,
                  colorFilter: ColorFilter.mode(
                    colors.primary.shade500,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: AppSpacing.token2Xs),
                AppText(
                  remainingTimeLabel,
                  variant: AppTextVariant.labelSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.caption.toTextStyle(
                    color: colors.primary.shade500,
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

class _ClaimProgress extends StatelessWidget {
  const _ClaimProgress({required this.steps, required this.activeStepIndex});

  final List<String> steps;
  final int activeStepIndex;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final activeLineColor = colors.primary.shade500;
    final inactiveLineColor = colors.neutral.shade300;

    return Row(
      children: <Widget>[
        for (var index = 0; index < steps.length; index++)
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 16,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: index == 0
                                ? const SizedBox.shrink()
                                : Container(
                                    height: 2.5,
                                    color: (index - 1) < activeStepIndex
                                        ? activeLineColor
                                        : inactiveLineColor,
                                  ),
                          ),
                          Expanded(
                            child: index == steps.length - 1
                                ? const SizedBox.shrink()
                                : Container(
                                    height: 2.5,
                                    color: index < activeStepIndex
                                        ? activeLineColor
                                        : inactiveLineColor,
                                  ),
                          ),
                        ],
                      ),
                      _buildStepCircle(index),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.token2Xs),
                AppText(
                  steps[index],
                  variant: AppTextVariant.labelSmall,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.caption.toTextStyle(
                    color: index <= activeStepIndex
                        ? colors.neutral.shade900
                        : colors.neutral.shade500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildStepCircle(int index) {
    const colors = AppColors.primitives;
    if (index < activeStepIndex) {
      return Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.primary.shade500,
        ),
      );
    } else if (index == activeStepIndex) {
      return Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.accent01.shade300,
          border: Border.all(
            color: colors.primary.shade500,
            width: 2.5,
          ),
        ),
      );
    } else {
      return Container(
        width: 13,
        height: 13,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors.neutral.shade300,
        ),
      );
    }
  }
}

class _ClaimNote extends StatelessWidget {
  const _ClaimNote({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primary.shade100,
        borderRadius: BorderRadius.circular(AppRadius.tokenL),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenS,
          vertical: AppSpacing.tokenXs,
        ),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              AppImages.shieldCheck,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(
                colors.primary.shade500,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: AppSpacing.tokenXs),
            Expanded(
              child: AppText(
                description,
                variant: AppTextVariant.labelSmall,
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.caption.toTextStyle(
                  color: colors.neutral.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClaimAmount extends StatelessWidget {
  const _ClaimAmount({required this.label, required this.amount});

  final String label;
  final String amount;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppText(
          label,
          variant: AppTextVariant.labelSmall,
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.caption.toTextStyle(
            color: colors.neutral.shade600,
          ),
        ),
        AppText(
          amount,
          variant: AppTextVariant.titleSmall,
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.label.toTextStyle(
            color: colors.neutral.shade900,
          ),
        ),
      ],
    );
  }
}
