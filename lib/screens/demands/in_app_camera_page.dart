import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../components/app_text.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/layout/app_bottom_sheet.dart';
import '../../core/camera/camera_capture_service.dart' as app_camera;
import '../../core/permissions/permission_service.dart';
import '../../core/resources/app_colors.dart';
import '../../core/resources/app_spacing.dart';
import '../../core/resources/app_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';

class InAppCameraPage extends StatefulWidget {
  const InAppCameraPage({
    super.key,
    required this.cameraCaptureService,
    required this.permissionService,
    required this.mediaType,
    this.categoryIndex = 0,
  });

  final app_camera.CameraCaptureService cameraCaptureService;
  final PermissionService permissionService;
  final app_camera.CameraMediaType mediaType;
  final int categoryIndex;

  @override
  State<InAppCameraPage> createState() => _InAppCameraPageState();
}

class _InAppCameraPageState extends State<InAppCameraPage>
    with WidgetsBindingObserver {
  static const _accent = Color(0xFFFFD34D);
  static const _background = Color(0xFF202330);

  CameraController? _controller;
  List<CameraDescription> _cameras = <CameraDescription>[];
  int _cameraIndex = 0;
  bool _isInitializing = true;
  bool _isCapturing = false;
  bool _isRecording = false;
  bool _showGuide = false;
  bool _showFlash = false;
  bool _isAppResumed = true;
  bool _allowPop = false;
  bool _isShowingExitConfirmation = false;
  XFile? _capturedPhoto;
  XFile? _capturedVideo;
  VideoPlayerController? _videoPlayerController;
  String? _error;
  int _recordingSeconds = 0;
  Timer? _recordingTimer;

  bool get _isVideo => widget.mediaType == app_camera.CameraMediaType.video;
  bool get _hasCapturedMedia =>
      _capturedPhoto != null || _capturedVideo != null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _showGuide = !widget.cameraCaptureService.hasSeenCameraGuide;
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _recordingTimer?.cancel();
    _controller?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _isAppResumed = false;
      unawaited(_pauseCamera());
    } else if (state == AppLifecycleState.resumed) {
      _isAppResumed = true;
      if (!_hasCapturedMedia) {
        _initializeCamera();
      } else if (_capturedVideo != null) {
        final player = _videoPlayerController;
        if (player != null) unawaited(_setVideoPlayback(player, play: true));
      }
    }
  }

  Future<void> _pauseCamera() async {
    _recordingTimer?.cancel();
    _recordingTimer = null;
    final videoPlayer = _videoPlayerController;
    if (videoPlayer != null) {
      unawaited(_setVideoPlayback(videoPlayer, play: false));
    }
    final controller = _controller;
    if (mounted) {
      setState(() {
        _controller = null;
        _isRecording = false;
        _isCapturing = false;
        _isInitializing = true;
      });
    } else {
      _controller = null;
    }
    if (controller != null) {
      await WidgetsBinding.instance.endOfFrame;
      await controller.dispose();
    }
  }

  Future<void> _initializeCamera({int? index}) async {
    if (!mounted) return;
    final oldController = _controller;
    setState(() {
      _controller = null;
      _isInitializing = true;
      _error = null;
    });
    if (oldController != null) {
      await WidgetsBinding.instance.endOfFrame;
      await oldController.dispose();
    }
    if (!mounted || !_isAppResumed) return;

    try {
      _cameras = await availableCameras();
      if (!mounted || !_isAppResumed) return;
      if (_cameras.isEmpty) throw CameraException('NoCameraAvailable', '');
      if (index != null) _cameraIndex = index;
      if (_cameraIndex >= _cameras.length) _cameraIndex = 0;
      final preferredIndex = _cameras.indexWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
      );
      if (_cameraIndex == 0 && preferredIndex >= 0) {
        _cameraIndex = preferredIndex;
      }
      final controller = CameraController(
        _cameras[_cameraIndex],
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await controller.initialize();
      if (!mounted || !_isAppResumed) {
        await controller.dispose();
        return;
      }
      _controller = controller;
      await widget.cameraCaptureService.saveCameraPermissionGranted();
      setState(() => _isInitializing = false);
    } on CameraException catch (error) {
      if (!mounted) return;
      setState(() {
        _isInitializing = false;
        _error = error.code;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isInitializing = false;
        _error = error.toString();
      });
    }
  }

  Future<void> _onReady() async {
    await widget.cameraCaptureService.markCameraGuideSeen();
    if (mounted) setState(() => _showGuide = false);
  }

  Future<void> _toggleCamera() async {
    if (_cameras.length < 2 || _isCapturing || _isRecording) return;
    final next = (_cameraIndex + 1) % _cameras.length;
    await _initializeCamera(index: next);
    _showFlash = false;
    if (mounted) setState(() {});
  }

  Future<void> _toggleFlash() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    try {
      _showFlash = !_showFlash;
      await controller.setFlashMode(
        _showFlash ? FlashMode.torch : FlashMode.off,
      );
      if (mounted) setState(() {});
    } on CameraException {
      _showFlash = false;
      await controller.setFlashMode(FlashMode.off).catchError((_) {});
    }
  }

  Future<void> _onShutter() async {
    if (_isVideo) {
      if (_isRecording) {
        await _stopRecording();
      } else {
        await _startRecording();
      }
      return;
    }
    final controller = _controller;
    if (controller == null || _isCapturing) return;
    setState(() => _isCapturing = true);
    try {
      final file = await controller.takePicture();
      if (mounted) {
        setState(() {
          _controller = null;
          _capturedPhoto = file;
          _isCapturing = false;
        });
      }
      await WidgetsBinding.instance.endOfFrame;
      await controller.dispose();
    } on CameraException catch (error) {
      if (mounted) setState(() => _error = error.code);
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  Future<void> _startRecording() async {
    final controller = _controller;
    if (controller == null || _isCapturing) return;
    setState(() {
      _isCapturing = true;
      _recordingSeconds = 0;
    });
    try {
      await controller.startVideoRecording();
      if (!mounted) return;
      setState(() {
        _isCapturing = false;
        _isRecording = true;
      });
      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;
        setState(() => _recordingSeconds++);
        if (_recordingSeconds >= 10) unawaited(_stopRecording());
      });
    } on CameraException catch (error) {
      if (mounted) setState(() => _error = error.code);
    } finally {
      if (mounted && _isCapturing) setState(() => _isCapturing = false);
    }
  }

  Future<void> _stopRecording() async {
    final controller = _controller;
    if (controller == null || !_isRecording || _isCapturing) return;
    _recordingTimer?.cancel();
    _recordingTimer = null;
    setState(() {
      _isCapturing = true;
      _isRecording = false;
    });
    try {
      final file = await controller.stopVideoRecording();
      if (mounted) {
        setState(() {
          _controller = null;
          _isCapturing = false;
          _isInitializing = true;
        });
      }
      await WidgetsBinding.instance.endOfFrame;
      await controller.dispose();
      if (mounted) await _showVideoReview(file);
    } on CameraException catch (error) {
      if (mounted) setState(() => _error = error.code);
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  Future<void> _openSettings() async {
    await widget.permissionService.openAppSettings();
  }

  void _usePhoto() {
    final media = _capturedPhoto ?? _capturedVideo;
    if (media != null) unawaited(_returnCapturedMedia(media));
  }

  Future<void> _showVideoReview(XFile file) async {
    VideoPlayerController? player;
    var playerInitialized = false;
    try {
      player = VideoPlayerController.file(File(file.path));
      await player.initialize();
      playerInitialized = true;
      await player.setLooping(true);
      await player.play();
    } catch (error, stackTrace) {
      debugPrint('Unable to initialize captured video preview: $error');
      debugPrintStack(stackTrace: stackTrace);
      // If the platform plugin failed before initialization completed,
      // dispose() can wait forever for the controller's creation completer.
      // Only dispose controllers that finished initialization, and bound the
      // cleanup in case the native player has already become unavailable.
      if (playerInitialized && player != null) {
        await _disposeVideoPlayer(player);
      }
      player = null;
    }
    if (!mounted) {
      if (player != null) await _disposeVideoPlayer(player);
      return;
    }
    setState(() {
      _videoPlayerController = player;
      _capturedVideo = file;
      _isCapturing = false;
      _isInitializing = false;
    });
  }

  Future<void> _disposeVideoPlayer(VideoPlayerController player) async {
    try {
      await player.dispose().timeout(const Duration(seconds: 2));
    } catch (_) {
      // Native cleanup is best effort when the platform channel is unavailable.
    }
  }

  Future<void> _setVideoPlayback(
    VideoPlayerController player, {
    required bool play,
  }) async {
    try {
      if (play) {
        await player.play();
      } else {
        await player.pause();
      }
    } catch (error) {
      debugPrint('Unable to ${play ? 'play' : 'pause'} captured video: $error');
    }
  }

  Future<void> _returnCapturedMedia(XFile media) async {
    if (!mounted) return;
    setState(() => _allowPop = true);
    await WidgetsBinding.instance.endOfFrame;
    if (mounted) context.pop<XFile>(media);
  }

  Future<void> _showExitConfirmation() async {
    if (_isShowingExitConfirmation || !mounted) return;
    _isShowingExitConfirmation = true;
    final l10n = AppLocalizations.of(context)!;
    final shouldExit = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (sheetContext) => SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.fromLTRB(24, 12, 24, 20),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                l10n.cameraExitTitle,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: Color(0xFF315FC2),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.cameraExitDescription,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: Color(0xFF777984),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: () => Navigator.of(sheetContext).pop(false),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF315FC2),
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(l10n.cameraContinueClaim),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: () => Navigator.of(sheetContext).pop(true),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFFCF2F2),
                    foregroundColor: const Color(0xFFE24C4C),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(l10n.cameraExitClaim),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    _isShowingExitConfirmation = false;
    if (shouldExit == true && mounted) {
      context.go(AppRoutes.openDemands);
    }
  }

  Future<void> _retakeCapture() async {
    if (_isInitializing) return;
    final player = _videoPlayerController;
    setState(() {
      _capturedPhoto = null;
      _capturedVideo = null;
      _videoPlayerController = null;
    });
    if (player != null) {
      await WidgetsBinding.instance.endOfFrame;
      await _disposeVideoPlayer(player);
    }
    await _initializeCamera();
  }

  Future<void> _toggleVideoPlayback(VideoPlayerController player) async {
    await _setVideoPlayback(player, play: !player.value.isPlaying);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = _controller;
    return PopScope<XFile>(
      canPop: _allowPop,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) unawaited(_showExitConfirmation());
      },
      child: Scaffold(
        backgroundColor: _background,
        body: SafeArea(
          bottom: !_showGuide,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              if (!_hasCapturedMedia &&
                  controller != null &&
                  controller.value.isInitialized)
                _CameraPreviewFill(controller: controller)
              else
                const ColoredBox(color: _background),
              if (!_hasCapturedMedia &&
                  controller != null &&
                  controller.value.isInitialized)
                const _CameraFramingOverlay(),
              if (_hasCapturedMedia)
                _buildMediaReview(l10n)
              else if (_showGuide &&
                  controller != null &&
                  controller.value.isInitialized)
                _buildGuide(l10n)
              else if (!_hasCapturedMedia)
                _buildCaptureControls(l10n),
              if (_isInitializing && !_hasCapturedMedia)
                const _LoadingOverlay(),
              if (_error != null) _buildError(l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuide(AppLocalizations l10n) {
    final detail = switch (widget.categoryIndex) {
      0 => l10n.cameraGuideDocuments,
      1 => l10n.cameraGuidePackaging,
      2 => l10n.cameraGuideDamage,
      _ => l10n.cameraGuideDocuments,
    };
    final text = AppColors.semantic.text;
    final checklist = <String>[
      l10n.cameraGuideShippingLabel,
      l10n.cameraGuideTrackingNumber,
      l10n.cameraGuideIncludedDocuments,
    ];

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          children: <Widget>[
            _buildTopBar(l10n),
            const Spacer(),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: AppBottomSheet(
            padding: EdgeInsets.zero,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    AppText(
                      l10n.cameraGuideQuestion,
                      variant: AppTextVariant.headlineSmall,
                      textAlign: TextAlign.end,
                      style: AppTypography.buyerMobile.h3.toTextStyle(
                        color: text.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenXs),
                    AppText(
                      _isVideo ? detail : l10n.cameraGuidePhotoHint,
                      variant: AppTextVariant.bodySmall,
                      textAlign: TextAlign.end,
                      style: AppTypography.buyerMobile.bodySmall.toTextStyle(
                        color: text.secondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenM),
                    ...checklist.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 48),
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            14,
                            8,
                            12,
                            8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primitives.neutral.shade200,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.check_rounded,
                                color: AppColors.primitives.primary.shade500,
                                size: 20,
                              ),
                              const Spacer(),
                              Flexible(
                                child: AppText(
                                  item,
                                  variant: AppTextVariant.bodyMedium,
                                  textAlign: TextAlign.end,
                                  style: AppTypography.buyerMobile.bodyMedium
                                      .toTextStyle(color: text.primary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.tokenS),
                    PrimaryButton(
                      label: l10n.cameraGuideReady,
                      onPressed: _onReady,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        shape: const StadiumBorder(),
                        textStyle:
                            AppTypography.buyerMobile.button.toTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCaptureControls(AppLocalizations l10n) {
    return Column(
      children: <Widget>[
        _buildTopBar(l10n),
        const Spacer(),
        if (_isRecording)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Text(
                    '${l10n.cameraRecording} 00:${_recordingSeconds.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _RoundCameraButton(
                icon: _showFlash
                    ? Icons.flash_on_rounded
                    : Icons.flash_off_rounded,
                label: l10n.cameraFlash,
                onPressed: _toggleFlash,
              ),
              GestureDetector(
                onTap: _isCapturing ? null : _onShutter,
                child: Container(
                  width: 78,
                  height: 78,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      color:
                          _isRecording ? const Color(0xFFE74D4D) : Colors.white,
                      shape:
                          _isRecording ? BoxShape.rectangle : BoxShape.circle,
                      borderRadius:
                          _isRecording ? BorderRadius.circular(12) : null,
                    ),
                  ),
                ),
              ),
              _RoundCameraButton(
                icon: Icons.flip_camera_ios_rounded,
                label: l10n.cameraSwitch,
                onPressed: _toggleCamera,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMediaReview(AppLocalizations l10n) {
    final isVideo = _capturedVideo != null;
    final media = _capturedVideo ?? _capturedPhoto!;
    final player = _videoPlayerController;
    return Column(
      children: <Widget>[
        _buildTopBar(l10n),
        Expanded(
          child: Center(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 42, vertical: 18),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF292C38),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: isVideo
                        ? player != null && player.value.isInitialized
                            ? Center(
                                child: AspectRatio(
                                  aspectRatio: player.value.aspectRatio,
                                  child: GestureDetector(
                                    onTap: () {
                                      unawaited(_toggleVideoPlayback(player));
                                    },
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
                        : Image.file(
                            File(media.path),
                            fit: BoxFit.contain,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.broken_image_outlined,
                              color: Colors.white70,
                              size: 48,
                            ),
                          ),
                  ),
                  PositionedDirectional(
                    top: 0,
                    end: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _accent,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        child: Text(
                          isVideo
                              ? l10n.cameraVideoLooksClear
                              : l10n.cameraPhotoLooksClear,
                          style: const TextStyle(
                            color: Color(0xFF252833),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 52,
                child: FilledButton(
                  onPressed: _usePhoto,
                  style: FilledButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: const Color(0xFF252833),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    isVideo ? l10n.cameraUseVideo : l10n.cameraUsePhoto,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              TextButton(
                onPressed: _retakeCapture,
                style: TextButton.styleFrom(foregroundColor: Colors.white70),
                child: Text(
                  isVideo ? l10n.cameraRetakeVideo : l10n.cameraRetakePhoto,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar(AppLocalizations l10n) {
    final progress = widget.categoryIndex + 1;
    final title = switch (widget.categoryIndex) {
      0 => l10n.cameraGuideTitle,
      1 => l10n.demandDetailsEvidencePackaging,
      _ => l10n.demandDetailsEvidenceDamageVideo,
    };
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: Column(
        children: <Widget>[
          Row(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              IconButton.filledTonal(
                tooltip: l10n.cameraHelp,
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0x332B2E3A),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.help_outline_rounded),
              ),
              const Spacer(),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0x332B2E3A),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  child: Text(
                    '$progress ${Localizations.localeOf(context).languageCode == 'ar' ? 'من' : 'of'} 3',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Spacer(),
              IconButton.filledTonal(
                tooltip: l10n.close,
                onPressed: () => unawaited(_showExitConfirmation()),
                style: IconButton.styleFrom(
                    backgroundColor: const Color(0x332B2E3A),
                    foregroundColor: Colors.white),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildError(AppLocalizations l10n) {
    final denied = _error?.toLowerCase().contains('denied') ?? false;
    return ColoredBox(
      color: _background.withValues(alpha: 0.96),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(Icons.no_photography_outlined,
                  color: _accent, size: 48),
              const SizedBox(height: 20),
              Text(
                  denied
                      ? l10n.cameraPermissionDeniedDescription
                      : l10n.cameraCaptureError,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, height: 1.5)),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: denied ? _openSettings : _initializeCamera,
                child: Text(denied
                    ? l10n.cameraPermissionOpenSettings
                    : l10n.cameraRetry),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CameraPreviewFill extends StatelessWidget {
  const _CameraPreviewFill({required this.controller});
  final CameraController controller;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final size = controller.value.previewSize;
          if (size == null) return CameraPreview(controller);
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          final previewWidth = size.height;
          final previewHeight = size.width;
          final scale = math.max(width / previewWidth, height / previewHeight);
          return ClipRect(
            child: OverflowBox(
              maxWidth: previewWidth * scale,
              maxHeight: previewHeight * scale,
              child: SizedBox(
                width: previewWidth * scale,
                height: previewHeight * scale,
                child: CameraPreview(controller),
              ),
            ),
          );
        },
      );
}

class _CameraFramingOverlay extends StatelessWidget {
  const _CameraFramingOverlay();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: SizedBox(
          width: 310,
          height: 250,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: CustomPaint(painter: _CornerFramePainter())),
              Align(
                child: Container(
                    height: 1,
                    color:
                        _InAppCameraPageState._accent.withValues(alpha: 0.8)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CornerFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const length = 25.0;
    const radius = 12.0;
    final paint = Paint()
      ..color = _InAppCameraPageState._accent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final paths = <Path>[
      Path()
        ..moveTo(1, radius + length)
        ..lineTo(1, radius)
        ..quadraticBezierTo(1, 1, radius, 1)
        ..lineTo(radius + length, 1),
      Path()
        ..moveTo(size.width - radius - length, 1)
        ..lineTo(size.width - radius, 1)
        ..quadraticBezierTo(size.width - 1, 1, size.width - 1, radius)
        ..lineTo(size.width - 1, radius + length),
      Path()
        ..moveTo(1, size.height - radius - length)
        ..lineTo(1, size.height - radius)
        ..quadraticBezierTo(1, size.height - 1, radius, size.height - 1)
        ..lineTo(radius + length, size.height - 1),
      Path()
        ..moveTo(size.width - radius - length, size.height - 1)
        ..lineTo(size.width - radius, size.height - 1)
        ..quadraticBezierTo(size.width - 1, size.height - 1, size.width - 1,
            size.height - radius)
        ..lineTo(size.width - 1, size.height - radius - length),
    ];
    for (final path in paths) {
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RoundCameraButton extends StatelessWidget {
  const _RoundCameraButton(
      {required this.icon, required this.label, required this.onPressed});
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

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) => const ColoredBox(
        color: Color(0xAA202330),
        child: Center(
            child: CircularProgressIndicator(
                color: _InAppCameraPageState._accent)),
      );
}
