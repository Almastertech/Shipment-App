import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/feedback/toast_service.dart';
import 'components/layout/bottom_sheet_service.dart';
import 'core/cache/cache_store.dart';
import 'core/config/app_environment.dart';
import 'core/config/app_remote_config.dart';
import 'core/camera/image_picker_camera_service.dart';
import 'core/camera/camera_capture_service.dart';
import 'core/monitoring/api_monitoring_service.dart';
import 'core/monitoring/in_memory_api_monitoring_service.dart';
import 'core/location/geolocator_location_service.dart';
import 'core/location/location_service.dart';
import 'core/network/network_rate_limiter.dart';
import 'core/network/request_deduplicator.dart';
import 'core/network_info.dart';
import 'core/permissions/permission_service.dart';
import 'core/permissions/geolocator_permission_service.dart';
import 'core/push/noop_push_notification_service.dart';
import 'core/push/push_notification_handler.dart';
import 'core/push/push_notification_service.dart';
import 'core/routing/app_router.dart';
import 'core/search/search_history_service.dart';
import 'core/session/auth_action_guard.dart';
import 'core/session/session_expiry_handler.dart';
import 'core/session/session_manager.dart';
import 'core/session/session_scoped_data_purger.dart';
import 'core/startup/startup_flow.dart';
import 'core/storage/local_storage.dart';
import 'core/storage/prefs_storage.dart';
import 'core/storage/secure_storage.dart';
import 'core/utils/app_constants.dart';
import 'data/datasource/remote/dio/api_monitoring_interceptor.dart';
import 'data/datasource/remote/dio/api_token_refresher.dart';
import 'data/datasource/remote/dio/auth_interceptor.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/datasource/remote/dio/rate_limit_interceptor.dart';
import 'data/datasource/remote/dio/retry_interceptor.dart';
import 'data/datasource/remote/sample_feature_data_source.dart';
import 'data/repository/sample_feature_repo.dart';
import 'features/notifications/application/in_app_notification_center.dart';
import 'localization/controllers/localization_controller.dart';
import 'screens/sample_feature/sample_feature_details_view_model.dart';
import 'screens/sample_feature/sample_feature_view_model.dart';
import 'themes/theme_controller.dart';

final getIt = GetIt.instance;
bool _initialized = false;
Future<void>? _initializationFuture;

Future<void> init() {
  if (_initialized) {
    return Future<void>.value();
  }

  return _initializationFuture ??= _initInternal();
}

