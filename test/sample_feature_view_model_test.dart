import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:shipments/core/config/app_remote_config.dart';
import 'package:shipments/core/search/search_history_service.dart';
import 'package:shipments/core/storage/local_storage.dart';
import 'package:shipments/data/datasource/remote/exception/api_error.dart';
import 'package:shipments/data/model/response/base/api_response.dart';
import 'package:shipments/data/model/sample_item.dart';
import 'package:shipments/data/repository/sample_feature_repo.dart';
import 'package:shipments/features/notifications/application/in_app_notification_center.dart';
import 'package:shipments/screens/sample_feature/sample_feature_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SampleFeatureViewModel', () {
    late _FakeRepository repository;
    late SampleFeatureViewModel viewModel;
    late InAppNotificationCenter notificationCenter;
    late SearchHistoryService searchHistoryService;

    setUp(() async {
      repository = _FakeRepository();
      notificationCenter = InAppNotificationCenter(
        storage: _MemoryLocalStorage(),
        storageKey: 'notification_test_key',
      );
      await notificationCenter.initialize();
      searchHistoryService = SearchHistoryService(
        storage: _MemoryLocalStorage(),
        queryStorageKey: 'search_queries',
        recentItemStorageKey: 'search_items',
      );
      await searchHistoryService.initialize();

      viewModel = SampleFeatureViewModel(
        repository: repository,
        remoteConfig: const AppRemoteConfig(),
        notificationCenter: notificationCenter,
        searchHistoryService: searchHistoryService,
      );
    });

    tearDown(() {
      viewModel.dispose();
    });

    test('initial load success sets state to success with items', () async {
      repository.result = ApiSuccess<PaginatedSampleItems>(
        PaginatedSampleItems(
          items: _generateItems(3),
          page: 1,
          hasMore: true,
        ),
      );

      await viewModel.initialize();

      expect(viewModel.state, SampleFeatureState.success);
      expect(viewModel.items.length, 3);
      expect(viewModel.items.first.title, 'Item 1');
    });

    test('initial load failure sets state to error', () async {
      repository.result = const ApiFailure<PaginatedSampleItems>(
        ApiError(
          type: ApiErrorType.server,
          message: 'Server error',
        ),
      );

      await viewModel.initialize();

      expect(viewModel.state, SampleFeatureState.error);
      expect(viewModel.errorMessage, 'Server error');
      expect(viewModel.items, isEmpty);
    });

    test('initial load empty list sets state to empty', () async {
      repository.result = const ApiSuccess<PaginatedSampleItems>(
        PaginatedSampleItems(
          items: <SampleItem>[],
          page: 1,
          hasMore: false,
        ),
      );

      await viewModel.initialize();

      expect(viewModel.state, SampleFeatureState.empty);
      expect(viewModel.items, isEmpty);
    });

    test('refresh clears items and reloads from page 1', () async {
      repository.result = ApiSuccess<PaginatedSampleItems>(
        PaginatedSampleItems(
          items: _generateItems(3),
          page: 1,
          hasMore: true,
        ),
      );

      await viewModel.initialize();
      expect(viewModel.items.length, 3);

      repository.result = ApiSuccess<PaginatedSampleItems>(
        PaginatedSampleItems(
          items: _generateItems(2, startFrom: 10),
          page: 1,
          hasMore: false,
        ),
      );

      await viewModel.refresh();

      expect(viewModel.state, SampleFeatureState.success);
      expect(viewModel.items.length, 2);
      expect(viewModel.items.first.title, 'Item 10');
    });

    test('refresh keeps previous items visible while request is in flight',
        () async {
      repository.result = ApiSuccess<PaginatedSampleItems>(
        PaginatedSampleItems(
          items: _generateItems(3),
          page: 1,
          hasMore: true,
        ),
      );
      await viewModel.initialize();

      final refreshCompleter = Completer<ApiResult<PaginatedSampleItems>>();
      repository.fetchHandler =
          ({required int page, required int pageSize, String query = ''}) {
        return refreshCompleter.future;
      };

      final refreshFuture = viewModel.refresh();
      await Future<void>.delayed(Duration.zero);

      expect(viewModel.items.length, 3);
      expect(viewModel.isRefreshing, isTrue);

      refreshCompleter.complete(
        ApiSuccess<PaginatedSampleItems>(
          PaginatedSampleItems(
            items: _generateItems(2, startFrom: 10),
            page: 1,
            hasMore: false,
          ),
        ),
      );

      await refreshFuture;
      expect(viewModel.items.length, 2);
      expect(viewModel.items.first.id, '10');
    });

    test('loadMore appends items and increments page', () async {
      repository.result = ApiSuccess<PaginatedSampleItems>(
        PaginatedSampleItems(
          items: _generateItems(3),
          page: 1,
          hasMore: true,
        ),
      );

      await viewModel.initialize();
      expect(viewModel.items.length, 3);

      repository.result = ApiSuccess<PaginatedSampleItems>(
        PaginatedSampleItems(
          items: _generateItems(2, startFrom: 4),
          page: 2,
          hasMore: false,
        ),
      );

      await viewModel.loadMore();

      expect(viewModel.items.length, 5);
      expect(viewModel.items.last.title, 'Item 5');
    });

    test('loadMore does nothing when hasMore is false', () async {
      repository.result = const ApiSuccess<PaginatedSampleItems>(
        PaginatedSampleItems(
          items: <SampleItem>[
            SampleItem(
              id: '1',
              title: 'Item 1',
              subtitle: 'Sub',
              description: 'Desc',
            ),
          ],
          page: 1,
          hasMore: false,
        ),
      );

      await viewModel.initialize();
      expect(viewModel.items.length, 1);

      repository.fetchCount = 0;
      await viewModel.loadMore();

      expect(repository.fetchCount, 0);
      expect(viewModel.items.length, 1);
    });

    test('debounced search triggers reload after delay', () {
      fakeAsync((async) {
        repository.result = ApiSuccess<PaginatedSampleItems>(
          PaginatedSampleItems(
            items: _generateItems(3),
            page: 1,
            hasMore: false,
          ),
        );

        viewModel.initialize();
        async.flushMicrotasks();

        repository.fetchCount = 0;
        repository.result = const ApiSuccess<PaginatedSampleItems>(
          PaginatedSampleItems(
            items: <SampleItem>[
              SampleItem(
                id: '99',
                title: 'Searched Item',
                subtitle: 'Sub',
                description: 'Desc',
              ),
            ],
            page: 1,
            hasMore: false,
          ),
        );

        viewModel.searchController.text = 'search';
        viewModel.onSearchChanged('search');

        async.elapse(const Duration(milliseconds: 200));
        expect(repository.fetchCount, 0);

        async.elapse(const Duration(milliseconds: 200));
        async.flushMicrotasks();

        expect(repository.fetchCount, greaterThan(0));
      });
    });

    test('search history is updated when searching', () async {
      repository.result = const ApiSuccess<PaginatedSampleItems>(
        PaginatedSampleItems(
          items: <SampleItem>[],
          page: 1,
          hasMore: false,
        ),
      );

      await viewModel.initialize();
      viewModel.onSearchChanged('pizza');
      await Future<void>.delayed(const Duration(milliseconds: 400));

      expect(viewModel.recentQueries, contains('pizza'));
    });

    test('cache hit followed by network success does not duplicate items',
        () async {
      repository.emitCacheBeforeResult = true;
      repository.cachedPage = PaginatedSampleItems(
        items: _generateItems(2),
        page: 1,
        hasMore: true,
      );
      repository.result = ApiSuccess<PaginatedSampleItems>(
        PaginatedSampleItems(
          items: _generateItems(2),
          page: 1,
          hasMore: true,
        ),
      );

      await viewModel.initialize();

      expect(viewModel.items.length, 2);
      expect(viewModel.items.map((item) => item.id), <String>['1', '2']);
      expect(viewModel.state, SampleFeatureState.success);
    });

    test('ignores stale request results when a newer load starts', () async {
      final firstRequest = Completer<ApiResult<PaginatedSampleItems>>();
      final secondRequest = Completer<ApiResult<PaginatedSampleItems>>();
      var callCount = 0;
      repository.fetchHandler =
          ({required int page, required int pageSize, String query = ''}) {
        callCount += 1;
        return callCount == 1 ? firstRequest.future : secondRequest.future;
      };

      final firstLoad = viewModel.loadInitial();
      final secondLoad = viewModel.loadInitial();

      firstRequest.complete(
        ApiSuccess<PaginatedSampleItems>(
          PaginatedSampleItems(
            items: _generateItems(1, startFrom: 1),
            page: 1,
            hasMore: false,
          ),
        ),
      );

      secondRequest.complete(
        ApiSuccess<PaginatedSampleItems>(
          PaginatedSampleItems(
            items: _generateItems(1, startFrom: 99),
            page: 1,
            hasMore: false,
          ),
        ),
      );

      await Future.wait<void>(<Future<void>>[firstLoad, secondLoad]);
      expect(viewModel.items.single.id, '99');
    });
  });
}

