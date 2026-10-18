import 'package:flutter/material.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_images.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_typography.dart';
import 'app_card.dart';
import 'app_text.dart';

class CustomClaimShipmentCard extends StatelessWidget {
  const CustomClaimShipmentCard({
    super.key,
    required this.productTitle,
    required this.deliveryDate,
    required this.trackingNumber,
    required this.protectionLabel,
    this.productImage = AppImages.shipmentBackground,
  });

  final String productTitle;
  final String deliveryDate;
  final String trackingNumber;
  final String protectionLabel;
  final String productImage;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return AppCard(
      color: colors.primary.shade700,
      padding: const EdgeInsets.all(AppSpacing.tokenM),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.tokenL),
            child: ColoredBox(
              color: Colors.white,
              child: Image.asset(
                productImage,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                alignment: const Alignment(-.65, 0),
                errorBuilder: (context, error, stackTrace) => SizedBox.square(
                  dimension: 64,
                  child: Icon(
                    Icons.watch_outlined,
                    color: colors.neutral.shade500,
                  ),
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
                  productTitle,
                  variant: AppTextVariant.titleSmall,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.h6.toTextStyle(
                    color: colors.neutral.shade100,
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                AppText(
                  '$deliveryDate • $trackingNumber',
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: colors.neutral.shade300,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.tokenS),
          DecoratedBox(
            decoration: BoxDecoration(
              color: colors.accent01.shade300,
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
                    Icons.verified_user_outlined,
                    size: 15,
                    color: colors.neutral.shade900,
                  ),
                  const SizedBox(width: AppSpacing.token2Xs),
                  AppText(
                    protectionLabel,
                    variant: AppTextVariant.labelSmall,
                    style: AppTypography.buyerMobile.caption.toTextStyle(
                      color: colors.neutral.shade900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
