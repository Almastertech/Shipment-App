import 'package:shipments/core/validation/app_validators.dart';
import 'package:shipments/core/validation/validation_failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppValidators', () {
    test('required validator', () {
      final result = AppValidators.validate(
        '',
        <Validator>[AppValidators.required()],
      );

      expect(result.isValid, isFalse);
      expect(result.firstFailure?.type, ValidationFailureType.required);
    });

    test('email validator', () {
      final result = AppValidators.validate(
        'invalid-email',
        <Validator>[AppValidators.email()],
      );

      expect(result.isValid, isFalse);
      expect(result.firstFailure?.type, ValidationFailureType.email);
    });

    test('password strength validator', () {
      final weak = AppValidators.validate(
        'abc123',
        <Validator>[AppValidators.passwordStrength()],
      );
      final strong = AppValidators.validate(
        'Abc12345',
        <Validator>[AppValidators.passwordStrength()],
      );

      expect(weak.isValid, isFalse);
      expect(strong.isValid, isTrue);
    });

    test('min/max length validators', () {
      final min = AppValidators.validate(
        'ab',
        <Validator>[AppValidators.minLength(3)],
      );
      final max = AppValidators.validate(
        'abcdef',
        <Validator>[AppValidators.maxLength(5)],
      );

      expect(min.firstFailure?.type, ValidationFailureType.minLength);
      expect(max.firstFailure?.type, ValidationFailureType.maxLength);
    });

    test('phone validator', () {
      final invalid = AppValidators.validate(
        '12ab',
        <Validator>[AppValidators.phone()],
      );
      final valid = AppValidators.validate(
        '+201234567890',
        <Validator>[AppValidators.phone()],
      );

      expect(invalid.isValid, isFalse);
      expect(valid.isValid, isTrue);
    });

    test('numeric range and match validators', () {
      final range = AppValidators.validate(
        '200',
        <Validator>[AppValidators.numericRange(min: 1, max: 100)],
      );
      final mismatch = AppValidators.validate(
        'abc',
        <Validator>[AppValidators.matches('xyz')],
      );

      expect(range.firstFailure?.type, ValidationFailureType.numericRange);
      expect(mismatch.firstFailure?.type, ValidationFailureType.mismatch);
    });
  });
}
