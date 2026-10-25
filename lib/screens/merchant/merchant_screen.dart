import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_text.dart';
import '../../components/layout/custom_bottom_nav_bar.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/merchant_hero_header.dart';
import 'widgets/merchant_store_widgets.dart';
import 'widgets/merchant_trust_card.dart';

class MerchantScreen extends StatelessWidget {
  const MerchantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final background = AppColors.primitives.neutral.shade100;
    const selectedNavigationIndex = 3;
    return Directionality(
      textDirection: WidgetsLocalizations.of(context).textDirection,
      child: Scaffold(
        extendBody: true,
        backgroundColor: background,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(
                height: 570,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    MerchantHeroHeader(
                      title: l10n.merchantHeroTitle,
                      subtitle: l10n.merchantHeroSubtitle,
                      searchHint: l10n.merchantSearchHint,
                    ),
                    PositionedDirectional(
                      top: 320,
                      start: 0,
                      end: 0,
                      child: MerchantTrustCard(
                        title: l10n.merchantTrustTitle,
                        description: l10n.merchantTrustDescription,
                        partnersLabel: l10n.merchantMetricPartners,
                        categoriesLabel: l10n.merchantMetricCategories,
                        daysLabel: l10n.merchantMetricDays,
                        daysValue: l10n.merchantDaysValue,
                        promise: l10n.merchantProtectionPromise,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.appPageMargin,
                AppSpacing.tokenL,
                AppSpacing.appPageMargin,
                0,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  _SectionHeading(
                    title: l10n.merchantFeaturedTitle,
                    action: l10n.merchantSeeAll,
                    onTap: () {},
                  ),
                  const SizedBox(height: AppSpacing.tokenM),
                  MerchantFeaturedCard(
                    protectionLabel: l10n.merchantProtectionAvailable,
                    storeName: l10n.merchantFeaturedStore,
                    category: l10n.merchantFeaturedCategory,
                    action: l10n.merchantShopNow,
                    onShopNow: () =>
                        context.push(AppRoutes.storeProtectionOptions),
                  ),
                  const SizedBox(height: AppSpacing.tokenXl),
                  _SectionHeading(
                    title: l10n.merchantAllStores,
                    action: l10n.merchantStoreCount,
                    onTap: () {},
                    actionIsBadge: true,
                  ),
                  const SizedBox(height: AppSpacing.tokenM),
                  MerchantStoreTile(
                    name: l10n.merchantFashionStore,
                    category: l10n.merchantFashionCategory,
                    rating: '4.7',
                    artwork: Icons.shopping_bag_outlined,
                    artworkColor: const Color(0xFFBBA38A),
                    protectionLabel: l10n.merchantProtectionAvailable,
                  ),
                  const SizedBox(height: AppSpacing.tokenM),
                  MerchantStoreTile(
                    name: l10n.merchantPerfumeStore,
                    category: l10n.merchantPerfumeCategory,
                    rating: '4.9',
                    artwork: Icons.spa_outlined,
                    artworkColor: const Color(0xFF77716D),
                    protectionLabel: l10n.merchantProtectionAvailable,
                  ),
                  const SizedBox(height: AppSpacing.tokenM),
                  MerchantStoreTile(
                    name: l10n.merchantCafeStore,
                    category: l10n.merchantCafeCategory,
                    rating: '4.8',
                    artwork: Icons.coffee_rounded,
                    artworkColor: const Color(0xFF8F756D),
                    protectionLabel: l10n.merchantProtectionAvailable,
                  ),
                  const SizedBox(height: AppSpacing.token3Xl),
                  MerchantJoinBanner(
                    title: l10n.merchantJoinTitle,
                    description: l10n.merchantJoinDescription,
                    action: l10n.merchantJoinAction,
                  ),
                  const SizedBox(height: AppSpacing.token9Xl),
                  const SizedBox(height: AppSpacing.token2Xl),
                ]),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: SizedBox(
            height: 84,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 380),
                child: CustomBottomNavBar(
                  selectedIndex: selectedNavigationIndex,
                  onDestinationSelected: (index) {
                    switch (index) {
                      case 0:
                        context.go(AppRoutes.home);
                        return;
                      case 1:
                        context.go(AppRoutes.shipments);
                        return;
                      case 2:
                        context.go(AppRoutes.requests);
                        return;
                      case 4:
                        context.go(AppRoutes.profile);
                        return;
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.title,
    required this.action,
    required this.onTap,
    this.actionIsBadge = false,
  });

  final String title;
  final String action;
  final VoidCallback onTap;
  final bool actionIsBadge;

  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          AppText(title, variant: AppTextVariant.titleMedium),
          const Spacer(),
          if (actionIsBadge)
            Container(
              padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color: AppColors.primitives.primary.shade100,
                borderRadius: BorderRadius.circular(AppRadius.tokenFull),
              ),
              child: AppText(
                action,
                variant: AppTextVariant.labelSmall,
                style: TextStyle(color: AppColors.primitives.primary.shade500),
              ),
            )
          else
            TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: AppText(
                action,
                variant: AppTextVariant.bodySmall,
                style: TextStyle(color: AppColors.primitives.primary.shade500),
              ),
            ),
        ],
      );
}
