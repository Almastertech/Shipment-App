import 'package:shipments/core/session/session_expiry_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('NoopSessionExpiryHandler completes without throwing', () async {
    final handler = NoopSessionExpiryHandler();
    await handler.onSessionExpired();
  });
}
