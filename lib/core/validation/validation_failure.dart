enum ValidationFailureType {
  required,
  email,
  passwordStrength,
  minLength,
  maxLength,
  phone,
  numericRange,
  mismatch,
}

class ValidationFailure {
  const ValidationFailure({
    required this.type,
    this.min,
    this.max,
    this.field,
  });

  final ValidationFailureType type;
  final num? min;
  final num? max;
  final String? field;
}
