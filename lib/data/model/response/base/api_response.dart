import '../../../datasource/remote/exception/api_error.dart';

sealed class ApiResult<T> {
  const ApiResult();

  R when<R>({
    required R Function(T data) success,
    required R Function(ApiError error) failure,
  }) {
    final self = this;
    if (self is ApiSuccess<T>) {
      return success(self.data);
    }

    if (self is ApiFailure<T>) {
      return failure(self.error);
    }

    throw StateError('Unhandled ApiResult type: $runtimeType');
  }
}

final class ApiSuccess<T> extends ApiResult<T> {
  const ApiSuccess(this.data);

  final T data;
}

final class ApiFailure<T> extends ApiResult<T> {
  const ApiFailure(this.error);

  final ApiError error;
}
