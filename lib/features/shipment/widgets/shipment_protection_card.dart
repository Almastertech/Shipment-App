import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/app_text.dart';
import '../../../components/buttons/text_link_button.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class ShipmentProtectionCard extends StatelessWidget {
  const ShipmentProtectionCard({
    super.key,
    required this.title,
    required this.protectedBy,
    required this.valueLabel,
    required this.value,
    required this.statusLabel,
    required this.status,
    required this.remainingLabel,
    required this.remaining,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String protectedBy;
  final String valueLabel;
  final String value;
  final String statusLabel;
  final String status;
  final String remainingLabel;
  final String remaining;
  final String actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.token2Xl),
      child: Stack(
        children: <Widget>[
          ColoredBox(
            color: colors.primary.shade600,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.tokenL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: colors.accent01.shade300,
                          borderRadius: BorderRadius.circular(AppRadius.tokenL),
                        ),
                        child: Icon(
                          Icons.verified_user_outlined,
                          color: colors.neutral.shade900,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.tokenS),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AppText(
                              title,
                              variant: AppTextVariant.titleLarge,
                              style: AppTypography.buyerMobile.h4.toTextStyle(
                                color: colors.neutral.shade100,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.tokenXs),
                            AppText(
                              protectedBy,
                              variant: AppTextVariant.bodySmall,
                              style: AppTypography.buyerMobile.bodySmall
                                  .toTextStyle(
                                color: colors.neutral.shade200,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.tokenL),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _ProtectionMetric(
                          label: valueLabel,
                          value: value,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.tokenXs),
                      Expanded(
                        child: _ProtectionMetric(
                          label: statusLabel,
                          value: status,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.tokenXs),
                      Expanded(
                        child: _ProtectionMetric(
                          label: remainingLabel,
                          value: remaining,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.tokenXs),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextLinkButton(
                      label: actionLabel,
                      onPressed: onAction,
                      iconOnTrailing: true,
                      icon: Icon(
                        Icons.help_outline_rounded,
                        size: 16,
                        color: colors.accent01.shade300,
                      ),
                      foregroundColor: colors.accent01.shade300,
                      semanticLabel: actionLabel,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: -12,
            top: -14,
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.08,
                child: SvgPicture.asset(
                  AppImages.logo,
                  width: 128,
                  height: 86,
                  colorFilter: ColorFilter.mode(
                    colors.primary.shade500,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProtectionMetric extends StatelessWidget {
  const _ProtectionMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return Container(
      constraints: const BoxConstraints(minHeight: 62),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.tokenS,
        vertical: AppSpacing.tokenXs,
      ),
      decoration: BoxDecoration(
        color: colors.primary.shade500.withValues(alpha: .62),
        borderRadius: BorderRadius.circular(AppRadius.tokenL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppText(
            label,
            variant: AppTextVariant.labelSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.caption.toTextStyle(
              color: colors.primary.shade100,
            ),
          ),
          AppText(
            value,
            variant: AppTextVariant.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
              color: colors.neutral.shade100,
            ),
          ),
        ],
      ),
    );
  }
}
