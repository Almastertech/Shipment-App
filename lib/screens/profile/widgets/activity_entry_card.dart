import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

enum ActivityEntryKind {
  shipment,
  pendingClaim,
  compensation,
  submittedClaim,
}

class ActivityEntry {
  const ActivityEntry({
    required this.day,
    required this.time,
    required this.title,
    required this.description,
    required this.kind,
    required this.filter,
  });

  final int day;
  final String time;
  final String title;
  final String description;
  final ActivityEntryKind kind;
  final ActivityEntryFilter filter;
}

enum ActivityEntryFilter { shipment, claim }

class ActivityEntryCard extends StatelessWidget {
  const ActivityEntryCard({
    super.key,
    required this.entry,
  });

  final ActivityEntry entry;

  @override
  Widget build(BuildContext context) {
    final appearance = _ActivityIconAppearance.forKind(entry.kind);
    final radius = BorderRadius.circular(AppRadius.tokenXl);

    return Container(
      height: 84,
      decoration: BoxDecoration(
        color: AppColors.semantic.surface.primary,
        borderRadius: radius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primitives.neutral.shade900.withValues(alpha: .08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.tokenL,
          AppSpacing.tokenL,
          AppSpacing.tokenL,
          AppSpacing.token2Xl,
        ),
        child: Row(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 51,
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.token2Xs),
                child: AppText(
                  entry.time,
                  variant: AppTextVariant.labelSmall,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.labelSmall.toTextStyle(
                    color: AppColors.primitives.neutral.shade600,
                  ).copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.tokenM),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AppText(
                    entry.title,
                    variant: AppTextVariant.bodyMedium,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
                      color: AppColors.primitives.neutral.shade900,
                    ).copyWith(fontWeight: FontWeight.w700),
                  ),
                  AppText(
                    entry.description,
                    variant: AppTextVariant.bodySmall,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                      color: AppColors.primitives.neutral.shade700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.tokenM),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: appearance.background,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: _ActivityIcon(appearance: appearance),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityIconAppearance {
  const _ActivityIconAppearance({
    required this.background,
    required this.foreground,
    this.svgAsset,
    this.icon,
  });

  final Color background;
  final Color foreground;
  final String? svgAsset;
  final IconData? icon;

  static _ActivityIconAppearance forKind(ActivityEntryKind kind) {
    const colors = AppColors.primitives;
    return switch (kind) {
      ActivityEntryKind.shipment => _ActivityIconAppearance(
          background: colors.primary.shade100,
          foreground: colors.primary.shade500,
          svgAsset: AppImages.svg('container.svg'),
        ),
      ActivityEntryKind.pendingClaim => _ActivityIconAppearance(
          background: colors.warning.shade100,
          foreground: colors.warning.shade700,
          svgAsset: AppImages.svg('time.svg'),
        ),
      ActivityEntryKind.compensation => _ActivityIconAppearance(
          background: colors.success.shade100,
          foreground: colors.success.shade600,
          svgAsset: AppImages.svg('check.svg'),
        ),
      ActivityEntryKind.submittedClaim => _ActivityIconAppearance(
          background: colors.accent01.shade100,
          foreground: colors.warning.shade700,
          svgAsset: AppImages.receiptSolid,
        ),
    };
  }
}

class _ActivityIcon extends StatelessWidget {
  const _ActivityIcon({required this.appearance});

  final _ActivityIconAppearance appearance;

  @override
  Widget build(BuildContext context) {
    final svgAsset = appearance.svgAsset;
    if (svgAsset != null) {
      return SvgPicture.asset(
        svgAsset,
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(appearance.foreground, BlendMode.srcIn),
      );
    }
    return Icon(
      appearance.icon,
      size: 24,
      color: appearance.foreground,
    );
  }
}
