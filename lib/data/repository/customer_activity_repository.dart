import '../datasource/remote/customer_activity_data_source.dart';
import '../model/customer_activity.dart';
import '../model/response/base/api_response.dart';
import 'base_repository.dart';

class CustomerActivityRepository extends BaseRepository {
  CustomerActivityRepository(this._source);
  final CustomerActivityDataSource _source;
  Future<ApiResult<CustomerActivityPage>> fetch(
          {required String type, String? cursor}) =>
      guard(() => _source.fetch(type: type, cursor: cursor));
}
