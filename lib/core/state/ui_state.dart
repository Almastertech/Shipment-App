sealed class UiState<T> {
  const UiState();

  bool get isInitial => this is UiStateInitial<T>;
  bool get isLoading => this is UiStateLoading<T>;
  bool get isContent => this is UiStateContent<T>;
  bool get isEmpty => this is UiStateEmpty<T>;
  bool get isError => this is UiStateError<T>;
}

class UiStateInitial<T> extends UiState<T> {
  const UiStateInitial();
}

class UiStateLoading<T> extends UiState<T> {
  const UiStateLoading({
    this.previousData,
    this.refreshing = false,
    this.loadingMore = false,
  });

  final T? previousData;
  final bool refreshing;
  final bool loadingMore;
}

class UiStateContent<T> extends UiState<T> {
  const UiStateContent({
    required this.data,
    this.refreshing = false,
    this.loadingMore = false,
  });

  final T data;
  final bool refreshing;
  final bool loadingMore;

  UiStateContent<T> copyWith({
    T? data,
    bool? refreshing,
    bool? loadingMore,
  }) {
    return UiStateContent<T>(
      data: data ?? this.data,
      refreshing: refreshing ?? this.refreshing,
      loadingMore: loadingMore ?? this.loadingMore,
    );
  }
}

class UiStateEmpty<T> extends UiState<T> {
  const UiStateEmpty();
}

class UiStateError<T> extends UiState<T> {
  const UiStateError({
    required this.message,
    this.error,
    this.previousData,
  });

  final String message;
  final Object? error;
  final T? previousData;
}
