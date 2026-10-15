class PushMessage {
  const PushMessage({
    required this.id,
    required this.title,
    required this.body,
    required this.sentAt,
    this.data = const <String, String>{},
  });

  final String id;
  final String title;
  final String body;
  final DateTime sentAt;
  final Map<String, String> data;
}
