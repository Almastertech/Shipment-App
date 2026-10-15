import '../logger.dart';

enum AppFlavor { dev, staging, prod }

class AppEnvironment {
  AppEnvironment._({
    required this.flavor,
    required this.baseUrl,
    required this.enableLogging,
    required this.allowDebugLogs,
    required this.useMockApi,
  });

  final AppFlavor flavor;
  final String baseUrl;
  final bool enableLogging;
  final bool allowDebugLogs;
  final bool useMockApi;

  static AppEnvironment? _instance;

  static AppEnvironment get instance {
    final value = _instance;
    if (value == null) {
      throw StateError('AppEnvironment.initialize() must be called first.');
    }
    return value;
  }

  static const Set<String> _placeholderHosts = <String>{
    'example.com',
    'dev.example.com',
    'staging.example.com',
  };

  static void initialize() {
    if (_instance != null) {
      return;
    }

    const rawEnv = String.fromEnvironment('ENV', defaultValue: 'dev');
    const baseUrlOverride = String.fromEnvironment('API_BASE_URL');
    const logOverride = String.fromEnvironment('ENABLE_LOGS');
    const mockOverride = String.fromEnvironment('USE_MOCK_API');

    final flavor = switch (rawEnv.toLowerCase()) {
      'staging' => AppFlavor.staging,
      'prod' || 'production' => AppFlavor.prod,
      _ => AppFlavor.dev,
    };

    final fallbackBaseUrl = switch (flavor) {
      AppFlavor.dev => 'https://dev.example.com/api',
      AppFlavor.staging => 'https://staging.example.com/api',
      AppFlavor.prod => 'https://example.com/api',
    };

    final enableLogging = logOverride.isNotEmpty
        ? logOverride.toLowerCase() == 'true'
        : flavor != AppFlavor.prod;
    final allowDebugLogs = enableLogging && flavor != AppFlavor.prod;

    final useMockApi = mockOverride.isNotEmpty
        ? mockOverride.toLowerCase() == 'true'
        : flavor == AppFlavor.dev;
    final resolvedBaseUrl =
        baseUrlOverride.isNotEmpty ? baseUrlOverride : fallbackBaseUrl;

    if (flavor == AppFlavor.prod && _usesPlaceholderHost(resolvedBaseUrl)) {
      throw StateError(
        'ENV=prod requires a real API_BASE_URL. '
        'Current value "$resolvedBaseUrl" is a template placeholder.',
      );
    }

    _instance = AppEnvironment._(
      flavor: flavor,
      baseUrl: resolvedBaseUrl,
      enableLogging: enableLogging,
      allowDebugLogs: allowDebugLogs,
      useMockApi: useMockApi,
    );

    AppLogger.configure(
      isEnabled: _instance!.enableLogging,
      allowDebug: _instance!.allowDebugLogs,
    );
  }

  static bool _usesPlaceholderHost(String rawUrl) {
    final uri = Uri.tryParse(rawUrl);
    final host = uri?.host.toLowerCase() ?? '';
    return _placeholderHosts.contains(host);
  }
}
