import 'dart:ui';

class AppConstants {
  static const String defaultLanguageCode = 'ar';
  static const Locale defaultLocale = Locale('ar');
  static const String localeStorageKey = 'app_locale';
  static const String themeModeStorageKey = 'theme_mode';
  static const String onboardingCompletedStorageKey = 'onboarding_completed';
  static const String cameraPermissionGrantedStorageKey =
      'camera_permission_granted';
  static const String cameraGuideSeenStorageKey = 'camera_capture_guide_seen';
  static const String authTokenStorageKey = 'auth_token';
  static const String refreshTokenStorageKey = 'refresh_token';
  static const String deviceIdStorageKey = 'device_id';
  static const String guestSessionStorageKey = 'guest_session';
  static const String inAppNotificationsStorageKey = 'in_app_notifications';
  static const String searchHistoryStorageKey = 'search_history_queries';
  static const String recentViewedItemsStorageKey = 'search_recent_items';
  static const int defaultPageSize = 20;
  static const int memoryCacheMaxEntries = 300;
  static const int inAppNotificationsMaxItems = 100;
}
