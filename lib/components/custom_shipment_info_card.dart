import 'package:flutter/material.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_images.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_typography.dart';
import '../l10n/app_localizations.dart';
import 'app_text.dart';
import 'buttons/primary_button.dart';

/// Compact shipment summary card with product, protection, and delivery status.
///
/// The row order follows the active locale. Pass labels from app localizations.
class CustomShipmentInfoCard extends StatelessWidget {
  const CustomShipmentInfoCard({
    super.key,
    required this.productTitle,
    required this.merchantName,
    required this.price,
    required this.protectionLabel,
    required this.deliveryStatus,
    required this.expectedDeliveryLabel,
    required this.expectedDeliveryDate,
    required this.detailsActionLabel,
    required this.onDetails,
    this.productImage = AppImages.shipmentBackground,
    this.activeStepIndex = 1,
    this.showDetailsAction = true,
  });

  final String productTitle;
  final String merchantName;
  final String price;
  final String protectionLabel;
  final String deliveryStatus;
  final String expectedDeliveryLabel;
  final String expectedDeliveryDate;
  final String detailsActionLabel;
  final VoidCallback? onDetails;
  final String productImage;
  final int activeStepIndex;
  final bool showDetailsAction;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;
    final localizations = AppLocalizations.of(context)!;
    final steps = <String>[
      localizations.shipmentTimelineOrdered,
      localizations.shipmentTimelineInTransit,
      localizations.shipmentTimelineDelivered,
    ];

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
              end: -28,
              top: -54,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: colors.primary.shade500.withValues(alpha: .38),
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
                  _ProductHeader(
                    productTitle: productTitle,
                    merchantName: merchantName,
                    price: price,
                    protectionLabel: protectionLabel,
                    deliveryStatus: deliveryStatus,
                    image: productImage,
                  ),
                  const SizedBox(height: AppSpacing.tokenM),
                  _ShipmentTimeline(
                    steps: steps,
                    activeStepIndex: activeStepIndex,
                  ),
                  const SizedBox(height: AppSpacing.tokenS),
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: _DeliveryDate(
                            label: expectedDeliveryLabel,
                            date: expectedDeliveryDate,
                          ),
                        ),
                      ),
                      if (showDetailsAction) ...[
                        const SizedBox(width: AppSpacing.tokenS),
                        PrimaryButton(
                          label: detailsActionLabel,
                          onPressed: onDetails,
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
                            minimumSize: const Size(0, 30),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.tokenS,
                            ),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            elevation: 0,
                            shape: const StadiumBorder(),
                            textStyle: AppTypography.buyerMobile.caption
                                .toTextStyle(color: colors.neutral.shade900),
                          ),
                        ),
                      ],
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

class _ProductHeader extends StatelessWidget {
  const _ProductHeader({
    required this.productTitle,
    required this.merchantName,
    required this.price,
    required this.protectionLabel,
    required this.deliveryStatus,
    required this.image,
  });

  final String productTitle;
  final String merchantName;
  final String price;
  final String protectionLabel;
  final String deliveryStatus;
  final String image;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: _ProtectionBadge(label: protectionLabel),
              ),
              const SizedBox(height: AppSpacing.tokenXs),
              AppText(
                productTitle,
                variant: AppTextVariant.titleSmall,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.label.toTextStyle(
                  color: Colors.white,
                ),
              ),
              AppText(
                '$merchantName · $price',
                variant: AppTextVariant.bodySmall,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.caption.toTextStyle(
                  color: colors.neutral.shade200,
                ),
              ),
              const SizedBox(height: AppSpacing.tokenXs),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 14,
                    color: colors.accent01.shade300,
                  ),
                  const SizedBox(width: AppSpacing.token2Xs),
                  Flexible(
                    child: AppText(
                      deliveryStatus,
                      variant: AppTextVariant.labelSmall,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.buyerMobile.labelSmall.toTextStyle(
                        color: colors.accent01.shade300,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.tokenS),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.tokenL),
          child: Image.asset(
            image,
            width: 54,
            height: 66,
            fit: BoxFit.cover,
            alignment: const Alignment(-.4, 0),
            errorBuilder: (context, error, stackTrace) => ColoredBox(
              color: colors.neutral.shade100,
              child: SizedBox(
                width: 54,
                height: 66,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: colors.neutral.shade500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProtectionBadge extends StatelessWidget {
  const _ProtectionBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.accent01.shade300,
        borderRadius: BorderRadius.circular(AppRadius.tokenFull),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 3, 6, 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.verified_user_outlined,
              size: 12,
              color: colors.neutral.shade900,
            ),
            const SizedBox(width: AppSpacing.token2Xs),
            AppText(
              label,
              variant: AppTextVariant.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.buyerMobile.caption.toTextStyle(
                color: colors.neutral.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShipmentTimeline extends StatelessWidget {
  const _ShipmentTimeline({
    required this.steps,
    required this.activeStepIndex,
  });

  final List<String> steps;
  final int activeStepIndex;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;
    final activeIndex = activeStepIndex.clamp(0, steps.length - 1);

    return SizedBox(
      height: 36,
      child: Stack(
        children: [
          PositionedDirectional(
            start: 20,
            end: 20,
            top: 5,
            child: Container(
              height: 2,
              color: Colors.white.withValues(alpha: .22),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var index = 0; index < steps.length; index++)
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: index <= activeIndex
                              ? colors.accent01.shade300
                              : colors.primary.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.token2Xs),
                      AppText(
                        steps[index],
                        variant: AppTextVariant.labelSmall,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.caption
                            .toTextStyle(color: colors.neutral.shade200)
                            .copyWith(fontSize: 10, height: 1.2),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeliveryDate extends StatelessWidget {
  const _DeliveryDate({required this.label, required this.date});

  final String label;
  final String date;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(AppRadius.tokenFull),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.tokenS,
          vertical: AppSpacing.tokenXs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 13,
              color: colors.neutral.shade200,
            ),
            const SizedBox(width: AppSpacing.token2Xs),
            Flexible(
              child: AppText(
                '$label · $date',
                variant: AppTextVariant.bodySmall,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.caption.toTextStyle(
                  color: colors.neutral.shade100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
