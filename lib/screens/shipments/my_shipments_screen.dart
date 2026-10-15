import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/custom_shipment_info_card.dart';
import '../../components/layout/custom_bottom_nav_bar.dart';
import '../../components/shipment_card_widget.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../features/notifications/presentation/notification_bell_button.dart';
import '../../l10n/app_localizations.dart';

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
    const colors = AppColors.primitives;
    final isActive = _selectedFilter == 0;

    return AppScaffold(
      padding: EdgeInsets.zero,
      safeAreaBottom: false,
      extendBody: true,
      backgroundColor: AppColors.semantic.background.primary,
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
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppText(
                        l10n.homeActiveShipments,
                        variant: AppTextVariant.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.h4.toTextStyle(
                          color: colors.primary.shade500,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.tokenXs),
                      AppText(
                        l10n.myShipmentsSubtitle,
                        variant: AppTextVariant.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                          color: colors.neutral.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.tokenM),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.neutral.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: IconTheme(
                      data: IconThemeData(
                        color: colors.primary.shade500,
                        size: 22,
                      ),
                      child: const NotificationBellButton(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.tokenL),
            Container(
              height: 52,
              padding: const EdgeInsets.all(AppSpacing.tokenXs),
              decoration: BoxDecoration(
                color: colors.neutral.shade200,
                borderRadius: BorderRadius.circular(AppRadius.tokenXl),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildFilterButton(
                    label: l10n.myShipmentsActiveTab,
                    index: 0,
                  ),
                  _buildFilterButton(
                    label: l10n.myShipmentsDeliveredTab,
                    index: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.tokenM),
            if (isActive) ...<Widget>[
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
                onAction: () => context.go(AppRoutes.shipmentDetails),
                detailsHero: true,
                trackingNumber: l10n.homeShipmentTrackingNumber,
              ),
            ],
            const SizedBox(height: AppSpacing.tokenS),
            ...List<Widget>.generate(isActive ? 2 : 1, (index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == (isActive ? 1 : 0) ? 0 : AppSpacing.tokenS,
                ),
                child: CustomShipmentInfoCard(
                  productTitle: l10n.homeShipmentProduct,
                  merchantName: l10n.homeShipmentMerchant,
                  price: l10n.homeShipmentPrice,
                  protectionLabel: l10n.homeShipmentProtection,
                  deliveryStatus: isActive
                      ? l10n.homeShipmentDeliveryStatus
                      : l10n.homeShipmentStepDelivered,
                  expectedDeliveryLabel: l10n.homeShipmentExpectedDelivery,
                  expectedDeliveryDate: l10n.homeShipmentExpectedDate,
                  trackingNumberLabel: l10n.homeShipmentTrackingLabel,
                  trackingNumber: l10n.homeShipmentTrackingNumber,
                  detailsActionLabel: l10n.homeShipmentDetails,
                  onDetails: () => context.go(AppRoutes.shipmentDetails),
                ),
              );
            }),
            const SizedBox(height: 88),
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
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton({required String label, required int index}) {
    final selected = _selectedFilter == index;
    const colors = AppColors.primitives;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _selectedFilter = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: selected ? colors.primary.shade500 : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.tokenL),
          ),
          alignment: Alignment.center,
          child: AppText(
            label,
            variant: AppTextVariant.titleSmall,
            textAlign: TextAlign.center,
            style: AppTypography.buyerMobile.h6.toTextStyle(
              color:
                  selected ? colors.neutral.shade100 : colors.neutral.shade400,
            ),
          ),
        ),
      ),
    );
  }
}
