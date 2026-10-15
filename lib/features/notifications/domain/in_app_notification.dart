enum InAppNotificationType {
  info,
  success,
  warning,
  error,
}

class InAppNotification {
  const InAppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    this.type = InAppNotificationType.info,
    this.isRead = false,
  });

  factory InAppNotification.create({
    required String title,
    required String message,
    InAppNotificationType type = InAppNotificationType.info,
  }) {
    return InAppNotification(
      id: '${DateTime.now().microsecondsSinceEpoch}_$title',
      title: title,
      message: message,
      type: type,
      createdAt: DateTime.now(),
    );
  }

  factory InAppNotification.fromJson(Map<String, dynamic> json) {
    return InAppNotification(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      type: InAppNotificationType.values.firstWhere(
        (candidate) => candidate.name == json['type'],
        orElse: () => InAppNotificationType.info,
      ),
      isRead: json['isRead'] == true,
    );
  }

  final String id;
  final String title;
  final String message;
  final DateTime createdAt;
  final InAppNotificationType type;
  final bool isRead;

  InAppNotification copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? createdAt,
    InAppNotificationType? type,
    bool? isRead,
  }) {
    return InAppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'message': message,
      'createdAt': createdAt.toIso8601String(),
      'type': type.name,
      'isRead': isRead,
    };
  }
}
