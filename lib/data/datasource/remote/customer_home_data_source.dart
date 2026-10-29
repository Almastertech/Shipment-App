import '../../app_urls/app_url.dart';
import '../../model/customer_home.dart';
import 'dio/dio_client.dart';

class CustomerHomeDataSource {
  CustomerHomeDataSource(this._client);

  final DioClient _client;

  Future<CustomerHome> fetch() async {
    final response = await _client.get(AppUrl.customerHome);
    final body = response.data;
    if (body is! Map || body['data'] is! Map) {
      throw const FormatException('Customer home response data is missing.');
    }
    return CustomerHome.fromJson(
      Map<String, dynamic>.from(body['data'] as Map),
    );
  }
}
