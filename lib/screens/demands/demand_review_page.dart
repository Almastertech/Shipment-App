import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/custom_claim_shipment_card.dart';
import '../../core/location/location_coordinates.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_images.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/demand_evidence_header.dart';
import 'widgets/demand_loading_state.dart';
import 'widgets/demand_review_description_input.dart';
import 'widgets/demand_review_evidence_grid.dart';
import 'widgets/demand_review_location_card.dart';

class DemandReviewPage extends StatefulWidget {
  const DemandReviewPage({
    super.key,
    required this.locationUnavailable,
    required this.location,
    required this.evidence,
    required this.optionalPhotos,
    required this.onBack,
    required this.onRetakeEvidence,
    required this.onAddOptionalPhoto,
    required this.onSubmit,
    this.isLoading = false,
  });

  final bool locationUnavailable;
  final LocationCoordinates? location;
  final List<XFile?> evidence;
  final List<XFile?> optionalPhotos;
  final VoidCallback onBack;
  final ValueChanged<int> onRetakeEvidence;
  final ValueChanged<int> onAddOptionalPhoto;
  final VoidCallback onSubmit;
  final bool isLoading;

  @override
  State<DemandReviewPage> createState() => _DemandReviewPageState();
}

class _DemandReviewPageState extends State<DemandReviewPage> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  String _formatLocation(LocationCoordinates? location) {
    if (location == null) return '';
    return '${location.latitude.toStringAsFixed(4)}, '
        '${location.longitude.toStringAsFixed(4)}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const colors = AppColors.primitives;
    final width = MediaQuery.sizeOf(context).width;
    final headerHeight = (width * .8).clamp(310.0, 360.0);
    const summaryCardHeight = 96.0;
    const summaryCardOverlap = 20.0;
    final headerStageHeight =
        headerHeight + summaryCardHeight - summaryCardOverlap;
    final fileCount = widget.evidence.whereType<XFile>().length +
        widget.optionalPhotos.whereType<XFile>().length;

    final content = AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.semantic.background.primary,
      safeArea: false,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: headerStageHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                PositionedDirectional(
                  top: 0,
                  start: 0,
                  end: 0,
                  height: headerHeight,
                  child: DemandEvidenceHeader(
                    title: l10n.openDemandsTitle,
                    steps: <String>[
                      l10n.openDemandsStepLocation,
                      l10n.openDemandsStepEvidence,
                      l10n.openDemandsStepReview,
                    ],
                    heading: l10n.demandReviewHeading,
                    description: l10n.demandReviewDescription,
                    locationMessage: widget.locationUnavailable
                        ? l10n.demandDetailsLocationUnavailable
                        : l10n.demandDetailsLocationAvailable,
                    locationUnavailable: widget.locationUnavailable,
                    activeStepIndex: 2,
                    showLocationStatus: false,
                    onBack: widget.onBack,
                    backTooltip: l10n.navigationBack,
                  ),
                ),
                PositionedDirectional(
                  top: headerHeight - summaryCardOverlap,
                  start: AppSpacing.tokenXl,
                  end: AppSpacing.tokenXl,
                  height: summaryCardHeight,
                  child: CustomClaimShipmentCard(
                    productTitle: l10n.homeShipmentProduct,
                    deliveryDate: l10n.homeShipmentExpectedDate,
                    trackingNumber: l10n.homeShipmentTrackingNumber,
                    protectionLabel: l10n.homeShipmentProtection,
                    productImage: AppImages.shipmentBackground,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.tokenM,
                AppSpacing.tokenL,
                AppSpacing.tokenM,
                AppSpacing.tokenM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _SectionHeading(l10n.demandReviewLocationTitle),
                  const SizedBox(height: AppSpacing.tokenS),
                  DemandReviewLocationCard(
                    unavailable: widget.locationUnavailable,
                    title: widget.locationUnavailable
                        ? l10n.demandReviewLocationMissing
                        : l10n.demandReviewLocationCurrent,
                    description: widget.locationUnavailable
                        ? l10n.demandReviewLocationMissingDescription
                        : _formatLocation(widget.location),
                    actionLabel: widget.locationUnavailable
                        ? l10n.demandReviewLocationEnable
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.tokenL),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _SectionHeading(l10n.demandReviewEvidenceTitle),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.success.shade100,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            AppSpacing.tokenS,
                            AppSpacing.token2Xs,
                            AppSpacing.tokenS,
                            AppSpacing.token2Xs,
                          ),
                          child: AppText(
                            l10n.demandReviewFileCount(fileCount),
                            variant: AppTextVariant.labelSmall,
                            style:
                                AppTypography.buyerMobile.caption.toTextStyle(
                              color: colors.success.shade700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.tokenS),
                  DemandReviewEvidenceGrid(
                    evidence: widget.evidence,
                    optionalPhotos: widget.optionalPhotos,
                    onRetakeEvidence: widget.onRetakeEvidence,
                    onAddOptionalPhoto: widget.onAddOptionalPhoto,
                  ),
                  const SizedBox(height: AppSpacing.tokenL),
                  _SectionHeading(l10n.demandReviewDescriptionTitle),
                  const SizedBox(height: AppSpacing.tokenS),
                  DemandReviewDescriptionInput(
                    controller: _descriptionController,
                    onChanged: (_) => setState(() {}),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenM,
              AppSpacing.tokenXs,
              AppSpacing.tokenM,
              AppSpacing.tokenXs,
            ),
            child: PrimaryButton(
              label: l10n.demandReviewSubmit,
              onPressed: widget.onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary.shade500,
                foregroundColor: colors.neutral.shade100,
                elevation: 0,
                minimumSize: const Size.fromHeight(56),
                shape: const StadiumBorder(),
                textStyle: AppTypography.buyerMobile.button.toTextStyle(),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );

    return DemandLoadingState(
      isLoading: widget.isLoading,
      loadingLabel: l10n.loading,
      child: content,
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return AppText(
      text,
      variant: AppTextVariant.titleLarge,
      textAlign: TextAlign.start,
      style: AppTypography.buyerMobile.h4.toTextStyle(
        color: colors.neutral.shade900,
      ),
    );
  }
}
