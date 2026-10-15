import 'package:shipments/core/monitoring/in_memory_api_monitoring_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InMemoryApiMonitoringService', () {
    test('records successful request and appears in recent/slowest', () {
      final service = InMemoryApiMonitoringService(maxRecords: 10);
      final startedAt = DateTime(2026, 1, 1, 0, 0, 0);

      service.onRequestStarted(
        requestId: 'r1',
        method: 'GET',
        path: '/items',
        startedAt: startedAt,
      );
      service.onRequestCompleted(
        requestId: 'r1',
        statusCode: 200,
        completedAt: startedAt.add(const Duration(milliseconds: 240)),
      );

      expect(service.recent(), hasLength(1));
      expect(service.recent().first.isSuccess, isTrue);
      expect(service.slowest().first.duration.inMilliseconds, 240);
    });

    test('records failed requests', () {
      final service = InMemoryApiMonitoringService(maxRecords: 10);
      final startedAt = DateTime(2026, 1, 1, 0, 0, 0);

      service.onRequestStarted(
        requestId: 'r2',
        method: 'POST',
        path: '/submit',
        startedAt: startedAt,
      );
      service.onRequestFailed(
        requestId: 'r2',
        statusCode: 500,
        errorType: 'badResponse',
        completedAt: startedAt.add(const Duration(milliseconds: 100)),
      );

      expect(service.failed(), hasLength(1));
      expect(service.failed().first.statusCode, 500);
      expect(service.failed().first.errorType, 'badResponse');
    });

    test('respects max record cap', () {
      final service = InMemoryApiMonitoringService(maxRecords: 2);
      final base = DateTime(2026, 1, 1, 0, 0, 0);

      for (var i = 0; i < 3; i++) {
        service.onRequestStarted(
          requestId: 'r$i',
          method: 'GET',
          path: '/$i',
          startedAt: base,
        );
        service.onRequestCompleted(
          requestId: 'r$i',
          statusCode: 200,
          completedAt: base.add(Duration(milliseconds: i + 1)),
        );
      }

      expect(service.recent(), hasLength(2));
    });
  });
}
