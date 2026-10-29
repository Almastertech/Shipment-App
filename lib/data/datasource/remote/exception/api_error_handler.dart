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
    final body = _asMap(exception.response?.data);
    final message = _extractServerMessage(body);
    final code = body?['code'] as String?;
    final correlationId = body?['correlation_id'] as String?;
    final invalidParams = _extractInvalidParams(body?['invalid_params']);
    final retryAfter = _readInt(body?['retry_after']) ??
        _readInt(exception.response?.headers.value('Retry-After'));
    final remainingAttempts = _readInt(body?['remaining_attempts']);

    if (statusCode == 401) {
      return ApiError(
        type: ApiErrorType.unauthorized,
        message: message ?? 'Unauthorized request.',
        statusCode: statusCode,
        code: code,
        correlationId: correlationId,
        invalidParams: invalidParams,
        retryAfter: retryAfter,
        remainingAttempts: remainingAttempts,
      );
    }

    if (statusCode == 403) {
      return ApiError(
        type: ApiErrorType.forbidden,
        message: message ?? 'You do not have permission for this action.',
        statusCode: statusCode,
        code: code,
        correlationId: correlationId,
        invalidParams: invalidParams,
        retryAfter: retryAfter,
        remainingAttempts: remainingAttempts,
      );
    }

    if (statusCode == 404) {
      return ApiError(
        type: ApiErrorType.notFound,
        message: message ?? 'Requested resource was not found.',
        statusCode: statusCode,
        code: code,
        correlationId: correlationId,
        invalidParams: invalidParams,
        retryAfter: retryAfter,
        remainingAttempts: remainingAttempts,
      );
    }

    if (statusCode == 400 || statusCode == 422) {
      return ApiError(
        type: ApiErrorType.validation,
        message: message ?? 'Validation failed.',
        statusCode: statusCode,
        code: code,
        correlationId: correlationId,
        invalidParams: invalidParams,
        retryAfter: retryAfter,
        remainingAttempts: remainingAttempts,
      );
    }

    if (statusCode != null && statusCode >= 500) {
      return ApiError(
        type: ApiErrorType.server,
        message: message ?? 'Server error. Please try later.',
        statusCode: statusCode,
        code: code,
        correlationId: correlationId,
        invalidParams: invalidParams,
        retryAfter: retryAfter,
        remainingAttempts: remainingAttempts,
      );
    }

    return ApiError(
      type: ApiErrorType.unknown,
      message: message ?? 'Request failed.',
      statusCode: statusCode,
      code: code,
      correlationId: correlationId,
      invalidParams: invalidParams,
      retryAfter: retryAfter,
      remainingAttempts: remainingAttempts,
    );
  }

  static Map<String, dynamic>? _asMap(dynamic body) {
    if (body is Map) {
      return Map<String, dynamic>.from(body);
    }
    return null;
  }

  static String? _extractServerMessage(Map<String, dynamic>? body) {
    if (body == null) return null;

    final dynamic message = body['detail'] ?? body['message'] ?? body['error'];
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

    return null;
  }

  static List<ApiInvalidParam>? _extractInvalidParams(dynamic raw) {
    if (raw is! List) return null;

    final params = raw
        .whereType<Map<Object?, Object?>>()
        .map((param) {
          return ApiInvalidParam(
            name: param['name']?.toString() ?? '',
            reason: param['reason']?.toString() ?? '',
          );
        })
        .where((param) => param.name.isNotEmpty || param.reason.isNotEmpty)
        .toList(growable: false);
    return params.isEmpty ? null : params;
  }

  static int? _readInt(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }
}
