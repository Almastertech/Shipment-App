import 'package:camera/camera.dart';

import '../storage/local_storage.dart';
import '../utils/app_constants.dart';
import 'camera_capture_service.dart';

class ImagePickerCameraService implements CameraCaptureService {
  ImagePickerCameraService({required LocalStorage localStorage})
      : _localStorage = localStorage;

  final LocalStorage _localStorage;

  @override
  bool get hasPreviouslyGrantedCameraPermission =>
      _localStorage.getBool(AppConstants.cameraPermissionGrantedStorageKey) ??
      false;

  @override
  bool get hasSeenCameraGuide =>
      _localStorage.getBool(AppConstants.cameraGuideSeenStorageKey) ?? false;

  @override
  Future<void> saveCameraPermissionGranted() => _localStorage.setBool(
        AppConstants.cameraPermissionGrantedStorageKey,
        true,
      );

  @override
  Future<void> markCameraGuideSeen() => _localStorage.setBool(
        AppConstants.cameraGuideSeenStorageKey,
        true,
      );

  @override
  Future<bool> requestCameraAccess() async {
    CameraController? controller;
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) throw CameraException('NoCameraAvailable', '');
      final camera = cameras.firstWhere(
        (item) => item.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      controller = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await controller.initialize();
      await saveCameraPermissionGranted();
      return true;
    } finally {
      await controller?.dispose();
    }
  }
}
