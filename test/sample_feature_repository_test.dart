import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/data/datasource/remote/exception/api_error.dart';
import 'package:shipments/data/model/response/base/api_response.dart';
import 'package:shipments/data/model/sample_item.dart';
import 'package:shipments/data/repository/sample_feature_repo.dart';

void main() {
  group('SampleFeatureRepository', () {
    test('returns paginated data when data source succeeds', () async {
      final repository = SampleFeatureRepositoryImpl(_FakeDataSource());

      final result = await repository.fetchItems(
        page: 1,
        pageSize: 10,
        query: '',
      );

      expect(result, isA<ApiSuccess<PaginatedSampleItems>>());
      final success = result as ApiSuccess<PaginatedSampleItems>;
      expect(success.data.items.length, 1);
      expect(success.data.items.first.title, 'Template Item 1');
      expect(success.data.hasMore, isFalse);
    });

    test('returns failure when data source throws', () async {
      final repository = SampleFeatureRepositoryImpl(_ThrowingDataSource());

      final result = await repository.fetchItems(
        page: 1,
        pageSize: 10,
        query: '',
      );

      expect(result, isA<ApiFailure<PaginatedSampleItems>>());
      final failure = result as ApiFailure<PaginatedSampleItems>;
      expect(failure.error.type, ApiErrorType.timeout);
    });

    test('keeps the in-memory item index bounded', () async {
      final dataSource = _GrowingDataSource();
      final repository = SampleFeatureRepositoryImpl(dataSource);

      for (var page = 1; page <= 201; page++) {
        await repository.fetchItems(page: page, pageSize: 1);
      }

      await repository.findItemById('1');
      await repository.findItemById('201');

      expect(dataSource.itemByIdRequests, <String>['1']);
    });
  });
}

class _FakeDataSource implements SampleFeatureDataSource {
  @override
  Future<PaginatedSampleItems> fetchItems({
    required int page,
    required int pageSize,
    String query = '',
  }) async {
    return const PaginatedSampleItems(
      items: <SampleItem>[
        SampleItem(
          id: '1',
          title: 'Template Item 1',
          subtitle: 'Template subtitle',
          description: 'Template description',
        ),
      ],
      page: 1,
      hasMore: false,
    );
  }

  @override
  Future<SampleItem> fetchItemById(String id) async {
    return const SampleItem(
      id: '1',
      title: 'Template Item 1',
      subtitle: 'Template subtitle',
      description: 'Template description',
    );
  }
}

class _ThrowingDataSource implements SampleFeatureDataSource {
  @override
  Future<PaginatedSampleItems> fetchItems({
    required int page,
    required int pageSize,
    String query = '',
  }) async {
    throw DioException.connectionTimeout(
      requestOptions: RequestOptions(path: '/sample-items'),
      timeout: const Duration(seconds: 5),
    );
  }

  @override
  Future<SampleItem> fetchItemById(String id) async {
    throw Exception('Error');
  }
}

class _GrowingDataSource implements SampleFeatureDataSource {
  final List<String> itemByIdRequests = <String>[];

  @override
  Future<PaginatedSampleItems> fetchItems({
    required int page,
    required int pageSize,
    String query = '',
  }) async {
    return PaginatedSampleItems(
      items: <SampleItem>[
        SampleItem(
          id: '$page',
          title: 'Item $page',
          subtitle: '',
          description: '',
        ),
      ],
      page: page,
      hasMore: true,
    );
  }

  @override
  Future<SampleItem> fetchItemById(String id) async {
    itemByIdRequests.add(id);
    return SampleItem(
      id: id,
      title: 'Item $id',
      subtitle: '',
      description: '',
    );
  }
}
