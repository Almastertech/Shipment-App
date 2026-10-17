import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/app_card.dart';
import '../../../components/app_divider.dart';
import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

/// Compact shipment information row for the home screen.
class CustomHomeInfoCard extends StatelessWidget {
  const CustomHomeInfoCard({
    super.key,
    required this.productTitle,
    required this.merchantName,
    required this.price,
    required this.statusLabel,
    required this.deliveryLabel,
    required this.trackingLabel,
    required this.trackingNumber,
    this.productImage = AppImages.shipmentBackground,
    this.onTap,
  });

  final String productTitle;
  final String merchantName;
  final String price;
  final String statusLabel;
  final String deliveryLabel;
  final String trackingLabel;
  final String trackingNumber;
  final String productImage;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.tokenXl),
        border: Border.all(color: colors.neutral.shade200),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .06),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: AppCard(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.tokenM,
            AppSpacing.tokenS,
            AppSpacing.tokenS,
            AppSpacing.tokenS,
          ),
          onTap: onTap,
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.tokenM),
                    child: Image.asset(
                      productImage,
                      width: 42,
                      height: 42,
                      fit: BoxFit.cover,
                      alignment: const Alignment(-.4, 0),
                      errorBuilder: (context, error, stackTrace) => ColoredBox(
                        color: colors.neutral.shade200,
                        child: SizedBox(
                          width: 42,
                          height: 42,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 18,
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
                          variant: AppTextVariant.labelMedium,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.buyerMobile.label.toTextStyle(
                            color: colors.neutral.shade900,
                          ),
                        ),
                        AppText(
                          '$merchantName · $price',
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
                  const SizedBox(width: AppSpacing.tokenS),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.warning.shade100,
                      borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.tokenXs,
                        vertical: AppSpacing.token3Xs,
                      ),
                      child: AppText(
                        statusLabel,
                        variant: AppTextVariant.labelSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.caption.toTextStyle(
                          color: colors.warning.shade700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const AppDivider(
                height: AppSpacing.tokenM,
                thickness: 1,
              ),
              Row(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AppText(
                        trackingLabel,
                        variant: AppTextVariant.labelSmall,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.caption.toTextStyle(
                          color: colors.neutral.shade700,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.token2Xs),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: AppText(
                          trackingNumber,
                          variant: AppTextVariant.labelSmall,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.buyerMobile.caption.toTextStyle(
                            color: colors.neutral.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SvgPicture.asset(
                          AppImages.timeQuarterTo,
                          width: 13,
                          height: 13,
                          colorFilter: ColorFilter.mode(
                            colors.primary.shade500,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.token2Xs),
                        Flexible(
                          child: AppText(
                            deliveryLabel,
                            variant: AppTextVariant.labelSmall,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                AppTypography.buyerMobile.caption.toTextStyle(
                              color: colors.neutral.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
