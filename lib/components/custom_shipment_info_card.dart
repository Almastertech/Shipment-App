import 'package:flutter/material.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_images.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_typography.dart';
import 'app_card.dart';
import 'app_text.dart';
import 'buttons/primary_button.dart';

/// Compact shipment details card for an item and its delivery information.
///
/// Pass labels from the app's localizations. The ambient text direction controls
/// the placement of the image, details, badges, and information cells.
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
    required this.trackingNumberLabel,
    required this.trackingNumber,
    required this.detailsActionLabel,
    required this.onDetails,
    this.productImage = AppImages.shipmentBackground,
    this.showDetailsAction = true,
  });

  final String productTitle;
  final String merchantName;
  final String price;
  final String protectionLabel;
  final String deliveryStatus;
  final String expectedDeliveryLabel;
  final String expectedDeliveryDate;
  final String trackingNumberLabel;
  final String trackingNumber;
  final String detailsActionLabel;
  final VoidCallback? onDetails;
  final String productImage;
  final bool showDetailsAction;

  @override
  Widget build(BuildContext context) {
    const cardRadius = BorderRadius.all(
      Radius.circular(AppRadius.token2Xl),
    );

    return ClipRRect(
      borderRadius: cardRadius,
      child: AppCard(
        padding: EdgeInsets.zero,
        child: ColoredBox(
          color: AppColors.primitives.neutral.shade200,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.tokenM),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _ProductHeader(
                  productTitle: productTitle,
                  merchantName: merchantName,
                  price: price,
                  protectionLabel: protectionLabel,
                  deliveryStatus: deliveryStatus,
                  image: productImage,
                ),
                const SizedBox(height: AppSpacing.tokenM),
                _ShipmentMetadata(
                  expectedDeliveryLabel: expectedDeliveryLabel,
                  expectedDeliveryDate: expectedDeliveryDate,
                  trackingNumberLabel: trackingNumberLabel,
                  trackingNumber: trackingNumber,
                ),
                if (showDetailsAction) ...<Widget>[
                  const SizedBox(height: AppSpacing.tokenS),
                  PrimaryButton(
                    label: detailsActionLabel,
                    onPressed: onDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primitives.primary.shade500,
                      foregroundColor: AppColors.primitives.neutral.shade100,
                      disabledBackgroundColor:
                          AppColors.primitives.primary.shade300,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.tokenM,
                        vertical: AppSpacing.tokenS,
                      ),
                      minimumSize: const Size.fromHeight(48),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: const StadiumBorder(),
                      textStyle: AppTypography.buyerMobile.button.toTextStyle(),
                    ),
                  ),
                ],
              ],
            ),
          ),
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
    const imageRadius = BorderRadius.all(
      Radius.circular(AppRadius.tokenXl),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: imageRadius,
          child: Image.asset(
            image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => ColoredBox(
              color: AppColors.primitives.neutral.shade300,
              child: const SizedBox(
                width: 100,
                height: 100,
                child: Icon(Icons.image_not_supported_outlined),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.tokenS),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: AppText(
                      productTitle,
                      variant: AppTextVariant.titleSmall,
                      textAlign: TextAlign.start,
                      style: AppTypography.buyerMobile.h6.toTextStyle(
                        color: AppColors.primitives.neutral.shade500,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.tokenXs),
                  Flexible(
                    flex: 2,
                    child: AppText(
                      merchantName,
                      variant: AppTextVariant.bodySmall,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                        color: AppColors.primitives.neutral.shade400,
                      ),
                    ),
                  ),
                ],
              ),
              AppText(
                price,
                variant: AppTextVariant.titleSmall,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.buyerMobile.h6.toTextStyle(
                  color: AppColors.primitives.primary.shade500,
                ),
              ),
              const SizedBox(height: AppSpacing.tokenS),
              Wrap(
                spacing: AppSpacing.tokenXs,
                runSpacing: AppSpacing.tokenXs,
                children: <Widget>[
                  _ShipmentBadge(
                    label: protectionLabel,
                    color: AppColors.primitives.accent01.shade500,
                    foregroundColor: AppColors.primitives.neutral.shade500,
                    icon: Icons.verified_user_outlined,
                  ),
                  _ShipmentBadge(
                    label: deliveryStatus,
                    color: AppColors.primitives.primary.shade100,
                    foregroundColor: AppColors.primitives.primary.shade500,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShipmentBadge extends StatelessWidget {
  const _ShipmentBadge({
    required this.label,
    required this.color,
    required this.foregroundColor,
    this.icon,
  });

  final String label;
  final Color color;
  final Color foregroundColor;
  final IconData? icon;

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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Icon(icon, size: 14, color: foregroundColor),
              const SizedBox(width: AppSpacing.tokenXs),
            ],
            AppText(
              label,
              variant: AppTextVariant.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.buyerMobile.caption.toTextStyle(
                color: foregroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShipmentMetadata extends StatelessWidget {
  const _ShipmentMetadata({
    required this.expectedDeliveryLabel,
    required this.expectedDeliveryDate,
    required this.trackingNumberLabel,
    required this.trackingNumber,
  });

  final String expectedDeliveryLabel;
  final String expectedDeliveryDate;
  final String trackingNumberLabel;
  final String trackingNumber;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.tokenXl),
      child: ColoredBox(
        color: AppColors.primitives.neutral.shade100,
        child: IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Expanded(
                child: _MetadataCell(
                  label: expectedDeliveryLabel,
                  value: expectedDeliveryDate,
                ),
              ),
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: AppColors.primitives.neutral.shade200,
              ),
              Expanded(
                child: _MetadataCell(
                  label: trackingNumberLabel,
                  value: trackingNumber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetadataCell extends StatelessWidget {
  const _MetadataCell({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.tokenM,
        vertical: AppSpacing.tokenS,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText(
            label,
            variant: AppTextVariant.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.bodySmall.toTextStyle(
              color: AppColors.primitives.neutral.shade300,
            ),
          ),
          AppText(
            value,
            variant: AppTextVariant.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
              color: AppColors.primitives.neutral.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
