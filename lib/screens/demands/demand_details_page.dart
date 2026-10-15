import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/app_scaffold.dart';
import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/custom_shipment_info_card.dart';
import '../../core/camera/camera_capture_service.dart';
import '../../core/location/location_coordinates.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_radius.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/demand_progress.dart';

class DemandDetailsPage extends StatefulWidget {
  const DemandDetailsPage({
    super.key,
    this.locationUnavailable = true,
    this.location,
    required this.cameraCaptureService,
  });

  final bool locationUnavailable;
  final LocationCoordinates? location;
  final CameraCaptureService cameraCaptureService;

  @override
  State<DemandDetailsPage> createState() => _DemandDetailsPageState();
}

class _DemandDetailsPageState extends State<DemandDetailsPage> {
  int? _selectedEvidence = 0;
  final List<XFile?> _requiredEvidence = List<XFile?>.filled(3, null);
  final List<XFile?> _optionalPhotos = List<XFile?>.filled(3, null);
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
  }

  bool get _allRequiredEvidenceCaptured =>
      _requiredEvidence.every((file) => file != null);

  Future<XFile?> _openCamera(CameraMediaType mediaType,
      {int categoryIndex = 0}) async {
    final request = CameraCaptureRequest(
      mediaType: mediaType,
      categoryIndex: categoryIndex,
    );
    if (!widget.cameraCaptureService.hasPreviouslyGrantedCameraPermission) {
      final granted = await context.push<bool>(
        AppRoutes.cameraPermission,
        extra: request,
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
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.demandDetailsReviewComingSoon,
            ),
          ),
        );
      return;
    }
    _captureEvidence(_nextEvidenceIndex());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const colors = AppColors.primitives;

    return AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.semantic.background.primary,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenM,
              AppSpacing.tokenS,
              AppSpacing.tokenM,
              0,
            ),
            child: SizedBox(
              height: 48,
              child: Row(
                children: <Widget>[
                  Material(
                    color: colors.neutral.shade200,
                    shape: const CircleBorder(),
                    child: IconButton(
                      tooltip: l10n.navigationBack,
                      onPressed: () => context.pop(),
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        color: colors.primary.shade500,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.tokenS),
                  AppText(
                    l10n.openDemandsTitle,
                    variant: AppTextVariant.titleLarge,
                    style: AppTypography.buyerMobile.h4.toTextStyle(
                      color: colors.primary.shade500,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.tokenM,
              AppSpacing.tokenM,
              AppSpacing.tokenM,
              0,
            ),
            child: DemandProgress(
              activeStepIndex: 1,
              steps: <String>[
                l10n.openDemandsStepLocation,
                l10n.openDemandsStepEvidence,
                l10n.openDemandsStepReview,
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.tokenM,
                AppSpacing.tokenM,
                AppSpacing.tokenM,
                AppSpacing.tokenM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Align(
                    child: _LocationStatusBadge(
                      label: widget.locationUnavailable
                          ? l10n.demandDetailsLocationUnavailable
                          : l10n.demandDetailsLocationAvailable,
                      unavailable: widget.locationUnavailable,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.tokenS),
                  AppText(
                    l10n.demandDetailsHeading,
                    variant: AppTextVariant.headlineSmall,
                    style: AppTypography.buyerMobile.h2.toTextStyle(
                      color: colors.primary.shade500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.tokenXs),
                  AppText(
                    l10n.demandDetailsDescription,
                    variant: AppTextVariant.bodySmall,
                    style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                      color: colors.neutral.shade400,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.tokenM),
                  CustomShipmentInfoCard(
                    productTitle: l10n.homeShipmentProduct,
                    merchantName: l10n.homeShipmentMerchant,
                    price: l10n.homeShipmentPrice,
                    protectionLabel: l10n.homeShipmentProtection,
                    deliveryStatus: l10n.homeShipmentStepDelivered,
                    expectedDeliveryLabel: l10n.homeShipmentExpectedDelivery,
                    expectedDeliveryDate: l10n.homeShipmentExpectedDate,
                    trackingNumberLabel: l10n.homeShipmentTrackingLabel,
                    trackingNumber: l10n.homeShipmentTrackingNumber,
                    detailsActionLabel: l10n.homeShipmentDetails,
                    onDetails: null,
                    showDetailsAction: false,
                  ),
                  const SizedBox(height: AppSpacing.tokenM),
                  for (var index = 0; index < 3; index++) ...<Widget>[
                    _EvidenceCategoryRow(
                      number: '${index + 1}',
                      title: switch (index) {
                        0 => l10n.demandDetailsEvidenceDocuments,
                        1 => l10n.demandDetailsEvidencePackaging,
                        _ => l10n.demandDetailsEvidenceDamageVideo,
                      },
                      attachmentHint: switch (index) {
                        0 => l10n.demandDetailsOnePhoto,
                        1 => l10n.demandDetailsOnePhoto,
                        _ => l10n.demandDetailsAboutTenSeconds,
                      },
                      completed: _requiredEvidence[index] != null,
                      selected: _selectedEvidence == index,
                      onTap: () => setState(() => _selectedEvidence = index),
                      onRetake: () => _captureEvidence(index),
                    ),
                    if (index < 2) const SizedBox(height: AppSpacing.tokenS),
                  ],
                  const SizedBox(height: AppSpacing.tokenS),
                  AppText(
                    l10n.demandDetailsOptionalImages,
                    variant: AppTextVariant.bodyMedium,
                    textAlign: TextAlign.end,
                    style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
                      color: colors.neutral.shade500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.tokenS),
                  Row(
                    children: List<Widget>.generate(3, (index) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: index == 0 ? 0 : AppSpacing.tokenS,
                          ),
                          child: _AddEvidenceTile(
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
              0,
              AppSpacing.tokenM,
              AppSpacing.tokenS,
            ),
            child: PrimaryButton(
              label: _allRequiredEvidenceCaptured
                  ? l10n.demandDetailsNextReview
                  : _requiredEvidence.any((file) => file != null)
                      ? l10n.demandDetailsContinueDocumentation
                      : l10n.demandDetailsStartDocumentation,
              icon: _allRequiredEvidenceCaptured
                  ? null
                  : Icon(
                      Icons.photo_camera_outlined,
                      color: colors.neutral.shade100,
                      size: 18,
                    ),
              onPressed: _isCapturing ? null : _onPrimaryAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary.shade500,
                foregroundColor: colors.neutral.shade100,
                elevation: 0,
                minimumSize: const Size.fromHeight(52),
                shape: const StadiumBorder(),
                textStyle: AppTypography.buyerMobile.button.toTextStyle(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationStatusBadge extends StatelessWidget {
  const _LocationStatusBadge({
    required this.label,
    required this.unavailable,
  });

  final String label;
  final bool unavailable;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final background =
        unavailable ? colors.neutral.shade200 : colors.success.shade100;
    final foreground =
        unavailable ? colors.neutral.shade400 : colors.success.shade700;

    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.tokenS,
        AppSpacing.tokenXs,
        AppSpacing.tokenS,
        AppSpacing.tokenXs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.tokenFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            unavailable ? Icons.cancel_outlined : Icons.check_circle_outline,
            size: 14,
            color: foreground,
          ),
          const SizedBox(width: AppSpacing.tokenXs),
          AppText(
            label,
            variant: AppTextVariant.labelSmall,
            style: AppTypography.buyerMobile.caption.toTextStyle(
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}

class _EvidenceCategoryRow extends StatelessWidget {
  const _EvidenceCategoryRow({
    required this.number,
    required this.title,
    required this.attachmentHint,
    required this.completed,
    required this.selected,
    required this.onTap,
    required this.onRetake,
  });

  final String number;
  final String title;
  final String attachmentHint;
  final bool completed;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onRetake;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return Material(
      color: selected ? colors.neutral.shade100 : colors.neutral.shade200,
      borderRadius: BorderRadius.circular(AppRadius.token2Xl),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.token2Xl),
        child: Container(
          constraints: const BoxConstraints(minHeight: 64),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.tokenS),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.token2Xl),
            border: Border.all(
              color: selected ? colors.primary.shade500 : Colors.transparent,
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: completed
                      ? colors.primary.shade500
                      : selected
                          ? colors.primary.shade500
                          : colors.neutral.shade100,
                  borderRadius: BorderRadius.circular(AppRadius.tokenL),
                ),
                child: completed
                    ? Icon(
                        Icons.check_rounded,
                        size: 20,
                        color: colors.neutral.shade100,
                      )
                    : AppText(
                        number,
                        variant: AppTextVariant.bodyMedium,
                        style: AppTypography.buyerMobile.bodyMedium.toTextStyle(
                          color: selected
                              ? colors.neutral.shade100
                              : colors.neutral.shade400,
                        ),
                      ),
              ),
              const SizedBox(width: AppSpacing.tokenS),
              Expanded(
                child: AppText(
                  title,
                  variant: AppTextVariant.titleSmall,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.buyerMobile.h6.toTextStyle(
                    color: selected
                        ? colors.primary.shade500
                        : colors.neutral.shade400,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.tokenS),
              if (completed)
                TextButton(
                  onPressed: onRetake,
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.tokenXs,
                      vertical: AppSpacing.tokenXs,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: AppText(
                    AppLocalizations.of(context)!.demandDetailsRetake,
                    variant: AppTextVariant.labelSmall,
                    style: AppTypography.buyerMobile.caption.toTextStyle(
                      color: colors.primary.shade500,
                    ),
                  ),
                )
              else
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.primary.shade200,
                    borderRadius: BorderRadius.circular(AppRadius.tokenFull),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.tokenS,
                      vertical: AppSpacing.tokenXs,
                    ),
                    child: AppText(
                      attachmentHint,
                      variant: AppTextVariant.labelSmall,
                      maxLines: 1,
                      style: AppTypography.buyerMobile.caption.toTextStyle(
                        color: colors.primary.shade500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddEvidenceTile extends StatelessWidget {
  const _AddEvidenceTile({
    required this.semanticLabel,
    required this.photo,
    required this.onTap,
  });

  final String semanticLabel;
  final XFile? photo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: colors.neutral.shade200,
        borderRadius: BorderRadius.circular(AppRadius.tokenM),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.tokenM),
          child: CustomPaint(
            painter: _DashedBorderPainter(color: colors.primary.shade500),
            child: SizedBox(
              height: 72,
              child: Center(
                child: photo == null
                    ? Icon(
                        Icons.add_rounded,
                        color: colors.primary.shade500,
                        size: 22,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.tokenM),
                        child: FutureBuilder<Uint8List>(
                          future: photo!.readAsBytes(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError || !snapshot.hasData) {
                              return Icon(
                                Icons.photo_outlined,
                                color: colors.primary.shade500,
                                size: 22,
                              );
                            }
                            return Image.memory(
                              snapshot.data!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 72,
                            );
                          },
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const radius = AppRadius.tokenM;
    const dashWidth = 6.0;
    const dashSpace = 4.0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          const Radius.circular(radius),
        ),
      );
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = (distance + dashWidth).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance = end + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color;
}
