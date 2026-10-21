import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shipments/components/app_scaffold.dart';
import 'package:shipments/components/layout/custom_bottom_nav_bar.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/routing/app_routes.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/requests/widgets/claim_details_card.dart';
import 'package:shipments/screens/requests/widgets/claim_evidence_strip.dart';
import 'package:shipments/screens/requests/widgets/claim_location_card.dart';
import 'package:shipments/screens/requests/widgets/claim_note_card.dart';
import 'package:shipments/screens/requests/widgets/claim_success_summary.dart';
import 'package:shipments/screens/requests/widgets/claim_timeline.dart';
import 'package:shipments/screens/requests/widgets/request_details_hero.dart';
import 'package:shipments/screens/requests/widgets/request_details_section_title.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({super.key});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  bool _showAllDetails = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppScaffold(
      padding: EdgeInsets.zero,
      safeArea: false,
      safeAreaBottom: false,
      extendBody: true,
      backgroundColor: AppColors.semantic.background.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: AppSpacing.token3Xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 400,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned.fill(
                    child: RequestDetailsHero(
                      title: l10n.claimDetailsTitle,
                      subtitle: l10n.claimDetailsProduct,
                      status: l10n.claimDetailsAccepted,
                    ),
                  ),
                  PositionedDirectional(
                    start: AppSpacing.tokenXl,
                    end: AppSpacing.tokenXl,
                    bottom: -108,
                    child: ClaimSuccessSummary(
                      title: l10n.claimDetailsSuccessTitle,
                      body: l10n.claimDetailsSuccessBody,
                      compensationLabel: l10n.requestsCompensationLabel,
                      compensation: l10n.requestsAcceptedCompensation,
                      valueLabel: l10n.requestsItemValueLabel,
                      value: l10n.requestsClosedItemValue,
                      settlementLabel: l10n.claimDetailsSettlement,
                      settlement: l10n.claimDetailsSep7,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 148),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.tokenXl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RequestDetailsSectionTitle(l10n.claimDetailsTimelineTitle),
                  const SizedBox(height: AppSpacing.tokenS),
                  ClaimTimeline(
                    entries: <ClaimTimelineEntry>[
                      ClaimTimelineEntry(
                          l10n.claimDetailsSubmitted, l10n.claimDetailsSep6),
                      ClaimTimelineEntry(
                          l10n.claimDetailsReviewed, l10n.claimDetailsSep7),
                      ClaimTimelineEntry(
                          l10n.claimDetailsDecision, l10n.claimDetailsSep7),
                      ClaimTimelineEntry(
                        l10n.claimDetailsCompensation,
                        '${l10n.claimDetailsSep7} · ${l10n.requestsAcceptedCompensation}',
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.tokenL),
                  RequestDetailsSectionTitle(l10n.claimDetailsEvidenceTitle),
                  const SizedBox(height: AppSpacing.tokenS),
                  ClaimEvidenceStrip(
                    labels: <String>[
                      l10n.claimDetailsLabel,
                      l10n.claimDetailsPackaging,
                      l10n.claimDetailsVideo,
                      l10n.claimDetailsAttachment,
                    ],
                  ),
                  const SizedBox(height: AppSpacing.token2Xl),
                  RequestDetailsSectionTitle(l10n.claimDetailsLocationTitle),
                  const SizedBox(height: AppSpacing.tokenS),
                  ClaimLocationCard(
                    caption: l10n.claimDetailsLocationCaption,
                    address: l10n.claimDetailsLocation,
                  ),
                  const SizedBox(height: AppSpacing.tokenS),
                  ClaimNoteCard(
                    title: l10n.claimDetailsNoteTitle,
                    note: l10n.claimDetailsNote,
                  ),
                  const SizedBox(height: AppSpacing.token2Xl),
                  RequestDetailsSectionTitle(l10n.claimDetailsDetailsTitle),
                  const SizedBox(height: AppSpacing.tokenS),
                  ClaimDetailsCard(
                    expanded: _showAllDetails,
                    onToggle: () =>
                        setState(() => _showAllDetails = !_showAllDetails),
                    seeAll: l10n.claimDetailsSeeAll,
                    hide: l10n.claimDetailsHide,
                    rows: <ClaimDetailRow>[
                      ClaimDetailRow(l10n.claimDetailsClaimNumber, 'HS-2048'),
                      ClaimDetailRow(l10n.claimDetailsProductLabel,
                          l10n.claimDetailsProductName),
                      ClaimDetailRow(l10n.claimDetailsItemPrice,
                          l10n.requestsClosedItemValue),
                      ClaimDetailRow(l10n.claimDetailsClaimValue,
                          l10n.requestsAcceptedCompensation),
                      ClaimDetailRow(l10n.claimDetailsShipment, 'HS-2048'),
                      ClaimDetailRow(
                          l10n.claimDetailsStore, l10n.claimDetailsStoreName),
                      ClaimDetailRow(l10n.claimDetailsSubmittedDate,
                          l10n.claimDetailsSubmittedDateValue),
                      ClaimDetailRow(l10n.claimDetailsDecisionDate,
                          l10n.claimDetailsDecisionDateValue),
                      ClaimDetailRow(l10n.claimDetailsTransferDate,
                          l10n.claimDetailsTransferDateValue),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.token9Xl),
                  const SizedBox(height: AppSpacing.tokenL),
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
                selectedIndex: 2,
                onDestinationSelected: (index) {
                  if (index == 0) context.go(AppRoutes.home);
                  if (index == 1) context.go(AppRoutes.shipments);
                  if (index == 2) context.go(AppRoutes.requests);
                  if (index == 3) context.go(AppRoutes.merchant);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
