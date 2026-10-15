import 'package:logger/logger.dart';

enum AppLogLevel { debug, info, warning, error }

enum AppLogCategory {
  general,
  network,
  auth,
  cache,
  queue,
  analytics,
  routing,
  ui,
}

class AppLogger {
  static bool enabled = true;
  static bool includeDebugLogs = true;
  static Duration repeatedMuteWindow = const Duration(milliseconds: 1200);
  static int maxSuppressedEntries = 500;

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
    ),
  );

  static final Map<String, DateTime> _lastPrintedAt = <String, DateTime>{};
  static final Map<String, int> _suppressedCount = <String, int>{};

  static void configure({
    required bool isEnabled,
    required bool allowDebug,
    Duration? muteWindow,
  }) {
    enabled = isEnabled;
    includeDebugLogs = allowDebug;
    if (muteWindow != null) {
      repeatedMuteWindow = muteWindow;
    }
  }

  static void debug(
    String message, {
    AppLogCategory category = AppLogCategory.general,
    String? tag,
  }) {
    _log(
      AppLogLevel.debug,
      message,
      category: category,
      tag: tag,
    );
  }

  static void info(
    String message, {
    AppLogCategory category = AppLogCategory.general,
    String? tag,
  }) {
    _log(
      AppLogLevel.info,
      message,
      category: category,
      tag: tag,
    );
  }

  static void warning(
    String message, {
    AppLogCategory category = AppLogCategory.general,
    String? tag,
  }) {
    _log(
      AppLogLevel.warning,
      message,
      category: category,
      tag: tag,
    );
  }

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    AppLogCategory category = AppLogCategory.general,
    String? tag,
  }) {
    _log(
      AppLogLevel.error,
      message,
      category: category,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void _log(
    AppLogLevel level,
    String message, {
    required AppLogCategory category,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!enabled) return;
    if (level == AppLogLevel.debug && !includeDebugLogs) return;

    final key = '${level.name}|${category.name}|$message';
    final now = DateTime.now();
    final last = _lastPrintedAt[key];

    if (last != null && now.difference(last) < repeatedMuteWindow) {
      _suppressedCount[key] = (_suppressedCount[key] ?? 0) + 1;
      return;
    }

    final suppressed = _suppressedCount.remove(key);
    if (suppressed != null && suppressed > 0) {
      _dispatch(
        AppLogLevel.debug,
        '[${category.name}] Suppressed $suppressed repeated logs.',
      );
    }

    _lastPrintedAt[key] = now;
    _pruneSuppressedMaps();

    final prefix =
        tag == null ? '[${category.name}] ' : '[${category.name}][$tag] ';
    _dispatch(
      level,
      '$prefix$message',
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void _dispatch(
    AppLogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    switch (level) {
      case AppLogLevel.debug:
        _logger.d(message);
        return;
      case AppLogLevel.info:
        _logger.i(message);
        return;
      case AppLogLevel.warning:
        _logger.w(message);
        return;
      case AppLogLevel.error:
        _logger.e(message, error: error, stackTrace: stackTrace);
        return;
    }
  }

  static void _pruneSuppressedMaps() {
    if (_lastPrintedAt.length <= maxSuppressedEntries) {
      return;
    }

    final overflow = _lastPrintedAt.length - maxSuppressedEntries;
    final oldestEntries = _lastPrintedAt.entries.toList(growable: false)
      ..sort(
        (a, b) => a.value.compareTo(b.value),
      );

    for (var i = 0; i < overflow; i++) {
      final key = oldestEntries[i].key;
      _lastPrintedAt.remove(key);
      _suppressedCount.remove(key);
    }
  }
}
