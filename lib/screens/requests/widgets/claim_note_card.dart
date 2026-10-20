import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_radius.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';

class ClaimNoteCard extends StatelessWidget {
  const ClaimNoteCard({super.key, required this.title, required this.note});
  final String title, note;
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.tokenL),
        decoration: BoxDecoration(
            color: AppColors.primitives.neutral.shade200,
            borderRadius: BorderRadius.circular(AppRadius.token2Xl)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AppText(title,
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.start,
                  style: AppTypography.buyerMobile.caption.toTextStyle(
                      color: AppColors.primitives.neutral.shade600)),
              const SizedBox(height: AppSpacing.tokenXs),
              AppText(note,
                  variant: AppTextVariant.bodyMedium,
                  textAlign: TextAlign.start,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                      color: AppColors.primitives.neutral.shade900)),
            ]),
      );
}
