import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/layout/custom_bottom_nav_bar.dart';
import '../../components/section_title.dart';
import '../../components/shipment_card_widget.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/routing/app_routes.dart';
import '../../features/shipment/widgets/shipment_details_card.dart';
import '../../features/shipment/widgets/shipment_loading_state.dart';
import '../../features/shipment/widgets/shipment_protection_card.dart';
import '../../features/shipment/widgets/shipment_timeline_card.dart';
import '../../l10n/app_localizations.dart';

class ShipmentDetailsScreen extends StatelessWidget {
  const ShipmentDetailsScreen({super.key, this.isLoading = false});

  /// Applies skeletons to the shipment details while it is loading.
  ///
  /// The current screen uses localized sample content, so the caller owns this
  /// state until shipment data is connected to a view model.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final heroHeight = MediaQuery.sizeOf(context).width * (368 / 404);

    final content = AppScaffold(
      padding: EdgeInsets.zero,
      safeArea: false,
      safeAreaBottom: false,
      extendBody: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: AppSpacing.tokenL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: heroHeight + 145,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  PositionedDirectional(
                    top: 0,
                    start: 0,
                    end: 0,
                    height: heroHeight,
                    child: ShipmentCardWidget(
                      deliveryStatus: l10n.shipmentDetailsInTransitLabel,
                      protectionLabel: l10n.homeShipmentProtection,
                      merchantAndItem: l10n.homeShipmentMerchant,
                      title: l10n.homeShipmentProduct,
                      progressSteps: <String>[
                        l10n.homeShipmentStepOrdered,
                        l10n.homeShipmentStepInTransit,
                        l10n.homeShipmentStepDelivered,
                      ],
                      activeStepIndex: 1,
                      expectedDeliveryLabel: l10n.homeShipmentExpectedDelivery,
                      expectedDeliveryDate: l10n.homeShipmentExpectedDate,
                      actionLabel: l10n.homeShipmentView,
                      onAction: null,
                      detailsHero: true,
                      trackingNumber: l10n.homeShipmentTrackingNumber,
                      onBack: () => context.go(AppRoutes.shipments),
                      onShare: () {},
                      backTooltip: l10n.shipmentDetailsBack,
                      shareTooltip: l10n.shipmentDetailsShare,
                    ),
                  ),
                  PositionedDirectional(
                    top: heroHeight - 62,
                    start: AppSpacing.tokenXl,
                    end: AppSpacing.tokenXl,
                    child: ShipmentProtectionCard(
                      title: l10n.shipmentProtectionTitle,
                      protectedBy: l10n.shipmentProtectionCoveredBy,
                      valueLabel: l10n.shipmentProtectionValueLabel,
                      value: l10n.shipmentProtectionValue,
                      statusLabel: l10n.shipmentProtectionStatusLabel,
                      status: l10n.shipmentProtectionStatus,
                      remainingLabel: l10n.shipmentProtectionRemainingLabel,
                      remaining: l10n.shipmentProtectionRemaining,
                      actionLabel: l10n.shipmentProtectionClaimAction,
                      onAction: () => context.push(AppRoutes.openDemands),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.tokenXl,
                AppSpacing.tokenL,
                AppSpacing.tokenXl,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ShipmentTimelineCard(
                    title: l10n.shipmentTimelineTitle,
                    steps: <String>[
                      l10n.shipmentTimelineOrdered,
                      l10n.shipmentTimelineShipped,
                      l10n.shipmentTimelineInTransit,
                      l10n.shipmentTimelineDelivered,
                    ],
                    dates: <String>[
                      l10n.shipmentTimelineOrderedDate,
                      l10n.shipmentTimelineShippedDate,
                      l10n.shipmentTimelineInTransitDate,
                      l10n.shipmentTimelineDeliveryDate,
                    ],
                    activeStepIndex: 2,
                  ),
                  const SizedBox(height: AppSpacing.token3Xl),
                  SectionTitle(title: l10n.shipmentDetailsSectionTitle),
                  const SizedBox(height: AppSpacing.tokenM),
                  ShipmentDetailsCard(
                    title: l10n.shipmentDetailsSectionTitle,
                    showTitle: false,
                    rows: <ShipmentDetailEntry>[
                      ShipmentDetailEntry(
                        label: l10n.homeShipmentTrackingLabel,
                        value: l10n.homeShipmentTrackingNumber,
                      ),
                      ShipmentDetailEntry(
                        label: l10n.shipmentDetailsMerchant,
                        value: l10n.homeShipmentMerchant,
                      ),
                      ShipmentDetailEntry(
                        label: l10n.shipmentDetailsProduct,
                        value: l10n.homeShipmentProduct,
                      ),
                      ShipmentDetailEntry(
                        label: l10n.shipmentDetailsQuantity,
                        value: l10n.shipmentDetailsQuantityValue,
                      ),
                      ShipmentDetailEntry(
                        label: l10n.shipmentDetailsOrderDate,
                        value: l10n.shipmentDetailsOrderDateValue,
                      ),
                      ShipmentDetailEntry(
                        label: l10n.shipmentDetailsExpectedDelivery,
                        value: l10n.shipmentDetailsExpectedDeliveryValue,
                      ),
                      ShipmentDetailEntry(
                        label: l10n.shipmentDetailsAddress,
                        value: l10n.shipmentDetailsAddressValue,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.tokenL),
                  PrimaryButton(
                    label: l10n.openDemandsTitle,
                    onPressed: () => context.push(AppRoutes.openDemands),
                  ),
                  const SizedBox(height: AppSpacing.token8Xl),
                  const SizedBox(height: AppSpacing.token4Xl),
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
                  if (index == 1) context.go(AppRoutes.shipments);
                  if (index == 2) context.go(AppRoutes.requests);
                },
              ),
            ),
          ),
        ),
      ),
    );

    return ShipmentLoadingState(
      isLoading: isLoading,
      loadingLabel: l10n.loading,
      child: content,
    );
  }
}
