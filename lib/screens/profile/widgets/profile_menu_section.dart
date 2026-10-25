import 'package:flutter/material.dart';

import '../../../components/app_divider.dart';
import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import 'profile_menu_tile.dart';

class ProfileMenuItem {
  const ProfileMenuItem({
    required this.label,
    required this.onTap,
    this.svgAsset,
    this.icon,
    this.destructive = false,
    this.filledLeading = false,
    this.trailing,
  });

  final String label;
  final VoidCallback onTap;
  final String? svgAsset;
  final IconData? icon;
  final bool destructive;
  final bool filledLeading;
  final Widget? trailing;
}

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<ProfileMenuItem> items;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.primitives;
    final text = AppColors.semantic.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: AppSpacing.tokenXs,
            end: AppSpacing.tokenXs,
            bottom: AppSpacing.tokenS,
          ),
          child: AppText(
            title,
            variant: AppTextVariant.titleSmall,
            textAlign: TextAlign.start,
            style: AppTypography.buyerMobile.h6
                .toTextStyle(
                  color: text.primary,
                )
                .copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.semantic.surface.primary,
            borderRadius: BorderRadius.circular(AppRadius.token2Xl),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: colors.neutral.shade900.withValues(alpha: .08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.token2Xl),
            child: Column(
              children: <Widget>[
                for (var index = 0; index < items.length; index++) ...<Widget>[
                  ProfileMenuTile(
                    label: items[index].label,
                    onTap: items[index].onTap,
                    svgAsset: items[index].svgAsset,
                    icon: items[index].icon,
                    destructive: items[index].destructive,
                    filledLeading: items[index].filledLeading,
                    trailing: items[index].trailing,
                  ),
                  if (index != items.length - 1)
                    AppDivider(
                      height: 1,
                      indent: AppSpacing.tokenXl,
                      endIndent: AppSpacing.tokenXl,
                      color: AppColors.semantic.border.secondary,
                    ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
