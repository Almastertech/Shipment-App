import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shipments/components/app_scaffold.dart';
import 'package:shipments/components/layout/custom_bottom_nav_bar.dart';
import 'package:shipments/components/secondary_request_custom_card.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_images.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/routing/app_routes.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/requests/widgets/closed_request_card.dart';
import 'package:shipments/screens/shipments/widgets/shipments_hero.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  int _selectedTab = 0;

  void _showDetailsUnavailable() {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.requestsDetailsComingSoon)));
  }

  void _openAcceptedClaimDetails() => context.push(AppRoutes.requestDetails);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final width = MediaQuery.sizeOf(context).width;
    final heroHeight = math.max(314.0, width * .75).toDouble();
    final isOpen = _selectedTab == 0;
    final progressSteps = <String>[
      l10n.homeRequestStepReceived,
      l10n.homeRequestStepReview,
      l10n.homeRequestStepDecision,
      l10n.homeRequestStepCompensation,
    ];

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
              height: heroHeight - AppSpacing.tokenL,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  PositionedDirectional(
                    top: 0,
                    start: 0,
                    end: 0,
                    height: heroHeight,
                    child: ShipmentsHero(
                      backgroundImage: AppImages.boxFocus,
                      flipTopActions: true,
                      title: l10n.requestsScreenTitle,
                      subtitle: isOpen
                          ? l10n.requestsOpenSubtitle
                          : l10n.requestsClosedSubtitle,
                      activeLabel: l10n.requestsOpenTab,
                      deliveredLabel: l10n.requestsClosedTab,
                      selectedIndex: _selectedTab,
                      onSelect: (index) => setState(() => _selectedTab = index),
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
                children: isOpen
                    ? <Widget>[
                        SecondaryRequestCustomCard(
                          requestNumber: l10n.homeRequestNumber,
                          requestType: l10n.homeRequestType,
                          remainingTimeLabel: l10n.homeRequestRemainingTime,
                          title: l10n.homeRequestTitle,
                          description: l10n.homeRequestDescription,
                          progressSteps: progressSteps,
                          activeStepIndex: 1,
                          amountLabel: l10n.requestsClaimAmountLabel,
                          amount: l10n.requestsOpenClaimAmount,
                          actionLabel: l10n.homeRequestAction,
                          onTap: () => context.go(
                            AppRoutes.demandDetails,
                            extra: true,
                          ),
                          productImage: AppImages.shipmentBackground,
                          needsAction: true,
                          filledAction: true,
                          cardHeight: 312,
                          cardPadding: const EdgeInsets.all(AppSpacing.tokenL),
                          imageSize: 64,
                        ),
                        const SizedBox(height: AppSpacing.tokenL),
                        SecondaryRequestCustomCard(
                          requestNumber: l10n.requestsSecondOpenNumber,
                          requestType: l10n.homeRequestType,
                          remainingTimeLabel: l10n.homeSecondaryRequestEta,
                          title: l10n.requestsSecondOpenTitle,
                          description: l10n.homeSecondaryRequestDescription,
                          progressSteps: progressSteps,
                          activeStepIndex: 1,
                          amountLabel: l10n.requestsClaimAmountLabel,
                          amount: l10n.requestsOpenClaimAmount,
                          actionLabel: l10n.homeSecondaryRequestAction,
                          onTap: _openAcceptedClaimDetails,
                          productImage: AppImages.boxFocus,
                          cardHeight: 312,
                          cardPadding: const EdgeInsets.all(AppSpacing.tokenL),
                          imageSize: 64,
                        ),
                      ]
                    : <Widget>[
                        ClosedRequestCard(
                          requestType: l10n.homeRequestType,
                          requestNumber: l10n.homeRequestNumber,
                          product: l10n.homeShipmentProduct,
                          productImage: AppImages.shipmentBackground,
                          status: l10n.requestsClosedAcceptedStatus,
                          compensationLabel: l10n.requestsCompensationLabel,
                          compensation: l10n.requestsAcceptedCompensation,
                          valueLabel: l10n.requestsItemValueLabel,
                          value: l10n.requestsClosedItemValue,
                          outcomeMessage: l10n.requestsAcceptedMessage,
                          detailsLabel: l10n.requestsDetailsAction,
                          accepted: true,
                          onDetails: _openAcceptedClaimDetails,
                        ),
                        const SizedBox(height: AppSpacing.tokenL),
                        ClosedRequestCard(
                          requestType: l10n.homeRequestType,
                          requestNumber: l10n.requestsClosedRejectedNumber,
                          product: l10n.requestsClosedRejectedTitle,
                          productImage: AppImages.boxFocus,
                          status: l10n.requestsClosedRejectedStatus,
                          compensationLabel: l10n.requestsCompensationLabel,
                          compensation: l10n.requestsRejectedCompensation,
                          valueLabel: l10n.requestsItemValueLabel,
                          value: l10n.requestsClosedItemValue,
                          outcomeMessage: l10n.requestsRejectedMessage,
                          detailsLabel: l10n.requestsDetailsAction,
                          accepted: false,
                          onDetails: _showDetailsUnavailable,
                        ),
                      ],
              ),
            ),
            const SizedBox(height: AppSpacing.token9Xl),
            const SizedBox(height: AppSpacing.tokenL),
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
                selectedIndex: 2,
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
