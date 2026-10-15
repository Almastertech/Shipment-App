import 'package:shipments/core/refresh/pull_to_refresh_contract.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PullToRefreshContract', () {
    test('skips while initial loading', () async {
      final decision = PullToRefreshContract.evaluate(
        isInitialLoading: true,
        isLoadingMore: false,
      );

      expect(decision.shouldRun, isFalse);
      expect(decision.skipReason, PullToRefreshSkipReason.initialLoading);
    });

    test('skips while loading more', () async {
      final decision = PullToRefreshContract.evaluate(
        isInitialLoading: false,
        isLoadingMore: true,
      );

      expect(decision.shouldRun, isFalse);
      expect(decision.skipReason, PullToRefreshSkipReason.loadingMore);
    });

    test('runs refresh when allowed', () async {
      var called = false;
      final decision = await PullToRefreshContract.run(
        isInitialLoading: false,
        isLoadingMore: false,
        refreshAction: () async {
          called = true;
        },
      );

      expect(decision.shouldRun, isTrue);
      expect(called, isTrue);
    });
  });
}
