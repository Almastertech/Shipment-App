import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/config/app_remote_config.dart';
import '../../core/search/search_history_service.dart';
import '../../core/state/ui_state.dart';
import '../../core/utils/debouncer.dart';
import '../../core/utils/pagination_helper.dart';
import '../../data/datasource/remote/exception/api_error.dart';
import '../../data/model/sample_item.dart';
import '../../data/repository/sample_feature_repo.dart';
import '../../features/notifications/application/in_app_notification_center.dart';
import '../../features/notifications/domain/in_app_notification.dart';

enum SampleFeatureState { initial, loading, success, empty, error }

class SampleFeatureViewModel extends ChangeNotifier {
  SampleFeatureViewModel({
    required SampleFeatureRepository repository,
    required AppRemoteConfig remoteConfig,
    required InAppNotificationCenter notificationCenter,
    required SearchHistoryService searchHistoryService,
  })  : _repository = repository,
        _remoteConfig = remoteConfig,
        _notificationCenter = notificationCenter,
        _searchHistoryService = searchHistoryService,
        _pagination = PaginationHelper(pageSize: remoteConfig.pageSize);

  final SampleFeatureRepository _repository;
  final AppRemoteConfig _remoteConfig;
  final InAppNotificationCenter _notificationCenter;
  final SearchHistoryService _searchHistoryService;

  final Debouncer _searchDebouncer = Debouncer(milliseconds: 350);
  final PaginationHelper _pagination;

  final TextEditingController searchController = TextEditingController();

  final List<SampleItem> _items = <SampleItem>[];

  UiState<List<SampleItem>> _uiState = const UiStateInitial<List<SampleItem>>();

  List<SampleItem> get items => List<SampleItem>.unmodifiable(_items);
  UiState<List<SampleItem>> get uiState => _uiState;

  SampleFeatureState get state {
    if (_uiState is UiStateInitial<List<SampleItem>>) {
      return SampleFeatureState.initial;
    }
    if (_uiState is UiStateLoading<List<SampleItem>>) {
      return _items.isEmpty
          ? SampleFeatureState.loading
          : SampleFeatureState.success;
    }
    if (_uiState is UiStateEmpty<List<SampleItem>>) {
      return SampleFeatureState.empty;
    }
    if (_uiState is UiStateError<List<SampleItem>>) {
      return _items.isEmpty
          ? SampleFeatureState.error
          : SampleFeatureState.success;
    }
    return SampleFeatureState.success;
  }

  String? get errorMessage {
    final state = _uiState;
    if (state is UiStateError<List<SampleItem>>) {
      return state.message;
    }
    return null;
  }

  ApiError? _lastError;
  ApiError? get lastError => _lastError;

  bool get isRefreshing => _isUiStateRefreshing(_uiState);
  bool get isLoadingMore => _isUiStateLoadingMore(_uiState);

  String _query = '';
  bool _initialized = false;
  int _requestVersion = 0;

  bool get isLoading =>
      _uiState is UiStateLoading<List<SampleItem>> &&
      !isRefreshing &&
      !isLoadingMore &&
      _items.isEmpty;
  bool get isEmpty => _uiState is UiStateEmpty<List<SampleItem>>;
  bool get hasError => _uiState is UiStateError<List<SampleItem>>;
  bool get hasMore => _pagination.hasMore;
  int get pageSize => _remoteConfig.pageSize;

