import 'package:flutter/services.dart';
import 'package:shipments/core/config/app_environment.dart';
import 'package:shipments/core/push/push_notification_handler.dart';
import 'package:shipments/core/routing/app_routes.dart';
import 'package:shipments/core/startup/startup_flow.dart';
import 'package:shipments/core/utils/app_constants.dart';
import 'package:shipments/injection.dart';
import 'package:shipments/screens/sample_feature/sample_feature_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const secureStorageChannel =
      MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
  const connectivityChannel =
      MethodChannel('dev.fluttercommunity.plus/connectivity');
  const connectivityEventChannel =
      MethodChannel('dev.fluttercommunity.plus/connectivity_status');
  final fakeSecureStorage = <String, String>{};

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{
      AppConstants.onboardingCompletedStorageKey: true,
    });
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(secureStorageChannel, (call) async {
      final args =
          (call.arguments as Map<dynamic, dynamic>?)?.cast<String, dynamic>() ??
              const <String, dynamic>{};
      final key = args['key'] as String?;

      switch (call.method) {
        case 'read':
          return key == null ? null : fakeSecureStorage[key];
        case 'write':
          if (key != null) {
            fakeSecureStorage[key] = args['value'] as String? ?? '';
          }
          return null;
        case 'delete':
          if (key != null) {
            fakeSecureStorage.remove(key);
          }
          return null;
        case 'containsKey':
          return key != null && fakeSecureStorage.containsKey(key);
        case 'readAll':
          return Map<String, String>.from(fakeSecureStorage);
        case 'deleteAll':
          fakeSecureStorage.clear();
          return null;
        default:
          return null;
      }
    });
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(connectivityChannel, (call) async {
      if (call.method == 'check') {
        return <String>['wifi'];
      }
      return null;
    });
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(connectivityEventChannel, (call) async {
      if (call.method == 'listen' || call.method == 'cancel') {
        return null;
      }
      return null;
    });
    AppEnvironment.initialize();
    await resetInjectionForTesting();
  });

  tearDown(() async {
    if (getIt.isRegistered<PushNotificationHandler>()) {
      await getIt<PushNotificationHandler>().dispose();
    }
    fakeSecureStorage.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(secureStorageChannel, null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(connectivityChannel, null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(connectivityEventChannel, null);
    await resetInjectionForTesting();
  });

  test('initializes and resolves critical dependencies', () async {
    await init();

    expect(getIt.isRegistered<GoRouter>(), isTrue);
    expect(getIt.isRegistered<StartupFlow>(), isTrue);
    expect(getIt.isRegistered<SampleFeatureViewModel>(), isTrue);

    final startupRoute = getIt<StartupFlow>().resolveInitialRoute();
    expect(startupRoute, AppRoutes.login);

    final vm = getIt<SampleFeatureViewModel>();
    expect(vm.items, isEmpty);
    vm.dispose();
  });
}
