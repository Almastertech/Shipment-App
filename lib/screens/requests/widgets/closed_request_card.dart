import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/components/buttons/secondary_button.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_images.dart';
import 'package:shipments/core/resources/app_radius.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';

class ClosedRequestCard extends StatelessWidget {
  const ClosedRequestCard({
    super.key,
    required this.requestType,
    required this.requestNumber,
    required this.product,
    required this.status,
    required this.compensationLabel,
    required this.compensation,
    required this.valueLabel,
    required this.value,
    required this.outcomeMessage,
    required this.detailsLabel,
    required this.accepted,
    required this.onDetails,
    this.productImage = AppImages.shipmentBackground,
    this.cardHeight = 246,
  });

  final String requestType;
  final String requestNumber;
  final String product;
  final String status;
  final String compensationLabel;
  final String compensation;
  final String valueLabel;
  final String value;
  final String outcomeMessage;
  final String detailsLabel;
  final bool accepted;
  final VoidCallback onDetails;
  final String productImage;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final outcomeColor =
        accepted ? colors.success.shade600 : colors.failure.shade500;

    return Container(
      height: cardHeight,
      padding: const EdgeInsets.all(AppSpacing.tokenL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.tokenL),
                child: Image.asset(
                  productImage,
                  width: 52,
                  height: 52,
                  fit: BoxFit.cover,
                  alignment: const Alignment(-.4, 0),
                  errorBuilder: (context, error, stackTrace) => ColoredBox(
                    color: colors.neutral.shade200,
                    child: const SizedBox.square(
                      dimension: 52,
                      child: Icon(Icons.image_not_supported_outlined, size: 20),
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
                      variant: AppTextVariant.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.buyerMobile.h6.toTextStyle(
                        color: colors.neutral.shade900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.token2Xs),
                    AppText(
                      product,
                      variant: AppTextVariant.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                        color: colors.neutral.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.tokenS),
              _StatusPill(label: status, accepted: accepted),
            ],
          ),
          const SizedBox(height: AppSpacing.tokenL),
          Row(
            children: <Widget>[
              Expanded(
                child: _AmountPanel(
                  label: compensationLabel,
                  value: compensation,
                  highlighted: accepted,
                ),
              ),
              const SizedBox(width: AppSpacing.tokenXs),
              Expanded(
                child: _AmountPanel(
                  label: valueLabel,
                  value: value,
                  highlighted: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.tokenS),
          Row(
            children: <Widget>[
              Expanded(
                child: AppText(
                  outcomeMessage,
                  variant: AppTextVariant.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: outcomeColor,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.tokenS),
              SecondaryButton(
                label: detailsLabel,
                onPressed: onDetails,
                fullWidth: false,
                iconOnTrailing: true,
                icon: const Icon(
                   Icons.chevron_right_rounded,
                  size: 18,
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.primary.shade500,
                  side: BorderSide(color: colors.primary.shade500),
                  minimumSize: const Size(0, 38),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.tokenM,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const StadiumBorder(),
                  textStyle: AppTypography.buyerMobile.button.toTextStyle(
                    color: colors.primary.shade500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.accepted});

  final String label;
  final bool accepted;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final color = accepted ? colors.success.shade700 : colors.failure.shade600;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: accepted ? colors.success.shade100 : colors.failure.shade100,
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
              accepted ? Icons.check_rounded : Icons.close_rounded,
              size: 13,
              color: color,
            ),
            const SizedBox(width: AppSpacing.token2Xs),
            AppText(
              label,
              variant: AppTextVariant.labelSmall,
              style:
                  AppTypography.buyerMobile.caption.toTextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmountPanel extends StatelessWidget {
  const _AmountPanel({
    required this.label,
    required this.value,
    required this.highlighted,
  });

  final String label;
  final String value;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Container(
      constraints: const BoxConstraints(minHeight: 64),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.tokenS,
        vertical: AppSpacing.tokenXs,
      ),
      decoration: BoxDecoration(
        color: highlighted ? colors.accent01.shade300 : colors.neutral.shade200,
        borderRadius: BorderRadius.circular(AppRadius.tokenL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppText(
            label,
            variant: AppTextVariant.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.caption.toTextStyle(
              color: colors.neutral.shade700,
            ),
          ),
          AppText(
            value,
            variant: AppTextVariant.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.label.toTextStyle(
              color: colors.neutral.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
