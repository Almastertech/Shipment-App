import 'package:shipments/core/network/request_deduplicator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RequestDeduplicator', () {
    late RequestDeduplicator deduplicator;

    setUp(() {
      deduplicator = RequestDeduplicator();
    });

    test('two calls with same key trigger only one execution', () async {
      var callCount = 0;

      Future<String> request() async {
        callCount++;
        await Future<void>.delayed(const Duration(milliseconds: 50));
        return 'result';
      }

      final future1 = deduplicator.deduplicate('key1', request);
      final future2 = deduplicator.deduplicate('key1', request);

      final results = await Future.wait(<Future<String>>[future1, future2]);

      expect(callCount, 1, reason: 'Request should only execute once');
      expect(results, <String>['result', 'result']);
    });

    test('different keys trigger separate executions', () async {
      var callCount = 0;

      Future<String> request() async {
        callCount++;
        return 'result';
      }

      await Future.wait(<Future<String>>[
        deduplicator.deduplicate('key1', request),
        deduplicator.deduplicate('key2', request),
      ]);

      expect(callCount, 2);
    });

    test('key is cleaned up after completion', () async {
      await deduplicator.deduplicate('key1', () async => 'done');

      expect(deduplicator.activeCount, 0);

      // A new call with the same key should execute again
      var secondCallExecuted = false;
      await deduplicator.deduplicate('key1', () async {
        secondCallExecuted = true;
        return 'done again';
      });

      expect(secondCallExecuted, isTrue);
    });

    test('key is cleaned up after error', () async {
      try {
        await deduplicator.deduplicate<String>('key1', () async {
          throw Exception('test error');
        });
      } catch (_) {
        // expected
      }

      expect(deduplicator.activeCount, 0);
    });

    test('error propagates to all waiters', () async {
      Future<String> failingRequest() async {
        await Future<void>.delayed(const Duration(milliseconds: 10));
        throw Exception('shared failure');
      }

      final future1 = deduplicator.deduplicate('key1', failingRequest);
      final future2 = deduplicator.deduplicate('key1', failingRequest);

      expect(future1, throwsException);
      expect(future2, throwsException);
    });
  });
}
