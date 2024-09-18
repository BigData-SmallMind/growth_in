class TicketMessage {
  const TicketMessage({
    required this.id,
    required this.text,
    this.file,
    this.profileImage,
    required this.companyName,
    required this.createdAt,
  });

  final int id;
  final String text;
  final String? file;
  final String? profileImage;
  final String companyName;
  final DateTime createdAt;
}
