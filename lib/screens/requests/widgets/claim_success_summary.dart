import 'package:flutter/material.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_radius.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';

class ClaimSuccessSummary extends StatelessWidget {
  const ClaimSuccessSummary(
      {super.key,
      required this.title,
      required this.body,
      required this.compensationLabel,
      required this.compensation,
      required this.valueLabel,
      required this.value,
      required this.settlementLabel,
      required this.settlement});
  final String title,
      body,
      compensationLabel,
      compensation,
      valueLabel,
      value,
      settlementLabel,
      settlement;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary;
    final entries = <(String, String)>[
      (compensationLabel, compensation),
      (valueLabel, value),
      (settlementLabel, settlement)
    ];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.tokenL),
      decoration: BoxDecoration(
          color: primary.shade700,
          borderRadius: BorderRadius.circular(AppRadius.token2Xl),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withValues(alpha: .14),
                blurRadius: 18,
                offset: const Offset(0, 8))
          ]),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                      color: AppColors.primitives.accent01.shade300,
                      borderRadius: BorderRadius.circular(AppRadius.tokenL)),
                  child: Icon(Icons.verified_user_outlined,
                      color: primary.shade900)),
              const SizedBox(width: AppSpacing.tokenS),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                    AppText(title,
                        variant: AppTextVariant.titleMedium,
                        textAlign: TextAlign.start,
                        style: AppTypography.buyerMobile.h6
                            .toTextStyle(color: Colors.white)),
                    const SizedBox(height: AppSpacing.token2Xs),
                    AppText(body,
                        variant: AppTextVariant.bodySmall,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.caption.toTextStyle(
                            color: Colors.white.withValues(alpha: .75))),
                  ])),
            ],
          ),
          const SizedBox(height: AppSpacing.tokenL),
          Row(
              children: entries
                  .map((entry) => Expanded(
                          child: Container(
                        margin: const EdgeInsetsDirectional.only(
                            end: AppSpacing.tokenXs),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.tokenS,
                            vertical: AppSpacing.tokenS),
                        decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .13),
                            borderRadius:
                                BorderRadius.circular(AppRadius.tokenL)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              AppText(entry.$1,
                                  variant: AppTextVariant.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.buyerMobile.caption
                                      .toTextStyle(
                                          color: Colors.white
                                              .withValues(alpha: .75))),
                              AppText(entry.$2,
                                  variant: AppTextVariant.titleSmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.buyerMobile.label
                                      .toTextStyle(color: Colors.white)),
                            ]),
                      )))
                  .toList()),
        ],
      ),
    );
  }
}
