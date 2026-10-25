import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/app_divider.dart';
import '../../../components/app_text.dart';
import '../../../components/buttons/secondary_button.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

/// A product shipment card that displays product details, protection status,
/// shipping state, tracking number, expected delivery date, and a details action.
class CustomProductCardShipments extends StatelessWidget {
  const CustomProductCardShipments({
    super.key,
    required this.productTitle,
    required this.storeName,
    required this.price,
    required this.protectionLabel,
    required this.statusLabel,
    required this.trackingLabel,
    required this.trackingNumber,
    required this.deliveryDateLabel,
    required this.deliveryDate,
    required this.actionLabel,
    this.productImage = AppImages.shipmentBackground,
    this.imageAlignment = const Alignment(-.4, 0),
    this.isDelivered = false,
    this.footer,
    this.onAction,
    this.onTap,
  });

  final String productTitle;
  final String storeName;
  final String price;
  final String protectionLabel;
  final String statusLabel;
  final String trackingLabel;
  final String trackingNumber;
  final String deliveryDateLabel;
  final String deliveryDate;
  final String actionLabel;
  final String productImage;
  final Alignment imageAlignment;
  final bool isDelivered;
  final Widget? footer;
  final VoidCallback? onAction;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
        border: Border.all(color: colors.neutral.shade200),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.tokenM),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Top section: Product image, Details, and Status pill
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Product Thumbnail
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: colors.neutral.shade100,
                          borderRadius: BorderRadius.circular(AppRadius.tokenL),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          productImage,
                          fit: BoxFit.cover,
                          alignment: imageAlignment,
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Icon(
                              Icons.watch_outlined,
                              size: 26,
                              color: colors.neutral.shade400,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.tokenS),

                      // Title, shops • Price, and Protection Pill
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            AppText(
                              productTitle,
                              variant: AppTextVariant.titleSmall,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  AppTypography.buyerMobile.label.toTextStyle(
                                color: colors.neutral.shade900,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.token3Xs),
                            AppText(
                              '$storeName • $price',
                              variant: AppTextVariant.bodySmall,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  AppTypography.buyerMobile.caption.toTextStyle(
                                color: colors.neutral.shade500,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.tokenXs),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: colors.accent01.shade300,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.tokenFull,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.tokenS,
                                  vertical: AppSpacing.token3Xs,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Flexible(
                                      child: AppText(
                                        protectionLabel,
                                        variant: AppTextVariant.labelSmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTypography
                                            .buyerMobile.labelSmall
                                            .toTextStyle(
                                          color: colors.neutral.shade900,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.token2Xs),
                                    SvgPicture.asset(
                                      AppImages.shieldCheck,
                                      width: 14,
                                      height: 14,
                                      colorFilter: ColorFilter.mode(
                                        colors.neutral.shade900,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.tokenS),

                      // Status Badge (e.g. بالطريق)
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: isDelivered
                              ? colors.success.shade100
                              : colors.accent01.shade100,
                          borderRadius: BorderRadius.circular(
                            AppRadius.tokenFull,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.tokenS,
                            vertical: AppSpacing.token3Xs,
                          ),
                          child: AppText(
                            statusLabel,
                            variant: AppTextVariant.labelSmall,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.buyerMobile.labelSmall
                                .toTextStyle(
                              color: isDelivered
                                  ? colors.success.shade700
                                  : colors.accent01.shade600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Divider
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.tokenM),
                    child: AppDivider(
                      height: 1,
                      thickness: 1,
                    ),
                  ),

                  // Bottom section: Tracking, Expected delivery, and Action button
                  Row(
                    children: <Widget>[
                      // Tracking Info
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            AppText(
                              trackingLabel,
                              variant: AppTextVariant.labelSmall,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  AppTypography.buyerMobile.caption.toTextStyle(
                                color: colors.neutral.shade400,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.token3Xs),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: AppText(
                                trackingNumber,
                                variant: AppTextVariant.labelMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    AppTypography.buyerMobile.label.toTextStyle(
                                  color: colors.neutral.shade900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.tokenS),

                      // Expected Delivery Date
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            AppText(
                              deliveryDateLabel,
                              variant: AppTextVariant.labelSmall,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  AppTypography.buyerMobile.caption.toTextStyle(
                                color: colors.neutral.shade400,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.token3Xs),
                            AppText(
                              deliveryDate,
                              variant: AppTextVariant.labelMedium,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  AppTypography.buyerMobile.label.toTextStyle(
                                color: colors.neutral.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.tokenS),

                      // Action Button (التفاصيل <)
                      SecondaryButton(
                        label: actionLabel,
                        onPressed: onAction,
                        fullWidth: false,
                        iconOnTrailing: true,
                        icon: Icon(
                          Icons.chevron_right_rounded,
                          size: 16,
                          color: colors.primary.shade500,
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colors.primary.shade500,
                          side: BorderSide(
                            color: colors.primary.shade500,
                            width: 1.2,
                          ),
                          backgroundColor: Colors.transparent,
                          minimumSize: const Size(0, 36),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.tokenM,
                            vertical: AppSpacing.tokenXs,
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          shape: const StadiumBorder(),
                          textStyle:
                              AppTypography.buyerMobile.labelSmall.toTextStyle(
                            color: colors.primary.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (footer != null) ...<Widget>[
                    const SizedBox(height: AppSpacing.tokenM),
                    footer!,
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
