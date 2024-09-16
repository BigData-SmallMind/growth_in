class Ticket {
  const Ticket({
    required this.id,
    required this.title,
    this.subject,
    required this.status,
    required this.createdAt,
  });

  final int id;
  final String title;
  final String? subject;
  final TicketStatus status;
  final DateTime createdAt;
}

enum TicketStatus {
  // مفتوحة , محلولة , مغلقة
  open,
  solved,
  closed,
}
