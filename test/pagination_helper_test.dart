import 'package:shipments/core/utils/pagination_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaginationHelper', () {
    test('reset/load/consume updates page cursor', () {
      final pagination = PaginationHelper(pageSize: 20);

      expect(pagination.currentPage, 1);
      expect(pagination.hasMore, isTrue);

      pagination.startInitialLoad();
      pagination.consume(hasMore: true, itemCount: 20);

      expect(pagination.currentPage, 2);
      expect(pagination.state, PaginationState.idle);
    });

    test('beginLoadMore prevents duplicate concurrent loadMore', () {
      final pagination = PaginationHelper(pageSize: 10);

      final first = pagination.beginLoadMore();
      final second = pagination.beginLoadMore();

      expect(first, isTrue);
      expect(second, isFalse);

      pagination.completeRequest();
      expect(pagination.beginLoadMore(), isTrue);
    });

    test('supports offset mode cursor increment', () {
      final pagination = PaginationHelper(
        pageSize: 10,
        mode: PaginationMode.offset,
      );

      pagination.consume(hasMore: true, itemCount: 10);
      expect(pagination.currentOffset, 10);
    });

    test('prefetch threshold helper works', () {
      final pagination = PaginationHelper(pageSize: 20, prefetchThreshold: 100);

      expect(
        pagination.shouldPrefetch(currentPixels: 850, maxScrollExtent: 1000),
        isFalse,
      );
      expect(
        pagination.shouldPrefetch(currentPixels: 920, maxScrollExtent: 1000),
        isTrue,
      );
    });
  });
}
