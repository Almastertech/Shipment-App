enum SupportTicketCategory { shipment, compensation }

enum SupportTicketStatus { inProgress, awaitingReply }

enum SupportTicketMessageAuthor { customer, team }

class SupportTicketMessage {
  const SupportTicketMessage({
    required this.author,
    required this.body,
    required this.metadata,
  });

  final SupportTicketMessageAuthor author;
  final String body;
  final String metadata;
}

class SupportTicket {
  const SupportTicket({
    required this.category,
    required this.status,
    required this.statusLabel,
    required this.title,
    required this.subtitle,
    required this.lastUpdate,
    required this.categoryLabel,
    required this.actionLabel,
    required this.conversationDate,
    required this.messages,
  });

  final SupportTicketCategory category;
  final SupportTicketStatus status;
  final String statusLabel;
  final String title;
  final String subtitle;
  final String lastUpdate;
  final String categoryLabel;
  final String actionLabel;
  final String conversationDate;
  final List<SupportTicketMessage> messages;
}
