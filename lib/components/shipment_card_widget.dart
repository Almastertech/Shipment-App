import 'package:flutter/material.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_images.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_typography.dart';
import 'app_card.dart';
import 'app_text.dart';
import 'buttons/icon_circle_button.dart';
import 'buttons/primary_button.dart';

/// A shipment summary card with delivery status, protection, progress, and CTA.
///
/// Supply display strings from the app's generated localization so the widget
/// stays reusable across locales and shipment states.
class ShipmentCardWidget extends StatelessWidget {
  const ShipmentCardWidget({
    super.key,
    required this.deliveryStatus,
    required this.protectionLabel,
    required this.merchantAndItem,
    required this.title,
    required this.progressSteps,
    required this.activeStepIndex,
    required this.expectedDeliveryLabel,
    required this.expectedDeliveryDate,
    required this.actionLabel,
    required this.onAction,
    this.detailsHero = false,
    this.trackingNumber = '',
    this.onBack,
    this.onShare,
    this.backTooltip,
    this.shareTooltip,
  })  : assert(progressSteps.length > 1),
        assert(activeStepIndex >= 0 && activeStepIndex < progressSteps.length);

  final String deliveryStatus;
  final String protectionLabel;
  final String merchantAndItem;
  final String title;

  /// Ordered from the logical start to end (RTL Arabic order: right to left).
  final List<String> progressSteps;
  final int activeStepIndex;
  final String expectedDeliveryLabel;
  final String expectedDeliveryDate;
  final String actionLabel;
  final VoidCallback? onAction;
  final bool detailsHero;
  final String trackingNumber;
  final VoidCallback? onBack;
  final VoidCallback? onShare;
  final String? backTooltip;
  final String? shareTooltip;

  @override
  Widget build(BuildContext context) {
    if (detailsHero) return _buildDetailsHero();

    const colors = AppColors.primitives;
    const radius = BorderRadius.all(Radius.circular(AppRadius.token2Xl));

    return AspectRatio(
      aspectRatio: 404 / 370,
      child: ClipRRect(
        borderRadius: radius,
        child: AppCard(
          padding: EdgeInsets.zero,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                AppImages.shipmentBackground,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) => ColoredBox(
                  color: AppColors.primitives.neutral.shade400,
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0x22090A0D),
                      Color(0x08090A0D),
                      Color(0x55090A0D),
                      Color(0xE6090A0D),
                    ],
                    stops: <double>[0, 0.38, 0.68, 1],
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
                        _ProtectionPill(label: protectionLabel),
                        const Spacer(),
                        _StatusPill(label: deliveryStatus),
                      ],
                    ),
                    const Spacer(),
                    AppText(
                      merchantAndItem,
                      variant: AppTextVariant.bodySmall,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                        color: colors.neutral.shade100,
                      ),
                    ),
                    AppText(
                      title,
                      variant: AppTextVariant.headlineSmall,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.buyerMobile.h2.toTextStyle(
                        color: colors.neutral.shade100,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenS),
                    _ShipmentProgress(
                      steps: progressSteps,
                      activeStepIndex: activeStepIndex,
                    ),
                    const SizedBox(height: AppSpacing.tokenM),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: _ExpectedDelivery(
                            label: expectedDeliveryLabel,
                            date: expectedDeliveryDate,
                          ),
                        ),
                        PrimaryButton(
                          label: actionLabel,
                          onPressed: onAction,
                          fullWidth: false,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.accent01.shade500,
                            foregroundColor: colors.neutral.shade500,
                            disabledBackgroundColor: colors.accent01.shade600,
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

  Widget _buildDetailsHero() {
    const colors = AppColors.primitives;

    return AspectRatio(
      aspectRatio: 404 / 368,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            AppImages.shipmentBackground,
            fit: BoxFit.cover,
            alignment: const Alignment(-.35, -.1),
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
                  colors.primary.shade900.withValues(alpha: .20),
                  colors.primary.shade800.withValues(alpha: .42),
                  colors.primary.shade800.withValues(alpha: .92),
                ],
                stops: const <double>[0, .56, 1],
              ),
            ),
          ),
          PositionedDirectional(
            top: 0,
            start: AppSpacing.tokenL,
            end: AppSpacing.tokenL,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.tokenS),
                child: Row(
                  children: <Widget>[
                    IconCircleButton(
                      icon: Icons.arrow_back_rounded,
                      tooltip: backTooltip ?? title,
                      onPressed: onBack,
                      backgroundColor: Colors.white.withValues(alpha: .16),
                      foregroundColor: Colors.white,
                    ),
                    const Spacer(),
                    IconCircleButton(
                      icon: Icons.ios_share_rounded,
                      tooltip: shareTooltip ?? title,
                      onPressed: onShare,
                      backgroundColor: Colors.white.withValues(alpha: .16),
                      foregroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: AppSpacing.tokenXl,
            end: AppSpacing.tokenXl,
            bottom: AppSpacing.token8Xl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: _Pill(
                    color: colors.accent01.shade300,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 16,
                          color: colors.neutral.shade900,
                        ),
                        const SizedBox(width: AppSpacing.tokenXs),
                        AppText(
                          deliveryStatus,
                          variant: AppTextVariant.labelSmall,
                          style: AppTypography.buyerMobile.labelSmall
                              .toTextStyle(color: colors.neutral.shade900),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenS),
                AppText(
                  title,
                  variant: AppTextVariant.headlineSmall,
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.h2.toTextStyle(
                    color: colors.neutral.shade100,
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenS),
                AppText(
                  '$merchantAndItem · $trackingNumber',
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: colors.neutral.shade200,
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

class _ProtectionPill extends StatelessWidget {
  const _ProtectionPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return _Pill(
      color: AppColors.primitives.accent01.shade500,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.verified_user_outlined,
            size: 14,
            color: AppColors.primitives.neutral.shade500,
          ),
          const SizedBox(width: AppSpacing.tokenXs),
          AppText(
            label,
            variant: AppTextVariant.labelSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.caption.toTextStyle(
              color: AppColors.primitives.neutral.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return _Pill(
      color: AppColors.primitives.primary.shade100,
      child: AppText(
        label,
        variant: AppTextVariant.labelSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.buyerMobile.caption.toTextStyle(
          color: AppColors.primitives.primary.shade500,
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.tokenFull),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenS,
          vertical: AppSpacing.tokenXs,
        ),
        child: child,
      ),
    );
  }
}

class _ShipmentProgress extends StatelessWidget {
  const _ShipmentProgress({
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
        final lineColor = isReached
            ? AppColors.primitives.accent01.shade500
            : AppColors.primitives.neutral.shade100.withValues(alpha: 0.8);

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
                    color: lineColor,
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
                        ? AppColors.primitives.accent01.shade500
                        : AppColors.primitives.neutral.shade200,
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

class _ExpectedDelivery extends StatelessWidget {
  const _ExpectedDelivery({required this.label, required this.date});

  final String label;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText(
          label,
          variant: AppTextVariant.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.bodySmall.toTextStyle(
            color: AppColors.primitives.neutral.shade200,
          ),
        ),
        AppText(
          date,
          variant: AppTextVariant.titleSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.h6.toTextStyle(
            color: AppColors.primitives.accent01.shade500,
          ),
        ),
      ],
    );
  }
}
