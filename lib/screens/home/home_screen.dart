import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shipments/screens/home/widgets/custom_home_info_card.dart';
import 'package:shipments/screens/home/widgets/home_header_widget.dart';
import 'package:shipments/screens/home/widgets/see_all_shipments_link.dart';

import '../../components/app_scaffold.dart';
import '../../components/custom_secondary_banner.dart';
import '../../components/layout/custom_bottom_nav_bar.dart';
import '../../components/secondary_request_custom_card.dart';
import '../../components/section_title.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../core/session/session_manager.dart';
import '../../injection.dart';
import '../../l10n/app_localizations.dart';
import '../profile/profile_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.isLoading = false});

  /// Skeletonizes the complete home flow while its content is loading.
  ///
  /// The home screen currently uses localized sample content, so the caller
  /// owns this state until home data is connected to a view model.
  final bool isLoading;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavigationIndex = 0;
  ProfileViewModel? _profile;

  @override
  void initState() {
    super.initState();
    if (getIt.isRegistered<SessionManager>() &&
        getIt.isRegistered<ProfileViewModel>() &&
        getIt<SessionManager>().isAuthenticated) {
      _profile = getIt<ProfileViewModel>()..addListener(_onAccountChanged);
      _profile!.load();
    }
  }

  void _onAccountChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _profile
      ?..removeListener(_onAccountChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.semantic;

    return IgnorePointer(
      key: const Key('home-screen-loading-interaction-blocker'),
      ignoring: widget.isLoading,
      child: AppScaffold(
        isLoading: widget.isLoading,
        padding: EdgeInsets.zero,
        safeArea: false,
        safeAreaBottom: false,
        backgroundColor: colors.background.primary,
        extendBody: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              HomeHeaderWidget(
                customerName: _profile?.account?.fullName ?? l10n.homeUserName,
                avatarUrl: _profile?.account?.avatarUrl,
              ),
              const SizedBox(height: AppSpacing.token4Xl),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.tokenXl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SectionTitle(
                      title: l10n.homeMoreShipmentsTitle,
                      trailing: SeeAllShipmentsLink(
                        label: l10n.homeSeeAll,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenM),
                    CustomHomeInfoCard(
                      productTitle: l10n.homeCompactShipmentProduct,
                      storeName: l10n.homeCompactShipmentStore,
                      price: l10n.homeCompactShipmentPrice,
                      statusLabel: l10n.homeCompactShipmentStatus,
                      deliveryLabel: l10n.homeCompactShipmentDelivery,
                      trackingLabel: l10n.homeCompactShipmentTrackingLabel,
                      trackingNumber: l10n.homeCompactShipmentTrackingNumber,
                      onTap: () {},
                    ),
                    const SizedBox(height: AppSpacing.tokenS),
                    CustomHomeInfoCard(
                      productTitle: l10n.homeCompactShipment2Product,
                      storeName: l10n.homeCompactShipment2Store,
                      price: l10n.homeCompactShipment2Price,
                      statusLabel: l10n.homeCompactShipment2Status,
                      deliveryLabel: l10n.homeCompactShipment2Delivery,
                      trackingLabel: l10n.homeCompactShipmentTrackingLabel,
                      trackingNumber: l10n.homeCompactShipment2TrackingNumber,
                      onTap: () {},
                    ),
                    const SizedBox(height: AppSpacing.tokenL),
                    SectionTitle(
                      title: l10n.homeActiveClaims,
                      trailing: SeeAllShipmentsLink(
                        label: l10n.homeSeeAll,
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenM),
                    SecondaryRequestCustomCard(
                      requestNumber: l10n.homeRequestNumber,
                      requestType: l10n.homeRequestType,
                      remainingTimeLabel: l10n.homeSecondaryRequestEta,
                      title: l10n.homeRequestTitle,
                      description: l10n.homeSecondaryRequestDescription,
                      progressSteps: <String>[
                        l10n.homeRequestStepReceived,
                        l10n.homeRequestStepReview,
                        l10n.homeRequestStepDecision,
                        l10n.homeRequestStepCompensation,
                      ],
                      activeStepIndex: 1,
                      amountLabel: l10n.homeSecondaryRequestAmountLabel,
                      amount: l10n.homeRequestAmount,
                      actionLabel: l10n.homeSecondaryRequestAction,
                      onTap: () {},
                    ),
                    const SizedBox(height: AppSpacing.tokenL),
                    CustomSecondaryBanner(
                      title: l10n.secondaryBannerTitle,
                      description: l10n.secondaryBannerDescription,
                      actionLabel: l10n.secondaryBannerAction,
                      onAction: () {},
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
                    if (index == 1) {
                      context.go(AppRoutes.shipments);
                      return;
                    }
                    if (index == 2) {
                      context.go(AppRoutes.requests);
                      return;
                    }
                    if (index == 3) {
                      context.go(AppRoutes.shops);
                      return;
                    }
                    if (index == 4) {
                      context.go(AppRoutes.profile);
                      return;
                    }
                    setState(() => _selectedNavigationIndex = index);
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
