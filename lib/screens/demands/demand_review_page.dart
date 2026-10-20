import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipments/components/app_scaffold.dart';
import 'package:shipments/components/app_text.dart';
import 'package:shipments/components/buttons/primary_button.dart';
import 'package:shipments/components/custom_claim_shipment_card.dart';
import 'package:shipments/core/location/location_coordinates.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_images.dart';
import 'package:shipments/core/resources/app_spacing.dart';
import 'package:shipments/core/resources/app_typography.dart';
import 'package:shipments/l10n/app_localizations.dart';
import 'package:shipments/screens/demands/widgets/demand_evidence_header.dart';

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
  });

  final bool locationUnavailable;
  final LocationCoordinates? location;
  final List<XFile?> evidence;
  final List<XFile?> optionalPhotos;
  final VoidCallback onBack;
  final ValueChanged<int> onRetakeEvidence;
  final ValueChanged<int> onAddOptionalPhoto;
  final VoidCallback onSubmit;

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

    return AppScaffold(
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
                  _LocationCard(
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
                  Row(
                    children: <Widget>[
                      for (var index = 0; index < 3; index++) ...<Widget>[
                        if (index > 0)
                          const SizedBox(width: AppSpacing.tokenXs),
                        Expanded(
                          child: _EvidenceTile(
                            evidence: widget.evidence[index],
                            video: index == 2,
                            label: switch (index) {
                              0 => l10n.demandReviewLabelPhoto,
                              1 => l10n.demandReviewPackagingPhoto,
                              _ => l10n.demandReviewVideo,
                            },
                            onTap: () => widget.onRetakeEvidence(index),
                          ),
                        ),
                      ],
                      const SizedBox(width: AppSpacing.tokenXs),
                      Expanded(
                        child: _EvidenceTile(
                          evidence: widget.optionalPhotos.isEmpty
                              ? null
                              : widget.optionalPhotos.first,
                          label: l10n.demandReviewAdditionalPhoto,
                          onTap: () => widget.onAddOptionalPhoto(
                            widget.optionalPhotos.indexWhere(
                                      (photo) => photo == null,
                                    ) ==
                                    -1
                                ? 0
                                : widget.optionalPhotos.indexWhere(
                                    (photo) => photo == null,
                                  ),
                          ),
                          isAddTile: widget.optionalPhotos.isEmpty ||
                              widget.optionalPhotos.first == null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.tokenL),
                  _SectionHeading(l10n.demandReviewDescriptionTitle),
                  const SizedBox(height: AppSpacing.tokenS),
                  Container(
                    height: 118,
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.tokenM,
                      AppSpacing.tokenS,
                      AppSpacing.tokenM,
                      AppSpacing.tokenXs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: _descriptionController.text.isEmpty
                            ? colors.neutral.shade300
                            : colors.primary.shade500,
                        width: _descriptionController.text.isEmpty ? 1 : 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _descriptionController,
                            maxLength: 300,
                            maxLines: null,
                            expands: true,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.top,
                            style: AppTypography.buyerMobile.bodySmall
                                .toTextStyle(color: colors.neutral.shade900),
                            decoration: InputDecoration(
                              hintText: l10n.demandReviewDescriptionHint,
                              hintStyle: AppTypography.buyerMobile.bodySmall
                                  .toTextStyle(color: colors.neutral.shade500),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              counterText: '',
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: AppText(
                            l10n.demandReviewCharacterCount(
                              _descriptionController.text.length,
                            ),
                            variant: AppTextVariant.labelSmall,
                            style:
                                AppTypography.buyerMobile.caption.toTextStyle(
                              color: colors.neutral.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
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
  }

  String _formatLocation(LocationCoordinates? location) {
    if (location == null) return '';
    return '${location.latitude.toStringAsFixed(4)}, '
        '${location.longitude.toStringAsFixed(4)}';
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

class _LocationCard extends StatelessWidget {
  const _LocationCard({
    required this.unavailable,
    required this.title,
    required this.description,
    this.actionLabel,
  });

  final bool unavailable;
  final String title;
  final String description;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Container(
      constraints: const BoxConstraints(minHeight: 84),
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 12, 12),
      decoration: BoxDecoration(
        color: unavailable ? colors.warning.shade100 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: unavailable
            ? null
            : const <BoxShadow>[
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              unavailable ? Icons.warning_amber_rounded : Icons.place_outlined,
              color: unavailable
                  ? colors.warning.shade700
                  : colors.primary.shade500,
              size: 23,
            ),
          ),
          const SizedBox(width: AppSpacing.tokenS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AppText(
                  title,
                  variant: AppTextVariant.labelLarge,
                  style: AppTypography.buyerMobile.label.toTextStyle(
                    color: colors.neutral.shade900,
                  ),
                ),
                const SizedBox(height: AppSpacing.token2Xs),
                AppText(
                  description,
                  variant: AppTextVariant.bodySmall,
                  style: AppTypography.buyerMobile.caption.toTextStyle(
                    color: colors.neutral.shade600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (actionLabel != null) ...<Widget>[
            const SizedBox(width: AppSpacing.tokenS),
            AppText(
              actionLabel!,
              variant: AppTextVariant.labelMedium,
              style: AppTypography.buyerMobile.labelSmall.toTextStyle(
                color: colors.primary.shade500,
              ),
            ),
          ] else ...<Widget>[
            const SizedBox(width: AppSpacing.tokenS),
            Icon(
              Icons.edit_outlined,
              color: colors.primary.shade500,
              size: 21,
            ),
          ],
        ],
      ),
    );
  }
}

class _EvidenceTile extends StatelessWidget {
  const _EvidenceTile({
    required this.evidence,
    required this.label,
    required this.onTap,
    this.video = false,
    this.isAddTile = false,
  });

  final XFile? evidence;
  final String label;
  final VoidCallback onTap;
  final bool video;
  final bool isAddTile;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 92,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                if (evidence != null && !video)
                  FutureBuilder<Uint8List>(
                    future: evidence!.readAsBytes(),
                    builder: (context, snapshot) => snapshot.hasData
                        ? Image.memory(snapshot.data!, fit: BoxFit.cover)
                        : ColoredBox(color: colors.neutral.shade300),
                  )
                else
                  ColoredBox(
                    color: video
                        ? colors.neutral.shade800
                        : colors.neutral.shade300,
                    child: Center(
                      child: Icon(
                        isAddTile
                            ? Icons.add_rounded
                            : video
                                ? Icons.play_arrow_rounded
                                : Icons.image_outlined,
                        color: Colors.white,
                        size: isAddTile ? 28 : 32,
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    color: Colors.black.withValues(alpha: .68),
                    child: AppText(
                      label,
                      variant: AppTextVariant.labelSmall,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.buyerMobile.caption.toTextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
