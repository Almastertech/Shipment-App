import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_images.dart';
import 'package:shipments/core/resources/app_radius.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';
import 'package:shipments/l10n/app_localizations.dart';

class RequestDetailsHero extends StatelessWidget {
  const RequestDetailsHero({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
  });

  final String title;
  final String subtitle;
  final String status;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final l10n = AppLocalizations.of(context)!;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(AppRadius.token2Xl),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            AppImages.boxFocus,
            fit: BoxFit.cover,
            alignment: const Alignment(.25, -.3),
          ),
          ColoredBox(color: colors.primary.shade900.withValues(alpha: .42)),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  colors.primary.shade900.withValues(alpha: .14),
                  colors.primary.shade900.withValues(alpha: .88),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenXl,
              MediaQuery.paddingOf(context).top + AppSpacing.tokenS,
              AppSpacing.tokenXl,
              AppSpacing.token5Xl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _HeroAction(
                      icon: Icons.chevron_left_rounded,
                      label: l10n.navigationBack,
                      onTap: () => context.pop(),
                    ),
                    _HeroAction(
                      icon: Icons.ios_share_rounded,
                      label: l10n.navigationBack,
                      onTap: () {},
                    ),
                  ],
                ),
                const Spacer(),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.tokenS,
                      vertical: AppSpacing.token2Xs,
                    ),
                    decoration: BoxDecoration(
                      color: colors.success.shade100,
                      borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 16,
                          color: colors.success.shade700,
                        ),
                        const SizedBox(width: AppSpacing.token2Xs),
                        AppText(
                          status,
                          variant: AppTextVariant.labelSmall,
                          style: AppTypography.buyerMobile.caption
                              .toTextStyle(color: colors.success.shade700),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenS),
                AppText(
                  title,
                  variant: AppTextVariant.headlineMedium,
                  textAlign: TextAlign.start,
                  style: AppTypography.buyerMobile.h2
                      .toTextStyle(color: Colors.white),
                ),
                const SizedBox(height: AppSpacing.token2Xs),
                AppText(
                  subtitle,
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                    color: Colors.white.withValues(alpha: .82),
                  ),
                ),
                const SizedBox(height: AppSpacing.token2Xl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroAction extends StatelessWidget {
  const _HeroAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Tooltip(
        message: label,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: .16),
              border: Border.all(
                color: Colors.white.withValues(alpha: .45),
              ),
            ),
            child: Icon(icon, color: Colors.white, size: 21),
          ),
        ),
      );
}
