import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shipments/data/datasource/remote/customer_home_data_source.dart';
import 'package:shipments/data/datasource/remote/dio/dio_client.dart';
import 'package:shipments/data/model/customer_home.dart';
import 'package:shipments/data/repository/customer_home_repository.dart';
import 'package:shipments/screens/home/home_view_model.dart';

void main() {
  group('CustomerHome', () {
    test('parses shipment, claim and locale-object fields defensively', () {
      final home = CustomerHome.fromJson(<String, dynamic>{
        'customer_name': <String, dynamic>{'en': 'Maha'},
        'hero_state': 'claim_in_review',
        'featured_shipment': <String, dynamic>{
          'package_id': 'package-1',
          'store_name': <String, dynamic>{'value': 'Store'},
          'product_name': 'Book',
          'status': 'in_transit',
          'expected_delivery_at': '2026-11-01T12:00:00Z',
        },
        'active_shipments': <dynamic>[
          <String, dynamic>{'package_id': 'package-2'},
          null,
          'ignored malformed item',
        ],
        'active_claims': <dynamic>[
          <String, dynamic>{
            'id': 'claim-1',
            'ticket_number': 'T-1',
            'type': 'damage',
            'status': 'submitted',
            'claimed_amount_halalas': '12550',
          },
        ],
        'required_action': <String, dynamic>{'type': 'anything'},
        'partner_stores_count': 4,
      });

      expect(home.customerName, 'Maha');
      expect(home.heroState, 'claim_in_review');
      expect(home.featuredShipment?.storeName, 'Store');
      expect(home.featuredShipment?.expectedDeliveryAt, isNotNull);
      expect(home.activeShipments, hasLength(1));
      expect(home.activeClaims.single.claimedAmountHalalas, '12550');
      expect(home.hasRequiredAction, isTrue);
      expect(home.partnerStoresCount, 4);
    });

    test('uses safe defaults when optional data is absent or malformed', () {
      final home = CustomerHome.fromJson(<String, dynamic>{
        'active_shipments': 'not a list',
        'active_claims': null,
        'partner_stores_count': -5,
        'required_action': <String, dynamic>{},
      });

      expect(home.customerName, isNull);
      expect(home.activeShipments, isEmpty);
      expect(home.activeClaims, isEmpty);
      expect(home.partnerStoresCount, 0);
      expect(home.hasRequiredAction, isFalse);
    });
  });

  test('data source requests the documented customer home endpoint', () async {
    final client = _FakeDioClient();
    final source = CustomerHomeDataSource(client);

    final home = await source.fetch();

    expect(client.requestedPath, '/v1/customer/home');
    expect(home.customerName, 'Aisha');
  });

  test('view model publishes the loaded home response and clears loading',
      () async {
    final viewModel = HomeViewModel(
      CustomerHomeRepository(_StubCustomerHomeDataSource()),
    );
    addTearDown(viewModel.dispose);

    await viewModel.load();

    expect(viewModel.loading, isFalse);
    expect(viewModel.error, isNull);
    expect(viewModel.home?.customerName, 'Aisha');
  });
}

class _FakeDioClient implements DioClient {
  String? requestedPath;

  @override
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool deduplicate = true,
  }) async {
    requestedPath = path;
    return Response<dynamic>(
      requestOptions: RequestOptions(path: path),
      data: <String, dynamic>{
        'success': true,
        'data': <String, dynamic>{'customer_name': 'Aisha'},
      },
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _StubCustomerHomeDataSource implements CustomerHomeDataSource {
  @override
  Future<CustomerHome> fetch() async =>
      CustomerHome.fromJson(<String, dynamic>{'customer_name': 'Aisha'});

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
