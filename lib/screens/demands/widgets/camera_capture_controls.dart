import 'package:flutter/material.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import '../../../l10n/app_localizations.dart';

class CameraCaptureControls extends StatelessWidget {
  const CameraCaptureControls({
    super.key,
    required this.isVideo,
    required this.isRecording,
    required this.isCapturing,
    required this.showFlash,
    required this.recordingSeconds,
    required this.onShutter,
    required this.onToggleFlash,
    required this.onToggleCamera,
    this.accentColor = const Color(0xFFFFD34D),
  });

  final bool isVideo;
  final bool isRecording;
  final bool isCapturing;
  final bool showFlash;
  final int recordingSeconds;
  final VoidCallback onShutter;
  final VoidCallback onToggleFlash;
  final VoidCallback onToggleCamera;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: <Widget>[
        if (isRecording) ...<Widget>[
          const SizedBox(height: AppSpacing.tokenS),
          CameraRecordingIndicator(recordingSeconds: recordingSeconds),
        ],
        const Spacer(),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: .48),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.tokenM,
                vertical: AppSpacing.tokenS,
              ),
              child: AppText(
                isVideo ? l10n.cameraVideoFramingHint : l10n.cameraFramingHint,
                variant: AppTextVariant.bodySmall,
                textAlign: TextAlign.center,
                style: AppTypography.buyerMobile.caption.toTextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            12,
            24,
            MediaQuery.paddingOf(context).bottom + 24,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RoundCameraButton(
                icon: showFlash
                    ? Icons.flash_on_rounded
                    : Icons.flash_off_rounded,
                label: l10n.cameraFlash,
                onPressed: onToggleFlash,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Semantics(
                    button: true,
                    enabled: !isCapturing,
                    label: isVideo
                        ? isRecording
                            ? l10n.cameraStopRecording
                            : l10n.cameraStartRecording
                        : l10n.cameraCapture,
                    onTap: isCapturing ? null : onShutter,
                    child: GestureDetector(
                      excludeFromSemantics: true,
                      onTap: isCapturing ? null : onShutter,
                      child: Container(
                        width: 78,
                        height: 78,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isRecording ? accentColor : Colors.white,
                            width: 3,
                          ),
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          decoration: BoxDecoration(
                            color: isRecording
                                ? const Color(0xFFE74D4D)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(
                              isRecording ? 12 : 34,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.tokenXs),
                  AppText(
                    isVideo
                        ? l10n.cameraVideoModeLabel
                        : l10n.cameraPhotoModeLabel,
                    variant: AppTextVariant.labelSmall,
                    style: AppTypography.buyerMobile.caption.toTextStyle(
                      color: accentColor,
                    ),
                  ),
                ],
              ),
              RoundCameraButton(
                icon: Icons.flip_camera_ios_rounded,
                label: l10n.cameraSwitch,
                onPressed: onToggleCamera,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RoundCameraButton extends StatelessWidget {
  const RoundCameraButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
        tooltip: label,
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: const Color(0x332B2E3A),
          foregroundColor: Colors.white,
          fixedSize: const Size(48, 48),
        ),
        icon: Icon(icon),
      );
}

class CameraRecordingIndicator extends StatelessWidget {
  const CameraRecordingIndicator({
    super.key,
    required this.recordingSeconds,
  });

  final int recordingSeconds;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final seconds = (recordingSeconds % 60).toString().padLeft(2, '0');

    return Semantics(
      label: l10n.cameraRecording,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFE34B56),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppText(
                '0:$seconds',
                variant: AppTextVariant.labelMedium,
                style: AppTypography.buyerMobile.button.toTextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: AppSpacing.tokenXs),
              const Icon(Icons.circle, size: 8, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
