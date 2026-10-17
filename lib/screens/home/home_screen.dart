import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shipments/screens/home/widgets/home_header.dart';
import 'package:shipments/screens/home/widgets/see_all_shipments_link.dart';

import '../../components/app_scaffold.dart';
import '../../components/custom_secondary_banner.dart';
import '../../components/custom_shipment_info_card.dart';
import '../../components/layout/custom_bottom_nav_bar.dart';
import '../../components/request_custom_card.dart';
import '../../components/section_title.dart';
import '../../components/shipment_card_widget.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.semantic;

    return AppScaffold(
      padding: EdgeInsets.zero,
      safeAreaBottom: false,
      backgroundColor: colors.background.primary,
      extendBody: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.tokenM,
          AppSpacing.tokenXl,
          AppSpacing.tokenM,
          AppSpacing.tokenM,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            HomeHeader(
              greeting: l10n.homeGreeting(
                l10n.localeName.startsWith('ar') ? 'عبدالله' : 'Abdullah',
              ),
              title: l10n.homeTitle,
            ),
            const SizedBox(height: AppSpacing.tokenL),
            ShipmentCardWidget(
              deliveryStatus: l10n.homeShipmentDeliveryStatus,
              protectionLabel: l10n.homeShipmentProtection,
              merchantAndItem:
                  '${l10n.homeShipmentMerchant} · ${l10n.homeShipmentProduct}',
              title: l10n.homeShipmentTitle,
              progressSteps: <String>[
                l10n.homeShipmentStepOrdered,
                l10n.homeShipmentStepInTransit,
                l10n.homeShipmentStepDelivered,
              ],
              activeStepIndex: 1,
              expectedDeliveryLabel: l10n.homeShipmentExpectedDelivery,
              expectedDeliveryDate: l10n.homeShipmentExpectedDate,
              actionLabel: l10n.homeShipmentView,
              onAction: () {},
            ),
            const SizedBox(height: AppSpacing.tokenL),
            SectionTitle(
              title: l10n.homeActiveShipments,
              trailing: SeeAllShipmentsLink(
                label: l10n.homeSeeAllShipments,
                onTap: () {},
              ),
            ),
            const SizedBox(height: AppSpacing.tokenM),
            CustomShipmentInfoCard(
              productTitle: l10n.homeShipmentProduct,
              merchantName: l10n.homeShipmentMerchant,
              price: l10n.homeShipmentPrice,
              protectionLabel: l10n.homeShipmentProtection,
              deliveryStatus: l10n.homeShipmentDeliveryStatus,
              expectedDeliveryLabel: l10n.homeShipmentExpectedDelivery,
              expectedDeliveryDate: l10n.homeShipmentExpectedDate,
              detailsActionLabel: l10n.homeShipmentDetails,
              onDetails: () {},
            ),
            const SizedBox(height: AppSpacing.tokenS),
            CustomShipmentInfoCard(
              productTitle: l10n.homeShipmentProduct,
              merchantName: l10n.homeShipmentMerchant,
              price: l10n.homeShipmentPrice,
              protectionLabel: l10n.homeShipmentProtection,
              deliveryStatus: l10n.homeShipmentDeliveryStatus,
              expectedDeliveryLabel: l10n.homeShipmentExpectedDelivery,
              expectedDeliveryDate: l10n.homeShipmentExpectedDate,
              detailsActionLabel: l10n.homeShipmentDetails,
              onDetails: () {},
            ),
            const SizedBox(height: AppSpacing.tokenL),
            SectionTitle(
              title: l10n.homeActiveClaims,
              trailing: SeeAllShipmentsLink(
                label: l10n.homeSeeAllShipments,
                onTap: () {},
              ),
            ),
            const SizedBox(height: AppSpacing.tokenM),
            RequestCustomCard(
              requestNumber: l10n.homeRequestNumber,
              requestType: l10n.homeRequestType,
              remainingTimeLabel: l10n.homeRequestRemainingTime,
              title: l10n.homeRequestTitle,
              description: l10n.homeRequestDescription,
              progressSteps: <String>[
                l10n.homeRequestStepReceived,
                l10n.homeRequestStepReview,
                l10n.homeRequestStepDecision,
                l10n.homeRequestStepCompensation,
              ],
              activeStepIndex: 1,
              amountLabel: l10n.homeRequestAmountLabel,
              amount: l10n.homeRequestAmount,
              actionLabel: l10n.homeRequestAction,
              onTap: () {},
            ),
            const SizedBox(height: AppSpacing.tokenL),
            CustomSecondaryBanner(
              eyebrow: l10n.secondaryBannerEyebrow,
              title: l10n.secondaryBannerTitle,
              description: l10n.secondaryBannerDescription,
              blogLabel: l10n.secondaryBannerAction,
              onBlogTap: () {},
            ),
            const SizedBox(height: 82),
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
                  setState(() => _selectedNavigationIndex = index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