Future<void> _initInternal() async {
  try {
    final sharedPreferences = await SharedPreferences.getInstance();

    // Core services
    getIt.registerLazySingleton<InMemoryApiMonitoringService>(
      InMemoryApiMonitoringService.new,
    );
    getIt.registerLazySingleton<ApiMonitoringService>(
      () => getIt<InMemoryApiMonitoringService>(),
    );
    getIt.registerLazySingleton<PermissionService>(
      GeolocatorPermissionService.new,
    );
    getIt.registerLazySingleton<LocationService>(
      GeolocatorLocationService.new,
    );
    getIt.registerLazySingleton<CameraCaptureService>(
      () => ImagePickerCameraService(localStorage: getIt<LocalStorage>()),
    );
    getIt.registerLazySingleton<PushNotificationService>(
      NoopPushNotificationService.new,
    );

    // Storage
    getIt.registerSingleton<SharedPreferences>(sharedPreferences);
    getIt.registerLazySingleton<LocalStorage>(
      () => PrefsStorage(getIt<SharedPreferences>()),
    );
    getIt.registerLazySingleton<SecureStorage>(FlutterSecureStorageService.new);
    getIt.registerLazySingleton<SearchHistoryService>(
      () => SearchHistoryService(
        storage: getIt<LocalStorage>(),
        queryStorageKey: AppConstants.searchHistoryStorageKey,
        recentItemStorageKey: AppConstants.recentViewedItemsStorageKey,
      ),
    );
    await getIt<SearchHistoryService>().initialize();

    getIt.registerLazySingleton<AppRemoteConfig>(
      AppRemoteConfig.new,
    );

    // Session and startup
    getIt.registerLazySingleton<SessionScopedDataPurger>(
      () => CompositeSessionScopedDataPurger(
        stopBackgroundWork: () async {},
        asyncTasks: <AsyncPurgeTask>[
          () async {
            if (getIt.isRegistered<SearchHistoryService>()) {
              await getIt<SearchHistoryService>().clearQueries();
              await getIt<SearchHistoryService>().clearRecentItems();
              return;
            }
            await getIt<LocalStorage>().remove(
              AppConstants.searchHistoryStorageKey,
            );
            await getIt<LocalStorage>().remove(
              AppConstants.recentViewedItemsStorageKey,
            );
          },
          () async {
            if (getIt.isRegistered<InAppNotificationCenter>()) {
              await getIt<InAppNotificationCenter>().clear();
              return;
            }
            await getIt<LocalStorage>().remove(
              AppConstants.inAppNotificationsStorageKey,
            );
          },
        ],
        syncTasks: <SyncPurgeTask>[
          () {
            if (getIt.isRegistered<CacheStore>()) {
              getIt<CacheStore>().clear();
            }
          },
        ],
        resumeBackgroundWork: () async {},
      ),
    );

    getIt.registerLazySingleton<SessionManager>(
      () => SessionManager(
        secureStorage: getIt<SecureStorage>(),
        sessionScopedDataPurger: getIt<SessionScopedDataPurger>(),
      ),
    );
    await getIt<SessionManager>().initialize();
    getIt.registerLazySingleton<AuthActionGuard>(
      () => AuthActionGuard(sessionManager: getIt<SessionManager>()),
    );

    getIt.registerLazySingleton<AppRouter>(
      () => AppRouter(
        sessionManager: getIt<SessionManager>(),
      ),
    );
    getIt.registerLazySingleton<GoRouter>(() => getIt<AppRouter>().router);

    getIt.registerLazySingleton<SessionExpiryHandler>(
      () => NavigationSessionExpiryHandler(
        router: getIt<GoRouter>(),
      ),
    );
    getIt.registerLazySingleton<StartupFlow>(
      () => StartupFlow(
        sessionManager: getIt<SessionManager>(),
        localStorage: getIt<LocalStorage>(),
      ),
    );

    // Networking
    getIt.registerLazySingleton<Connectivity>(Connectivity.new);
    getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfo(getIt<Connectivity>()),
    );
    getIt.registerLazySingleton<RequestDeduplicator>(RequestDeduplicator.new);
    getIt.registerLazySingleton<NetworkRateLimiter>(
      () => NetworkRateLimiter(
        maxRequests: getIt<AppRemoteConfig>().networkRateLimitMaxRequests,
        window: getIt<AppRemoteConfig>().networkRateLimitWindow,
      ),
    );

    getIt.registerLazySingleton<Dio>(Dio.new);
    getIt.registerLazySingleton<TokenRefresher>(
      () => ApiTokenRefresher(dio: getIt<Dio>()),
    );
    getIt.registerLazySingleton<AuthInterceptor>(
      () => AuthInterceptor(
        dio: getIt<Dio>(),
        sessionManager: getIt<SessionManager>(),
        tokenRefresher: getIt<TokenRefresher>(),
        sessionExpiryHandler: getIt<SessionExpiryHandler>(),
      ),
    );
    getIt.registerLazySingleton<RetryInterceptor>(
      () => RetryInterceptor(
        dio: getIt<Dio>(),
        retries: getIt<AppRemoteConfig>().retryMaxAttempts,
      ),
    );
    getIt.registerLazySingleton<RateLimitInterceptor>(
      () => RateLimitInterceptor(limiter: getIt<NetworkRateLimiter>()),
    );
    getIt.registerLazySingleton<LoggingInterceptor>(
      () => LoggingInterceptor(enabled: AppEnvironment.instance.enableLogging),
    );
    getIt.registerLazySingleton<ApiMonitoringInterceptor>(
      () => ApiMonitoringInterceptor(
        monitoringService: getIt<ApiMonitoringService>(),
      ),
    );

    getIt.registerLazySingleton<DioClient>(
      () => DioClient(
        baseUrl: AppEnvironment.instance.baseUrl,
        dio: getIt<Dio>(),
        authInterceptor: getIt<AuthInterceptor>(),
        apiMonitoringInterceptor: getIt<ApiMonitoringInterceptor>(),
        loggingInterceptor: getIt<LoggingInterceptor>(),
        retryInterceptor: getIt<RetryInterceptor>(),
        rateLimitInterceptor: getIt<RateLimitInterceptor>(),
        sessionManager: getIt<SessionManager>(),
        deduplicator: getIt<RequestDeduplicator>(),
      ),
    );

    // Cache
    getIt.registerLazySingleton<CacheStore>(
      () => MemoryCacheStore(maxEntries: AppConstants.memoryCacheMaxEntries),
    );

    // Notifications and global toast
    getIt.registerLazySingleton<InAppNotificationCenter>(
      () => InAppNotificationCenter(
        storage: getIt<LocalStorage>(),
        storageKey: AppConstants.inAppNotificationsStorageKey,
        maxItems: AppConstants.inAppNotificationsMaxItems,
      ),
    );
    await getIt<InAppNotificationCenter>().initialize();

    getIt.registerLazySingleton<ToastService>(
      () => OverlayToastService(navigatorKey: rootNavigatorKey),
    );
    getIt.registerLazySingleton<AppBottomSheetService>(
      () => BottomSheetService(navigatorKey: rootNavigatorKey),
    );
    getIt.registerLazySingleton<PushNotificationHandler>(
      () => PushNotificationHandler(
        service: getIt<PushNotificationService>(),
        router: getIt<GoRouter>(),
        notificationCenter: getIt<InAppNotificationCenter>(),
      ),
    );
    await getIt<PushNotificationHandler>().initialize();

    // Data layer
    getIt.registerLazySingleton<SampleFeatureDataSource>(() {
      final environment = AppEnvironment.instance;
      final allowMockDataSource =
          environment.useMockApi && environment.flavor != AppFlavor.prod;

      if (allowMockDataSource) {
        return MockSampleFeatureDataSource();
      }
      return NetworkSampleFeatureDataSource(getIt<DioClient>());
    });

    getIt.registerLazySingleton<SampleFeatureRepository>(
      () => SampleFeatureRepositoryImpl(
        getIt<SampleFeatureDataSource>(),
        cacheStore: getIt<CacheStore>(),
      ),
    );

    // Controllers
    getIt.registerLazySingleton(
      () => ThemeController(
        storage: getIt<LocalStorage>(),
      ),
    );
    getIt.registerLazySingleton(
      () => LocalizationController(
        storage: getIt<LocalStorage>(),
        dioClient: getIt<DioClient>(),
      ),
    );

    // Feature VMs
    getIt.registerFactory(
      () => SampleFeatureViewModel(
        repository: getIt<SampleFeatureRepository>(),
        remoteConfig: getIt<AppRemoteConfig>(),
        notificationCenter: getIt<InAppNotificationCenter>(),
        searchHistoryService: getIt<SearchHistoryService>(),
      ),
    );
    getIt.registerFactoryParam<SampleFeatureDetailsViewModel, String, Object?>(
      (itemId, _) => SampleFeatureDetailsViewModel(
        repository: getIt<SampleFeatureRepository>(),
        itemId: itemId,
      ),
    );
    _initialized = true;
  } catch (error) {
    _initialized = false;
    _initializationFuture = null;
    await getIt.reset();
    rethrow;
  }
}

@visibleForTesting
Future<void> resetInjectionForTesting() async {
  _initialized = false;
  _initializationFuture = null;
  await getIt.reset();
}
