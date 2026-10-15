import 'package:shipments/core/push/noop_push_notification_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NoopPushNotificationService', () {
    test('initialize/get token are safe', () async {
      const service = NoopPushNotificationService();

      await service.initialize();
      expect(await service.getDeviceToken(), isNull);
    });

    test('message streams stay empty', () async {
      const service = NoopPushNotificationService();

      await expectLater(service.onMessageReceived, emitsDone);
      await expectLater(service.onMessageOpenedApp, emitsDone);
    });
  });
}