List<SampleItem> _generateItems(int count, {int startFrom = 1}) {
  return List<SampleItem>.generate(
    count,
    (index) {
      final num = startFrom + index;
      return SampleItem(
        id: '$num',
        title: 'Item $num',
        subtitle: 'Subtitle $num',
        description: 'Description $num',
      );
    },
    growable: false,
  );
}

class _FakeRepository implements SampleFeatureRepository {
  ApiResult<PaginatedSampleItems> result =
      const ApiSuccess<PaginatedSampleItems>(
    PaginatedSampleItems(
      items: <SampleItem>[],
      page: 1,
      hasMore: false,
    ),
  );

  int fetchCount = 0;
  bool emitCacheBeforeResult = false;
  PaginatedSampleItems? cachedPage;
  Future<ApiResult<PaginatedSampleItems>> Function({
    required int page,
    required int pageSize,
    String query,
  })? fetchHandler;

  @override
  Future<ApiResult<PaginatedSampleItems>> fetchItems({
    required int page,
    required int pageSize,
    String query = '',
    void Function(PaginatedSampleItems cache)? onCacheHit,
  }) async {
    fetchCount++;
    final handler = fetchHandler;
    if (handler != null) {
      return handler(page: page, pageSize: pageSize, query: query);
    }
    if (emitCacheBeforeResult && cachedPage != null && onCacheHit != null) {
      onCacheHit(cachedPage!);
    }
    return result;
  }

  @override
  Future<ApiResult<SampleItem>> findItemById(String id) async {
    return const ApiFailure<SampleItem>(
      ApiError(type: ApiErrorType.notFound, message: 'Not found'),
    );
  }
}

class _MemoryLocalStorage implements LocalStorage {
  final Map<String, Object> _data = <String, Object>{};

  @override
  Future<bool> clear() async {
    _data.clear();
    return true;
  }

  @override
  bool? getBool(String key) => _data[key] as bool?;

  @override
  int? getInt(String key) => _data[key] as int?;

  @override
  String? getString(String key) => _data[key] as String?;

  @override
  Future<bool> remove(String key) async {
    _data.remove(key);
    return true;
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> setInt(String key, int value) async {
    _data[key] = value;
    return true;
  }

  @override
  Future<bool> setString(String key, String value) async {
    _data[key] = value;
    return true;
  }
}
