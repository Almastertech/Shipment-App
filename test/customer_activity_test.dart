import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/data/datasource/remote/customer_activity_data_source.dart';
import 'package:shipments/data/datasource/remote/dio/dio_client.dart';
import 'package:shipments/data/model/customer_activity.dart';
import 'package:shipments/data/model/response/base/api_response.dart';
import 'package:shipments/data/repository/customer_activity_repository.dart';
import 'package:shipments/screens/profile/activity_view_model.dart';

void main() {
  test(
      'fetch sends filters and cursor and parses pagination and nullable fields',
      () async {
    final client = _Client();
    final page = await CustomerActivityDataSource(client)
        .fetch(type: 'claims', cursor: 'opaque');
    expect(client.path, '/v1/customer/account/activity');
    expect(client.query, {'type': 'claims', 'cursor': 'opaque', 'limit': 20});
    expect(page.items.single.storeName, isNull);
    expect(page.items.single.claimStatus, 'DRAFT');
    expect(page.hasMore, isTrue);
    expect(page.nextCursor, 'next');
  });

  test('switching filters ignores stale responses', () async {
    final repository = _Repository();
    final vm = ActivityViewModel(repository);
    final first = vm.load();
    final second = vm.selectType('claims');
    repository.claims.complete(ApiSuccess(_page('claim')));
    await second;
    repository.all.complete(ApiSuccess(_page('old')));
    await first;
    expect(vm.type, 'claims');
    expect(vm.items.single.id, 'claim');
    vm.dispose();
  });
}

CustomerActivityPage _page(String id) => CustomerActivityPage(
      items: [
        CustomerActivity(
            id: id,
            type: 'claims',
            event: 'event',
            occurredAt: DateTime.utc(2026))
      ],
      hasMore: false,
      nextCursor: null,
    );

class _Client implements DioClient {
  String? path;
  Map<String, dynamic>? query;
  @override
  Future<Response<dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      bool deduplicate = true}) async {
    this.path = path;
    query = queryParameters;
    return Response(requestOptions: RequestOptions(path: path), data: {
      'data': [
        {
          'id': 'item',
          'type': 'claims',
          'event': 'event',
          'occurred_at': '2026-10-28T13:01:59Z',
          'store_name': {},
          'claim': {'status': 'DRAFT'}
        }
      ],
      'meta': {
        'pagination': {'has_more': true, 'next_cursor': 'next'}
      },
    });
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Repository extends CustomerActivityRepository {
  _Repository() : super(CustomerActivityDataSource(_Client()));
  final all = Completer<ApiResult<CustomerActivityPage>>();
  final claims = Completer<ApiResult<CustomerActivityPage>>();
  @override
  Future<ApiResult<CustomerActivityPage>> fetch(
          {required String type, String? cursor}) =>
      type == 'all' ? all.future : claims.future;
}
