import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_images.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_typography.dart';
import 'app_text.dart';
import 'buttons/primary_button.dart';

/// Compact claim summary showing its current status and progress.
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

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.token2Xl),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [colors.primary.shade600, colors.primary.shade700],
          ),
        ),
        child: Stack(
          children: [
            PositionedDirectional(
              start: -32,
              top: -44,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: colors.primary.shade500.withValues(alpha: .36),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.tokenM),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _RequestHeader(
                    requestNumber: requestNumber,
                    requestType: requestType,
                    remainingTimeLabel: remainingTimeLabel,
                    title: title,
                    image: productImage,
                  ),
                  const SizedBox(height: AppSpacing.tokenS),
                  _RequestProgress(
                    steps: progressSteps,
                    activeStepIndex: activeStepIndex,
                  ),
                  const SizedBox(height: AppSpacing.tokenS),
                  _RequestDescription(description: description),
                  const SizedBox(height: AppSpacing.tokenS),
                  Row(
                    children: [
                      _ClaimAmount(label: amountLabel, amount: amount),
                      const Spacer(),
                      PrimaryButton(
                        label: actionLabel,
                        onPressed: onTap,
                        fullWidth: false,
                        iconOnTrailing: true,
                        icon: Icon(
                          Directionality.of(context) == TextDirection.rtl
                              ? Icons.chevron_left_rounded
                              : Icons.chevron_right_rounded,
                          size: 16,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.accent01.shade300,
                          foregroundColor: colors.neutral.shade900,
                          disabledBackgroundColor: colors.accent01.shade200,
                          disabledForegroundColor: colors.neutral.shade700,
                          minimumSize: const Size(0, 32),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.tokenS,
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          elevation: 0,
                          shape: const StadiumBorder(),
                          textStyle: AppTypography.buyerMobile.labelSmall
                              .toTextStyle(color: colors.neutral.shade900),
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

class _RequestHeader extends StatelessWidget {
  const _RequestHeader({
    required this.requestNumber,
    required this.requestType,
    required this.remainingTimeLabel,
    required this.title,
    required this.image,
  });

  final String requestNumber;
  final String requestType;
  final String remainingTimeLabel;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.tokenL),
          child: Image.asset(
            image,
            width: 42,
            height: 42,
            fit: BoxFit.cover,
            alignment: const Alignment(-.4, 0),
            errorBuilder: (context, error, stackTrace) => ColoredBox(
              color: AppColors.primitives.neutral.shade100,
              child: const SizedBox(
                width: 42,
                height: 42,
                child: Icon(Icons.image_not_supported_outlined, size: 18),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.tokenS),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText(
                '$requestType $requestNumber',
                variant: AppTextVariant.labelMedium,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.label.toTextStyle(
                  color: Colors.white,
                ),
              ),
              AppText(
                title,
                variant: AppTextVariant.bodySmall,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.caption.toTextStyle(
                  color: colors.neutral.shade200,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.tokenS),
        _RemainingTimePill(label: remainingTimeLabel),
      ],
    );
  }
}

class _RemainingTimePill extends StatelessWidget {
  const _RemainingTimePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.warning.shade100,
        borderRadius: BorderRadius.circular(AppRadius.tokenFull),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenS,
          vertical: AppSpacing.token2Xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_rounded,
              size: 13,
              color: colors.warning.shade700,
            ),
            const SizedBox(width: AppSpacing.token2Xs),
            AppText(
              label,
              variant: AppTextVariant.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.buyerMobile.labelSmall.toTextStyle(
                color: colors.warning.shade800,
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
    final colors = AppColors.primitives;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < steps.length; index++)
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: index == 0
                          ? const SizedBox(height: 2)
                          : _ProgressLine(
                              isActive: index <= activeStepIndex,
                            ),
                    ),
                    Container(
                      width: 11,
                      height: 11,
                      decoration: BoxDecoration(
                        color: index <= activeStepIndex
                            ? colors.accent01.shade300
                            : colors.primary.shade300,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: index == steps.length - 1
                          ? const SizedBox(height: 2)
                          : _ProgressLine(
                              isActive: index < activeStepIndex,
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                AppText(
                  steps[index],
                  variant: AppTextVariant.labelSmall,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.caption
                      .toTextStyle(
                        color: index <= activeStepIndex
                            ? colors.neutral.shade100
                            : colors.primary.shade300,
                      )
                      .copyWith(fontSize: 10, height: 1.2),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ProgressLine extends StatelessWidget {
  const _ProgressLine({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return Container(
      height: 2,
      color: isActive
          ? colors.accent01.shade300
          : Colors.white.withValues(alpha: .22),
    );
  }
}

class _RequestDescription extends StatelessWidget {
  const _RequestDescription({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.accent01.shade100,
        borderRadius: BorderRadius.circular(AppRadius.tokenL),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenS,
          vertical: AppSpacing.tokenS,
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                description,
                variant: AppTextVariant.labelSmall,
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.caption
                    .toTextStyle(color: colors.neutral.shade800)
                    .copyWith(fontSize: 11, height: 14 / 11),
              ),
            ),
            const SizedBox(width: AppSpacing.tokenS),
            SvgPicture.asset(
              AppImages.camera,
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(
                colors.warning.shade700,
                BlendMode.srcIn,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          label,
          variant: AppTextVariant.labelSmall,
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.caption.toTextStyle(
            color: AppColors.primitives.neutral.shade200,
          ),
        ),
        AppText(
          amount,
          variant: AppTextVariant.titleSmall,
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.h6.toTextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
