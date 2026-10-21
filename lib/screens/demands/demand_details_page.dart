import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipments/screens/demands/widgets/add_evidence_tile.dart';
import 'package:shipments/screens/demands/widgets/evidence_category_row.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/custom_claim_shipment_card.dart';
import '../../components/layout/app_bottom_sheet.dart';
import '../../core/camera/camera_capture_service.dart';
import '../../core/location/location_coordinates.dart';
import '../../core/permissions/permission_service.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_images.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'camera_permission_page.dart';
import 'demand_review_page.dart';
import 'widgets/demand_evidence_header.dart';
import 'widgets/demand_loading_state.dart';

class DemandDetailsPage extends StatefulWidget {
  const DemandDetailsPage({
    super.key,
    this.locationUnavailable = true,
    this.location,
    required this.cameraCaptureService,
    required this.permissionService,
  });

  final bool locationUnavailable;
  final LocationCoordinates? location;
  final CameraCaptureService cameraCaptureService;
  final PermissionService permissionService;

  @override
  State<DemandDetailsPage> createState() => _DemandDetailsPageState();
}

class _DemandDetailsPageState extends State<DemandDetailsPage> {
  int? _selectedEvidence = 0;
  final List<XFile?> _requiredEvidence = List<XFile?>.filled(3, null);
  final List<XFile?> _optionalPhotos = List<XFile?>.filled(3, null);
  bool _isCapturing = false;
  bool _showReview = false;

  bool get _allRequiredEvidenceCaptured =>
      _requiredEvidence.every((file) => file != null);

  Future<XFile?> _openCamera(
    CameraMediaType mediaType, {
    int categoryIndex = 0,
  }) async {
    final request = CameraCaptureRequest(
      mediaType: mediaType,
      categoryIndex: categoryIndex,
    );
    if (!widget.cameraCaptureService.hasPreviouslyGrantedCameraPermission) {
      final granted = await AppBottomSheet.show<bool>(
        context,
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        barrierColor: Colors.black54,
        child: CameraPermissionSheet(
          cameraCaptureService: widget.cameraCaptureService,
          permissionService: widget.permissionService,
        ),
      );
      if (granted != true || !mounted) return null;
    }
    return context.push<XFile>(AppRoutes.cameraCapture, extra: request);
  }

  int _nextEvidenceIndex() {
    final selected = _selectedEvidence;
    if (selected != null && _requiredEvidence[selected] == null) {
      return selected;
    }
    final missingIndex = _requiredEvidence.indexWhere((file) => file == null);
    return missingIndex == -1 ? 0 : missingIndex;
  }

  Future<void> _captureEvidence(int index) async {
    if (_isCapturing) return;
    final mediaType =
        index == 2 ? CameraMediaType.video : CameraMediaType.photo;
    setState(() {
      _selectedEvidence = index;
      _isCapturing = true;
    });
    try {
      final media = await _openCamera(mediaType, categoryIndex: index);
      if (media == null || !mounted) return;
      setState(() {
        _requiredEvidence[index] = media;
        _selectedEvidence = _allRequiredEvidenceCaptured
            ? null
            : _requiredEvidence.indexWhere((file) => file == null);
      });
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  Future<void> _captureOptionalPhoto(int index) async {
    if (_isCapturing) return;
    setState(() => _isCapturing = true);
    try {
      final photo = await _openCamera(CameraMediaType.photo);
      if (photo != null && mounted) {
        setState(() => _optionalPhotos[index] = photo);
      }
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  void _onPrimaryAction() {
    if (_allRequiredEvidenceCaptured) {
      setState(() => _showReview = true);
      return;
    }
    _captureEvidence(_nextEvidenceIndex());
  }

  void _handleBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.openDemands);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const colors = AppColors.primitives;

    if (_showReview) {
      return DemandReviewPage(
        locationUnavailable: widget.locationUnavailable,
        location: widget.location,
        evidence: _requiredEvidence,
        optionalPhotos: _optionalPhotos,
        onBack: () => setState(() => _showReview = false),
        onRetakeEvidence: _captureEvidence,
        onAddOptionalPhoto: _captureOptionalPhoto,
        onSubmit: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(l10n.demandReviewSubmitComingSoon)),
            );
        },
      );
    }

    final width = MediaQuery.sizeOf(context).width;
    final headerHeight = (width * .8).clamp(310.0, 360.0);
    const summaryCardHeight = 96.0;
    const summaryCardOverlap = 20.0;
    final headerStageHeight =
        headerHeight + summaryCardHeight - summaryCardOverlap;

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
                    heading: l10n.demandDetailsHeading,
                    description: l10n.demandDetailsDescription,
                    locationMessage: widget.locationUnavailable
                        ? l10n.demandDetailsLocationUnavailable
                        : l10n.demandDetailsLocationAvailable,
                    locationUnavailable: widget.locationUnavailable,
                    onBack: _handleBack,
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
                  AppText(
                    l10n.demandDetailsEvidenceQuestion,
                    variant: AppTextVariant.titleLarge,
                    textAlign: TextAlign.start,
                    style: AppTypography.buyerMobile.h4.toTextStyle(
                      color: colors.neutral.shade900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.tokenS),
                  for (var index = 0; index < 3; index++) ...<Widget>[
                    EvidenceCategoryRow(
                      number: '${index + 1}',
                      title: switch (index) {
                        0 => l10n.demandDetailsEvidenceDocuments,
                        1 => l10n.demandDetailsEvidencePackaging,
                        _ => l10n.demandDetailsEvidenceDamageVideo,
                      },
                      subtitle: switch (index) {
                        _ when _requiredEvidence[index] != null =>
                          l10n.demandDetailsEvidenceAdded,
                        0 => l10n.demandDetailsDocumentsHint,
                        1 => l10n.demandDetailsPackagingHint,
                        _ => l10n.demandDetailsVideoHint,
                      },
                      icon: index == 2
                          ? Icons.videocam_outlined
                          : Icons.camera_alt_outlined,
                      completed: _requiredEvidence[index] != null,
                      evidence: _requiredEvidence[index],
                      selected: _selectedEvidence == index,
                      enabled: _requiredEvidence[index] == null &&
                          _selectedEvidence == index,
                      onTap: () => setState(() => _selectedEvidence = index),
                      onRetake: () => _captureEvidence(index),
                    ),
                    if (index < 2) const SizedBox(height: AppSpacing.tokenS),
                  ],
                  const SizedBox(height: AppSpacing.tokenL),
                  AppText(
                    l10n.demandDetailsOptionalImages,
                    variant: AppTextVariant.bodyMedium,
                    textAlign: TextAlign.start,
                    style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
                      color: colors.neutral.shade500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.tokenM),
                  Row(
                    children: List<Widget>.generate(3, (index) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: index == 0 ? 0 : AppSpacing.tokenS,
                          ),
                          child: AddEvidenceTile(
                            semanticLabel: l10n.demandDetailsAddImage,
                            photo: _optionalPhotos[index],
                            onTap: () => _captureOptionalPhoto(index),
                          ),
                        ),
                      );
                    }),
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
              label: _allRequiredEvidenceCaptured
                  ? l10n.demandDetailsNextReview
                  : _requiredEvidence.any((file) => file != null)
                      ? l10n.demandDetailsContinueDocumentation
                      : l10n.demandDetailsStartDocumentation,
              onPressed: _isCapturing ? null : _onPrimaryAction,
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
      isLoading: _isCapturing,
      loadingLabel: l10n.loading,
      child: content,
    );
  }
}
