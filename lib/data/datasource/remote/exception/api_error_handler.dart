import 'dart:io';

import 'package:dio/dio.dart';

import 'api_error.dart';

class ApiErrorHandler {
  static ApiError map(Object error, {StackTrace? stackTrace}) {
    if (error is ApiError) {
      return error;
    }

    if (error is DioException) {
      return _mapDioException(error);
    }

    if (error is SocketException) {
      return const ApiError(
        type: ApiErrorType.network,
        message: 'No internet connection.',
      );
    }

    return const ApiError(
      type: ApiErrorType.unknown,
      message: 'Unexpected error occurred.',
    );
  }

  static ApiError _mapDioException(DioException exception) {
    final statusCode = exception.response?.statusCode;

    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiError(
          type: ApiErrorType.timeout,
          message: 'Request timed out. Please try again.',
          statusCode: statusCode,
        );
      case DioExceptionType.badResponse:
        return _mapStatusCode(statusCode, exception);
      case DioExceptionType.cancel:
        return ApiError(
          type: ApiErrorType.unknown,
          message: 'Request was cancelled.',
          statusCode: statusCode,
        );
      case DioExceptionType.connectionError:
        return ApiError(
          type: ApiErrorType.network,
          message: 'Connection failed. Check your internet and retry.',
          statusCode: statusCode,
        );
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return ApiError(
          type: ApiErrorType.unknown,
          message: exception.message ?? 'Unexpected network error.',
          statusCode: statusCode,
        );
    }
  }

  static ApiError _mapStatusCode(int? statusCode, DioException exception) {
    final message = _extractServerMessage(exception.response?.data);

    if (statusCode == 401) {
      return ApiError(
        type: ApiErrorType.unauthorized,
        message: message ?? 'Unauthorized request.',
        statusCode: statusCode,
      );
    }

    if (statusCode == 403) {
      return ApiError(
        type: ApiErrorType.forbidden,
        message: message ?? 'You do not have permission for this action.',
        statusCode: statusCode,
      );
    }

    if (statusCode == 404) {
      return ApiError(
        type: ApiErrorType.notFound,
        message: message ?? 'Requested resource was not found.',
        statusCode: statusCode,
      );
    }

    if (statusCode == 422) {
      return ApiError(
        type: ApiErrorType.validation,
        message: message ?? 'Validation failed.',
        statusCode: statusCode,
      );
    }

    if (statusCode != null && statusCode >= 500) {
      return ApiError(
        type: ApiErrorType.server,
        message: message ?? 'Server error. Please try later.',
        statusCode: statusCode,
      );
    }

    return ApiError(
      type: ApiErrorType.unknown,
      message: message ?? 'Request failed.',
      statusCode: statusCode,
    );
  }

  static String? _extractServerMessage(dynamic body) {
    if (body is Map<String, dynamic>) {
      final dynamic message = body['message'] ?? body['error'];
      if (message is String && message.trim().isNotEmpty) {
        return message.trim();
      }

      final dynamic errors = body['errors'];
      if (errors is List && errors.isNotEmpty) {
        final first = errors.first;
        if (first is String && first.trim().isNotEmpty) {
          return first.trim();
        }
      }
    }

    return null;
  }
}
