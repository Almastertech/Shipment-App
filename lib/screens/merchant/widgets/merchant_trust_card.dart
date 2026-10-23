import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class MerchantTrustCard extends StatelessWidget {
  const MerchantTrustCard({
    super.key,
    required this.title,
    required this.description,
    required this.partnersLabel,
    required this.categoriesLabel,
    required this.daysLabel,
    required this.daysValue,
    required this.promise,
  });

  final String title;
  final String description;
  final String partnersLabel;
  final String categoriesLabel;
  final String daysLabel;
  final String daysValue;
  final String promise;

  @override
  Widget build(BuildContext context) {
    final purple = AppColors.primitives.primary.shade700;
    final yellow = AppColors.primitives.accent01.shade300;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.appPageMargin),
      padding: const EdgeInsets.all(AppSpacing.tokenL),
      decoration: BoxDecoration(
        color: purple,
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: purple.withValues(alpha: .2),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: yellow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.verified_user_outlined,
                  color: Colors.black87,
                  size: 26,
                ),
              ),
              const SizedBox(width: AppSpacing.tokenM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppText(
                      title,
                      variant: AppTextVariant.titleMedium,
                      textAlign: TextAlign.start,
                      style: AppTypography.buyerMobile.h6
                          .toTextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: AppSpacing.token2Xs),
                    AppText(
                      description,
                      variant: AppTextVariant.bodySmall,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: const TextStyle(color: Color(0xFFD8D0FF)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.tokenL),
          Row(
            children: <Widget>[
              Expanded(child: _Metric(value: '+40', label: partnersLabel)),
              const SizedBox(width: AppSpacing.tokenS),
              Expanded(child: _Metric(value: '6', label: categoriesLabel)),
              const SizedBox(width: AppSpacing.tokenS),
              Expanded(child: _Metric(value: daysValue, label: daysLabel)),
            ],
          ),
          const SizedBox(height: AppSpacing.tokenM),
          Row(
            children: <Widget>[
              Icon(Icons.check_rounded, color: yellow, size: 18),
              const SizedBox(width: AppSpacing.tokenXs),
              Expanded(
                child: AppText(
                  promise,
                  variant: AppTextVariant.labelSmall,
                  style: TextStyle(color: yellow),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
        height: 62,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .12),
          borderRadius: BorderRadius.circular(AppRadius.tokenXl),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppText(
              value,
              variant: AppTextVariant.titleMedium,
              style:
                  AppTypography.buyerMobile.h6.toTextStyle(color: Colors.white),
            ),
            AppText(
              label,
              variant: AppTextVariant.labelSmall,
              style: const TextStyle(color: Color(0xFFD8D0FF)),
              maxLines: 1,
            ),
          ],
        ),
      );
}
