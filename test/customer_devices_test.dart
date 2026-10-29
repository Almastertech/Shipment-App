import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/core/device/device_id_service.dart';
import 'package:shipments/core/push/customer_device_api.dart';
import 'package:shipments/core/push/customer_device_registration_service.dart';
import 'package:shipments/core/push/push_message.dart';
import 'package:shipments/core/push/push_notification_service.dart';
import 'package:shipments/core/session/session_manager.dart';
import 'package:shipments/core/storage/secure_storage.dart';
import 'package:shipments/data/app_urls/app_url.dart';
import 'package:shipments/data/datasource/remote/customer_devices_data_source.dart';
import 'package:shipments/data/datasource/remote/dio/dio_client.dart';

void main() {
  test('registration sends body and required device header to API', () async {
    final client = _RecordingDioClient();
    final source = CustomerDevicesDataSource(client);

    await source.register(
      deviceId: 'opaque-id',
      pushToken: 'push-token',
      platform: 'android',
      appVersion: '2.4.1',
    );

    expect(client.path, AppUrl.customerDevices);
    expect(client.data, <String, dynamic>{
      'push_token': 'push-token',
      'platform': 'android',
      'app_version': '2.4.1',
    });
    expect(client.options?.headers?['X-Device-Id'], 'opaque-id');
  });

  test('revocation calls current-device endpoint with device header', () async {
    final client = _RecordingDioClient();
    final source = CustomerDevicesDataSource(client);

    await source.revokeCurrent(deviceId: 'opaque-id');

    expect(client.path, AppUrl.currentCustomerDevice);
    expect(client.options?.headers?['X-Device-Id'], 'opaque-id');
  });

  test('registration and revocation require an authenticated session',
      () async {
    final storage = InMemorySecureStorage();
    final session = SessionManager(secureStorage: storage);
    await session.initialize();
    final api = _RecordingDeviceApi();
    final service = CustomerDeviceRegistrationService(
      deviceApi: api,
      deviceIdService: DeviceIdService(storage),
      pushService: _FakePushService(),
      sessionManager: session,
      appVersionProvider: () async => '2.4.1',
      platformProvider: () => 'ios',
    );

    await service.registerCurrentDevice();
    await service.unregisterCurrentDevice();
    expect(api.registeredToken, isNull);
    expect(api.revokedDeviceId, isNull);

    await session.saveTokens(accessToken: 'access');
    await service.registerCurrentDevice();
    await service.unregisterCurrentDevice();

    expect(api.registeredToken, 'push-token');
    expect(api.registeredPlatform, 'ios');
    expect(api.registeredAppVersion, '2.4.1');
    expect(api.revokedDeviceId, isNotEmpty);
    session.dispose();
  });
}

class _RecordingDioClient implements DioClient {
  String? path;
  Object? data;
  Options? options;

  @override
  Future<Response<dynamic>> post(
    String requestPath, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    path = requestPath;
    this.data = data;
    this.options = options;
    return Response<dynamic>(
      requestOptions: RequestOptions(path: requestPath),
      statusCode: 204,
    );
  }

  @override
  Future<Response<dynamic>> delete(
    String requestPath, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    path = requestPath;
    this.data = data;
    this.options = options;
    return Response<dynamic>(
      requestOptions: RequestOptions(path: requestPath),
      statusCode: 204,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _RecordingDeviceApi implements CustomerDeviceApi {
  String? registeredToken;
  String? registeredPlatform;
  String? registeredAppVersion;
  String? revokedDeviceId;

  @override
  Future<void> registerDevice({
    required String deviceId,
    required String pushToken,
    required String platform,
    required String appVersion,
  }) async {
    registeredToken = pushToken;
    registeredPlatform = platform;
    registeredAppVersion = appVersion;
  }

  @override
  Future<void> revokeCurrentDevice({required String deviceId}) async {
    revokedDeviceId = deviceId;
  }
}

class _FakePushService implements PushNotificationService {
  @override
  Future<String?> getDeviceToken() async => 'push-token';

  @override
  Future<void> initialize() async {}

  @override
  Stream<String> get onDeviceTokenChanged => const Stream<String>.empty();

  @override
  Stream<PushMessage> get onMessageOpenedApp =>
      const Stream<PushMessage>.empty();

  @override
  Stream<PushMessage> get onMessageReceived =>
      const Stream<PushMessage>.empty();

  @override
  Future<void> subscribeToTopic(String topic) async {}

  @override
  Future<void> unsubscribeFromTopic(String topic) async {}
}
