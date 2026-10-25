import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shipments/components/layout/custom_bottom_nav_bar.dart';
import 'package:shipments/screens/profile/widgets/profile_footer.dart';
import 'package:shipments/screens/profile/widgets/profile_hero.dart';
import 'package:shipments/screens/profile/widgets/profile_language_switcher.dart';
import 'package:shipments/screens/profile/widgets/profile_logout_bottom_sheet.dart';
import 'package:shipments/screens/profile/widgets/profile_menu_section.dart';
import 'package:shipments/screens/profile/widgets/profile_user_card.dart';

import '../../components/app_scaffold.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_images.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../core/session/session_manager.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import '../../localization/controllers/localization_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isNavigating = false;
  int _selectedNavigationIndex = 4;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final heroHeight = ProfileHero.heightForWidth(width);

    return AppScaffold(
      padding: EdgeInsets.zero,
      safeArea: false,
      safeAreaBottom: false,
      extendBody: true,
      backgroundColor: AppColors.semantic.background.primary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: heroHeight + 134,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  PositionedDirectional(
                    top: 0,
                    start: 0,
                    end: 0,
                    height: heroHeight,
                    child: ProfileHero(
                      title: l10n.profileScreenTitle,
                      subtitle: l10n.profileScreenSubtitle,
                    ),
                  ),
                  PositionedDirectional(
                    top: heroHeight - 60,
                    start: AppSpacing.tokenXl,
                    end: AppSpacing.tokenXl,
                    child: ProfileUserCard(
                      name: l10n.homeUserName,
                      phone: l10n.profilePhone,
                      avatarAsset: AppImages.profileAvatar,
                      compensationsLabel: l10n.profileStatCompensations,
                      compensationsValue: l10n.profileStatCompensationsValue,
                      claimsLabel: l10n.profileStatClaims,
                      claimsValue: l10n.profileStatClaimsValue,
                      shipmentsLabel: l10n.profileStatShipments,
                      shipmentsValue: l10n.profileStatShipmentsValue,
                      onEdit: () => _openRoute(AppRoutes.editProfile),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.tokenXl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ProfileMenuSection(
                    title: l10n.profileSectionGeneral,
                    items: <ProfileMenuItem>[
                      ProfileMenuItem(
                        label: l10n.profileActivity,
                        svgAsset: AppImages.chartBars,
                        onTap: () => _openRoute(AppRoutes.activity),
                      ),
                      ProfileMenuItem(
                        label: l10n.profileNotifications,
                        svgAsset: AppImages.bell,
                        onTap: () => _openRoute(AppRoutes.notificationSettings),
                      ),
                      ProfileMenuItem(
                        label: l10n.profileLanguage,
                        icon: Icons.language_rounded,
                        trailing: const ProfileLanguageSwitcher(),
                        onTap: () => context
                            .read<LocalizationController>()
                            .toggleLanguage(),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.tokenL),
                  ProfileMenuSection(
                    title: l10n.profileSectionSupport,
                    items: <ProfileMenuItem>[
                      ProfileMenuItem(
                        label: l10n.profileSupportTickets,
                        svgAsset: AppImages.receipt,
                        onTap: () => _openRoute(AppRoutes.supportTickets),
                      ),
                      ProfileMenuItem(
                        label: l10n.profileBlog,
                        svgAsset: AppImages.book,
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        label: l10n.profileFaq,
                        svgAsset: AppImages.interrogation,
                        onTap: () => _openRoute(AppRoutes.profileFaq),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.tokenL),
                  ProfileMenuSection(
                    title: l10n.profileSectionLegal,
                    items: <ProfileMenuItem>[
                      ProfileMenuItem(
                        label: l10n.profileTerms,
                        svgAsset: AppImages.receiptSolid,
                        onTap: () => _openRoute(AppRoutes.profileTerms),
                      ),
                      ProfileMenuItem(
                        label: l10n.profilePrivacy,
                        svgAsset: AppImages.lock,
                        onTap: () => _openRoute(AppRoutes.profilePrivacy),
                      ),
                      ProfileMenuItem(
                        label: l10n.profileProtectionTerms,
                        svgAsset: AppImages.shieldCheck,
                        onTap: () =>
                            _openRoute(AppRoutes.profileProtectionTerms),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.tokenL),
                  ProfileMenuSection(
                    title: l10n.profileSectionAccount,
                    items: <ProfileMenuItem>[
                      ProfileMenuItem(
                        label: l10n.profileLogout,
                        svgAsset: AppImages.logout,
                        onTap: () => _confirmLogout(l10n),
                      ),
                      ProfileMenuItem(
                        label: l10n.profileDeleteAccount,
                        svgAsset: AppImages.trash,
                        destructive: true,
                        onTap: () => _openRoute(AppRoutes.deleteAccount),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.token2Xl),
                  ProfileFooter(
                    versionLabel: l10n.profileVersion('1.0.0'),
                    creditsLabel: l10n.profileCredits,
                  ),
                  const SizedBox(height: AppSpacing.token9Xl),
                  const SizedBox(height: AppSpacing.tokenXl),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: SizedBox(
          height: 84,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: CustomBottomNavBar(
                selectedIndex: _selectedNavigationIndex,
                onDestinationSelected: (index) {
                  if (index == 0) {
                    context.go(AppRoutes.home);
                    return;
                  }
                  if (index == 1) {
                    context.go(AppRoutes.shipments);
                    return;
                  }
                  if (index == 2) {
                    context.go(AppRoutes.requests);
                    return;
                  }
                  if (index == 3) {
                    context.go(AppRoutes.merchant);
                    return;
                  }
                  setState(() => _selectedNavigationIndex = index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openRoute(String route) async {
    if (!mounted || _isNavigating) return;
    _isNavigating = true;
    try {
      await context.push<void>(route);
    } finally {
      if (mounted) _isNavigating = false;
    }
  }

  Future<void> _confirmLogout(AppLocalizations l10n) async {
    if (!mounted || _isNavigating) return;
    _isNavigating = true;
    try {
      final confirmed = await ProfileLogoutBottomSheet.show(
        context,
        title: l10n.profileLogoutTitle,
        message: l10n.profileLogoutMessage,
        confirmLabel: l10n.profileLogoutConfirm,
        cancelLabel: l10n.profileLogoutCancel,
      );
      if (!confirmed || !mounted) return;

      await getIt<SessionManager>().clearTokens();
      if (!mounted) return;
      context.go(AppRoutes.login);
    } finally {
      if (mounted) _isNavigating = false;
    }
  }
}
