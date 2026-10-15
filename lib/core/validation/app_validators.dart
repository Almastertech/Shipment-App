import 'validation_failure.dart';
import 'validation_result.dart';

typedef Validator = ValidationFailure? Function(String? value);

class AppValidators {
  static ValidationResult validate(String? value, List<Validator> validators) {
    final failures = <ValidationFailure>[];

    for (final validator in validators) {
      final failure = validator(value);
      if (failure != null) {
        failures.add(failure);
      }
    }

    if (failures.isEmpty) {
      return const ValidationResult.valid();
    }

    return ValidationResult.invalid(failures);
  }

  static Validator required() {
    return (value) {
      final text = value?.trim() ?? '';
      if (text.isEmpty) {
        return const ValidationFailure(type: ValidationFailureType.required);
      }
      return null;
    };
  }

  static Validator email() {
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.[A-Za-z]{2,}$');
    return (value) {
      final text = value?.trim() ?? '';
      if (text.isEmpty) {
        return null;
      }
      if (!regex.hasMatch(text)) {
        return const ValidationFailure(type: ValidationFailureType.email);
      }
      return null;
    };
  }

  static Validator passwordStrength({int minLength = 8}) {
    final upper = RegExp(r'[A-Z]');
    final lower = RegExp(r'[a-z]');
    final digit = RegExp(r'[0-9]');

    return (value) {
      final text = value ?? '';
      final isStrong = text.length >= minLength &&
          upper.hasMatch(text) &&
          lower.hasMatch(text) &&
          digit.hasMatch(text);

      if (!isStrong) {
        return const ValidationFailure(
          type: ValidationFailureType.passwordStrength,
        );
      }

      return null;
    };
  }

  static Validator minLength(int min) {
    return (value) {
      final text = value ?? '';
      if (text.length < min) {
        return ValidationFailure(
          type: ValidationFailureType.minLength,
          min: min,
        );
      }
      return null;
    };
  }

  static Validator maxLength(int max) {
    return (value) {
      final text = value ?? '';
      if (text.length > max) {
        return ValidationFailure(
          type: ValidationFailureType.maxLength,
          max: max,
        );
      }
      return null;
    };
  }

  static Validator phone() {
    final regex = RegExp(r'^\+?[0-9]{7,15}$');
    return (value) {
      final text = value?.trim() ?? '';
      if (text.isEmpty) {
        return null;
      }
      if (!regex.hasMatch(text)) {
        return const ValidationFailure(type: ValidationFailureType.phone);
      }
      return null;
    };
  }

  static Validator numericRange({required num min, required num max}) {
    return (value) {
      final parsed = num.tryParse(value?.trim() ?? '');
      if (parsed == null || parsed < min || parsed > max) {
        return ValidationFailure(
          type: ValidationFailureType.numericRange,
          min: min,
          max: max,
        );
      }
      return null;
    };
  }

  static Validator matches(String? other, {String? field}) {
    return (value) {
      if ((value ?? '') != (other ?? '')) {
        return ValidationFailure(
          type: ValidationFailureType.mismatch,
          field: field,
        );
      }
      return null;
    };
  }
}
