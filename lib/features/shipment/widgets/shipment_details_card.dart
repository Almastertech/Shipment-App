import 'package:flutter/material.dart';

import '../../../components/app_card.dart';
import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class ShipmentDetailsCard extends StatelessWidget {
  const ShipmentDetailsCard({
    super.key,
    required this.title,
    required this.rows,
    this.showTitle = true,
  });

  final String title;
  final List<ShipmentDetailEntry> rows;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return AppCard(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.tokenL,
        AppSpacing.tokenS,
        AppSpacing.tokenL,
        AppSpacing.tokenS,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (showTitle) ...<Widget>[
            AppText(
              title,
              variant: AppTextVariant.titleLarge,
              style: AppTypography.buyerMobile.h4.toTextStyle(
                color: colors.primary.shade500,
              ),
            ),
            const SizedBox(height: AppSpacing.tokenS),
          ],
          ListView.builder(
            itemCount: rows.length,
            shrinkWrap: true,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final row = rows[index];
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.tokenS,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: AppText(
                            row.label,
                            variant: AppTextVariant.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                AppTypography.buyerMobile.bodySmall.toTextStyle(
                              color: colors.neutral.shade400,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.tokenM),
                        Flexible(
                          child: AppText(
                            row.value,
                            variant: AppTextVariant.bodyMedium,
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.buyerMobile.bodyMedium
                                .toTextStyle(
                              color: colors.neutral.shade500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (index < rows.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: colors.neutral.shade300.withValues(alpha: 0.28),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class ShipmentDetailEntry {
  const ShipmentDetailEntry({required this.label, required this.value});

  final String label;
  final String value;
}
