import 'push_message.dart';

abstract class PushNotificationService {
  Future<void> initialize();

  Future<String?> getDeviceToken();

  Stream<PushMessage> get onMessageReceived;

  Stream<PushMessage> get onMessageOpenedApp;

  Future<void> subscribeToTopic(String topic);

  Future<void> unsubscribeFromTopic(String topic);
}