  List<String> get recentQueries => _searchHistoryService.queries;
  List<String> get recentItemIds => _searchHistoryService.recentItemIds;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    await loadInitial();
  }

  Future<void> loadInitial() async {
    final requestVersion = ++_requestVersion;
    _lastError = null;
    _items.clear();
    _pagination.reset();
    _pagination.startInitialLoad();
    _setUiState(const UiStateLoading<List<SampleItem>>());

    await _fetchCurrentPage(requestVersion: requestVersion);
  }

  Future<void> refresh() async {
    if (isRefreshing) return;

    final requestVersion = ++_requestVersion;
    _lastError = null;
    _pagination.reset();
    _pagination.startRefresh();

    _setUiState(
      UiStateLoading<List<SampleItem>>(
        previousData: items,
        refreshing: true,
      ),
    );

    await _fetchCurrentPage(
      isRefresh: true,
      requestVersion: requestVersion,
    );
  }

  Future<void> loadMore() async {
    if (isRefreshing || isLoading) {
      return;
    }
    if (!_pagination.beginLoadMore()) return;

    final requestVersion = ++_requestVersion;
    _lastError = null;

    if (_uiState is UiStateContent<List<SampleItem>>) {
      _setUiState(
        UiStateContent<List<SampleItem>>(
          data: items,
          loadingMore: true,
        ),
      );
    } else {
      _setUiState(
        UiStateLoading<List<SampleItem>>(
          previousData: items,
          loadingMore: true,
        ),
      );
    }

    await _fetchCurrentPage(
      isLoadMore: true,
      requestVersion: requestVersion,
    );
  }

  bool shouldLoadMore({
    required double currentPixels,
    required double maxScrollExtent,
  }) {
    return _pagination.shouldPrefetch(
      currentPixels: currentPixels,
      maxScrollExtent: maxScrollExtent,
    );
  }

  void onSearchChanged(String value) {
    _query = value.trim();
    if (_query.isNotEmpty) {
      unawaited(_searchHistoryService.addQuery(_query));
    }
    notifyListeners();
    _searchDebouncer.run(loadInitial);
  }

  void useRecentQuery(String query) {
    searchController.text = query;
    onSearchChanged(query);
  }

  Future<void> clearSearchHistory() async {
    await _searchHistoryService.clearQueries();
    notifyListeners();
  }

  Future<void> recordItemViewed(String itemId) async {
    await _searchHistoryService.addRecentItem(itemId);
    notifyListeners();
  }

  Future<void> showInfoNotification({
    required String title,
    required String message,
  }) async {
    await _notificationCenter.push(
      InAppNotification.create(
        title: title,
        message: message,
        type: InAppNotificationType.info,
      ),
    );
  }

  Future<void> _fetchCurrentPage({
    bool isRefresh = false,
    bool isLoadMore = false,
    required int requestVersion,
  }) async {
    ApiError? requestError;

    final result = await _repository.fetchItems(
      page: _pagination.currentPage,
      pageSize: _pagination.pageSize,
      query: _query,
      onCacheHit: (cache) {
        if (_isStaleRequest(requestVersion)) {
          return;
        }
        if (isLoadMore) {
          return;
        }

        _lastError = null;
        _handleSuccess(cache, append: false);
        _setUiState(
          UiStateContent<List<SampleItem>>(
            data: items,
            refreshing: isRefresh,
          ),
        );
      },
    );

    if (_isStaleRequest(requestVersion)) {
      return;
    }

    result.when(
      success: (pageData) {
        _lastError = null;
        _handleSuccess(pageData, append: isLoadMore);
      },
      failure: (error) {
        requestError = error;
        _lastError = error;
        _pagination.markError();
      },
    );

    if (requestError != null && _items.isEmpty) {
      _setUiState(
        UiStateError<List<SampleItem>>(
          message: requestError!.message,
          error: requestError,
        ),
      );
      return;
    }

    if (_items.isEmpty) {
      _setUiState(const UiStateEmpty<List<SampleItem>>());
      return;
    }

    _setUiState(
      UiStateContent<List<SampleItem>>(
        data: items,
      ),
    );
  }

  bool _isStaleRequest(int requestVersion) {
    return requestVersion != _requestVersion;
  }

  void _handleSuccess(
    PaginatedSampleItems pageData, {
    required bool append,
  }) {
    if (append) {
      _appendUnique(pageData.items);
    } else {
      _replaceItems(pageData.items);
    }

    _pagination.consume(
      hasMore: pageData.hasMore,
      itemCount: pageData.items.length,
    );
  }

  void _replaceItems(List<SampleItem> nextItems) {
    _items
      ..clear()
      ..addAll(nextItems);
    _pagination.reset();
  }

  void _appendUnique(List<SampleItem> nextItems) {
    final existingIds = _items.map((item) => item.id).toSet();
    for (final item in nextItems) {
      if (existingIds.add(item.id)) {
        _items.add(item);
      }
    }
  }

  void _setUiState(UiState<List<SampleItem>> state) {
    _uiState = state;
    notifyListeners();
  }

  bool _isUiStateRefreshing(UiState<List<SampleItem>> state) {
    if (state is UiStateLoading<List<SampleItem>>) {
      return state.refreshing;
    }
    if (state is UiStateContent<List<SampleItem>>) {
      return state.refreshing;
    }
    return false;
  }

  bool _isUiStateLoadingMore(UiState<List<SampleItem>> state) {
    if (state is UiStateLoading<List<SampleItem>>) {
      return state.loadingMore;
    }
    if (state is UiStateContent<List<SampleItem>>) {
      return state.loadingMore;
    }
    return false;
  }

  @override
  void dispose() {
    searchController.dispose();
    _searchDebouncer.dispose();
    super.dispose();
  }
}
