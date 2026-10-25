import 'dart:convert';

import '../../core/cache/cache_store.dart';
import '../../core/logger.dart';
import '../datasource/remote/sample_feature_data_source.dart';
import '../model/paginated_sample_items.dart';
import '../model/response/base/api_response.dart';
import '../model/sample_item.dart';
import 'base_repository.dart';

export '../datasource/remote/sample_feature_data_source.dart'
    show SampleFeatureDataSource;
export '../model/paginated_sample_items.dart' show PaginatedSampleItems;

abstract class SampleFeatureRepository {
  Future<ApiResult<PaginatedSampleItems>> fetchItems({
    required int page,
    required int pageSize,
    String query,
    void Function(PaginatedSampleItems cache)? onCacheHit,
  });

  /// Finds a single item by id from the cache or data source.
  Future<ApiResult<SampleItem>> findItemById(String id);
}

class SampleFeatureRepositoryImpl extends BaseRepository
    implements SampleFeatureRepository {
  static const int _maxIndexedItems = 200;

  SampleFeatureRepositoryImpl(
    this._dataSource, {
    CacheStore? cacheStore,
    this.cacheTtl = const Duration(minutes: 5),
  }) : _cacheStore = cacheStore;

  final SampleFeatureDataSource _dataSource;
  final CacheStore? _cacheStore;
  final Duration cacheTtl;

  /// In-memory item index for findById lookups.
  final Map<String, SampleItem> _itemIndex = <String, SampleItem>{};

  static String _cacheKey(int page, int pageSize, String query) =>
      'sample_items:p$page:s$pageSize:q$query';

  @override
  Future<ApiResult<PaginatedSampleItems>> fetchItems({
    required int page,
    required int pageSize,
    String query = '',
    void Function(PaginatedSampleItems cache)? onCacheHit,
  }) async {
    final key = _cacheKey(page, pageSize, query);
    final cache = _cacheStore;

    // 1. Try returning cached data immediately (stale-while-revalidate)
    final cached = cache?.get(key);
    PaginatedSampleItems? cachedItems;

    if (cached != null && !cached.isExpired(cacheTtl)) {
      cachedItems = _tryDecodeCachedPage(
        key: key,
        raw: cached.data,
        page: page,
      );
      if (onCacheHit != null) {
        final safeCached = cachedItems;
        if (safeCached != null) {
          onCacheHit(safeCached);
        }
      }
    }

    // 2. Fetch from network
    final result = await guard<PaginatedSampleItems>(
      () => _dataSource.fetchItems(
        page: page,
        pageSize: pageSize,
        query: query,
      ),
    );

    // 3. On success: update cache + item index
    result.when(
      success: (data) {
        _cachePageResult(key, data);
        _indexItems(data.items);
      },
      failure: (_) {},
    );

    // If network failed but cache exists, return stale cache.
    if (result is ApiFailure<PaginatedSampleItems> && cachedItems != null) {
      return ApiSuccess<PaginatedSampleItems>(cachedItems);
    }

    return result;
  }

  @override
  Future<ApiResult<SampleItem>> findItemById(String id) async {
    // 1. Check in-memory index first
    final indexed = _itemIndex[id];
    if (indexed != null) {
      return ApiSuccess<SampleItem>(indexed);
    }

    // 2. Fetch from network
    final result = await guard<SampleItem>(() => _dataSource.fetchItemById(id));

    // 3. Cache it if successful
    result.when(
      success: (item) {
        _indexItem(item);
      },
      failure: (_) {},
    );

    return result;
  }

  void _indexItems(List<SampleItem> items) {
    for (final item in items) {
      _indexItem(item);
    }
  }

  void _indexItem(SampleItem item) {
    _itemIndex.remove(item.id);
    _itemIndex[item.id] = item;
    while (_itemIndex.length > _maxIndexedItems) {
      _itemIndex.remove(_itemIndex.keys.first);
    }
  }

  void _cachePageResult(String key, PaginatedSampleItems data) {
    final cache = _cacheStore;
    if (cache == null) return;

    final encoded = jsonEncode(<String, dynamic>{
      'items': data.items.map((i) => i.toJson()).toList(growable: false),
      'hasMore': data.hasMore,
    });
    cache.put(key, encoded);
  }

  PaginatedSampleItems? _tryDecodeCachedPage({
    required String key,
    required String raw,
    required int page,
  }) {
    try {
      return _decodeCachedPage(raw, page);
    } on Object catch (error, stackTrace) {
      _cacheStore?.invalidate(key);
      AppLogger.warning(
        'Dropped malformed cache entry key=$key',
        category: AppLogCategory.cache,
      );
      AppLogger.debug(
        'Cache decode failure: error=$error stackTrace=$stackTrace',
        category: AppLogCategory.cache,
      );
      return null;
    }
  }

  PaginatedSampleItems _decodeCachedPage(String raw, int page) {
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    final rawItems = decoded['items'] as List<dynamic>? ?? <dynamic>[];
    final items = rawItems
        .whereType<Map<String, dynamic>>()
        .map(SampleItem.fromJson)
        .toList(growable: false);
    final hasMore = decoded['hasMore'] as bool? ?? false;

    // Also index these items
    _indexItems(items);

    return PaginatedSampleItems(
      items: items,
      page: page,
      hasMore: hasMore,
    );
  }
}
