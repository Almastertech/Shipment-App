import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shipments/screens/shipments/widgets/shipments_hero.dart';

import '../../components/app_scaffold.dart';
import '../../components/custom_secondary_banner.dart';
import '../../components/feedback/status_banner.dart';
import '../../components/layout/custom_bottom_nav_bar.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_images.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/custom_product_card_shipments.dart';

class MyShipmentsScreen extends StatefulWidget {
  const MyShipmentsScreen({super.key});

  @override
  State<MyShipmentsScreen> createState() => _MyShipmentsScreenState();
}

class _MyShipmentsScreenState extends State<MyShipmentsScreen> {
  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final heroHeight = math.max(314.0, width * .75).toDouble();
    final isActive = _selectedFilter == 0;
    final firstProduct = CustomProductCardShipments(
      productTitle: isActive
          ? l10n.homeShipmentProduct
          : l10n.homeCompactShipment2Product,
      merchantName: isActive
          ? l10n.homeCompactShipmentMerchant
          : l10n.homeCompactShipment2Merchant,
      price: isActive
          ? l10n.homeCompactShipmentPrice
          : l10n.homeCompactShipment2Price,
      protectionLabel: l10n.homeShipmentProtection,
      statusLabel: isActive
          ? l10n.homeShipmentStepInTransit
          : l10n.shipmentDeliveredStatus,
      trackingLabel: l10n.homeShipmentTrackingLabel,
      trackingNumber: isActive
          ? l10n.homeShipmentTrackingNumber
          : l10n.homeCompactShipment2TrackingNumber,
      deliveryDateLabel: isActive
          ? l10n.homeShipmentExpectedDelivery
          : l10n.shipmentDeliveredAt,
      deliveryDate:
          isActive ? l10n.homeShipmentExpectedDate : l10n.shipmentDeliveredDate,
      actionLabel: l10n.homeShipmentDetails,
      isDelivered: !isActive,
      imageAlignment:
          isActive ? const Alignment(-.4, 0) : const Alignment(.8, 0),
      footer: isActive
          ? null
          : StatusBanner(
              message: l10n.shipmentDeliveredClaimHint,
              type: StatusBannerType.warning,
              leadingIcon: Icons.camera_alt_outlined,
              actionLabel: l10n.shipmentProtectionClaimAction,
              maxMessageLines: 2,
              onAction: () => context.go(AppRoutes.openDemands),
            ),
      onAction: () => context.go(AppRoutes.shipmentDetails),
      onTap: () => context.go(AppRoutes.shipmentDetails),
    );

    return AppScaffold(
      padding: EdgeInsets.zero,
      safeArea: false,
      safeAreaBottom: false,
      extendBody: true,
      backgroundColor: AppColors.semantic.background.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: AppSpacing.tokenL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: heroHeight + (isActive ? 172 : 261),
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  PositionedDirectional(
                    top: 0,
                    start: 0,
                    end: 0,
                    height: heroHeight,
                    child: ShipmentsHero(
                      title: l10n.shipmentsScreenTitle,
                      subtitle: isActive
                          ? l10n.shipmentsScreenSubtitle
                          : l10n.shipmentsDeliveredSubtitle,
                      activeLabel: l10n.myShipmentsActiveTab,
                      deliveredLabel: l10n.myShipmentsDeliveredTab,
                      selectedIndex: _selectedFilter,
                      onSelect: (index) =>
                          setState(() => _selectedFilter = index),
                    ),
                  ),
                  PositionedDirectional(
                    top: heroHeight - 16,
                    start: AppSpacing.tokenXl,
                    end: AppSpacing.tokenXl,
                    child: firstProduct,
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
                  if (isActive) ...<Widget>[
                    CustomProductCardShipments(
                      productTitle: l10n.homeCompactShipmentProduct,
                      merchantName: l10n.homeCompactShipmentMerchant,
                      price: l10n.homeCompactShipmentPrice,
                      protectionLabel: l10n.homeShipmentProtection,
                      statusLabel: l10n.homeCompactShipmentStatus,
                      trackingLabel: l10n.homeShipmentTrackingLabel,
                      trackingNumber: l10n.homeCompactShipmentTrackingNumber,
                      deliveryDateLabel: l10n.homeShipmentExpectedDelivery,
                      deliveryDate: l10n.homeCompactShipmentDelivery,
                      actionLabel: l10n.homeShipmentDetails,
                      productImage: AppImages.shipmentBackground,
                      imageAlignment: const Alignment(.8, 0),
                      onAction: () => context.go(AppRoutes.shipmentDetails),
                      onTap: () => context.go(AppRoutes.shipmentDetails),
                    ),
                    const SizedBox(height: AppSpacing.token3Xl),
                  ] else
                    const SizedBox(height: AppSpacing.token2Xl),
                  CustomSecondaryBanner(
                    title: l10n.secondaryBannerTitle,
                    description: l10n.secondaryBannerDescription,
                    actionLabel: l10n.secondaryBannerAction,
                    onAction: () {},
                  ),
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
                selectedIndex: 1,
                onDestinationSelected: (index) {
                  if (index == 0) context.go(AppRoutes.home);
                  if (index == 2) context.go(AppRoutes.requests);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
