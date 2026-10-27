import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_player/video_player.dart';

import '../../../components/app_text.dart';
import '../../../components/buttons/primary_button.dart';
import '../../../components/buttons/secondary_button.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import 'camera_framing_overlay.dart';
import 'camera_top_bar.dart';

class CameraMediaReviewView extends StatelessWidget {
  const CameraMediaReviewView({
    super.key,
    required this.media,
    required this.isVideo,
    required this.categoryIndex,
    required this.onUseMedia,
    required this.onRetakeMedia,
    required this.onClose,
    this.photoBytes,
    this.videoPlayerController,
    this.onToggleVideoPlayback,
    this.accentColor = const Color(0xFFFFD34D),
    this.backgroundColor = const Color(0xFF202330),
  });

  final XFile media;
  final bool isVideo;
  final int categoryIndex;
  final VoidCallback onUseMedia;
  final VoidCallback onRetakeMedia;
  final VoidCallback onClose;
  final Future<Uint8List>? photoBytes;
  final VideoPlayerController? videoPlayerController;
  final VoidCallback? onToggleVideoPlayback;
  final Color accentColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final l10nStyle = AppTypography.buyerMobile.button.toTextStyle();
    final player = videoPlayerController;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned.fill(
          child: isVideo
              ? player != null && player.value.isInitialized
                  ? GestureDetector(
                      onTap: onToggleVideoPlayback,
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: player.value.aspectRatio,
                          child: VideoPlayer(player),
                        ),
                      ),
                    )
                  : const Center(
                      child: Icon(
                        Icons.videocam_outlined,
                        color: Colors.white70,
                        size: 48,
                      ),
                    )
              : FutureBuilder<Uint8List>(
                  future: photoBytes ?? media.readAsBytes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: Colors.white70,
                          size: 48,
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Skeletonizer(
                        enabled: true,
                        child: ColoredBox(color: backgroundColor),
                      );
                    }
                    return Image.memory(
                      snapshot.data!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: Colors.white70,
                          size: 48,
                        ),
                      ),
                    );
                  },
                ),
        ),
        const CameraFramingOverlay(color: Color(0xFF54C66A)),
        Column(
          children: <Widget>[
            CameraTopBar(
              categoryIndex: categoryIndex,
              onClose: onClose,
            ),
            const Spacer(),
            DecoratedBox(
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
                  isVideo
                      ? l10n.cameraVideoLooksClear
                      : l10n.cameraPhotoLooksClear,
                  variant: AppTextVariant.bodySmall,
                  style: AppTypography.buyerMobile.caption.toTextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.tokenL,
                AppSpacing.token5Xl,
                AppSpacing.tokenL,
                MediaQuery.paddingOf(context).bottom + AppSpacing.tokenL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  PrimaryButton(
                    label: isVideo ? l10n.cameraUseVideo : l10n.cameraUsePhoto,
                    onPressed: onUseMedia,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: AppColors.primitives.neutral.shade900,
                      elevation: 0,
                      minimumSize: const Size.fromHeight(52),
                      shape: const StadiumBorder(),
                      textStyle: l10nStyle,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.tokenS),
                  SecondaryButton(
                    label: isVideo
                        ? l10n.cameraRetakeVideo
                        : l10n.cameraRetakePhoto,
                    onPressed: onRetakeMedia,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      minimumSize: const Size.fromHeight(52),
                      shape: const StadiumBorder(),
                      textStyle: l10nStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
