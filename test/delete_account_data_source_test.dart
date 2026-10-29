import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/data/datasource/remote/auth_data_source.dart';
import 'package:shipments/data/datasource/remote/dio/dio_client.dart';

void main() {
  test('deletes the account with an idempotency key and accepts 204', () async {
    final client = _DeleteClient();
    final source = NetworkAuthDataSource(client);

    await source.deleteAccount(idempotencyKey: 'operation-key');

    expect(client.path, '/v1/customer/account');
    expect(client.options?.headers?['Idempotency-Key'], 'operation-key');
    expect(client.options?.extra?['requiresAuth'], isNot(false));
    expect(client.options?.extra?['retryable'], isTrue);
  });
}

class _DeleteClient implements DioClient {
  String? path;
  Options? options;

  @override
  Future<Response<dynamic>> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    this.path = path;
    this.options = options;
    return Response<dynamic>(
      requestOptions: RequestOptions(path: path),
      statusCode: 204,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
