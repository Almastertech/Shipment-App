import '../logger.dart';

abstract class SessionScopedDataPurger {
  Future<void> purgeUserScopedData();
}

class NoopSessionScopedDataPurger implements SessionScopedDataPurger {
  @override
  Future<void> purgeUserScopedData() async {}
}

typedef AsyncPurgeTask = Future<void> Function();
typedef SyncPurgeTask = void Function();

class CompositeSessionScopedDataPurger implements SessionScopedDataPurger {
  CompositeSessionScopedDataPurger({
    required this.stopBackgroundWork,
    required this.resumeBackgroundWork,
    required this.asyncTasks,
    this.syncTasks = const <SyncPurgeTask>[],
  });

  final AsyncPurgeTask stopBackgroundWork;
  final AsyncPurgeTask resumeBackgroundWork;
  final List<AsyncPurgeTask> asyncTasks;
  final List<SyncPurgeTask> syncTasks;

  Future<void>? _inFlight;

  @override
  Future<void> purgeUserScopedData() {
    return _inFlight ??= _purgeInternal().whenComplete(() {
      _inFlight = null;
    });
  }

  Future<void> _purgeInternal() async {
    await _runAsync(stopBackgroundWork, 'stop_background');

    for (final task in asyncTasks) {
      await _runAsync(task, 'async_task');
    }

    for (final task in syncTasks) {
      _runSync(task, 'sync_task');
    }

    await _runAsync(resumeBackgroundWork, 'resume_background');
  }

  Future<void> _runAsync(AsyncPurgeTask task, String tag) async {
    try {
      await task();
    } on Object catch (error, stackTrace) {
      AppLogger.error(
        'Session-scoped purge async task failed.',
        category: AppLogCategory.general,
        tag: tag,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _runSync(SyncPurgeTask task, String tag) {
    try {
      task();
    } on Object catch (error, stackTrace) {
      AppLogger.error(
        'Session-scoped purge sync task failed.',
        category: AppLogCategory.general,
        tag: tag,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
