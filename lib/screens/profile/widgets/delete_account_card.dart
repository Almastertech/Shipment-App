import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class DeleteAccountCard extends StatelessWidget {
  const DeleteAccountCard({
    super.key,
    required this.title,
    required this.message,
    required this.nameLabel,
    required this.name,
    required this.phoneLabel,
    required this.phone,
  });

  final String title;
  final String message;
  final String nameLabel;
  final String name;
  final String phoneLabel;
  final String phone;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final text = AppColors.semantic.text;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.semantic.surface.primary,
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.token2Xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colors.failure.shade100,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.warning_amber_outlined,
                size: 28,
                color: colors.failure.shade500,
              ),
            ),
            const SizedBox(height: AppSpacing.tokenL),
            AppText(
              title,
              variant: AppTextVariant.titleMedium,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.buyerMobile.h5
                  .toTextStyle(color: text.primary)
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.tokenXs),
            AppText(
              message,
              variant: AppTextVariant.bodySmall,
              textAlign: TextAlign.center,
              style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                color: text.secondary,
              ),
            ),
            const SizedBox(height: AppSpacing.tokenL),
            _AccountInfoRow(label: nameLabel, value: name),
            const SizedBox(height: AppSpacing.tokenS),
            _AccountInfoRow(
              label: phoneLabel,
              value: phone,
              valueDirection: TextDirection.ltr,
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountInfoRow extends StatelessWidget {
  const _AccountInfoRow({
    required this.label,
    required this.value,
    this.valueDirection,
  });

  final String label;
  final String value;
  final TextDirection? valueDirection;

  @override
  Widget build(BuildContext context) {
    final text = AppColors.semantic.text;

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.tokenM),
      decoration: BoxDecoration(
        color: AppColors.primitives.neutral.shade200,
        borderRadius: BorderRadius.circular(AppRadius.tokenM),
      ),
      child: Row(
        children: <Widget>[
          AppText(
            label,
            variant: AppTextVariant.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.bodySmall.toTextStyle(
              color: text.secondary,
            ),
          ),
          const Spacer(),
          AppText(
            value,
            variant: AppTextVariant.bodyMedium,
            textDirection: valueDirection,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
              color: text.primary,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
