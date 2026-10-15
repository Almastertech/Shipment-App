enum PaginationMode {
  page,
  offset,
}

enum PaginationState {
  idle,
  initialLoading,
  refreshing,
  loadingMore,
  error,
}

class PaginationHelper {
  PaginationHelper({
    required this.pageSize,
    this.mode = PaginationMode.page,
    this.prefetchThreshold = 180,
  });

  final int pageSize;
  final PaginationMode mode;
  final double prefetchThreshold;

  int _currentPage = 1;
  int _currentOffset = 0;
  bool _hasMore = true;
  PaginationState _state = PaginationState.idle;

  int get currentPage => _currentPage;
  int get currentOffset => _currentOffset;
  bool get hasMore => _hasMore;
  PaginationState get state => _state;

  bool get canLoadMore =>
      _hasMore &&
      _state != PaginationState.loadingMore &&
      _state != PaginationState.initialLoading;

  bool get isLoadingMore => _state == PaginationState.loadingMore;

  void startInitialLoad() {
    _state = PaginationState.initialLoading;
  }

  void startRefresh() {
    _state = PaginationState.refreshing;
  }

  bool beginLoadMore() {
    if (!canLoadMore) {
      return false;
    }
    _state = PaginationState.loadingMore;
    return true;
  }

  void completeRequest() {
    _state = PaginationState.idle;
  }

  void markError() {
    _state = PaginationState.error;
  }

  void reset() {
    _currentPage = 1;
    _currentOffset = 0;
    _hasMore = true;
    _state = PaginationState.idle;
  }

  void consume({required bool hasMore, required int itemCount}) {
    _hasMore = hasMore;

    if (_hasMore && itemCount > 0) {
      switch (mode) {
        case PaginationMode.page:
          _currentPage += 1;
        case PaginationMode.offset:
          _currentOffset += itemCount;
      }
    }

    if (_state != PaginationState.error) {
      _state = PaginationState.idle;
    }
  }

  bool shouldPrefetch({
    required double currentPixels,
    required double maxScrollExtent,
    double? threshold,
  }) {
    final effectiveThreshold = threshold ?? prefetchThreshold;
    return currentPixels >= maxScrollExtent - effectiveThreshold;
  }
}
