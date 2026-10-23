import 'package:flutter/material.dart';

import '../../../components/app_card.dart';
import '../../../components/app_text.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class MerchantFeaturedCard extends StatelessWidget {
  const MerchantFeaturedCard({
    super.key,
    required this.protectionLabel,
    required this.storeName,
    required this.category,
    required this.action,
    required this.onShopNow,
  });

  final String protectionLabel;
  final String storeName;
  final String category;
  final String action;
  final VoidCallback onShopNow;

  @override
  Widget build(BuildContext context) {
    final purple = AppColors.primitives.primary.shade500;
    final yellow = AppColors.primitives.accent01.shade300;
    return AppCard(
      padding: EdgeInsets.zero,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 176,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(AppImages.merchantHero, fit: BoxFit.cover),
                PositionedDirectional(
                  top: AppSpacing.tokenM,
                  end: AppSpacing.tokenM,
                  child: Container(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 6, 10, 6),
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(Icons.verified_user_outlined, size: 14),
                        const SizedBox(width: 4),
                        AppText(
                          protectionLabel,
                          variant: AppTextVariant.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenL,
              AppSpacing.tokenM,
              AppSpacing.tokenL,
              AppSpacing.tokenL,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: purple,
                        borderRadius: BorderRadius.circular(AppRadius.tokenL),
                      ),
                      child: const Center(
                        child: AppText(
                          'م',
                          variant: AppTextVariant.headlineSmall,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.tokenM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppText(
                            storeName,
                            variant: AppTextVariant.titleMedium,
                            style: AppTypography.buyerMobile.h6.toTextStyle(),
                          ),
                          AppText(
                            category,
                            variant: AppTextVariant.bodySmall,
                            style: TextStyle(
                              color: AppColors.primitives.neutral.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.tokenS),
                    _RatingBadge(),
                  ],
                ),
                const SizedBox(height: AppSpacing.tokenL),
                PrimaryButton(
                  label: action,
                  onPressed: onShopNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(46),
                    shape: const StadiumBorder(),
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

class MerchantStoreTile extends StatelessWidget {
  const MerchantStoreTile({
    super.key,
    required this.name,
    required this.category,
    required this.rating,
    required this.artwork,
    required this.artworkColor,
    required this.protectionLabel,
  });

  final String name;
  final String category;
  final String rating;
  final IconData artwork;
  final Color artworkColor;
  final String protectionLabel;

  @override
  Widget build(BuildContext context) {
    final purple = AppColors.primitives.primary.shade500;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.tokenM),
      color: Colors.white,
      onTap: () {},
      child: Row(
        children: <Widget>[
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: artworkColor,
              borderRadius: BorderRadius.circular(AppRadius.tokenXl),
            ),
            child: Icon(artwork, size: 34, color: Colors.white),
          ),
          const SizedBox(width: AppSpacing.tokenM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(
                  name,
                  variant: AppTextVariant.titleSmall,
                  style: AppTypography.buyerMobile.h6.toTextStyle(),
                ),
                AppText(
                  category,
                  variant: AppTextVariant.bodySmall,
                  style: TextStyle(
                    color: AppColors.primitives.neutral.shade600,
                  ),
                ),
                const SizedBox(height: AppSpacing.tokenXs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F8EF),
                        borderRadius:
                            BorderRadius.circular(AppRadius.tokenFull),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.verified_user_outlined,
                            size: 13,
                            color: AppColors.primitives.success.shade600,
                          ),
                          const SizedBox(width: 4),
                          AppText(
                            protectionLabel,
                            variant: AppTextVariant.labelSmall,
                            style: TextStyle(
                              color: AppColors.primitives.success.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.tokenM),
                    AppText(
                      rating,
                      variant: AppTextVariant.labelSmall,
                      style: TextStyle(
                        color: AppColors.primitives.neutral.shade700,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: AppColors.primitives.accent01.shade400,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.tokenM),
          Icon(
            Directionality.of(context) == TextDirection.rtl
                ? Icons.chevron_left_rounded
                : Icons.chevron_right_rounded,
            color: purple,
            size: 22,
          ),
        ],
      ),
    );
  }
}

class MerchantJoinBanner extends StatelessWidget {
  const MerchantJoinBanner({
    super.key,
    required this.title,
    required this.description,
    required this.action,
  });
  final String title;
  final String description;
  final String action;

  @override
  Widget build(BuildContext context) {
    final purple = AppColors.primitives.primary.shade700;
    final yellow = AppColors.primitives.accent01.shade300;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.token2Xl),
      decoration: BoxDecoration(
        color: purple,
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppText(
            title,
            variant: AppTextVariant.titleLarge,
            textAlign: TextAlign.start,
            style:
                AppTypography.buyerMobile.h5.toTextStyle(color: Colors.white),
          ),
          const SizedBox(height: AppSpacing.tokenS),
          AppText(
            description,
            variant: AppTextVariant.bodySmall,
            textAlign: TextAlign.start,
            style: const TextStyle(color: Color(0xFFD8D0FF)),
          ),
          const SizedBox(height: AppSpacing.tokenL),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: PrimaryButton(
              label: action,
              fullWidth: false,
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: yellow,
                foregroundColor: AppColors.primitives.neutral.shade900,
                minimumSize: const Size(150, 44),
                shape: const StadiumBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 5, 8, 5),
        decoration: BoxDecoration(
          color: AppColors.primitives.accent01.shade100,
          borderRadius: BorderRadius.circular(AppRadius.tokenFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AppText(
              '4.8',
              variant: AppTextVariant.labelSmall,
              style: TextStyle(color: AppColors.primitives.accent01.shade800),
            ),
            Icon(
              Icons.star_rounded,
              size: 14,
              color: AppColors.primitives.accent01.shade500,
            ),
          ],
        ),
      );
}
