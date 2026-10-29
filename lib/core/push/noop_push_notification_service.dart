import 'push_message.dart';
import 'push_notification_service.dart';

class NoopPushNotificationService implements PushNotificationService {
  const NoopPushNotificationService();

  @override
  Future<String?> getDeviceToken() async => null;

  @override
  Future<void> initialize() async {}

  @override
  Stream<String> get onDeviceTokenChanged => const Stream<String>.empty();

  @override
  Stream<PushMessage> get onMessageOpenedApp => const Stream.empty();

  @override
  Stream<PushMessage> get onMessageReceived => const Stream.empty();

  @override
  Future<void> subscribeToTopic(String topic) async {}

  @override
  Future<void> unsubscribeFromTopic(String topic) async {}
}
