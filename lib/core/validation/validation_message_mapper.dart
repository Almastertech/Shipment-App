import '../../l10n/app_localizations.dart';
import 'validation_failure.dart';

class ValidationMessageMapper {
  static String toMessage(
    ValidationFailure failure,
    AppLocalizations l10n,
  ) {
    switch (failure.type) {
      case ValidationFailureType.required:
        return l10n.validationRequired;
      case ValidationFailureType.email:
        return l10n.validationEmail;
      case ValidationFailureType.passwordStrength:
        return l10n.validationPasswordWeak;
      case ValidationFailureType.minLength:
        return l10n.validationMinLength(failure.min?.toInt() ?? 0);
      case ValidationFailureType.maxLength:
        return l10n.validationMaxLength(failure.max?.toInt() ?? 0);
      case ValidationFailureType.phone:
        return l10n.validationPhone;
      case ValidationFailureType.numericRange:
        return l10n.validationNumericRange(
          failure.min?.toString() ?? '0',
          failure.max?.toString() ?? '0',
        );
      case ValidationFailureType.mismatch:
        return l10n.validationMismatch;
    }
  }
}
