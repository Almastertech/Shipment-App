import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({
    super.key,
    required this.label,
    required this.onTap,
    this.svgAsset,
    this.icon,
    this.destructive = false,
    this.filledLeading = false,
  }) : assert(svgAsset != null || icon != null);

  final String label;
  final VoidCallback onTap;
  final String? svgAsset;
  final IconData? icon;
  final bool destructive;
  final bool filledLeading;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;
    final text = AppColors.semantic.text;
    final iconColor = filledLeading
        ? Colors.white
        : destructive
            ? colors.failure.shade600
            : colors.primary.shade500;
    final background = filledLeading
        ? colors.failure.shade500
        : destructive
            ? colors.failure.shade100
            : colors.primary.shade100;
    final labelColor =
        destructive || filledLeading ? colors.failure.shade600 : text.primary;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return InkWell(
      onTap: onTap,
      child: Semantics(
        button: true,
        label: label,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.tokenL,
            AppSpacing.tokenL,
            AppSpacing.tokenXl,
            AppSpacing.tokenL,
          ),
          child: Row(
            children: <Widget>[
              _LeadingIcon(
                svgAsset: svgAsset,
                icon: icon,
                background: background,
                iconColor: iconColor,
                filled: filledLeading,
                destructive: destructive,
              ),
              const SizedBox(width: AppSpacing.tokenM),
              Expanded(
                child: AppText(
                  label,
                  variant: AppTextVariant.bodyMedium,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodyMedium
                      .toTextStyle(color: labelColor)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Icon(
                isRtl
                    ? Icons.chevron_left_rounded
                    : Icons.chevron_right_rounded,
                color: colors.neutral.shade600,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon({
    required this.svgAsset,
    required this.icon,
    required this.background,
    required this.iconColor,
    required this.filled,
    required this.destructive,
  });

  final String? svgAsset;
  final IconData? icon;
  final Color background;
  final Color iconColor;
  final bool filled;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final asset = svgAsset;
    final radius = filled
        ? AppRadius.tokenFull
        : destructive
            ? AppRadius.tokenM
            : AppRadius.tokenS;

    return Container(
      width: 36,
      height: destructive ? 36 : 32,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: asset != null
          ? SvgPicture.asset(
              asset,
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            )
          : Icon(icon, size: 18, color: iconColor),
    );
  }
}
