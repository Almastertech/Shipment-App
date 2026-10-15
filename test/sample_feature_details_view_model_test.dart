import 'package:shipments/data/datasource/remote/exception/api_error.dart';
import 'package:shipments/data/model/response/base/api_response.dart';
import 'package:shipments/data/model/sample_item.dart';
import 'package:shipments/data/repository/sample_feature_repo.dart';
import 'package:shipments/screens/sample_feature/sample_feature_details_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SampleFeatureDetailsViewModel', () {
    test('load success exposes item content', () async {
      final repo = _FakeRepository(
        findByIdResult: const ApiSuccess<SampleItem>(
          SampleItem(
            id: '1',
            title: 'Item 1',
            subtitle: 'Sub 1',
            description: 'Desc 1',
          ),
        ),
      );
      final viewModel = SampleFeatureDetailsViewModel(
        repository: repo,
        itemId: '1',
      );

      await viewModel.load();

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);
      expect(viewModel.item?.id, '1');
    });

    test('load failure exposes error state', () async {
      final repo = _FakeRepository(
        findByIdResult: const ApiFailure<SampleItem>(
          ApiError(type: ApiErrorType.notFound, message: 'Not found'),
        ),
      );
      final viewModel = SampleFeatureDetailsViewModel(
        repository: repo,
        itemId: '404',
      );

      await viewModel.load();

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.item, isNull);
      expect(viewModel.error?.type, ApiErrorType.notFound);
    });
  });
}

class _FakeRepository implements SampleFeatureRepository {
  _FakeRepository({required this.findByIdResult});

  final ApiResult<SampleItem> findByIdResult;

  @override
  Future<ApiResult<PaginatedSampleItems>> fetchItems({
    required int page,
    required int pageSize,
    String query = '',
    void Function(PaginatedSampleItems cache)? onCacheHit,
  }) async {
    return const ApiSuccess<PaginatedSampleItems>(
      PaginatedSampleItems(
        items: <SampleItem>[],
        page: 1,
        hasMore: false,
      ),
    );
  }

  @override
  Future<ApiResult<SampleItem>> findItemById(String id) async {
    return findByIdResult;
  }
}
