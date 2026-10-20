import 'package:flutter/material.dart';
import 'package:shipments/components/app_card.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';

class ClaimLocationCard extends StatelessWidget {
  const ClaimLocationCard({
    super.key,
    required this.caption,
    required this.address,
  });
  final String caption, address;
  @override
  Widget build(BuildContext context) => AppCard(
        padding: const EdgeInsets.all(AppSpacing.tokenL),
        child: Row(children: <Widget>[
          Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: AppColors.primitives.primary.shade100,
                  shape: BoxShape.circle),
              child: Icon(Icons.location_on_outlined,
                  color: AppColors.primitives.primary.shade500)),
          const SizedBox(width: AppSpacing.tokenS),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                AppText(caption,
                    variant: AppTextVariant.bodySmall,
                    textAlign: TextAlign.start,
                    style: AppTypography.buyerMobile.caption.toTextStyle(
                        color: AppColors.primitives.neutral.shade600)),
                AppText(address,
                    variant: AppTextVariant.titleSmall,
                    textAlign: TextAlign.start,
                    style: AppTypography.buyerMobile.label.toTextStyle(
                        color: AppColors.primitives.neutral.shade900)),
              ])),
        ]),
      );
}
