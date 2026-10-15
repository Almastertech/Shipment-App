import 'package:shipments/core/state/ui_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UiState', () {
    test('initial state flags', () {
      const state = UiStateInitial<List<int>>();
      expect(state.isInitial, isTrue);
      expect(state.isLoading, isFalse);
    });

    test('content copyWith updates load flags', () {
      const state = UiStateContent<List<int>>(data: <int>[1, 2]);
      final next = state.copyWith(loadingMore: true);

      expect(next.loadingMore, isTrue);
      expect(next.data, <int>[1, 2]);
    });

    test('error state preserves message', () {
      const state = UiStateError<List<int>>(message: 'failed');
      expect(state.message, 'failed');
      expect(state.isError, isTrue);
    });
  });
}
