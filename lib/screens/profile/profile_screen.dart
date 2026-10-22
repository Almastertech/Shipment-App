import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shipments/screens/profile/widgets/profile_footer.dart';
import 'package:shipments/screens/profile/widgets/profile_hero.dart';
import 'package:shipments/screens/profile/widgets/profile_logout_bottom_sheet.dart';
import 'package:shipments/screens/profile/widgets/profile_menu_section.dart';
import 'package:shipments/screens/profile/widgets/profile_user_card.dart';

import '../../components/app_scaffold.dart';
import '../../components/layout/app_shell_bottom_bar.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_images.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../core/routing/bottom_nav_destinations.dart';
import '../../core/session/session_manager.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                    top: heroHeight - 80,
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
                      onEdit: () {},
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
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        label: l10n.profileNotifications,
                        svgAsset: AppImages.bell,
                        onTap: () {},
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
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        label: l10n.profileBlog,
                        svgAsset: AppImages.book,
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        label: l10n.profileFaq,
                        svgAsset: AppImages.interrogation,
                        onTap: () {},
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
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        label: l10n.profilePrivacy,
                        svgAsset: AppImages.lock,
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        label: l10n.profileProtectionTerms,
                        svgAsset: AppImages.shieldCheck,
                        onTap: () {},
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
                        onTap: () => _confirmLogout(context, l10n),
                      ),
                      ProfileMenuItem(
                        label: l10n.profileDeleteAccount,
                        svgAsset: AppImages.trash,
                        destructive: true,
                        onTap: () => context.push(AppRoutes.deleteAccount),
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
      bottomNavigationBar: const AppShellBottomBar(
        selectedIndex: BottomNavDestinations.profile,
      ),
    );
  }

  Future<void> _confirmLogout(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final confirmed = await ProfileLogoutBottomSheet.show(
      context,
      title: l10n.profileLogoutTitle,
      message: l10n.profileLogoutMessage,
      confirmLabel: l10n.profileLogoutConfirm,
      cancelLabel: l10n.profileLogoutCancel,
    );
    if (!confirmed || !context.mounted) return;

    await getIt<SessionManager>().clearTokens();
    if (!context.mounted) return;
    context.go(AppRoutes.login);
  }
}
