import 'package:flutter/material.dart';

import '../../../components/app_divider.dart';
import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

enum SupportTicketStatus { inProgress, awaitingReply }

class SupportTicketCard extends StatelessWidget {
  const SupportTicketCard({
    super.key,
    required this.status,
    required this.statusLabel,
    required this.title,
    required this.subtitle,
    required this.lastUpdateLabel,
    required this.lastUpdate,
    required this.categoryLabel,
    required this.category,
    required this.actionLabel,
    required this.onAction,
  });

  final SupportTicketStatus status;
  final String statusLabel;
  final String title;
  final String subtitle;
  final String lastUpdateLabel;
  final String lastUpdate;
  final String categoryLabel;
  final String category;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;
    final isWaiting = status == SupportTicketStatus.awaitingReply;
    final badgeColor = isWaiting
        ? colors.warning.shade100
        : colors.primary.shade100;
    final badgeTextColor = isWaiting
        ? colors.warning.shade700
        : colors.primary.shade500;
    final radius = BorderRadius.circular(AppRadius.token2Xl);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.semantic.surface.primary,
        borderRadius: radius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.tokenXl,
          AppSpacing.tokenL,
          AppSpacing.tokenXl,
          AppSpacing.tokenL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.tokenS,
                    vertical: AppSpacing.token3Xs,
                  ),
                  child: AppText(
                    statusLabel,
                    variant: AppTextVariant.labelSmall,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    style: AppTypography.buyerMobile.labelSmall.toTextStyle(
                      color: badgeTextColor,
                    ).copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.tokenS),
            AppText(
              title,
              variant: AppTextVariant.bodyMedium,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
                color: colors.neutral.shade900,
              ).copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.token2Xs),
            AppText(
              subtitle,
              variant: AppTextVariant.bodySmall,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                color: colors.neutral.shade700,
              ),
            ),
            const SizedBox(height: AppSpacing.tokenS),
            const AppDivider(color: Color(0xFFEEEEF3)),
            const SizedBox(height: AppSpacing.tokenS),
            Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                _TicketAction(label: actionLabel, onTap: onAction),
                const SizedBox(width: AppSpacing.tokenM),
                Expanded(
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Expanded(
                        child: _TicketMetadata(
                          label: lastUpdateLabel,
                          value: lastUpdate,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.tokenM),
                      Expanded(
                        child: _TicketMetadata(
                          label: categoryLabel,
                          value: category,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketMetadata extends StatelessWidget {
  const _TicketMetadata({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppText(
          label,
          variant: AppTextVariant.labelSmall,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.caption.toTextStyle(
            color: colors.neutral.shade600,
          ),
        ),
        const SizedBox(height: AppSpacing.token3Xs),
        AppText(
          value,
          variant: AppTextVariant.labelSmall,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.buyerMobile.labelSmall.toTextStyle(
            color: colors.neutral.shade900,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _TicketAction extends StatelessWidget {
  const _TicketAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.primitives.primary.shade500;
    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.tokenS),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.tokenXs),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              AppText(
                label,
                variant: AppTextVariant.labelMedium,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                maxLines: 1,
                style: AppTypography.buyerMobile.label.toTextStyle(
                  color: color,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: AppSpacing.token2Xs),
              Icon(Icons.chevron_right_rounded, size: 16, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
