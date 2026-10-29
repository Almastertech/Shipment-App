import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/data/datasource/remote/customer_account_data_source.dart';
import 'package:shipments/data/datasource/remote/dio/dio_client.dart';
import 'package:shipments/data/model/customer_account.dart';

void main() {
  test('parses nullable fields and formats halalas without floating point', () {
    final account = CustomerAccount.fromJson(<String, dynamic>{
      'id': 'customer-1',
      'full_name': <String, dynamic>{},
      'phone': '+966512345678',
      'avatar_url': null,
      'stats': <String, dynamic>{
        'shipments_count': 3,
        'claims_count': 2,
        'total_compensation_halalas': '900719925474099312',
      },
      'member_since': '2026-10-28T12:33:47.245Z',
    });
    expect(account.fullName, isNull);
    expect(account.avatarUrl, isNull);
    expect(account.shipmentsCount, 3);
    expect(account.claimsCount, 2);
    expect(account.compensationRiyals, '9007199254740993.12');
    expect(account.memberSince, isNotNull);
  });

  test('fetches account from authenticated endpoint and unwraps data',
      () async {
    final client = _Client();
    final account = await CustomerAccountDataSource(client).fetchAccount();
    expect(client.path, '/v1/customer/account');
    expect(client.options?.extra?['requiresAuth'], isNot(false));
    expect(account.id, 'customer-1');
  });

  test('patches supported profile fields and parses updated account', () async {
    final client = _Client();
    final account = await CustomerAccountDataSource(client).updateAccount(
      fullName: 'Customer Name',
      email: 'customer@example.com',
      preferredLanguage: 'ar',
    );
    expect(client.path, '/v1/customer/account');
    expect(client.options?.extra?['requiresAuth'], isNot(false));
    expect(client.body, {
      'full_name': 'Customer Name',
      'email': 'customer@example.com',
      'preferred_language': 'ar',
    });
    expect(account.fullName, 'Customer Name');
  });

  test('omits an absent email from the patch', () async {
    final client = _Client();
    await CustomerAccountDataSource(client).updateAccount(
      fullName: 'Name',
      preferredLanguage: 'en',
    );
    expect((client.body as Map).containsKey('email'), isFalse);
  });

  test('requests phone change and parses the verification challenge', () async {
    final client = _Client();
    final challenge = await CustomerAccountDataSource(client)
        .requestPhoneChange('0551234567');
    expect(client.path, '/v1/customer/account/phone/change');
    expect(client.body, {'phone': '0551234567'});
    expect(client.options?.extra?['requiresAuth'], isNot(false));
    expect(challenge.destination, '+966551234567');
    expect(challenge.retryAfterSeconds, 60);
  });

  test('verifies the new phone using its four-digit code', () async {
    final client = _Client();
    final phone = await CustomerAccountDataSource(client).verifyPhoneChange(
      phone: '+966551234567',
      code: '0012',
    );
    expect(client.path, '/v1/customer/account/phone/verify');
    expect(client.body, {'phone': '+966551234567', 'code': '0012'});
    expect(phone, '+966551234567');
  });
}

class _Client implements DioClient {
  String? path;
  Options? options;
  Object? body;

  @override
  Future<Response<dynamic>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    this.path = path;
    this.options = options;
    body = data;
    return Response<dynamic>(
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
      data: <String, dynamic>{
        'data': path.endsWith('/change')
            ? <String, dynamic>{
                'channel': 'phone',
                'destination': '+966551234567',
                'expires_at': 1776510120,
                'retry_after_seconds': 60
              }
            : <String, dynamic>{
                'phone': '+966551234567',
                'phone_verified_at': '2026-10-28T13:00:00Z'
              },
      },
    );
  }

  @override
  Future<Response<dynamic>> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    this.path = path;
    this.options = options;
    body = data;
    return Response<dynamic>(
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
      data: <String, dynamic>{
        'data': <String, dynamic>{
          'id': 'customer-1',
          'full_name': 'Customer Name'
        },
      },
    );
  }

  @override
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool deduplicate = true,
  }) async {
    this.path = path;
    this.options = options;
    return Response<dynamic>(
      requestOptions: RequestOptions(path: path),
      statusCode: 200,
      data: <String, dynamic>{
        'data': <String, dynamic>{'id': 'customer-1'}
      },
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
