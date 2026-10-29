import '../datasource/remote/customer_home_data_source.dart';
import '../model/customer_home.dart';
import '../model/response/base/api_response.dart';
import 'base_repository.dart';

class CustomerHomeRepository extends BaseRepository {
  CustomerHomeRepository(this._source);

  final CustomerHomeDataSource _source;

  Future<ApiResult<CustomerHome>> fetch() => guard(_source.fetch);
}
