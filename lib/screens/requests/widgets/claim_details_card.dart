import 'package:flutter/material.dart';
import 'package:shipments/components/app_card.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/components/buttons/text_link_button.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';

class ClaimDetailRow {
  const ClaimDetailRow(this.label, this.value);
  final String label, value;
}

class ClaimDetailsCard extends StatelessWidget {
  const ClaimDetailsCard(
      {super.key,
      required this.rows,
      required this.expanded,
      required this.onToggle,
      required this.seeAll,
      required this.hide});
  final List<ClaimDetailRow> rows;
  final bool expanded;
  final VoidCallback onToggle;
  final String seeAll, hide;
  @override
  Widget build(BuildContext context) => AppCard(
        padding: const EdgeInsetsDirectional.fromSTEB(AppSpacing.tokenL,
            AppSpacing.tokenS, AppSpacing.tokenL, AppSpacing.tokenS),
        child: Column(children: <Widget>[
          ...rows.take(expanded ? rows.length : 4).map((row) => Container(
                constraints: const BoxConstraints(minHeight: 44),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: AppColors.primitives.neutral.shade200))),
                child: Row(children: <Widget>[
                  AppText(row.label,
                      variant: AppTextVariant.bodySmall,
                      textAlign: TextAlign.start,
                      style: AppTypography.buyerMobile.caption.toTextStyle(
                          color: AppColors.primitives.neutral.shade600)),
                  const SizedBox(width: AppSpacing.tokenS),
                  Expanded(
                      child: AppText(row.value,
                          variant: AppTextVariant.titleSmall,
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.buyerMobile.label.toTextStyle(
                              color: AppColors.primitives.neutral.shade900))),
                ]),
              )),
          TextLinkButton(
            label: expanded ? hide : seeAll,
            onPressed: onToggle,
            foregroundColor: AppColors.primitives.primary.shade500,
          ),
        ]),
      );
}
