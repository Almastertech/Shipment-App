enum CameraMediaType { photo, video }

class CameraCaptureRequest {
  const CameraCaptureRequest({
    required this.mediaType,
    required this.categoryIndex,
  });

  final CameraMediaType mediaType;
  final int categoryIndex;
}

abstract class CameraCaptureService {
  bool get hasPreviouslyGrantedCameraPermission;
  bool get hasSeenCameraGuide;

  Future<bool> requestCameraAccess();
  Future<void> markCameraGuideSeen();
  Future<void> saveCameraPermissionGranted();
}
