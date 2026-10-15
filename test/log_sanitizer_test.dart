import 'package:shipments/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LogSanitizer', () {
    test('redacts sensitive keys recursively', () {
      final payload = <String, Object?>{
        'Authorization': 'Bearer abc',
        'user': <String, Object?>{
          'accessToken': 'token_1',
          'refresh_token': 'token_2',
          'password': 'pass_1',
          'name': 'Ahmed',
        },
        'list': <Object?>[
          <String, Object?>{'apiKey': 'k1'},
          <String, Object?>{'value': 'ok'},
        ],
      };

      final sanitized = LogSanitizer.sanitize(payload) as Map<String, Object?>;
      final user = sanitized['user']! as Map<String, Object?>;
      final list = sanitized['list']! as List<Object?>;

      expect(sanitized['Authorization'], '***');
      expect(user['accessToken'], '***');
      expect(user['refresh_token'], '***');
      expect(user['password'], '***');
      expect(user['name'], 'Ahmed');
      expect((list.first as Map<String, Object?>)['apiKey'], '***');
      expect((list.last as Map<String, Object?>)['value'], 'ok');
    });
  });
}
