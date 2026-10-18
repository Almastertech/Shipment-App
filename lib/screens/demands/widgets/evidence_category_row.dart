import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipments/components/app_card.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/demands/widgets/evidence_thumbnail.dart';

class EvidenceCategoryRow extends StatelessWidget {
  const EvidenceCategoryRow({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.completed,
    required this.evidence,
    required this.selected,
    required this.enabled,
    required this.onTap,
    required this.onRetake,
  });

  final String number;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool completed;
  final XFile? evidence;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;
  final VoidCallback onRetake;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    final localizations = AppLocalizations.of(context)!;

    return AppCard(
      color: selected ? colors.primary.shade900 : Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.tokenM,
        vertical: AppSpacing.tokenS,
      ),
      onTap: enabled ? onTap : null,
      child: Row(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: completed
                  ? colors.success.shade100
                  : selected
                      ? colors.accent01.shade300
                      : colors.neutral.shade200,
              shape: BoxShape.circle,
            ),
            child: completed
                ? Icon(
                    Icons.check_rounded,
                    size: 24,
                    color: colors.success.shade700,
                  )
                : AppText(
                    number,
                    variant: AppTextVariant.titleLarge,
                    style: AppTypography.buyerMobile.h4.toTextStyle(
                      color: selected
                          ? colors.neutral.shade900
                          : colors.neutral.shade700,
                    ),
                  ),
          ),
          const SizedBox(width: AppSpacing.tokenM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AppText(
                  title,
                  variant: AppTextVariant.titleSmall,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.h6.toTextStyle(
                    color: selected
                        ? colors.neutral.shade100
                        : enabled
                            ? colors.neutral.shade900
                            : colors.neutral.shade500,
                  ),
                ),
                const SizedBox(height: AppSpacing.token2Xs),
                AppText(
                  subtitle,
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: selected
                        ? colors.neutral.shade300
                        : completed
                            ? colors.success.shade700
                            : enabled
                                ? colors.neutral.shade600
                                : colors.neutral.shade500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.tokenM),
          if (completed && evidence != null)
            EvidenceThumbnail(
              evidence: evidence!,
              onTap: onRetake,
              semanticLabel: localizations.demandDetailsRetake,
            )
          else
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? colors.primary.shade700
                    : colors.neutral.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 24,
                color: selected
                    ? colors.neutral.shade100
                    : colors.neutral.shade700,
              ),
            ),
        ],
      ),
    );
  }
}
