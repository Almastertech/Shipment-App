import 'dart:math';

import '../storage/secure_storage.dart';
import '../utils/app_constants.dart';

class DeviceIdService {
  DeviceIdService(this._secureStorage);

  final SecureStorage _secureStorage;
  String? _deviceId;

  Future<String> getOrCreate() async {
    final cached = _deviceId;
    if (cached != null && cached.isNotEmpty) return cached;

    final stored = await _secureStorage.read(
      key: AppConstants.deviceIdStorageKey,
    );
    if (stored != null && stored.isNotEmpty) {
      _deviceId = stored;
      return stored;
    }

    final generated = _generateUuidV4();
    await _secureStorage.write(
      key: AppConstants.deviceIdStorageKey,
      value: generated,
    );
    _deviceId = generated;
    return generated;
  }

  String _generateUuidV4() {
    final random = Random.secure();
    final bytes = List<int>.generate(
      16,
      (_) => random.nextInt(256),
      growable: false,
    );
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;

    final hex = bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0'));
    final value = hex.join();
    return '${value.substring(0, 8)}-${value.substring(8, 12)}-'
        '${value.substring(12, 16)}-${value.substring(16, 20)}-'
        '${value.substring(20)}';
  }
}
