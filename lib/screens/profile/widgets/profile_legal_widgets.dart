import 'package:flutter/material.dart';

import '../../../components/app_card.dart';
import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class ProfileSummaryItem {
  const ProfileSummaryItem({required this.label, required this.value});

  final String label;
  final String value;
}

class ProfileDocumentSummaryCard extends StatelessWidget {
  const ProfileDocumentSummaryCard({
    super.key,
    required this.items,
  });

  final List<ProfileSummaryItem> items;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Container(
      decoration: BoxDecoration(
        color: colors.primary.shade700,
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .16),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: <Widget>[
          PositionedDirectional(
            start: -34,
            top: -54,
            child: Container(
              width: 168,
              height: 168,
              decoration: BoxDecoration(
                color: colors.primary.shade500.withValues(alpha: .46),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.tokenM,
              vertical: AppSpacing.tokenL,
            ),
            child: Row(
              textDirection: Directionality.of(context),
              children: <Widget>[
                for (var index = 0; index < items.length; index++) ...<Widget>[
                  if (index > 0) const SizedBox(width: AppSpacing.tokenS),
                  Expanded(child: _SummaryValue(item: items[index])),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryValue extends StatelessWidget {
  const _SummaryValue({required this.item});

  final ProfileSummaryItem item;

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppText(
          item.label,
          variant: AppTextVariant.labelSmall,
          textDirection: textDirection,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.caption.toTextStyle(
            color: AppColors.primitives.neutral.shade100.withValues(alpha: .78),
          ),
        ),
        const SizedBox(height: AppSpacing.token2Xs),
        AppText(
          item.value,
          variant: AppTextVariant.labelMedium,
          textDirection: textDirection,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.label
              .toTextStyle(
                color: AppColors.primitives.neutral.shade100,
              )
              .copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class ProfileNumberedInfoCard extends StatelessWidget {
  const ProfileNumberedInfoCard({
    super.key,
    required this.number,
    required this.title,
    required this.description,
  });

  final int number;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.tokenL),
      color: AppColors.semantic.surface.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.accent01.shade100,
                  shape: BoxShape.circle,
                ),
                child: AppText(
                  '$number',
                  variant: AppTextVariant.labelMedium,
                  textAlign: TextAlign.center,
                  style: AppTypography.buyerMobile.label
                      .toTextStyle(
                        color: colors.warning.shade700,
                      )
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: AppSpacing.tokenM),
              Expanded(
                child: AppText(
                  title,
                  variant: AppTextVariant.titleSmall,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: AppTypography.buyerMobile.h6
                      .toTextStyle(
                        color: colors.neutral.shade900,
                      )
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.tokenS),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 44),
            child: AppText(
              description,
              variant: AppTextVariant.bodySmall,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                color: colors.neutral.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
