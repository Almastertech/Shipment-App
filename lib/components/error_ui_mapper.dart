import 'package:flutter/material.dart';

import '../data/datasource/remote/exception/api_error.dart';
import '../l10n/app_localizations.dart';
import 'error_ui_model.dart';

class ErrorUiMapper {
  static ErrorUiModel fromApiError(
    ApiError? error,
    AppLocalizations l10n,
  ) {
    if (error == null) {
      return ErrorUiModel(
        type: ErrorUiType.generic,
        title: l10n.errorGenericTitle,
        message: l10n.errorGenericMessage,
        icon: _iconForType(ErrorUiType.generic),
        actionLabel: l10n.retry,
      );
    }

    final type = switch (error.type) {
      ApiErrorType.offline ||
      ApiErrorType.network ||
      ApiErrorType.timeout =>
        ErrorUiType.offline,
      ApiErrorType.unauthorized => ErrorUiType.unauthorized,
      ApiErrorType.forbidden => ErrorUiType.forbidden,
      ApiErrorType.notFound => ErrorUiType.notFound,
      ApiErrorType.validation => ErrorUiType.validation,
      ApiErrorType.server => ErrorUiType.server,
      ApiErrorType.unknown => ErrorUiType.generic,
    };

    final title = switch (type) {
      ErrorUiType.offline => l10n.errorOfflineTitle,
      ErrorUiType.unauthorized => l10n.errorUnauthorizedTitle,
      ErrorUiType.forbidden => l10n.errorForbiddenTitle,
      ErrorUiType.notFound => l10n.errorNotFoundTitle,
      ErrorUiType.validation => l10n.errorValidationTitle,
      ErrorUiType.server => l10n.errorServerTitle,
      ErrorUiType.generic => l10n.errorGenericTitle,
    };

    final fallbackMessage = switch (type) {
      ErrorUiType.offline => l10n.errorOfflineMessage,
      ErrorUiType.unauthorized => l10n.errorUnauthorizedMessage,
      ErrorUiType.forbidden => l10n.errorForbiddenMessage,
      ErrorUiType.notFound => l10n.errorNotFoundMessage,
      ErrorUiType.validation => l10n.errorValidationMessage,
      ErrorUiType.server => l10n.errorServerMessage,
      ErrorUiType.generic => l10n.errorGenericMessage,
    };

    return ErrorUiModel(
      type: type,
      title: title,
      message: error.message.trim().isEmpty ? fallbackMessage : error.message,
      icon: _iconForType(type),
      actionLabel: l10n.retry,
    );
  }

  static IconData _iconForType(ErrorUiType type) {
    return switch (type) {
      ErrorUiType.offline => Icons.wifi_off_rounded,
      ErrorUiType.unauthorized => Icons.lock_outline_rounded,
      ErrorUiType.forbidden => Icons.block_outlined,
      ErrorUiType.notFound => Icons.search_off_rounded,
      ErrorUiType.validation => Icons.rule_folder_outlined,
      ErrorUiType.server => Icons.dns_outlined,
      ErrorUiType.generic => Icons.error_outline_rounded,
    };
  }
}
