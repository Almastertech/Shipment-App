import 'validation_failure.dart';

class ValidationResult {
  const ValidationResult.valid() : failures = const <ValidationFailure>[];

  const ValidationResult.invalid(this.failures);

  final List<ValidationFailure> failures;

  bool get isValid => failures.isEmpty;

  ValidationFailure? get firstFailure =>
      failures.isEmpty ? null : failures.first;

  static ValidationResult fromFailure(ValidationFailure? failure) {
    if (failure == null) {
      return const ValidationResult.valid();
    }
    return ValidationResult.invalid(<ValidationFailure>[failure]);
  }
}
