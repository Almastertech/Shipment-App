import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

abstract class BaseRepository {
  Future<ApiResult<T>> guard<T>(Future<T> Function() request) async {
    try {
      final data = await request();
      return ApiSuccess<T>(data);
    } catch (error, stackTrace) {
      return ApiFailure<T>(
        ApiErrorHandler.map(error, stackTrace: stackTrace),
      );
    }
  }
}
