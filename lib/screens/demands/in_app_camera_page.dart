import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../core/camera/camera_capture_service.dart' as app_camera;
import '../../core/permissions/permission_service.dart';
import '../../core/routing/app_routes.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/camera_capture_controls.dart';
import 'widgets/camera_error_view.dart';
import 'widgets/camera_exit_dialog.dart';
import 'widgets/camera_framing_overlay.dart';
import 'widgets/camera_guide_sheet.dart';
import 'widgets/camera_media_review_view.dart';
import 'widgets/camera_top_bar.dart';
import 'widgets/demand_loading_state.dart';

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
  static const Color _accent = Color(0xFFFFD34D);
  static const Color _background = Color(0xFF202330);

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
  Future<Uint8List>? _capturedPhotoBytes;
  VideoPlayerController? _videoPlayerController;
  String? _error;
  int _recordingSeconds = 0;
  Timer? _recordingTimer;
  int _cameraInitializationGeneration = 0;
  Future<void> _cameraInitializationQueue = Future<void>.value();

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
    _cameraInitializationGeneration++;
    _recordingTimer?.cancel();
    final controller = _controller;
    if (controller != null) unawaited(_disposeCameraController(controller));
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
    _cameraInitializationGeneration++;
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
      await _disposeCameraController(controller);
    }
  }

  Future<void> _initializeCamera({int? index}) {
    if (!mounted) return Future<void>.value();

    final generation = ++_cameraInitializationGeneration;
    final initialization = _cameraInitializationQueue.then(
      (_) => _initializeCameraOnce(index: index, generation: generation),
    );
    _cameraInitializationQueue = initialization.catchError((Object _) {});
    return initialization;
  }

  Future<void> _initializeCameraOnce({
    required int? index,
    required int generation,
  }) async {
    if (!_isCurrentCameraInitialization(generation)) return;

    final oldController = _controller;
    setState(() {
      _controller = null;
      _isInitializing = true;
      _error = null;
    });
    if (oldController != null) {
      await WidgetsBinding.instance.endOfFrame;
      await _disposeCameraController(oldController);
    }
    if (!_isCurrentCameraInitialization(generation)) return;

    CameraController? initializingController;
    try {
      _cameras = await availableCameras();
      if (!_isCurrentCameraInitialization(generation)) return;
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
      initializingController = controller;
      await controller.initialize();
      if (!_isCurrentCameraInitialization(generation)) {
        await _disposeCameraController(controller);
        initializingController = null;
        return;
      }
      await widget.cameraCaptureService.saveCameraPermissionGranted();
      if (!_isCurrentCameraInitialization(generation)) {
        await _disposeCameraController(controller);
        initializingController = null;
        return;
      }
      _controller = controller;
      initializingController = null;
      setState(() => _isInitializing = false);
    } on CameraException catch (error) {
      final controller = initializingController;
      if (controller != null) await _disposeCameraController(controller);
      if (!_isCurrentCameraInitialization(generation)) return;
      setState(() {
        _isInitializing = false;
        _error = error.code;
      });
    } catch (error) {
      final controller = initializingController;
      if (controller != null) await _disposeCameraController(controller);
      if (!_isCurrentCameraInitialization(generation)) return;
      setState(() {
        _isInitializing = false;
        _error = error.toString();
      });
    }
  }

  bool _isCurrentCameraInitialization(int generation) =>
      mounted && _isAppResumed && generation == _cameraInitializationGeneration;

  Future<void> _disposeCameraController(CameraController controller) async {
    try {
      await controller.dispose();
    } catch (error) {
      debugPrint('Unable to dispose camera controller: $error');
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
          _capturedPhotoBytes = file.readAsBytes();
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
      // Best effort native cleanup
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
    final shouldExit = await showCameraExitConfirmationDialog(context);
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
      _capturedPhotoBytes = null;
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
    final hasValidController =
        controller != null && controller.value.isInitialized;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
      ),
      child: PopScope<XFile>(
        canPop: _allowPop,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) unawaited(_showExitConfirmation());
        },
        child: DemandLoadingState(
          isLoading: (_isInitializing && !_hasCapturedMedia) || _isCapturing,
          loadingLabel: l10n.loading,
          child: Scaffold(
            backgroundColor: _background,
            body: SafeArea(
              top: false,
              bottom: !_showGuide,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  if (!_hasCapturedMedia && hasValidController)
                    CameraPreviewFill(controller: controller)
                  else
                    const ColoredBox(color: _background),
                  if (!_hasCapturedMedia && hasValidController)
                    CameraFramingOverlay(
                      color: _isRecording ? const Color(0xFFE34B56) : _accent,
                    ),
                  if (_hasCapturedMedia)
                    CameraMediaReviewView(
                      media: (_capturedVideo ?? _capturedPhoto)!,
                      isVideo: _capturedVideo != null,
                      categoryIndex: widget.categoryIndex,
                      onUseMedia: _usePhoto,
                      onRetakeMedia: _retakeCapture,
                      onClose: () => unawaited(_showExitConfirmation()),
                      photoBytes: _capturedPhotoBytes,
                      videoPlayerController: _videoPlayerController,
                      onToggleVideoPlayback: _videoPlayerController == null
                          ? null
                          : () => unawaited(
                                _toggleVideoPlayback(_videoPlayerController!),
                              ),
                    )
                  else if (_showGuide && hasValidController)
                    Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            CameraTopBar(
                              categoryIndex: widget.categoryIndex,
                              onClose: () => unawaited(_showExitConfirmation()),
                            ),
                            const Spacer(),
                          ],
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: CameraGuideSheet(
                            categoryIndex: widget.categoryIndex,
                            isVideo: _isVideo,
                            onReady: _onReady,
                          ),
                        ),
                      ],
                    )
                  else if (!_hasCapturedMedia)
                    Column(
                      children: <Widget>[
                        CameraTopBar(
                          categoryIndex: widget.categoryIndex,
                          onClose: () => unawaited(_showExitConfirmation()),
                        ),
                        Expanded(
                          child: CameraCaptureControls(
                            isVideo: _isVideo,
                            isRecording: _isRecording,
                            isCapturing: _isCapturing,
                            showFlash: _showFlash,
                            recordingSeconds: _recordingSeconds,
                            onShutter: _onShutter,
                            onToggleFlash: _toggleFlash,
                            onToggleCamera: _toggleCamera,
                            accentColor: _accent,
                          ),
                        ),
                      ],
                    ),
                  if (_isInitializing && !_hasCapturedMedia)
                    const _LoadingOverlay(),
                  if (_error != null)
                    CameraErrorView(
                      error: _error,
                      onRetry: _initializeCamera,
                      onOpenSettings: _openSettings,
                      accentColor: _accent,
                      backgroundColor: _background,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) => const ColoredBox(
        color: Color(0xAA202330),
        child: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFFFD34D),
          ),
        ),
      );
}
