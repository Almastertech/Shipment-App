import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class LocationBenefitsSection extends StatelessWidget {
  const LocationBenefitsSection({
    super.key,
    required this.heading,
    required this.benefits,
  });

  final String heading;
  final List<String> benefits;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppText(
          heading,
          variant: AppTextVariant.titleLarge,
          textAlign: TextAlign.start,
          style: AppTypography.buyerMobile.h4.toTextStyle(
            color: colors.neutral.shade900,
          ),
        ),
        const SizedBox(height: AppSpacing.tokenS),
        for (final benefit in benefits)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.tokenXs,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: AppText(
                    benefit,
                    variant: AppTextVariant.bodyMedium,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.buyerMobile.bodyMedium
                        .toTextStyle(color: colors.neutral.shade900),
                  ),
                ),
                const SizedBox(width: AppSpacing.tokenS),
                Icon(
                  Icons.check_rounded,
                  size: 20,
                  color: colors.primary.shade500,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
