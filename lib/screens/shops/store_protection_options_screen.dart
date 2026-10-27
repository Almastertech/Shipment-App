import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/shops_protection_widgets.dart';

class StoreProtectionOptionsScreen extends StatefulWidget {
  const StoreProtectionOptionsScreen({super.key});

  @override
  State<StoreProtectionOptionsScreen> createState() =>
      _StoreProtectionOptionsScreenState();
}

class _StoreProtectionOptionsScreenState
    extends State<StoreProtectionOptionsScreen> {
  bool _protectionSelected = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const colors = AppColors.primitives;

    return Directionality(
      textDirection: WidgetsLocalizations.of(context).textDirection,
      child: AppScaffold(
        padding: EdgeInsets.zero,
        safeArea: false,
        backgroundColor: AppColors.semantic.background.primary,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: StoreHero(
                storeName: l10n.shopsOptionsHeroTitle,
                category: l10n.shopsOptionsCategory,
                protectionLabel: l10n.shopsOptionsProtection,
                protectionValue: l10n.shopsOptionsAvailable,
                deliveryLabel: l10n.shopsOptionsDelivery,
                deliveryValue: l10n.shopsOptionsDeliveryValue,
                returnLabel: l10n.shopsOptionsReturn,
                returnValue: l10n.shopsOptionsReturnValue,
                onBack: () => context.pop(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.token2Xl,
                AppSpacing.tokenL,
                AppSpacing.token2Xl,
                AppSpacing.tokenXl,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    AppText(
                      l10n.shopsOptionsQuestion,
                      variant: AppTextVariant.titleLarge,
                      textAlign: TextAlign.start,
                      style: AppTypography.buyerMobile.h5.toTextStyle(
                        color: colors.neutral.shade900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.token2Xs),
                    AppText(
                      l10n.shopsOptionsSubtitle,
                      variant: AppTextVariant.bodyMedium,
                      textAlign: TextAlign.start,
                      style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
                        color: colors.neutral.shade600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenL),
                    ProtectionOptionCard(
                      selected: _protectionSelected,
                      title: l10n.shopsOptionsProtectedTitle,
                      description: l10n.shopsOptionsProtectedDescription,
                      icon: Icons.verified_user_outlined,
                      onTap: () => setState(() => _protectionSelected = true),
                    ),
                    const SizedBox(height: AppSpacing.tokenM),
                    ProtectionOptionCard(
                      selected: !_protectionSelected,
                      title: l10n.shopsOptionsUnprotectedTitle,
                      description: l10n.shopsOptionsUnprotectedDescription,
                      icon: Icons.close_rounded,
                      onTap: () => setState(() => _protectionSelected = false),
                    ),
                    const SizedBox(height: AppSpacing.tokenL),
                    ProtectionDisclaimer(
                      message: l10n.shopsOptionsDisclaimer,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.token2Xl,
              AppSpacing.tokenS,
              AppSpacing.token2Xl,
              AppSpacing.tokenL,
            ),
            child: PrimaryButton(
              label: l10n.shopsShopNow,
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary.shade500,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(60),
                shape: const StadiumBorder(),
                textStyle: AppTypography.buyerMobile.h6.toTextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
