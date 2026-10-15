import 'dart:math';

import 'package:dio/dio.dart';

import '../../app_urls/app_url.dart';
import '../../model/paginated_sample_items.dart';
import '../../model/sample_item.dart';
import 'dio/dio_client.dart';

abstract class SampleFeatureDataSource {
  Future<PaginatedSampleItems> fetchItems({
    required int page,
    required int pageSize,
    String query,
  });

  Future<SampleItem> fetchItemById(String id);
}

class MockSampleFeatureDataSource implements SampleFeatureDataSource {
  MockSampleFeatureDataSource({
    this.totalItems = 120,
    this.delay = const Duration(milliseconds: 450),
  });

  final int totalItems;
  final Duration delay;

  @override
  Future<PaginatedSampleItems> fetchItems({
    required int page,
    required int pageSize,
    String query = '',
  }) async {
    await Future<void>.delayed(delay);

    final allItems = List<SampleItem>.generate(
      totalItems,
      (index) {
        final number = index + 1;
        return SampleItem(
          id: '$number',
          title: 'Template Item $number',
          subtitle: 'Reusable subtitle for item $number',
          description:
              'This is a sample description for item $number. Replace it with your domain content.',
          imageUrl: 'https://picsum.photos/seed/template_$number/240/240',
        );
      },
      growable: false,
    );

    final normalizedQuery = query.trim().toLowerCase();
    final filteredItems = normalizedQuery.isEmpty
        ? allItems
        : allItems
            .where(
              (item) =>
                  item.title.toLowerCase().contains(normalizedQuery) ||
                  item.subtitle.toLowerCase().contains(normalizedQuery),
            )
            .toList(growable: false);

    final startIndex = (page - 1) * pageSize;
    if (startIndex >= filteredItems.length) {
      return PaginatedSampleItems(
        items: const <SampleItem>[],
        page: page,
        hasMore: false,
      );
    }

    final endIndex = min(startIndex + pageSize, filteredItems.length);

    return PaginatedSampleItems(
      items: filteredItems.sublist(startIndex, endIndex),
      page: page,
      hasMore: endIndex < filteredItems.length,
    );
  }

  @override
  Future<SampleItem> fetchItemById(String id) async {
    await Future<void>.delayed(delay);
    return SampleItem(
      id: id,
      title: 'Template Item $id',
      subtitle: 'Reusable subtitle for item $id',
      description:
          'This is a sample description for item $id. Fetched dynamically for deep link.',
      imageUrl: 'https://picsum.photos/seed/template_$id/240/240',
    );
  }
}

class NetworkSampleFeatureDataSource implements SampleFeatureDataSource {
  NetworkSampleFeatureDataSource(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<PaginatedSampleItems> fetchItems({
    required int page,
    required int pageSize,
    String query = '',
  }) async {
    final response = await _dioClient.get(
      AppUrl.sampleItems,
      queryParameters: <String, dynamic>{
        'page': page,
        'limit': pageSize,
        if (query.isNotEmpty) 'q': query,
      },
      options: Options(
        extra: <String, dynamic>{'requiresAuth': false},
      ),
    );

    final body = response.data as Map<String, dynamic>? ?? <String, dynamic>{};
    final payload = body['data'] as Map<String, dynamic>? ?? body;
    final rawItems = payload['items'] as List<dynamic>? ?? <dynamic>[];

    final items = rawItems
        .whereType<Map<String, dynamic>>()
        .map(SampleItem.fromJson)
        .toList(growable: false);

    final hasMore = payload['hasMore'] as bool? ?? items.length >= pageSize;

    return PaginatedSampleItems(
      items: items,
      page: page,
      hasMore: hasMore,
    );
  }

  @override
  Future<SampleItem> fetchItemById(String id) async {
    final response = await _dioClient.get(
      '${AppUrl.sampleItems}/$id',
      options: Options(
        extra: <String, dynamic>{'requiresAuth': false},
      ),
    );

    final body = response.data as Map<String, dynamic>? ?? <String, dynamic>{};
    final payload = body['data'] as Map<String, dynamic>? ?? body;

    return SampleItem.fromJson(payload);
  }
}
