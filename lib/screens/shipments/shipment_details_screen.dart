import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/layout/custom_bottom_nav_bar.dart';
import '../../components/shipment_card_widget.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../features/shipment/widgets/shipment_details_card.dart';
import '../../features/shipment/widgets/shipment_protection_card.dart';
import '../../features/shipment/widgets/shipment_timeline_card.dart';
import '../../l10n/app_localizations.dart';

class ShipmentDetailsScreen extends StatelessWidget {
  const ShipmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const colors = AppColors.primitives;

    return AppScaffold(
      padding: EdgeInsets.zero,
      safeAreaBottom: false,
      extendBody: true,
      backgroundColor: AppColors.semantic.background.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.tokenM,
          AppSpacing.tokenM,
          AppSpacing.tokenM,
          AppSpacing.tokenM,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: AppText(
                    l10n.shipmentDetailsTitle,
                    variant: AppTextVariant.titleLarge,
                    textAlign: TextAlign.start,
                    style: AppTypography.buyerMobile.h4.toTextStyle(
                      color: colors.primary.shade500,
                    ),
                  ),
                ),
                Material(
                  color: colors.neutral.shade200,
                  shape: const CircleBorder(),
                  child: IconButton(
                    tooltip: l10n.shipmentDetailsTitle,
                    onPressed: () => context.go(AppRoutes.shipments),
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      color: colors.primary.shade500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.tokenM),
            ShipmentCardWidget(
              deliveryStatus: l10n.homeShipmentDeliveryStatus,
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
            ),
            const SizedBox(height: AppSpacing.tokenM),
            ShipmentProtectionCard(
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
            const SizedBox(height: AppSpacing.tokenM),
            ShipmentTimelineCard(
              title: l10n.shipmentTimelineTitle,
              steps: <String>[
                l10n.shipmentTimelineOrdered,
                l10n.shipmentTimelineShipped,
                l10n.shipmentTimelineInTransit,
                l10n.shipmentTimelineDelivered,
              ],
              dates: <String>[
                l10n.shipmentTimelineOrderDate,
                l10n.shipmentTimelineOrderDate,
                '',
                '',
              ],
              activeStepIndex: 2,
            ),
            const SizedBox(height: AppSpacing.tokenM),
            ShipmentDetailsCard(
              title: l10n.shipmentDetailsSectionTitle,
              rows: <ShipmentDetailEntry>[
                ShipmentDetailEntry(
                  label: l10n.homeShipmentTrackingLabel,
                  value: l10n.homeShipmentTrackingNumber,
                ),
                ShipmentDetailEntry(
                  label: l10n.shipmentDetailsExpectedDelivery,
                  value: l10n.shipmentDetailsExpectedDeliveryValue,
                ),
                ShipmentDetailEntry(
                  label: l10n.shipmentDetailsOrderDate,
                  value: l10n.shipmentDetailsOrderDateValue,
                ),
                ShipmentDetailEntry(
                  label: l10n.shipmentDetailsProduct,
                  value: l10n.shipmentDetailsProductValue,
                ),
                ShipmentDetailEntry(
                  label: l10n.shipmentDetailsAddress,
                  value: l10n.shipmentDetailsAddressValue,
                ),
                ShipmentDetailEntry(
                  label: l10n.shipmentDetailsQuantity,
                  value: l10n.shipmentDetailsQuantityValue,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.token8Xl),
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
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
