import '../../model/customer_activity.dart';
import 'dio/dio_client.dart';

class CustomerActivityDataSource {
  CustomerActivityDataSource(this._client);
  final DioClient _client;

  Future<CustomerActivityPage> fetch(
      {required String type, String? cursor, int limit = 20}) async {
    final response = await _client.get(
      '/v1/customer/account/activity',
      queryParameters: <String, dynamic>{
        'type': type,
        'limit': limit,
        if (cursor != null) 'cursor': cursor
      },
    );
    final body = response.data;
    if (body is! Map || body['data'] is! List)
      throw const FormatException('Invalid activity response.');
    final metadata = body['meta'];
    final pagination = metadata is Map ? metadata['pagination'] : null;
    final rawCursor = pagination is Map ? pagination['next_cursor'] : null;
    final nextCursor =
        rawCursor is String && rawCursor.isNotEmpty ? rawCursor : null;
    final hasMore = pagination is Map && pagination['has_more'] == true;
    if (hasMore && nextCursor == null)
      throw const FormatException('Activity pagination cursor is missing.');
    return CustomerActivityPage(
      items: (body['data'] as List)
          .map((item) =>
              CustomerActivity.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(growable: false),
      hasMore: hasMore,
      nextCursor: nextCursor,
    );
  }
}
