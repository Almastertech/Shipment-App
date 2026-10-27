import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class DemandReviewLocationCard extends StatelessWidget {
  const DemandReviewLocationCard({
    super.key,
    required this.unavailable,
    required this.title,
    required this.description,
    this.actionLabel,
  });

  final bool unavailable;
  final String title;
  final String description;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Container(
      constraints: const BoxConstraints(minHeight: 84),
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
      decoration: BoxDecoration(
        color: unavailable ? colors.warning.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: unavailable
            ? null
            : const <BoxShadow>[
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              unavailable ? Icons.warning_amber_rounded : Icons.place_outlined,
              color: unavailable
                  ? colors.warning.shade700
                  : colors.primary.shade500,
              size: 23,
            ),
          ),
          const SizedBox(width: AppSpacing.tokenS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AppText(
                  title,
                  variant: AppTextVariant.labelLarge,
                  style: AppTypography.buyerMobile.label.toTextStyle(
                    color: colors.neutral.shade900,
                  ),
                ),
                const SizedBox(height: AppSpacing.token2Xs),
                AppText(
                  description,
                  variant: AppTextVariant.bodySmall,
                  style: AppTypography.buyerMobile.caption.toTextStyle(
                    color: colors.neutral.shade600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (actionLabel != null) ...<Widget>[
            const SizedBox(width: AppSpacing.tokenS),
            AppText(
              actionLabel!,
              variant: AppTextVariant.labelMedium,
              style: AppTypography.buyerMobile.labelSmall.toTextStyle(
                color: colors.primary.shade500,
              ),
            ),
          ] else ...<Widget>[
            const SizedBox(width: AppSpacing.tokenS),
            Icon(
              Icons.edit_outlined,
              color: colors.primary.shade500,
              size: 21,
            ),
          ],
        ],
      ),
    );
  }
}
