class AppRemoteConfig {
  const AppRemoteConfig();

  static const double defaultMinOrderAmount = 10;
  static const double defaultFreeDeliveryThreshold = 50;
  static const int defaultPageSize = 20;
  static const int defaultRetryMaxAttempts = 3;
  static const int defaultNetworkRateLimitMaxRequests = 4;
  static const int defaultNetworkRateLimitWindowMs = 2000;

  double get minOrderAmount => defaultMinOrderAmount;

  double get freeDeliveryThreshold => defaultFreeDeliveryThreshold;

  int get pageSize => defaultPageSize;

  int get retryMaxAttempts => defaultRetryMaxAttempts;

  int get networkRateLimitMaxRequests => defaultNetworkRateLimitMaxRequests;

  Duration get networkRateLimitWindow =>
      const Duration(milliseconds: defaultNetworkRateLimitWindowMs);
}
