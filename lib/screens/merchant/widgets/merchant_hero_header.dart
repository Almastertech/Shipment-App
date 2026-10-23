import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class MerchantHeroHeader extends StatelessWidget {
  const MerchantHeroHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.searchHint,
  });

  final String title;
  final String subtitle;
  final String searchHint;

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primitives.primary.shade700;
    return SizedBox(
      height: 482,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(AppImages.merchantHero, fit: BoxFit.cover),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  primary.withValues(alpha: .63),
                  primary.withValues(alpha: .75),
                  primary.withValues(alpha: .94),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppSpacing.appPageMargin,
              MediaQuery.paddingOf(context).top + AppSpacing.tokenL,
              AppSpacing.appPageMargin,
              AppSpacing.tokenXl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: _CircleAction(
                    icon: Icons.notifications_none_rounded,
                    onPressed: () {},
                  ),
                ),
                // Keep the hero copy above the overlapping trust card. A flex
                // spacer pushed it to the bottom of the header, where the card
                // covered the title and subtitle on phone-sized layouts.
                const SizedBox(height: AppSpacing.token8Xl),
                AppText(
                  title,
                  variant: AppTextVariant.headlineLarge,
                  textAlign: TextAlign.end,
                  style: AppTypography.buyerMobile.h1.toTextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                AppText(
                  subtitle,
                  variant: AppTextVariant.bodySmall,
                  textAlign: TextAlign.end,
                  style: const TextStyle(color: Color(0xFFEAE7FA)),
                  maxLines: 2,
                ),
                const SizedBox(height: AppSpacing.tokenS),
                Container(
                  height: 48,
                  padding: const EdgeInsetsDirectional.only(
                    start: AppSpacing.tokenL,
                    end: AppSpacing.tokenM,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .19),
                    borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 23,
                      ),
                      const SizedBox(width: AppSpacing.tokenS),
                      Expanded(
                        child: TextField(
                          textAlign: TextAlign.end,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: searchHint,
                            hintStyle: const TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  const _CircleAction({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white.withValues(alpha: .15),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: SizedBox(
            width: 42,
            height: 42,
            child: Icon(icon, color: Colors.white, size: 23),
          ),
        ),
      );
}
